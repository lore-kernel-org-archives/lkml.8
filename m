Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837F1C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469DC214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="KQ7zPYvV";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="wA5vC7g4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBFGL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:11:27 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:2226 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727827AbgBFGLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:25 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01667TD5008153;
        Wed, 5 Feb 2020 22:11:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=MCyjEYEUyvGUzRouJegJLAuiLb3zRFQeRIqcbzdEzu4=;
 b=KQ7zPYvVW99dfIY9seDUFY9E0t/KrZHyvuCmFHbeM2NrkyWUnrNythSpt7S0iSez/Pbs
 k3AQKKFGTMJ1NskQTeqOO+bvhX9GDByI7Ue1yByG5cYnD/V5fqB6sArAiH0/SXAcrcip
 BgKqdLPXsb6MYvAYlP2EdNp7VVRuk3HhQcrjzemTySdk4XVJU7ySV66EEeh6oVwh+thB
 7K7UtGIRuSisEY5g1Cu0rFGoivVKul+VGHokUznvylMXCfCNKVAzLf9BuhqT+Pj0Hi1P
 vc5LSr37hWYgm3Zjl/RR5Dtd/49jahwULo7TG+5rPJcO5h/DOou6SFkNzsl8EU2ZLBiQ kg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xyhkv5pja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+GKPQ74wCrT+FEH3SvbHaYD/wLQ2HbpieUmsr2jebPO+G0AAuh0A2qxXBLElHrUTqHOY77htwc76NxTejDoWz/rO96qHA77k9rD+OshvsL0P2QipU76yPP/DzR/cfdlMj31t1TyRP1hThaOTso/Djfy+EqFIhB+AzUdYhth+PHC4ugHJ2Zm897Wnrrro9QAQm9xeleGb2ser+00URDeHcszTNghnZEzL7W20gBQw2K/w4zkl8kA3tHxsLVzt9zcY6cJ6MiOWgWUo1eKwz68OA8Y9t9JFabVVQtjgN9DvFBsYWs5RF69VliOu34kEvByCUvhMgYoBoTY+F58H4v2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCyjEYEUyvGUzRouJegJLAuiLb3zRFQeRIqcbzdEzu4=;
 b=QIgXgqXB6C3SKrKwW83+y823QSiBZ6WTXM6cIO3wVegIrYwvBK7P7RlqIX+dG4QWn0uMEKKBWxOf7oP7EBs07lzEz5rd7mVI0Dkauei1JIPSiHIYXBgAW1bUnOblYIhPL/M0ABTsVj9FEYJjPiIdE+4bG7uDVsxx9JTaHTGD5fJN7M3kd+oigc8d6PdRARhSjMhlSaT9j1BB0whx3FZENWe9wqZiKb+vkcBxS1A4MGid6xw6FY3SoqJVhiBOgWOviuH2PqAVjbCIXiTgfw94MgQu7kj1NJtpv9ng6mEnvsnKa7IzNPKyqQGYAtOSzipsGyr5kypAknaqeXL1RpwAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCyjEYEUyvGUzRouJegJLAuiLb3zRFQeRIqcbzdEzu4=;
 b=wA5vC7g41uR8uIXhIDFgl/ksjvPtyIFnoSKqCvBNnp63h6l+fiLNvxMf9fj2qA6H+/tkyPowmlNS8Z24E/ScZFd4tWfFYmcf7eF0pJ4QcAo71SQKOkgGWQILCdor4JD3t/oHgbUd/LCe2HSO8G0803ioxP881tJJ5MGwKaQyzOI=
