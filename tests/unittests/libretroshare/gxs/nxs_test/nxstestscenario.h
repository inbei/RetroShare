/*
 * nxstestscenario.h
 *
 *  Created on: 10 Jul 2012
 *      Author: crispy
 */

#ifndef NXSTESTSCENARIO_H_
#define NXSTESTSCENARIO_H_

#include <map>
#include "retroshare/rstypes.h"
#include "gxs/rsgxsnetutils.h"
#include "gxs/rsdataservice.h"
#include "gxs/rsnxsobserver.h"
#include "util/rssharedptr.h"

namespace rs_nxs_test
{
	/*!
	 * This scenario module provides data resources
	 */
	class NxsTestScenario
	{
	public:

		typedef RsSharedPtr<NxsTestScenario> pointer;

		virtual ~NxsTestScenario() {}

		virtual void getPeers(std::list<RsPeerId>& peerIds) = 0;
		virtual RsGeneralDataService* getDataService(const RsPeerId& peerId) = 0;
		virtual bool checkTestPassed() = 0;
		virtual bool checkDeepTestPassed() = 0;
		virtual RsNxsNetMgr* getDummyNetManager(const RsPeerId& peerId) = 0;
		virtual RsGcxs* getDummyCircles(const RsPeerId& peerId) = 0;
		virtual RsGixsReputation* getDummyReputations(const RsPeerId& peerId) = 0;
		virtual uint16_t getServiceType() = 0;
		virtual RsServiceInfo getServiceInfo() = 0;
		virtual PgpAuxUtils* getDummyPgpUtils() = 0;

		virtual void cleanTestScenario() = 0;


	};
}

#endif /* NXSTESTSCENARIO_H_ */
