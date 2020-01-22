Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC02C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF72205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PPwvm3qZ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="En03v+gC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgAVKrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:47:03 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:62328 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729353AbgAVKpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:40 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAiocC016472;
        Wed, 22 Jan 2020 02:45:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=bqTwrA1XeUvm2P9cTdvJXX12imv8ekimrQTadBuzID0=;
 b=PPwvm3qZvuy8d5JRFXnWtM90qJ+R8qoSGm32tewNJkOjX0wUMu+71nHejrz0zWgmpDLX
 H8ckBkFG8ATowded9eP8oIvXudiW0MaJYrLOIy7iBsF2rDhKHg1ccoiyQIGXKO6AHKfJ
 hDHDnWk40hWBA1MFHkNwyuqIL3xRcCsgwMQ6grOsF/5c3TJNMRWKqp2JeaGQe5XzgakH
 HJ0ZLFONUV9QK0ANy13OGH/Sl3WK5N78KVgCsYXE2Z8WO12d08uqzkfaN7HlhR5kob1z
 OqJp7TMsvVxVzks9oD6Ak6ohnzgc4ZYbTh0RUcU9FVu7TbwWGnX58cUw+bKgUJaSCYlF CA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xkxg3vssx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:45:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdkD4TaRvjcqqbo5t0SoWpHS2DMhwj9QJw3z2YIlHnMVMN/YrLSm24UHcZitzlCOsWoFuezqHQ3fMNlabSoCRUJl7DE4Yzg/JcNuKOS/Ka3sSpPtvvV1P0tE4fGOqZ8c+HFnSe4GMIsInc1dYPuD8+pliJKcL6//Qz9MsCiS7TCGac+DWYV3cc2l6iMcXcBfnMf29hWFgj2KZ6jo04Ziqet+0NlUKgdcSZnNFS5pIwMFNeFRjiyLdyKMH09PequWq5hXd12NhQWhcT+sUgYACXUQLfmk4U4UQHGc7UvBnVOLVUHGZb4Pt2ATd2UYEwMRcRtkX9hJ9DhFrbSlAvK1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqTwrA1XeUvm2P9cTdvJXX12imv8ekimrQTadBuzID0=;
 b=UcpA2xBOvI4hvVAPPEx5EYwOF3bdHddcrD7plmP64+VxVMbk/f8bClPZxzMbY1RjDAwdmVzep2i7KvFkJ/vwk0tKWJsvWQMynwVwOV9p5CZXrTeYTK/3TxbSMfPNnT0XkiQhnoFDDJrXUIOYXAJ9ot5T/+emJ+cNRVzUOaDvnaXuV43z9ebpZ7S8mLWoXtiY2IgkjKHWoltPhclxT8NZ+wijdY6By/qDb6cdy5daWuwW0WWIjwhafLroY5Q8kQv2zRJvMWLghP2ToXNng4ypI75xu++uW6niTtrYi7DGJERQo4C8+O6qmO62bJYn+lF0y8OGdqs04eDxiqKe1F3hZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqTwrA1XeUvm2P9cTdvJXX12imv8ekimrQTadBuzID0=;
 b=En03v+gCC7P9Cjk6++Y+QfgMvSfTG1wqvfWxTf3RQzPwTTwQ/7iVHyxzYM/C04BprkI2YEJ5ObBzUZUv8ETbnT2E0PIwwI6L8eBogc28FRBNBo9V5YPffJM52S3ixfuvES7yY5u6M+n8wOwe9QcQLRGHXnDsnNpK8cPek7jnfKM=
