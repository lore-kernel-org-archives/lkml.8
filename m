Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254DAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2C12087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Dbvy/4og";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="pAnv2eLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgH0QWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:22:16 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:58704 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727022AbgH0QWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:22:14 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RGECUW029433;
        Thu, 27 Aug 2020 09:17:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=jypgz6jtrEN5ZBaN0gDuLcYeuTaHize0dfpyA+0txig=;
 b=Dbvy/4ogyj2p7iwKVRtE6nlpH1LP2BF2M+0pzmqDUOpg14uqtUwfEqorDuQ5c0h3yBWe
 It2E/3nuHGF3UGbZ773djg/IM5rud+8II+HBJ0tgQACAwIzhPgTk0pJsF41BjGaFTPF3
 HGZeyI8qanvBVtvRsisWsZuSlFjJ/vtJTNdtWqBCvIOz0MI5UfHoruk4BQ0IUpoMeDZp
 0Y3wBQqFAeluBr6/Fh7SeuDaB8PcXOI81zKfKe2HMetEgKNFD+SQxHhk+9zIt+fstm47
 fNoYeLs3Qjb5DMvYCqY+kz8YQ4j2bfyU2JzDtrfKvpvcuDzS84vPIv0gRMhx5lUFBJun Gg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxxdb0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:17:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QT8MK5mS0ws0KZh/U2uS7TsY7+UfScefOlUrU7H/eJppSpCh2uqtezP99aMMaNEucuPPs6WcTonkDOcqseRcFEqdvxTvLnhuRUMK/++GN5n73A8A2z19meoLO0CJRQYb76as8j4k6zqRgE2flUCJDvEJVtOT5TTzIg0LVrG3gPuCW20YBDBmZH0fbkZpe8VIKJ+Eg1qCa3en4CLI/TJSvFW7kvOaKgR4jD+/ZW7QxrbNH88/9c6Hj2lmEN9PvbZMQhoDR+48LjqC5/KdCUKTSdyEMSfZmtny0GUdNK0MkPSopX3n9q6WBjHg1pw9G3Q3ThblZVHZxtMAjHrM0BodEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jypgz6jtrEN5ZBaN0gDuLcYeuTaHize0dfpyA+0txig=;
 b=WacT9t+fkII9n2EV0tvg6/2xAQ01Tx1mOFWtfMtv55qyr5s+HGh5kVuQCn+PwVmTqi/4OOthJdWeGk/6l2dhZ0u2IZJEv2xr+lPQ5ZHAfECDxlBD64jDbGqKJr1s5OdfQZEUzJHCXkaO4ULLTIjvUyeCL2yaTvCx0Ji/c1ZTD4lFiFTLNS2cPY417RccmHI61xRdTuOvyRIYWiAiBtBRXbhsHlldN8IJEZcUmzcZldJ5Fvjbf5Ln4Js5+f8GxQJcGbcjCasntOWWWE93EzTNjtm3Inpzqypm1204dx4QCd8kVjIFiDrLrdzHihbx28eKvj1zM/HnS0rv79Yqdtftsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jypgz6jtrEN5ZBaN0gDuLcYeuTaHize0dfpyA+0txig=;
 b=pAnv2eLjb8qzalNOrg+nh//M5Q8XLOJynSv8GizK4dgiBVYjedbzvKIPq42upOGlUDT8tHJ98MkSsvKJuBJd1BItoRdEhIYM1RdzaFbkGRnZB3L6WQ82mNzLip7ytSBvHy6AKNU3whp0Ruw9nKI7TZT6mDLGSuEoZj5rT2uGok8=