Received: from DM6PR07CA0055.namprd07.prod.outlook.com (2603:10b6:5:74::32) by
 DM5PR07MB2857.namprd07.prod.outlook.com (2603:10b6:3:c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 06:11:13 +0000
Received: from MW2NAM12FT058.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::202) by DM6PR07CA0055.outlook.office365.com
 (2603:10b6:5:74::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32 via Frontend
 Transport; Thu, 6 Feb 2020 06:11:13 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT058.mail.protection.outlook.com (10.13.181.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Thu, 6 Feb 2020 06:11:12 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0166B5F4174490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 22:11:11 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0166B3bp017041;
        Thu, 6 Feb 2020 07:11:03 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0166B3PJ017040;
        Thu, 6 Feb 2020 07:11:03 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v4 05/13] phy: cadence-torrent: Add wrapper for PHY register access
Date:   Thu, 6 Feb 2020 07:10:53 +0100
Message-ID: <1580969461-16981-6-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(36092001)(70206006)(2906002)(70586007)(54906003)(110136005)(42186006)(316002)(36906005)(5660300002)(26005)(36756003)(186003)(86362001)(336012)(81166006)(426003)(81156014)(8676002)(8936002)(4326008)(2616005)(30864003)(356004)(6666004)(107886003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB2857;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d9965d4-c7f2-457d-c8b9-08d7aacb5de1
X-MS-TrafficTypeDiagnostic: DM5PR07MB2857:
X-Microsoft-Antispam-PRVS: <DM5PR07MB28575D7E6D2F899B632D91D0D21D0@DM5PR07MB2857.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TM0ltZXP2jJpCaHJA0JdIQ3QlYZbCZvE/IUtOAYEb3HwsjGwLh2zTfcWPJbUUOCCV2Z9y45Hnk4iCgu6bpDwBE/daGo7KuTJjBYompcxc94wIn3Tm7F3f8Iev+niQd2oV347qSnYJeoze3HVh/IE64kC9YShc1h7Hjqt+/9keRIY44pgo7IY4+ZVBm3MpOOZZA/sL/OUSKw4HbXuS7epYNjAW/MdkxSWPZXpTsivoLgJCsUapMoFPnPxQ7+5a3RdIUUgxx7n7oZnOANr7I4AxlAfUJAvYl3LSYizvqHLPwFVEAw2R5JbRRhTbfec/o4w2ebE2fKUU7v4l2SYYkEiwTrRfWnTBWX3JiTPF0Oj6n1bP4ZSuFaEi/Gvo5tvtSk4bNY8vhXS9+52NciKsrbGLdjJ5EsAXMOVU5ZQonh6SsbVTxkUblHaMdZZSr4bZRUeScoxDGxWPOHceSltuG28D9YByKT8J2YczLxNQHQK/xRgCd6j0Ac6pdptst2lyN41
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:11:12.5805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9965d4-c7f2-457d-c8b9-08d7aacb5de1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2857
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add a wrapper function to write Torrent PHY registers to improve
code readability.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 142 ++++++++++++----------
 1 file changed, 77 insertions(+), 65 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index eb61005077ab..59c85d8b9e16 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -132,6 +132,14 @@ static const struct phy_ops cdns_torrent_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+/* PHY mmr access functions */
+
+static void cdns_torrent_phy_write(struct cdns_torrent_phy *cdns_phy,
+				   u32 offset, u32 val)
+{
+	writel(val, cdns_phy->sd_base + offset);
+}
+
 static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
@@ -234,34 +242,35 @@ static
 void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
 	/* refclock registers - assumes 25 MHz refclock */
-	writel(0x0019, cdns_phy->sd_base + CMN_SSM_BIAS_TMR);
-	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM0_PLLPRE_TMR);
-	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM0_PLLLOCK_TMR);
-	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM1_PLLPRE_TMR);
-	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM1_PLLLOCK_TMR);
-	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_INIT_TMR);
-	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_ITER_TMR);
-	writel(0x0019, cdns_phy->sd_base + CMN_IBCAL_INIT_TMR);
-	writel(0x001E, cdns_phy->sd_base + CMN_TXPUCAL_INIT_TMR);
-	writel(0x0006, cdns_phy->sd_base + CMN_TXPUCAL_ITER_TMR);
-	writel(0x001E, cdns_phy->sd_base + CMN_TXPDCAL_INIT_TMR);
-	writel(0x0006, cdns_phy->sd_base + CMN_TXPDCAL_ITER_TMR);
-	writel(0x02EE, cdns_phy->sd_base + CMN_RXCAL_INIT_TMR);
-	writel(0x0006, cdns_phy->sd_base + CMN_RXCAL_ITER_TMR);
-	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_INIT_TMR);
-	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_ITER_TMR);
-	writel(0x000E, cdns_phy->sd_base + CMN_SD_CAL_REFTIM_START);
-	writel(0x012B, cdns_phy->sd_base + CMN_SD_CAL_PLLCNT_START);
+	cdns_torrent_phy_write(cdns_phy, CMN_SSM_BIAS_TMR, 0x0019);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLPRE_TMR, 0x0032);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLLOCK_TMR, 0x00D1);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLPRE_TMR, 0x0032);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLLOCK_TMR, 0x00D1);
+	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_INIT_TMR, 0x007D);
+	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_ITER_TMR, 0x007D);
+	cdns_torrent_phy_write(cdns_phy, CMN_IBCAL_INIT_TMR, 0x0019);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_INIT_TMR, 0x001E);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_INIT_TMR, 0x001E);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_INIT_TMR, 0x02EE);
+	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_INIT_TMR, 0x0002);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_ITER_TMR, 0x0002);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_REFTIM_START, 0x000E);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_PLLCNT_START, 0x012B);
+
 	/* PLL registers */
-	writel(0x0409, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_PADJ_M0);
-	writel(0x1001, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_IADJ_M0);
-	writel(0x0F08, cdns_phy->sd_base + CMN_PDIAG_PLL0_FILT_PADJ_M0);
-	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_DSM_DIAG_M0);
-	writel(0x00FA, cdns_phy->sd_base + CMN_PLL0_VCOCAL_INIT_TMR);
-	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_VCOCAL_ITER_TMR);
-	writel(0x00FA, cdns_phy->sd_base + CMN_PLL1_VCOCAL_INIT_TMR);
-	writel(0x0004, cdns_phy->sd_base + CMN_PLL1_VCOCAL_ITER_TMR);
-	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_REFTIM_START);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0409);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x1001);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_INIT_TMR, 0x00FA);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_INIT_TMR, 0x00FA);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_REFTIM_START, 0x0318);
 }
 
 static
