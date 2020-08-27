Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0480DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF82D2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XNgzfsAg";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="2re5Be8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgH0QSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:18:21 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:31842 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgH0QRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:17:11 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RGC686005481;
        Thu, 27 Aug 2020 09:17:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=EVEo2QxZbraRl5tTw+1l8tPTCuP3azGt5bnpLkhwwI4=;
 b=XNgzfsAg5Tak/9Xy19SckDTVRcn9k2KCGj+0/lCFA4Xe/auwx4/DJBzU6K74BRrQKDic
 w3NszYsm/tXSpjhg62cL9beTeEQ9MeiZANArDxgaped6P/X/LXK0CelMdrmhrEuvFkLd
 yT9YgfUMUSoWKnW0E9d9v8Ai+ZL8TGjPoY8Z8zPEn+KedIbap2kZJ/+vrN5GA/uuW6mi
 V47G4if9nCUmNOCYd65qIDPUmxJKufIV5IRCL3tWOXadrTKDdBxSLXFkf0/UlAo9JVR2
 wT8MCX5S9o64/x8HR6ONpx3tMZkO57i68viGDxd0xh2Gb6EDsqIkbZWycZgjUB4MbonU BQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww4tq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:17:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXJyXSwTf127mQV4a5SoJb2wIINHe72A+Rdq5n+37jKQ18cjCiuqKraBjFSQim6MDMA6bH+Z2Gyp9yPnOWeajJLJhvTjxvqizq/RWLJgez0oyThq80jqBTyMTyYh641EVfSz3W/NUQ1yqDAcy31TVp2PBBjCuvzwb0RUdUlV8gXl4giwZtqOwM5el7fOzjwK6sTU+rXSUAiGJXqy79dqLQYPivQzIHmwyZwQqEbrtAjyNzGplGuVa7ppAcfNPzj1Ihl/ygjWQpIL53z7EHs0NK+RdWNQKXybvRpta9cj1UxktuR2XnMJCGhfpZUi9zwyjVg20RilRRpRL+zYaVgBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVEo2QxZbraRl5tTw+1l8tPTCuP3azGt5bnpLkhwwI4=;
 b=Nb2M1VEXz5P+orzgkRwl09/yUN1kLGrOHaC3cvxb9yb2uDxtwaxV2jmnmBUhdzoDGiO/d0i5GRKXktDSCwbPsC15vd4BdVNbCOeDFtcA0qTmu7ivPCCoDR1mSSug+6TpcZQdnsd+sDEVAYZF72xSgiHpUfbWiVr2ewGmYKtF4eyOO2+ilJkahR6uDuxNIQZxqHRNJWB62AH0HWn64bFbm0jR2viExC+J+2hCR8Dh2jcPBPTp5vZ7G87hpQjQ/d0FImAS/Oh/yQBh/TpIYFmujjlXnLiPF3Kv99LI8Ec310lbzKz3m9NCacjeSiTjgDzdfcD2wcRZgTh+ITLG1Io6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVEo2QxZbraRl5tTw+1l8tPTCuP3azGt5bnpLkhwwI4=;
 b=2re5Be8EkF5jxC0+9sNp+Tf04RCI6+V5vF3fj2D5rsShm9jdbBzW6vCw5V9uoQ780OsyXZnH/g/xcvEvhGYyNX6fLzbfAIhviTFDi7Y3frClg6wz8CqKYNicgGVj0Fxx56oiIqBSOQ9I7Vdtp6qQydMFyAdX1iAACZcxWOQ1nJA=