Received: from DM3PR12CA0053.namprd12.prod.outlook.com (2603:10b6:0:56::21) by
 CH2PR07MB7303.namprd07.prod.outlook.com (2603:10b6:610:a4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Thu, 27 Aug 2020 16:17:05 +0000
Received: from DM6NAM12FT064.eop-nam12.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::ef) by DM3PR12CA0053.outlook.office365.com
 (2603:10b6:0:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 16:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=temperror action=none
 header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT064.mail.protection.outlook.com (10.13.178.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:17:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGquN016160
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 12:17:02 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 18:16:53 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 18:16:53 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGqIU031854;
        Thu, 27 Aug 2020 18:16:53 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RGGq7N031853;
        Thu, 27 Aug 2020 18:16:52 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 08/13] phy: cadence-torrent: Add PHY link configuration sequences for single link
Date:   Thu, 27 Aug 2020 18:16:46 +0200
Message-ID: <1598545011-31772-9-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
References: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1956ebff-5fff-4bdc-4b08-08d84aa4a2fc
X-MS-TrafficTypeDiagnostic: CH2PR07MB7303:
X-Microsoft-Antispam-PRVS: <CH2PR07MB7303BBA42D3628C42CAF379AC5550@CH2PR07MB7303.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qN2Wdwxp/3tqItMJJhk3c/AFbGN7gYkHcS01pyaywwUdwrUOlEMSL1nHclQPkGm20ZL2Ok0udRtg5glEuvSy57QZTlE4CMK8GK0ZJBCG1VOUr7ghpYuD55Nc5xwxwAwnJdR5GalE5ug2oaY8973Z8yEnKzC811g7QYMLg9LmRnQhkHeC2E4/qEClt0edxviF4SwgT2SFYpIRonLKcYdpY6VUU4bv7c6Q0VfxBtr+1YA3uV6sHKMPrCdaVEXBAdae45/tGMdMYmA54QassTpAP+a0dTR+QHQMLO80S+GlBb5BYrbW4sZvsEDWXofBaQwguwK6udz+zuKlND5x+Ye6DpHvcF0w1iboLwOj7yDBmxt4/J5IP1AsDTPlu/zhl2gsMTqGgo32c392arh6ph9EsuCmRJOgJtpCjtFuWEVIo+s=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(36092001)(46966005)(26005)(70586007)(70206006)(47076004)(4326008)(54906003)(36756003)(110136005)(81166007)(5660300002)(42186006)(8936002)(82740400003)(8676002)(82310400002)(356005)(478600001)(426003)(63350400001)(186003)(63370400001)(2616005)(316002)(36906005)(336012)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:17:04.1790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1956ebff-5fff-4bdc-4b08-08d84aa4a2fc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT064.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB7303
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=787 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to configure link_cmn_vals and xcvr_diag_vals in case of single
link PHY configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 9a87ee39a15a..eda3839762cb 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1809,6 +1809,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	enum cdns_torrent_phy_type phy_type = inst->phy_type;
 	enum cdns_torrent_ssc_mode ssc = inst->ssc_mode;
@@ -1823,6 +1824,29 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	if (phy_type == TYPE_DP)
 		return cdns_torrent_dp_init(phy);
 
+	/* PHY configuration specific registers for single link */
+	link_cmn_vals = init_data->link_cmn_vals[phy_type][TYPE_NONE][ssc];
+	if (link_cmn_vals) {
+		reg_pairs = link_cmn_vals->reg_pairs;
+		num_regs = link_cmn_vals->num_regs;
+		regmap = cdns_phy->regmap_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off,
+				     reg_pairs[i].val);
+	}
+
+	xcvr_diag_vals = init_data->xcvr_diag_vals[phy_type][TYPE_NONE][ssc];
+	if (xcvr_diag_vals) {
+		reg_pairs = xcvr_diag_vals->reg_pairs;
+		num_regs = xcvr_diag_vals->num_regs;
+		for (i = 0; i < inst->num_lanes; i++) {
+			regmap = cdns_phy->regmap_tx_lane_cdb[i + inst->mlane];
+			for (j = 0; j < num_regs; j++)
+				regmap_write(regmap, reg_pairs[j].off,
+					     reg_pairs[j].val);
+		}
+	}
+
 	/* PMA common registers configurations */
 	cmn_vals = init_data->cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (cmn_vals) {
@@ -2646,6 +2670,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	.reg_offset_shift = 0x2,
 	.link_cmn_vals = {
 		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 			[TYPE_SGMII] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2674,6 +2703,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	},
 	.xcvr_diag_vals = {
 		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 			[TYPE_SGMII] = {
 				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
@@ -2806,6 +2840,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	.reg_offset_shift = 0x1,
 	.link_cmn_vals = {
 		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 			[TYPE_SGMII] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2834,6 +2873,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	},
 	.xcvr_diag_vals = {
 		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 			[TYPE_SGMII] = {
 				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-- 
2.26.1