Received: from DM6PR07CA0053.namprd07.prod.outlook.com (2603:10b6:5:74::30) by
 BYAPR07MB4614.namprd07.prod.outlook.com (2603:10b6:a03::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 10:45:29 +0000
Received: from BN8NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5b::206) by DM6PR07CA0053.outlook.office365.com
 (2603:10b6:5:74::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Wed, 22 Jan 2020 10:45:29 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BN8NAM12FT017.mail.protection.outlook.com (10.13.182.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:45:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKBJ001726
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 22 Jan 2020 02:45:28 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:45:23 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:45:23 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjNal007315;
        Wed, 22 Jan 2020 11:45:23 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAjNu9007310;
        Wed, 22 Jan 2020 11:45:23 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 10/14] phy: cadence-torrent: Use regmap to read and write DPTX PHY registers
Date:   Wed, 22 Jan 2020 11:45:14 +0100
Message-ID: <1579689918-7181-11-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(36092001)(8936002)(30864003)(42186006)(5660300002)(36756003)(316002)(26826003)(478600001)(2906002)(426003)(356004)(6666004)(70206006)(336012)(8676002)(26005)(86362001)(2616005)(70586007)(107886003)(186003)(246002)(54906003)(4326008)(110136005)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4614;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28cce367-84f9-4e5c-fdec-08d79f2832a6
X-MS-TrafficTypeDiagnostic: BYAPR07MB4614:
X-Microsoft-Antispam-PRVS: <BYAPR07MB46142B71C88CA18B95D0616FD20C0@BYAPR07MB4614.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0ntitnnXf+CthKlk7uWqUffJtGMqx+Ucn9fQ1hLrrLxqwadvaPY57+11DiIJYTuFSB4Sp4TGuTVv1lP8QTlGpd++ln2QiNA0OTb48p4orJ2QnZest4lPCR5gBeTRhU7H/CWHUvUryxUOs9DAZPUskW1iO+dx4MXtJ68Ftal+Zlm6jhynAhk/BBCSUe/iZT0a6c2QkUwMQpa2evGogqq+NY2CMos55tIp6twwuLbRk6Euosh4ZYCj+a2MiUXjEQxY3s2i102EA/GLSprLuctEsyy+aelo0i4ko8aDapWQQyZ7gybYQnTJz5d7s5Xs0M1aMQAU6h8XeOnsU4sK2gnFDc6IzE73uYr+WbnVJqwPwWeB66RGygulb4N2/mr6FRAOmJ+d8qK1f7UqsSmQSsSwlCdi6/aRIAlqdfAjhRwGxCm/M0HK+7VszWg+xA0+GkuqXua0u4B8fRviIzcTmQysji+Lmxv9AiVZHS5HBLLyOjjH4VsBlk32kp9pzM1pmx7
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:45:29.1518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cce367-84f9-4e5c-fdec-08d79f2832a6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4614
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Use regmap to read and write DPTX specific PHY registers.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 169 ++++++++++++++++++------------
 1 file changed, 100 insertions(+), 69 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 027667a..0e03d3c 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -45,11 +45,12 @@
 #define TORRENT_PHY_PMA_COMMON_OFFSET(block_offset)	\
 				(0xE000 << (block_offset))
 
+#define TORRENT_DPTX_PHY_OFFSET		0x0
+
 /*
  * register offsets from DPTX PHY register block base (i.e MHDP
  * register base + 0x30a00)
  */
-#define PHY_AUX_CONFIG			0x00
 #define PHY_AUX_CTRL			0x04
 #define PHY_RESET			0x20
 #define PMA_TX_ELEC_IDLE_MASK		0xF0U
@@ -65,8 +66,6 @@
 #define PMA_XCVR_POWER_STATE_REQ_LN_MASK	0x3FU
 #define PHY_PMA_XCVR_POWER_STATE_ACK	0x30
 #define PHY_PMA_CMN_READY		0x34
-#define PHY_PMA_XCVR_TX_VMARGIN		0x38
-#define PHY_PMA_XCVR_TX_DEEMPH		0x3c
 
 /*
  * register offsets from SD0801 PHY register block base (i.e MHDP
@@ -179,6 +178,9 @@ static const struct reg_field phy_pma_cmn_ctrl_2 =
 static const struct reg_field phy_pma_pll_raw_ctrl =
 				REG_FIELD(PHY_PMA_PLL_RAW_CTRL, 0, 1);
 
+static const struct reg_field phy_reset_ctrl =
+				REG_FIELD(PHY_RESET, 8, 8);
+
 static const struct of_device_id cdns_torrent_phy_of_match[];
 
 struct cdns_torrent_phy {
@@ -195,9 +197,11 @@ struct cdns_torrent_phy {
 	struct regmap *regmap_phy_pma_common_cdb;
 	struct regmap *regmap_tx_lane_cdb[MAX_NUM_LANES];
 	struct regmap *regmap_rx_lane_cdb[MAX_NUM_LANES];
+	struct regmap *regmap_dptx_phy_reg;
 	struct regmap_field *phy_pll_cfg;
 	struct regmap_field *phy_pma_cmn_ctrl_2;
 	struct regmap_field *phy_pma_pll_raw_ctrl;
+	struct regmap_field *phy_reset_ctrl;
 };
 
 enum phy_powerstate {
@@ -228,12 +232,6 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 					 unsigned int lane);
 static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
 					 u32 rate, u32 num_lanes);
-static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
-				    unsigned int offset,
-				    unsigned char start_bit,
-				    unsigned char num_bits,
-				    unsigned int val);
-
 static int cdns_torrent_dp_configure(struct phy *phy,
 				     union phy_configure_opts *opts);
 static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
@@ -277,6 +275,27 @@ static int cdns_regmap_read(void *context, unsigned int reg, unsigned int *val)
 	return 0;
 }
 
+static int cdns_regmap_dptx_write(void *context, unsigned int reg,
+				  unsigned int val)
+{
+	struct cdns_regmap_cdb_context *ctx = context;
+	u32 offset = reg;
+
+	writel(val, ctx->base + offset);
+
+	return 0;
+}
+
+static int cdns_regmap_dptx_read(void *context, unsigned int reg,
+				 unsigned int *val)
+{
+	struct cdns_regmap_cdb_context *ctx = context;
+	u32 offset = reg;
+
+	*val = readl(ctx->base + offset);
+	return 0;
+}
+
 #define TORRENT_TX_LANE_CDB_REGMAP_CONF(n) \
 { \
 	.name = "torrent_tx_lane" n "_cdb", \
@@ -333,6 +352,14 @@ static struct regmap_config cdns_torrent_phy_pma_cmn_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
+static struct regmap_config cdns_torrent_dptx_phy_config = {
+	.name = "torrent_dptx_phy",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_dptx_write,
+	.reg_read = cdns_regmap_dptx_read,
+};
+
 /* PHY mmr access functions */
 
 static void cdns_torrent_phy_write(struct regmap *regmap, u32 offset, u32 val)
@@ -350,21 +377,18 @@ static u32 cdns_torrent_phy_read(struct regmap *regmap, u32 offset)
 
 /* DPTX mmr access functions */
 
-static void cdns_torrent_dp_write(struct cdns_torrent_phy *cdns_phy,
-				  u32 offset, u32 val)
+static void cdns_torrent_dp_write(struct regmap *regmap, u32 offset, u32 val)
 {
-	writel(val, cdns_phy->base + offset);
+	regmap_write(regmap, offset, val);
 }
 
-static u32 cdns_torrent_dp_read(struct cdns_torrent_phy *cdns_phy, u32 offset)
+static u32 cdns_torrent_dp_read(struct regmap *regmap, u32 offset)
 {
-	return readl(cdns_phy->base + offset);
-}
+	u32 val;
 
-#define cdns_torrent_dp_read_poll_timeout(cdns_phy, offset, val, cond, \
-					  delay_us, timeout_us) \
-	readl_poll_timeout((cdns_phy)->base + (offset), \
-			   val, cond, delay_us, timeout_us)
+	regmap_read(regmap, offset, &val);
+	return val;
+}
 
 /*
  * Structure used to store values of PHY registers for voltage-related
@@ -439,6 +463,8 @@ static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
 {
 	u32 rd_val;
 	u32 ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+
 	/*
 	 * Used to determine, which bits to check for or enable in
 	 * PHY_PMA_XCVR_PLLCLK_EN register.
@@ -470,14 +496,14 @@ static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
 	else
 		pll_val = 0x00000000;
 
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, pll_val);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, pll_val);
 
 	/* Wait for acknowledgment from PHY. */