@@ -269,41 +278,41 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
 	/* Assumes 25 MHz refclock */
 	switch (cdns_phy->max_bit_rate) {
-		/* Setting VCO for 10.8GHz */
+	/* Setting VCO for 10.8GHz */
 	case 2700:
 	case 5400:
-		writel(0x01B0, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
-		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
-		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
-		writel(0x0120, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x01B0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x0120);
 		break;
-		/* Setting VCO for 9.72GHz */
+	/* Setting VCO for 9.72GHz */
 	case 2430:
 	case 3240:
-		writel(0x0184, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
-		writel(0xCCCD, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
-		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
-		writel(0x0104, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0184);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0xCCCD);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x0104);
 		break;
-		/* Setting VCO for 8.64GHz */
+	/* Setting VCO for 8.64GHz */
 	case 2160:
 	case 4320:
-		writel(0x0159, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
-		writel(0x999A, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
-		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
-		writel(0x00E7, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0159);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x999A);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x00E7);
 		break;
-		/* Setting VCO for 8.1GHz */
+	/* Setting VCO for 8.1GHz */
 	case 8100:
-		writel(0x0144, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
-		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
-		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
-		writel(0x00D8, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0144);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x00D8);
 		break;
 	}
 
-	writel(0x0002, cdns_phy->sd_base + CMN_PDIAG_PLL0_CTRL_M0);
-	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_PLLCNT_START);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_PLLCNT_START, 0x0318);
 }
 
 static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
@@ -313,7 +322,7 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 	unsigned int i;
 
 	/* 16'h0000 for single DP link configuration */
-	writel(0x0000, cdns_phy->sd_base + PHY_PLL_CFG);
+	cdns_torrent_phy_write(cdns_phy, PHY_PLL_CFG, 0x0000);
 
 	switch (cdns_phy->max_bit_rate) {
 	case 1620:
@@ -324,7 +333,7 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 	case 2430:
 	case 2700:
 		clk_sel_val = 0x0701;
-		 hsclk_div_val = 1;
+		hsclk_div_val = 1;
 		break;
 	case 3240:
 		clk_sel_val = 0x0b00;
@@ -341,13 +350,14 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 		break;
 	}
 
-	writel(clk_sel_val, cdns_phy->sd_base + CMN_PDIAG_PLL0_CLK_SEL_M0);
+	cdns_torrent_phy_write(cdns_phy,
+			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
 
 	/* PMA lane configuration to deal with multi-link operation */
-	for (i = 0; i < cdns_phy->num_lanes; i++) {
-		writel(hsclk_div_val,
-		       cdns_phy->sd_base + (XCVR_DIAG_HSCLK_DIV | (i << 11)));
-	}
+	for (i = 0; i < cdns_phy->num_lanes; i++)
+		cdns_torrent_phy_write(cdns_phy,
+				       (XCVR_DIAG_HSCLK_DIV | (i << 11)),
+				       hsclk_div_val);
 }
 
 static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
@@ -356,15 +366,17 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 	unsigned int lane_bits = (lane & LANE_MASK) << 11;
 
 	/* Writing Tx/Rx Power State Controllers registers */
-	writel(0x00FB, cdns_phy->sd_base + (TX_PSC_A0 | lane_bits));
-	writel(0x04AA, cdns_phy->sd_base + (TX_PSC_A2 | lane_bits));
-	writel(0x04AA, cdns_phy->sd_base + (TX_PSC_A3 | lane_bits));
-	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A0 | lane_bits));
-	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A2 | lane_bits));
-	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A3 | lane_bits));
-
-	writel(0x0001, cdns_phy->sd_base + (XCVR_DIAG_PLLDRC_CTRL | lane_bits));
-	writel(0x0000, cdns_phy->sd_base + (XCVR_DIAG_HSCLK_SEL | lane_bits));
+	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A0 | lane_bits), 0x00FB);
+	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A2 | lane_bits), 0x04AA);
+	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A3 | lane_bits), 0x04AA);
+	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A0 | lane_bits), 0x0000);
+	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A2 | lane_bits), 0x0000);
+	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A3 | lane_bits), 0x0000);
+
+	cdns_torrent_phy_write(cdns_phy,
+			       (XCVR_DIAG_PLLDRC_CTRL | lane_bits), 0x0001);
+	cdns_torrent_phy_write(cdns_phy,
+			       (XCVR_DIAG_HSCLK_SEL | lane_bits), 0x0000);
 }
 
 static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
-- 
2.20.1