Received: from BN8PR16CA0007.namprd16.prod.outlook.com (2603:10b6:408:4c::20)
 by MW2PR07MB4124.namprd07.prod.outlook.com (2603:10b6:907:c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 16:16:56 +0000
Received: from BN8NAM12FT058.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::9b) by BN8PR16CA0007.outlook.office365.com
 (2603:10b6:408:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 16:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT058.mail.protection.outlook.com (10.13.182.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:16:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGquF016160
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 12:16:54 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGp0T031815;
        Thu, 27 Aug 2020 18:16:51 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RGGpww031809;
        Thu, 27 Aug 2020 18:16:51 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 00/13] PHY: Add support for multilink configurations in Cadence Torrent PHY driver
Date:   Thu, 27 Aug 2020 18:16:38 +0200
Message-ID: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d021330-2b16-449b-61a1-08d84aa49e39
X-MS-TrafficTypeDiagnostic: MW2PR07MB4124:
X-Microsoft-Antispam-PRVS: <MW2PR07MB41244A9256A87988363EF596C5550@MW2PR07MB4124.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLZFnSGc0Amb+kPFAtmVZdjZBM0zb1F8xM+JeDN4kj1+kzIl5C2aYoqZC9YfvVB6jDY4enYGYtE065ADYqEULAM/Kp8iUAaQFD6E+BqvOEv7Q3Yc8XDONc+j7JuA5Aq7kzUuTWwc5rxB6D2UudINdojfaUCwiCkE8TOsWYGUqIc1lPDLt1iaaW8b45ufP2KIEeRhI5NidakN16z+Mvh/Fe2idcn2HZHYR8znRX/GPvRLQE+g912c0Th2mJBotoy5hvnPPb5y2XzIIGB47TWGLnhEUmrX+VGKZhNtA2DIvflNFgSoRUL8dKRnrTW6r5NyCAcq13tvjBVmnwBqhgXkINQcwPd+m57qpYlfof5XbcgKKTzo9bOJT2kiBph1akZBSREdwpmFK2dABbvmtBTZUXi9kzzTVuzCqHoc0LJhuvraj//30koQTYlOgWwCCCDuzeH0Kqy5EHeB0SvoI1lxD/7bEilgrfAu2hv0uF8fMIGEXRn3tr9jkgNLSqED9GaO
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36092001)(46966005)(70586007)(82740400003)(2906002)(5660300002)(8676002)(47076004)(36756003)(82310400002)(426003)(336012)(186003)(966005)(26005)(54906003)(356005)(81166007)(42186006)(4326008)(478600001)(110136005)(6666004)(86362001)(8936002)(70206006)(316002)(2616005)(83380400001)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:16:56.2307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d021330-2b16-449b-61a1-08d84aa49e39
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT058.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4124
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=995 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence Torrent PHY is a multiprotocol PHY supporting different multilink
PHY configurations including DisplayPort, PCIe, USB, SGMII, QSGMII etc.
This patch series extends functionality of Torrent PHY driver to support
following configurations:
- Single link PCIe configuration
- PCIe + SGMII/QSGMII Unique SSC multilink configuration
- Single link SGMII/QSGMII configuration
- Single link USB configuration
- PCIe + USB Unique SSC multilink configuration
- USB + SGMII/QSGMII multilink configuration

The changes have been validated on TI J7200 platform.

This patch series is dependent on [1] and [2] and should be applied on
top of these.

[1] https://lkml.org/lkml/2020/8/24/1586

[2] https://lkml.org/lkml/2020/8/27/667

Version History:

v2:
   - Rebased on latest PHY next and new PHY patch series [1] and [2]

Swapnil Jakhade (13):
  phy: cadence-torrent: Add single link PCIe support
  phy: cadence-torrent: Check cmn_ready assertion during PHY power on
  phy: cadence-torrent: Add PHY APB reset support
  dt-bindings: phy: Add PHY_TYPE_QSGMII definition
  phy: cadence-torrent: Add support for PHY multilink configuration
  phy: cadence-torrent: Update PHY reset for multilink configuration
  phy: cadence-torrent: Add clk changes for multilink configuration
  phy: cadence-torrent: Add PHY link configuration sequences for single
    link
  phy: cadence-torrent: Configure PHY_PLL_CFG as part of link_cmn_vals
  phy: cadence-torrent: Add single link SGMII/QSGMII register sequences
  phy: cadence-torrent: Add single link USB register sequences
  phy: cadence-torrent: Add PCIe + USB multilink configuration
  phy: cadence-torrent: Add USB + SGMII/QSGMII multilink configuration

 drivers/phy/cadence/phy-cadence-torrent.c | 1975 ++++++++++++++++++++-
 include/dt-bindings/phy/phy.h             |    1 +
 2 files changed, 1934 insertions(+), 42 deletions(-)

-- 
2.26.1