-	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
-						PHY_PMA_XCVR_PLLCLK_EN_ACK,
-						rd_val,
-						(rd_val & pll_bits) == pll_val,
-						0, POLL_TIMEOUT_US);
+	ret = regmap_read_poll_timeout(regmap,
+				       PHY_PMA_XCVR_PLLCLK_EN_ACK,
+				       rd_val,
+				       (rd_val & pll_bits) == pll_val,
+				       0, POLL_TIMEOUT_US);
 	ndelay(100);
 	return ret;
 }
@@ -601,9 +627,10 @@ static int cdns_torrent_dp_verify_config(struct cdns_torrent_phy *cdns_phy,
 static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
 				       u32 num_lanes)
 {
-	u32 pwr_state = cdns_torrent_dp_read(cdns_phy,
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+	u32 pwr_state = cdns_torrent_dp_read(regmap,
 					     PHY_PMA_XCVR_POWER_STATE_REQ);
-	u32 pll_clk_en = cdns_torrent_dp_read(cdns_phy,
+	u32 pll_clk_en = cdns_torrent_dp_read(regmap,
 					      PHY_PMA_XCVR_PLLCLK_EN);
 
 	/* Lane 0 is always enabled. */
@@ -628,9 +655,8 @@ static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
 		pll_clk_en &= ~(0x01U << 3);
 	}
 
-	cdns_torrent_dp_write(cdns_phy,
-			      PHY_PMA_XCVR_POWER_STATE_REQ, pwr_state);
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, pll_clk_en);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, pwr_state);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, pll_clk_en);
 }
 
 /* Configure lane count as required. */
