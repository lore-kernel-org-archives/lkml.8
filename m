Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C423C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C604C207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgE0M1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:27:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:20108 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgE0M1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:27:49 -0400
IronPort-SDR: YnGEfuXxcBFg60huJhhEaZ/jFAAv1peWkkO6X7PzkK7hhViYBaFN1nHWkeFvM0IGebVRct+IIC
 u6dJheZgaZrg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 05:27:27 -0700
IronPort-SDR: Tp+uyMWLW9Ta0kiCvuHRH8vG4jgjcSMYavz9o/u9HIT78O52+BBMtcA20qvG/D+rjv9/S1Axlv
 LmnjtisJHiDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="gz'50?scan'50,208,50";a="442502316"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2020 05:27:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jdv9Y-00040X-8f; Wed, 27 May 2020 20:27:24 +0800
Date:   Wed, 27 May 2020 20:26:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ariel Elior <ariel.elior@marvell.com>
Subject: drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1377:21: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202005272049.h1SLU8w7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   444fc5cde64330661bf59944c43844e7d4c2ccd8
commit: 804c5702fc583afbdb6860f79e9d4058570ccc43 qed: Use dmae to write to widebus registers in fw_funcs
date:   4 months ago
config: ia64-randconfig-s032-20200527 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-240-gf0fe1cd9-dirty
        git checkout 804c5702fc583afbdb6860f79e9d4058570ccc43
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=ia64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:545:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:545:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:545:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:545:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1343:9: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1343:9: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1343:9: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1343:9: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1343:9: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1343:9: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1344:9: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1344:9: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1344:9: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1344:9: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1344:9: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1344:9: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1347:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1347:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1347:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1347:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1347:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1347:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1348:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1348:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1348:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1348:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1348:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1348:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1349:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1349:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1349:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1349:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1349:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1349:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1350:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1350:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1350:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1350:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1350:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1350:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1351:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1351:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1351:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1351:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1351:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1351:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1352:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1352:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1352:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1352:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1352:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1352:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1354:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1354:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1354:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1354:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1354:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1354:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1355:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1355:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1355:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1355:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1355:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1355:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1356:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1356:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1356:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1356:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1356:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1356:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1358:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1358:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1358:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1358:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1358:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1358:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1359:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1359:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1359:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1359:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1359:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1359:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1361:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1361:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1361:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1361:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1361:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1361:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1362:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1362:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1362:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1362:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1362:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1362:17: sparse:    right side has type unsigned long long
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1364:17: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1364:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1364:17: sparse:    right side has type int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1364:17: sparse: sparse: invalid assignment: |=
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1364:17: sparse:    left side has type restricted __le32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1364:17: sparse:    right side has type unsigned long long
>> drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1377:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [usertype] lo @@     got unsigned int @@
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1377:21: sparse:     expected restricted __le32 [addressable] [usertype] lo
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1377:21: sparse:     got unsigned int
>> drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1378:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [usertype] hi @@     got int @@
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1378:21: sparse:     expected restricted __le32 [addressable] [usertype] hi
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1378:21: sparse:     got int
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1419:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1419:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1419:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1419:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1419:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1419:23: sparse: sparse: cast to restricted __be32