@@ -639,18 +665,19 @@ static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
 {
 	u32 value;
 	u32 ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 	u8 lane_mask = (1 << dp->lanes) - 1;
 
-	value = cdns_torrent_dp_read(cdns_phy, PHY_RESET);
+	value = cdns_torrent_dp_read(regmap, PHY_RESET);
 	/* clear pma_tx_elec_idle_ln_* bits. */
 	value &= ~PMA_TX_ELEC_IDLE_MASK;
 	/* Assert pma_tx_elec_idle_ln_* for disabled lanes. */
 	value |= ((~lane_mask) << PMA_TX_ELEC_IDLE_SHIFT) &
 		 PMA_TX_ELEC_IDLE_MASK;
-	cdns_torrent_dp_write(cdns_phy, PHY_RESET, value);
+	cdns_torrent_dp_write(regmap, PHY_RESET, value);
 
 	/* reset the link by asserting phy_l00_reset_n low */
-	cdns_torrent_dp_write(cdns_phy, PHY_RESET,
+	cdns_torrent_dp_write(regmap, PHY_RESET,
 			      value & (~PHY_L00_RESET_N_MASK));
 
 	/*
@@ -658,13 +685,13 @@ static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
 	 * and powered down when re-enabling the link
 	 */
 	value = (value & 0x0000FFF0) | (0x0000000E & lane_mask);
-	cdns_torrent_dp_write(cdns_phy, PHY_RESET, value);
+	cdns_torrent_dp_write(regmap, PHY_RESET, value);
 
 	cdns_torrent_dp_set_a0_pll(cdns_phy, dp->lanes);
 
 	/* release phy_l0*_reset_n based on used laneCount */
 	value = (value & 0x0000FFF0) | (0x0000000F & lane_mask);
-	cdns_torrent_dp_write(cdns_phy, PHY_RESET, value);
+	cdns_torrent_dp_write(regmap, PHY_RESET, value);
 
 	/* Wait, until PHY gets ready after releasing PHY reset signal. */
 	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
@@ -674,7 +701,7 @@ static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
 	ndelay(100);
 
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
 
 	ret = cdns_torrent_dp_run(cdns_phy, dp->lanes);
 
@@ -801,6 +828,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	int ret;
 
 	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
 	ret = clk_prepare_enable(cdns_phy->clk);
 	if (ret) {
@@ -825,7 +853,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 		return -EINVAL;
 	}
 
-	cdns_torrent_dp_write(cdns_phy, PHY_AUX_CTRL, 0x0003); /* enable AUX */
+	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
 	/* PHY PMA registers configuration function */
 	cdns_torrent_dp_pma_cfg(cdns_phy);
@@ -841,11 +869,11 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	 * used lanes
 	 */
 	lane_bits = (1 << cdns_phy->num_lanes) - 1;
-	cdns_torrent_dp_write(cdns_phy, PHY_RESET,
+	cdns_torrent_dp_write(regmap, PHY_RESET,
 			      ((0xF & ~lane_bits) << 4) | (0xF & lane_bits));
 
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
 
 	/* PHY PMA registers configuration functions */
 	/* Initialize PHY with max supported link rate, without SSC. */
@@ -861,7 +889,8 @@ static int cdns_torrent_dp_init(struct phy *phy)
 				     cdns_phy->num_lanes);
 
 	/* take out of reset */
-	cdns_dp_phy_write_field(cdns_phy, PHY_RESET, 8, 1, 1);
+	regmap_field_write(cdns_phy->phy_reset_ctrl, 0x1);
+
 	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
 	if (ret)
 		return ret;
@@ -884,10 +913,10 @@ int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int reg;
 	int ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
-	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy, PHY_PMA_CMN_READY,
-						reg, reg & 1, 0,
-						POLL_TIMEOUT_US);
+	ret = regmap_read_poll_timeout(regmap, PHY_PMA_CMN_READY, reg,
+				       reg & 1, 0, POLL_TIMEOUT_US);
 	if (ret == -ETIMEDOUT) {
 		dev_err(cdns_phy->dev,
 			"timeout waiting for PMA common ready\n");
@@ -1405,6 +1434,7 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
 	u32 mask;
 	u32 read_val;
 	u32 ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
 	switch (powerstate) {
 	case (POWERSTATE_A0):
@@ -1445,15 +1475,12 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
 	}
 
 	/* Set power state A<n>. */
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ, value);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, value);
 	/* Wait, until PHY acknowledges power state completion. */
-	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
-						PHY_PMA_XCVR_POWER_STATE_ACK,
-						read_val,
-						(read_val & mask) == value, 0,
-						POLL_TIMEOUT_US);
-	cdns_torrent_dp_write(cdns_phy,
-			      PHY_PMA_XCVR_POWER_STATE_REQ, 0x00000000);
+	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_POWER_STATE_ACK,
+				       read_val, (read_val & mask) == value, 0,
+				       POLL_TIMEOUT_US);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, 0x00000000);
 	ndelay(100);
 
 	return ret;
@@ -1463,15 +1490,15 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
 {
 	unsigned int read_val;
 	int ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
 	/*
 	 * waiting for ACK of pma_xcvr_pllclk_en_ln_*, only for the
 	 * master lane
 	 */
-	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
-						PHY_PMA_XCVR_PLLCLK_EN_ACK,
-						read_val, read_val & 1, 0,
-						POLL_TIMEOUT_US);
+	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_PLLCLK_EN_ACK,
+				       read_val, read_val & 1,
+				       0, POLL_TIMEOUT_US);
 	if (ret == -ETIMEDOUT) {
 		dev_err(cdns_phy->dev,
 			"timeout waiting for link PLL clock enable ack\n");
@@ -1491,20 +1518,6 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
 	return ret;
 }
 
-static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
-				    unsigned int offset,
-				    unsigned char start_bit,
-				    unsigned char num_bits,
-				    unsigned int val)
-{
-	unsigned int read_val;
-
-	read_val = cdns_torrent_dp_read(cdns_phy, offset);
-	cdns_torrent_dp_write(cdns_phy, offset,
-			      ((val << start_bit) |
-			      (read_val & ~(((1 << num_bits) - 1) <<
-			      start_bit))));
-}
 
 static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
 				       u32 block_offset,
@@ -1554,6 +1567,14 @@ static int cdns_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	}
 	cdns_phy->phy_pma_pll_raw_ctrl = field;
 
+	regmap = cdns_phy->regmap_dptx_phy_reg;
+	field = devm_regmap_field_alloc(dev, regmap, phy_reset_ctrl);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_RESET reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_reset_ctrl = field;
+
 	return 0;
 }
 
@@ -1622,6 +1643,16 @@ static int cdns_regmap_init_torrent_dp(struct cdns_torrent_phy *cdns_phy,
 	}
 	cdns_phy->regmap_phy_pma_common_cdb = regmap;
 
+	block_offset = TORRENT_DPTX_PHY_OFFSET;
+	regmap = cdns_regmap_init(dev, base, block_offset,
+				  reg_offset_shift,
+				  &cdns_torrent_dptx_phy_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init DPTX PHY regmap\n");
+		return PTR_ERR(regmap);
+	}
+	cdns_phy->regmap_dptx_phy_reg = regmap;
+
 	return 0;
 }
 
-- 
2.4.5