vim +1377 drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c

  1263	
  1264	void qed_gft_config(struct qed_hwfn *p_hwfn,
  1265			    struct qed_ptt *p_ptt,
  1266			    u16 pf_id,
  1267			    bool tcp,
  1268			    bool udp,
  1269			    bool ipv4, bool ipv6, enum gft_profile_type profile_type)
  1270	{
  1271		u32 reg_val, cam_line, search_non_ip_as_gft;
  1272		struct regpair ram_line = { };
  1273	
  1274		if (!ipv6 && !ipv4)
  1275			DP_NOTICE(p_hwfn,
  1276				  "gft_config: must accept at least on of - ipv4 or ipv6'\n");
  1277		if (!tcp && !udp)
  1278			DP_NOTICE(p_hwfn,
  1279				  "gft_config: must accept at least on of - udp or tcp\n");
  1280		if (profile_type >= MAX_GFT_PROFILE_TYPE)
  1281			DP_NOTICE(p_hwfn, "gft_config: unsupported gft_profile_type\n");
  1282	
  1283		/* Set RFS event ID to be awakened i Tstorm By Prs */
  1284		reg_val = T_ETH_PACKET_MATCH_RFS_EVENTID <<
  1285			  PRS_REG_CM_HDR_GFT_EVENT_ID_SHIFT;
  1286		reg_val |= PARSER_ETH_CONN_CM_HDR << PRS_REG_CM_HDR_GFT_CM_HDR_SHIFT;
  1287		qed_wr(p_hwfn, p_ptt, PRS_REG_CM_HDR_GFT, reg_val);
  1288	
  1289		/* Do not load context only cid in PRS on match. */
  1290		qed_wr(p_hwfn, p_ptt, PRS_REG_LOAD_L2_FILTER, 0);
  1291	
  1292		/* Do not use tenant ID exist bit for gft search */
  1293		qed_wr(p_hwfn, p_ptt, PRS_REG_SEARCH_TENANT_ID, 0);
  1294	
  1295		/* Set Cam */
  1296		cam_line = 0;
  1297		SET_FIELD(cam_line, GFT_CAM_LINE_MAPPED_VALID, 1);
  1298	
  1299		/* Filters are per PF!! */
  1300		SET_FIELD(cam_line,
  1301			  GFT_CAM_LINE_MAPPED_PF_ID_MASK,
  1302			  GFT_CAM_LINE_MAPPED_PF_ID_MASK_MASK);
  1303		SET_FIELD(cam_line, GFT_CAM_LINE_MAPPED_PF_ID, pf_id);
  1304	
  1305		if (!(tcp && udp)) {
  1306			SET_FIELD(cam_line,
  1307				  GFT_CAM_LINE_MAPPED_UPPER_PROTOCOL_TYPE_MASK,
  1308				  GFT_CAM_LINE_MAPPED_UPPER_PROTOCOL_TYPE_MASK_MASK);
  1309			if (tcp)
  1310				SET_FIELD(cam_line,
  1311					  GFT_CAM_LINE_MAPPED_UPPER_PROTOCOL_TYPE,
  1312					  GFT_PROFILE_TCP_PROTOCOL);
  1313			else
  1314				SET_FIELD(cam_line,
  1315					  GFT_CAM_LINE_MAPPED_UPPER_PROTOCOL_TYPE,
  1316					  GFT_PROFILE_UDP_PROTOCOL);
  1317		}
  1318	
  1319		if (!(ipv4 && ipv6)) {
  1320			SET_FIELD(cam_line, GFT_CAM_LINE_MAPPED_IP_VERSION_MASK, 1);
  1321			if (ipv4)
  1322				SET_FIELD(cam_line,
  1323					  GFT_CAM_LINE_MAPPED_IP_VERSION,
  1324					  GFT_PROFILE_IPV4);
  1325			else
  1326				SET_FIELD(cam_line,
  1327					  GFT_CAM_LINE_MAPPED_IP_VERSION,
  1328					  GFT_PROFILE_IPV6);
  1329		}
  1330	
  1331		/* Write characteristics to cam */
  1332		qed_wr(p_hwfn, p_ptt, PRS_REG_GFT_CAM + CAM_LINE_SIZE * pf_id,
  1333		       cam_line);
  1334		cam_line =
  1335		    qed_rd(p_hwfn, p_ptt, PRS_REG_GFT_CAM + CAM_LINE_SIZE * pf_id);
  1336	
  1337		/* Write line to RAM - compare to filter 4 tuple */
  1338	
  1339		/* Search no IP as GFT */
  1340		search_non_ip_as_gft = 0;
  1341	
  1342		/* Tunnel type */
  1343		SET_FIELD(ram_line.lo, GFT_RAM_LINE_TUNNEL_DST_PORT, 1);
  1344		SET_FIELD(ram_line.lo, GFT_RAM_LINE_TUNNEL_OVER_IP_PROTOCOL, 1);
  1345	
  1346		if (profile_type == GFT_PROFILE_TYPE_4_TUPLE) {
  1347			SET_FIELD(ram_line.hi, GFT_RAM_LINE_DST_IP, 1);
  1348			SET_FIELD(ram_line.hi, GFT_RAM_LINE_SRC_IP, 1);
  1349			SET_FIELD(ram_line.hi, GFT_RAM_LINE_OVER_IP_PROTOCOL, 1);
  1350			SET_FIELD(ram_line.lo, GFT_RAM_LINE_ETHERTYPE, 1);
  1351			SET_FIELD(ram_line.lo, GFT_RAM_LINE_SRC_PORT, 1);
  1352			SET_FIELD(ram_line.lo, GFT_RAM_LINE_DST_PORT, 1);
  1353		} else if (profile_type == GFT_PROFILE_TYPE_L4_DST_PORT) {
  1354			SET_FIELD(ram_line.hi, GFT_RAM_LINE_OVER_IP_PROTOCOL, 1);
  1355			SET_FIELD(ram_line.lo, GFT_RAM_LINE_ETHERTYPE, 1);
  1356			SET_FIELD(ram_line.lo, GFT_RAM_LINE_DST_PORT, 1);
  1357		} else if (profile_type == GFT_PROFILE_TYPE_IP_DST_ADDR) {
  1358			SET_FIELD(ram_line.hi, GFT_RAM_LINE_DST_IP, 1);
  1359			SET_FIELD(ram_line.lo, GFT_RAM_LINE_ETHERTYPE, 1);
  1360		} else if (profile_type == GFT_PROFILE_TYPE_IP_SRC_ADDR) {
  1361			SET_FIELD(ram_line.hi, GFT_RAM_LINE_SRC_IP, 1);
  1362			SET_FIELD(ram_line.lo, GFT_RAM_LINE_ETHERTYPE, 1);
  1363		} else if (profile_type == GFT_PROFILE_TYPE_TUNNEL_TYPE) {
  1364			SET_FIELD(ram_line.lo, GFT_RAM_LINE_TUNNEL_ETHERTYPE, 1);
  1365	
  1366			/* Allow tunneled traffic without inner IP */
  1367			search_non_ip_as_gft = 1;
  1368		}
  1369	
  1370		qed_wr(p_hwfn,
  1371		       p_ptt, PRS_REG_SEARCH_NON_IP_AS_GFT, search_non_ip_as_gft);
  1372		qed_dmae_to_grc(p_hwfn, p_ptt, (u32 *)&ram_line,
  1373				PRS_REG_GFT_PROFILE_MASK_RAM + RAM_LINE_SIZE * pf_id,
  1374				sizeof(ram_line) / REG_SIZE);
  1375	
  1376		/* Set default profile so that no filter match will happen */
> 1377		ram_line.lo = 0xffffffff;
> 1378		ram_line.hi = 0x3ff;
  1379		qed_dmae_to_grc(p_hwfn, p_ptt, (u32 *)&ram_line,
  1380				PRS_REG_GFT_PROFILE_MASK_RAM + RAM_LINE_SIZE *
  1381				PRS_GFT_CAM_LINES_NO_MATCH,
  1382				sizeof(ram_line) / REG_SIZE);
  1383	
  1384		/* Enable gft search */
  1385		qed_wr(p_hwfn, p_ptt, PRS_REG_SEARCH_GFT, 1);
  1386	}
  1387	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--82I3+IH0IqGh5yIs--
