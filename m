Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9DEC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F11206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="cEoFg0+b";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="q7vjQk8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgBFGLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:11:42 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:11966 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727879AbgBFGLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:31 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01667GUR008108;
        Wed, 5 Feb 2020 22:11:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=iELKL8OJb7NGp6KSwHpyKw+KSnkXy5lzzt/+qsD8h+I=;
 b=cEoFg0+b/W9qi0vSzINTDIO6xgacSlRjiTyrSmycEdnGt2Oh459tkkkxUIqs8eWdgTo4
 jiXoGoxej9e8+tu31fjsMtaMM3xs1wDOFeXeb9TDGAj7vSDwiFE27EkeTT7hde9K7yDP
 xCY+a+Komvht4ZbqYk1vVKNox43Sg+bs062kiLnQusNj/kbm71zctfEfVNfggtqFP4RV
 /EYzmUbhSblzEPP9/uFKpMeJkxQSQwxgPdTzTn5Rnyyu9JbtESmcw34jrptDqsKXmBgv
 xLsEBquEOVU1i2vCad+2fCxNcwECT8fj4R2kNyPfijJc19ifQVG8OtYjV7SoM5veXtFr Qw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xyhkv5pjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4XBESHLdWE/IhKEp1Bs7uRjdJby7VO22XuwfZessTGoY+nfHHfCso2ymLnp+XK4CS2dekIL8rxYJllfqw5MmuPr4UL3teIHTRK+rf5PWbEft78IV4elHEsAGMwgrn7iCLdYebKxpWRMeS+6pyDoUkU2str5eZAmNq4lVCpjNmGLm0TBTt9e98ZAnTV6XhkYL3fbFZ8hrPjUBHpr9RlrY3ViUqHeCXMsHdT/MuWsSQcO0KKSETD1i6b2tzoznpedDtFtZK4diVpITn0gyt9spvIsdJkFhWtB9QNkG0P/SnM7YvMiIktV0PliBM4qsj8MtiaQCeJqE7El/JNc6yJfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iELKL8OJb7NGp6KSwHpyKw+KSnkXy5lzzt/+qsD8h+I=;
 b=QqeZeNtELyVGmkyRFx8Us6wrj5LOXJfSY0hWph7d8KkRoiDV8qBqA9OigWjIdPcZHeLohkPdJT5R/pOKN6OkwYT4xBEyucGsjRzJDYMOV0Ve/xj6NeYTkvtSpo31AHZ+M9jvBLFJR0OkwRW50vNSmqib+GyOA987LNygwAts92LllquahpV2hEBCVd/mZQaorjPO4LP84jjAp64anNUEV6K3BwGv2yjXn9uKaKtTYVMcYb1WsPb+u8Uo0aFd5h4FQtsVsEAeoEO2tXhiyRFLfnFfdYYgFf9/FLTkAupqGxVdtG20vG8nfjZCsfNWGb5JNKTpT7Gv8w/S73JEj56xkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iELKL8OJb7NGp6KSwHpyKw+KSnkXy5lzzt/+qsD8h+I=;
 b=q7vjQk8JzPOdaAjaBskuV+tJriSKJ4vvZiWIwtLZ2ch2hquoIYGNQ6GXgeoBOnghpzvz9gjbDgiE1VBY9YNUNGSqCzw99X0ZEoAQD5ozq0Nm0y0BJyN50AjrKvJdvcD1/EYBGUPn8zRrCkYCSZbxKnZfO63GvbjTHm1ptGFuxuE=
Received: from DM6PR07CA0067.namprd07.prod.outlook.com (2603:10b6:5:74::44) by
 BN7PR07MB4162.namprd07.prod.outlook.com (2603:10b6:406:ba::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 06:11:15 +0000
Received: from MW2NAM12FT061.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::207) by DM6PR07CA0067.outlook.office365.com
 (2603:10b6:5:74::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend
 Transport; Thu, 6 Feb 2020 06:11:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT061.mail.protection.outlook.com (10.13.181.253) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Thu, 6 Feb 2020 06:11:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0166B5F8174490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 22:11:14 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Feb 2020 07:11:04 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Feb 2020 07:11:04 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0166B4O0017064;
        Thu, 6 Feb 2020 07:11:04 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0166B4jv017062;
        Thu, 6 Feb 2020 07:11:04 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v4 10/13] phy: cadence-torrent: Use regmap to read and write Torrent PHY registers
Date:   Thu, 6 Feb 2020 07:10:58 +0100
Message-ID: <1580969461-16981-11-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(199004)(189003)(36092001)(70206006)(478600001)(70586007)(2616005)(86362001)(8936002)(107886003)(42186006)(6666004)(8676002)(5660300002)(356004)(316002)(2906002)(36906005)(81166006)(186003)(30864003)(4326008)(81156014)(54906003)(110136005)(336012)(36756003)(426003)(26005)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4162;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac63c55-19af-4bd0-ec17-08d7aacb5f69
X-MS-TrafficTypeDiagnostic: BN7PR07MB4162:
X-Microsoft-Antispam-PRVS: <BN7PR07MB4162488ED799B11915042993D21D0@BN7PR07MB4162.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6akhttjev2CTdToBC9YYEoMr7dudKcOi6unNLB52GOdotBjobBAlbV0q8AvPh7uvgGwcaq1s0PLU5r+80YHJb1hYz64wP5Jcg1mp1R/g2gc2MV3nlpup+iYSdguMwMdo8jgQ+FCl3uGScrUmsVxcorXub8dotNcdqJQNt8vCb0LuRLqukkWCubcC5jp4j+XBF3LxRetTssg98yn4CRjP7d18B0hPXEZhbDzdLCdTnHeLavRXekEfi7mVLD1AlUpHmQY+4yXn0LrqaQ4GkN2BA6yfYilb5zf/ge49uo7YPhpPiUmOu0sAJklljq/CT3Y+xhzuL8cFfI9/0b2S3O73Iq+WS2TYgbfewhZ+9wxbVyv71P27qcYBu1XP4CHoJqJ/W2oRazWg+UNTgVQefoGqCGsLNYlMeH5VMbXAqcrvKk9TAovTrfZU1av9VfGbaSV8KHOPkKvJOA7d4pckWS7t2sCOfcYXYqC7elPgIkGMOvAW0F8lMQXfaIjMqa88hpab
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:11:15.1515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac63c55-19af-4bd0-ec17-08d7aacb5f69
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4162
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

Use regmap for accessing Torrent PHY registers. Modify register offsets
as defined in Torrent PHY user guide. Abstract address calculation
using regmap APIs.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 1019 +++++++++++++--------
 1 file changed, 650 insertions(+), 369 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index e3b33569285f..027667a17ebe 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -18,6 +18,7 @@
 #include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #define REF_CLK_19_2MHz		19200000
 #define REF_CLK_25MHz		25000000
@@ -27,7 +28,22 @@
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
 #define POLL_TIMEOUT_US		5000
-#define LANE_MASK		0x7
+
+#define TORRENT_COMMON_CDB_OFFSET	0x0
+
+#define TORRENT_TX_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
+				((0x4000 << (block_offset)) +		\
+				(((ln) << 9) << (reg_offset)))
+
+#define TORRENT_RX_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
+				((0x8000 << (block_offset)) +		\
+				(((ln) << 9) << (reg_offset)))
+
+#define TORRENT_PHY_PCS_COMMON_OFFSET(block_offset)	\
+				(0xC000 << (block_offset))
+
+#define TORRENT_PHY_PMA_COMMON_OFFSET(block_offset)	\
+				(0xE000 << (block_offset))
 
 /*
  * register offsets from DPTX PHY register block base (i.e MHDP
@@ -56,100 +72,114 @@
  * register offsets from SD0801 PHY register block base (i.e MHDP
  * register base + 0x500000)
  */
-#define CMN_SSM_BANDGAP_TMR		0x00084
-#define CMN_SSM_BIAS_TMR		0x00088
-#define CMN_PLLSM0_PLLPRE_TMR		0x000a8
-#define CMN_PLLSM0_PLLLOCK_TMR		0x000b0
-#define CMN_PLLSM1_PLLPRE_TMR		0x000c8
-#define CMN_PLLSM1_PLLLOCK_TMR		0x000d0
-#define CMN_BGCAL_INIT_TMR		0x00190
-#define CMN_BGCAL_ITER_TMR		0x00194
-#define CMN_IBCAL_INIT_TMR		0x001d0
-#define CMN_PLL0_VCOCAL_TCTRL		0x00208
-#define CMN_PLL0_VCOCAL_INIT_TMR	0x00210
-#define CMN_PLL0_VCOCAL_ITER_TMR	0x00214
-#define CMN_PLL0_VCOCAL_REFTIM_START	0x00218
-#define CMN_PLL0_VCOCAL_PLLCNT_START	0x00220
-#define CMN_PLL0_INTDIV_M0		0x00240
-#define CMN_PLL0_FRACDIVL_M0		0x00244
-#define CMN_PLL0_FRACDIVH_M0		0x00248
-#define CMN_PLL0_HIGH_THR_M0		0x0024c
-#define CMN_PLL0_DSM_DIAG_M0		0x00250
-#define CMN_PLL0_SS_CTRL1_M0		0x00260
-#define CMN_PLL0_SS_CTRL2_M0            0x00264
-#define CMN_PLL0_SS_CTRL3_M0            0x00268
-#define CMN_PLL0_SS_CTRL4_M0            0x0026C
-#define CMN_PLL0_LOCK_REFCNT_START      0x00270
-#define CMN_PLL0_LOCK_PLLCNT_START	0x00278
-#define CMN_PLL0_LOCK_PLLCNT_THR        0x0027C
-#define CMN_PLL1_VCOCAL_TCTRL		0x00308
-#define CMN_PLL1_VCOCAL_INIT_TMR	0x00310
-#define CMN_PLL1_VCOCAL_ITER_TMR	0x00314
-#define CMN_PLL1_VCOCAL_REFTIM_START	0x00318
-#define CMN_PLL1_VCOCAL_PLLCNT_START	0x00320
-#define CMN_PLL1_INTDIV_M0		0x00340
-#define CMN_PLL1_FRACDIVL_M0		0x00344
-#define CMN_PLL1_FRACDIVH_M0		0x00348
-#define CMN_PLL1_HIGH_THR_M0		0x0034c
-#define CMN_PLL1_DSM_DIAG_M0		0x00350
-#define CMN_PLL1_SS_CTRL1_M0		0x00360
-#define CMN_PLL1_SS_CTRL2_M0            0x00364
-#define CMN_PLL1_SS_CTRL3_M0            0x00368
-#define CMN_PLL1_SS_CTRL4_M0            0x0036C
-#define CMN_PLL1_LOCK_REFCNT_START      0x00370
-#define CMN_PLL1_LOCK_PLLCNT_START	0x00378
-#define CMN_PLL1_LOCK_PLLCNT_THR        0x0037C
-#define CMN_TXPUCAL_INIT_TMR		0x00410
-#define CMN_TXPUCAL_ITER_TMR		0x00414
-#define CMN_TXPDCAL_INIT_TMR		0x00430
-#define CMN_TXPDCAL_ITER_TMR		0x00434
-#define CMN_RXCAL_INIT_TMR		0x00450
-#define CMN_RXCAL_ITER_TMR		0x00454
-#define CMN_SD_CAL_INIT_TMR		0x00490
-#define CMN_SD_CAL_ITER_TMR		0x00494
-#define CMN_SD_CAL_REFTIM_START		0x00498
-#define CMN_SD_CAL_PLLCNT_START		0x004a0
-#define CMN_PDIAG_PLL0_CTRL_M0		0x00680
-#define CMN_PDIAG_PLL0_CLK_SEL_M0	0x00684
-#define CMN_PDIAG_PLL0_CP_PADJ_M0	0x00690
-#define CMN_PDIAG_PLL0_CP_IADJ_M0	0x00694
-#define CMN_PDIAG_PLL0_FILT_PADJ_M0	0x00698
-#define CMN_PDIAG_PLL0_CP_PADJ_M1	0x006d0
-#define CMN_PDIAG_PLL0_CP_IADJ_M1	0x006d4
-#define CMN_PDIAG_PLL1_CTRL_M0		0x00700
-#define CMN_PDIAG_PLL1_CLK_SEL_M0	0x00704
-#define CMN_PDIAG_PLL1_CP_PADJ_M0	0x00710
-#define CMN_PDIAG_PLL1_CP_IADJ_M0	0x00714
-#define CMN_PDIAG_PLL1_FILT_PADJ_M0	0x00718
-
-#define TX_TXCC_CTRL			0x10100
-#define TX_TXCC_CPOST_MULT_00		0x10130
-#define TX_TXCC_MGNFS_MULT_000		0x10140
-#define DRV_DIAG_TX_DRV			0x10318
-#define XCVR_DIAG_PLLDRC_CTRL		0x10394
-#define XCVR_DIAG_HSCLK_SEL		0x10398
-#define XCVR_DIAG_HSCLK_DIV		0x1039c
-#define XCVR_DIAG_BIDI_CTRL		0x103a8
-#define TX_PSC_A0			0x10400
-#define TX_PSC_A1			0x10404
-#define TX_PSC_A2			0x10408
-#define TX_PSC_A3			0x1040c
-#define TX_RCVDET_ST_TMR		0x1048c
-#define TX_DIAG_ACYA			0x1079c
+#define CMN_SSM_BANDGAP_TMR		0x0021U
+#define CMN_SSM_BIAS_TMR		0x0022U
+#define CMN_PLLSM0_PLLPRE_TMR		0x002AU
+#define CMN_PLLSM0_PLLLOCK_TMR		0x002CU
+#define CMN_PLLSM1_PLLPRE_TMR		0x0032U
+#define CMN_PLLSM1_PLLLOCK_TMR		0x0034U
+#define CMN_BGCAL_INIT_TMR		0x0064U
+#define CMN_BGCAL_ITER_TMR		0x0065U
+#define CMN_IBCAL_INIT_TMR		0x0074U
+#define CMN_PLL0_VCOCAL_TCTRL		0x0082U
+#define CMN_PLL0_VCOCAL_INIT_TMR	0x0084U
+#define CMN_PLL0_VCOCAL_ITER_TMR	0x0085U
+#define CMN_PLL0_VCOCAL_REFTIM_START	0x0086U
+#define CMN_PLL0_VCOCAL_PLLCNT_START	0x0088U
+#define CMN_PLL0_INTDIV_M0		0x0090U
+#define CMN_PLL0_FRACDIVL_M0		0x0091U
+#define CMN_PLL0_FRACDIVH_M0		0x0092U
+#define CMN_PLL0_HIGH_THR_M0		0x0093U
+#define CMN_PLL0_DSM_DIAG_M0		0x0094U
+#define CMN_PLL0_SS_CTRL1_M0		0x0098U
+#define CMN_PLL0_SS_CTRL2_M0            0x0099U
+#define CMN_PLL0_SS_CTRL3_M0            0x009AU
+#define CMN_PLL0_SS_CTRL4_M0            0x009BU
+#define CMN_PLL0_LOCK_REFCNT_START      0x009CU
+#define CMN_PLL0_LOCK_PLLCNT_START	0x009EU
+#define CMN_PLL0_LOCK_PLLCNT_THR        0x009FU
+#define CMN_PLL1_VCOCAL_TCTRL		0x00C2U
+#define CMN_PLL1_VCOCAL_INIT_TMR	0x00C4U
+#define CMN_PLL1_VCOCAL_ITER_TMR	0x00C5U
+#define CMN_PLL1_VCOCAL_REFTIM_START	0x00C6U
+#define CMN_PLL1_VCOCAL_PLLCNT_START	0x00C8U
+#define CMN_PLL1_INTDIV_M0		0x00D0U
+#define CMN_PLL1_FRACDIVL_M0		0x00D1U
+#define CMN_PLL1_FRACDIVH_M0		0x00D2U
+#define CMN_PLL1_HIGH_THR_M0		0x00D3U
+#define CMN_PLL1_DSM_DIAG_M0		0x00D4U
+#define CMN_PLL1_SS_CTRL1_M0		0x00D8U
+#define CMN_PLL1_SS_CTRL2_M0            0x00D9U
+#define CMN_PLL1_SS_CTRL3_M0            0x00DAU
+#define CMN_PLL1_SS_CTRL4_M0            0x00DBU
+#define CMN_PLL1_LOCK_REFCNT_START      0x00DCU
+#define CMN_PLL1_LOCK_PLLCNT_START	0x00DEU
+#define CMN_PLL1_LOCK_PLLCNT_THR        0x00DFU
+#define CMN_TXPUCAL_INIT_TMR		0x0104U
+#define CMN_TXPUCAL_ITER_TMR		0x0105U
+#define CMN_TXPDCAL_INIT_TMR		0x010CU
+#define CMN_TXPDCAL_ITER_TMR		0x010DU
+#define CMN_RXCAL_INIT_TMR		0x0114U
+#define CMN_RXCAL_ITER_TMR		0x0115U
+#define CMN_SD_CAL_INIT_TMR		0x0124U
+#define CMN_SD_CAL_ITER_TMR		0x0125U
+#define CMN_SD_CAL_REFTIM_START		0x0126U
+#define CMN_SD_CAL_PLLCNT_START		0x0128U
+#define CMN_PDIAG_PLL0_CTRL_M0		0x01A0U
+#define CMN_PDIAG_PLL0_CLK_SEL_M0	0x01A1U
+#define CMN_PDIAG_PLL0_CP_PADJ_M0	0x01A4U
+#define CMN_PDIAG_PLL0_CP_IADJ_M0	0x01A5U
+#define CMN_PDIAG_PLL0_FILT_PADJ_M0	0x01A6U
+#define CMN_PDIAG_PLL0_CP_PADJ_M1	0x01B4U
+#define CMN_PDIAG_PLL0_CP_IADJ_M1	0x01B5U
+#define CMN_PDIAG_PLL1_CTRL_M0		0x01C0U
+#define CMN_PDIAG_PLL1_CLK_SEL_M0	0x01C1U
+#define CMN_PDIAG_PLL1_CP_PADJ_M0	0x01C4U
+#define CMN_PDIAG_PLL1_CP_IADJ_M0	0x01C5U
+#define CMN_PDIAG_PLL1_FILT_PADJ_M0	0x01C6U
+
+/* PMA TX Lane registers */
+#define TX_TXCC_CTRL			0x0040U
+#define TX_TXCC_CPOST_MULT_00		0x004CU
+#define TX_TXCC_MGNFS_MULT_000		0x0050U
+#define DRV_DIAG_TX_DRV			0x00C6U
+#define XCVR_DIAG_PLLDRC_CTRL		0x00E5U
+#define XCVR_DIAG_HSCLK_SEL		0x00E6U
+#define XCVR_DIAG_HSCLK_DIV		0x00E7U
+#define XCVR_DIAG_BIDI_CTRL		0x00EAU
+#define TX_PSC_A0			0x0100U
+#define TX_PSC_A2			0x0102U
+#define TX_PSC_A3			0x0103U
+#define TX_RCVDET_ST_TMR		0x0123U
+#define TX_DIAG_ACYA			0x01E7U
 #define TX_DIAG_ACYA_HBDC_MASK		0x0001U
-#define RX_PSC_A0			0x20000
-#define RX_PSC_A1			0x20004
-#define RX_PSC_A2			0x20008
-#define RX_PSC_A3			0x2000c
-#define RX_PSC_CAL			0x20018
-#define RX_REE_GCSM1_CTRL		0x20420
-#define RX_REE_GCSM2_CTRL		0x20440
-#define RX_REE_PERGCSM_CTRL		0x20460
 
-#define PHY_PLL_CFG			0x30038
+/* PMA RX Lane registers */
+#define RX_PSC_A0			0x0000U
+#define RX_PSC_A2			0x0002U
+#define RX_PSC_A3			0x0003U
+#define RX_PSC_CAL			0x0006U
+#define RX_REE_GCSM1_CTRL		0x0108U
+#define RX_REE_GCSM2_CTRL		0x0110U
+#define RX_REE_PERGCSM_CTRL		0x0118U
+
+/* PHY PCS common registers */
+#define PHY_PLL_CFG			0x000EU
+
+/* PHY PMA common registers */
+#define PHY_PMA_CMN_CTRL2		0x0001U
+#define PHY_PMA_PLL_RAW_CTRL		0x0003U
 
-#define PHY_PMA_CMN_CTRL2		0x38004
-#define PHY_PMA_PLL_RAW_CTRL		0x3800c
+static const struct reg_field phy_pll_cfg =
+				REG_FIELD(PHY_PLL_CFG, 0, 1);
+
+static const struct reg_field phy_pma_cmn_ctrl_2 =
+				REG_FIELD(PHY_PMA_CMN_CTRL2, 0, 7);
+
+static const struct reg_field phy_pma_pll_raw_ctrl =
+				REG_FIELD(PHY_PMA_PLL_RAW_CTRL, 0, 1);
+
+static const struct of_device_id cdns_torrent_phy_of_match[];
 
 struct cdns_torrent_phy {
 	void __iomem *base;	/* DPTX registers base */
@@ -159,6 +189,15 @@ struct cdns_torrent_phy {
 	struct device *dev;
 	struct clk *clk;
 	unsigned long ref_clk_rate;
+	struct regmap *regmap;
+	struct regmap *regmap_common_cdb;
+	struct regmap *regmap_phy_pcs_common_cdb;
+	struct regmap *regmap_phy_pma_common_cdb;
+	struct regmap *regmap_tx_lane_cdb[MAX_NUM_LANES];
+	struct regmap *regmap_rx_lane_cdb[MAX_NUM_LANES];
+	struct regmap_field *phy_pll_cfg;
+	struct regmap_field *phy_pma_cmn_ctrl_2;
+	struct regmap_field *phy_pma_pll_raw_ctrl;
 };
 
 enum phy_powerstate {
@@ -208,23 +247,106 @@ static const struct phy_ops cdns_torrent_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
-/* PHY mmr access functions */
+struct cdns_torrent_data {
+		u8 block_offset_shift;
+		u8 reg_offset_shift;
+};
 
-static void cdns_torrent_phy_write(struct cdns_torrent_phy *cdns_phy,
-				   u32 offset, u32 val)
+struct cdns_regmap_cdb_context {
+	struct device *dev;
+	void __iomem *base;
+	u8 reg_offset_shift;
+};
+
+static int cdns_regmap_write(void *context, unsigned int reg, unsigned int val)
 {
-	writel(val, cdns_phy->sd_base + offset);
+	struct cdns_regmap_cdb_context *ctx = context;
+	u32 offset = reg << ctx->reg_offset_shift;
+
+	writew(val, ctx->base + offset);
+
+	return 0;
 }
 
-static u32 cdns_torrent_phy_read(struct cdns_torrent_phy *cdns_phy, u32 offset)
+static int cdns_regmap_read(void *context, unsigned int reg, unsigned int *val)
 {
-	return readl(cdns_phy->sd_base + offset);
+	struct cdns_regmap_cdb_context *ctx = context;
+	u32 offset = reg << ctx->reg_offset_shift;
+
+	*val = readw(ctx->base + offset);
+	return 0;
 }
 
-#define cdns_torrent_phy_read_poll_timeout(cdns_phy, offset, val, cond, \
-					   delay_us, timeout_us) \
-	readl_poll_timeout((cdns_phy)->sd_base + (offset), \
-			   val, cond, delay_us, timeout_us)
+#define TORRENT_TX_LANE_CDB_REGMAP_CONF(n) \
+{ \
+	.name = "torrent_tx_lane" n "_cdb", \
+	.reg_stride = 1, \
+	.fast_io = true, \
+	.reg_write = cdns_regmap_write, \
+	.reg_read = cdns_regmap_read, \
+}
+
+#define TORRENT_RX_LANE_CDB_REGMAP_CONF(n) \
+{ \
+	.name = "torrent_rx_lane" n "_cdb", \
+	.reg_stride = 1, \
+	.fast_io = true, \
+	.reg_write = cdns_regmap_write, \
+	.reg_read = cdns_regmap_read, \
+}
+
+static struct regmap_config cdns_torrent_tx_lane_cdb_config[] = {
+	TORRENT_TX_LANE_CDB_REGMAP_CONF("0"),
+	TORRENT_TX_LANE_CDB_REGMAP_CONF("1"),
+	TORRENT_TX_LANE_CDB_REGMAP_CONF("2"),
+	TORRENT_TX_LANE_CDB_REGMAP_CONF("3"),
+};
+
+static struct regmap_config cdns_torrent_rx_lane_cdb_config[] = {
+	TORRENT_RX_LANE_CDB_REGMAP_CONF("0"),
+	TORRENT_RX_LANE_CDB_REGMAP_CONF("1"),
+	TORRENT_RX_LANE_CDB_REGMAP_CONF("2"),
+	TORRENT_RX_LANE_CDB_REGMAP_CONF("3"),
+};
+
+static struct regmap_config cdns_torrent_common_cdb_config = {
+	.name = "torrent_common_cdb",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_write,
+	.reg_read = cdns_regmap_read,
+};
+
+static struct regmap_config cdns_torrent_phy_pcs_cmn_cdb_config = {
+	.name = "torrent_phy_pcs_cmn_cdb",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_write,
+	.reg_read = cdns_regmap_read,
+};
+
+static struct regmap_config cdns_torrent_phy_pma_cmn_cdb_config = {
+	.name = "torrent_phy_pma_cmn_cdb",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_write,
+	.reg_read = cdns_regmap_read,
+};
+
+/* PHY mmr access functions */
+
+static void cdns_torrent_phy_write(struct regmap *regmap, u32 offset, u32 val)
+{
+	regmap_write(regmap, offset, val);
+}
+
+static u32 cdns_torrent_phy_read(struct regmap *regmap, u32 offset)
+{
+	unsigned int val;
+
+	regmap_read(regmap, offset, &val);
+	return val;
+}
 
 /* DPTX mmr access functions */
 
@@ -371,16 +493,16 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 	u32 read_val;
 
 	/* Disable the cmn_pll0_en before re-programming the new data rate. */
-	cdns_torrent_phy_write(cdns_phy, PHY_PMA_PLL_RAW_CTRL, 0);
+	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x0);
 
 	/*
 	 * Wait for PLL ready de-assertion.
 	 * For PLL0 - PHY_PMA_CMN_CTRL2[2] == 1
 	 */
-	ret = cdns_torrent_phy_read_poll_timeout(cdns_phy, PHY_PMA_CMN_CTRL2,
-						 read_val,
-						 ((read_val >> 2) & 0x01) != 0,
-						 0, POLL_TIMEOUT_US);
+	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+					     read_val,
+					     ((read_val >> 2) & 0x01) != 0,
+					     0, POLL_TIMEOUT_US);
 	if (ret)
 		return ret;
 	ndelay(200);
@@ -400,16 +522,16 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
 
 	/* Enable the cmn_pll0_en. */
-	cdns_torrent_phy_write(cdns_phy, PHY_PMA_PLL_RAW_CTRL, 0x3);
+	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x3);
 
 	/*
 	 * Wait for PLL ready assertion.
 	 * For PLL0 - PHY_PMA_CMN_CTRL2[0] == 1
 	 */
-	ret = cdns_torrent_phy_read_poll_timeout(cdns_phy, PHY_PMA_CMN_CTRL2,
-						 read_val,
-						 (read_val & 0x01) != 0,
-						 0, POLL_TIMEOUT_US);
+	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+					     read_val,
+					     (read_val & 0x01) != 0,
+					     0, POLL_TIMEOUT_US);
 	return ret;
 }
 
@@ -601,44 +723,41 @@ static void cdns_torrent_dp_set_voltages(struct cdns_torrent_phy *cdns_phy,
 {
 	u8 lane;
 	u16 val;
-	unsigned int lane_bits;
 
 	for (lane = 0; lane < dp->lanes; lane++) {
-		lane_bits = (lane & LANE_MASK) << 11;
-
-		val = cdns_torrent_phy_read(cdns_phy,
-					    (TX_DIAG_ACYA | lane_bits));
+		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
+					    TX_DIAG_ACYA);
 		/*
 		 * Write 1 to register bit TX_DIAG_ACYA[0] to freeze the
 		 * current state of the analog TX driver.
 		 */
 		val |= TX_DIAG_ACYA_HBDC_MASK;
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_DIAG_ACYA | lane_bits), val);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_DIAG_ACYA, val);
 
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_TXCC_CTRL | lane_bits), 0x08A4);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_TXCC_CTRL, 0x08A4);
 		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].diag_tx_drv;
-		cdns_torrent_phy_write(cdns_phy,
-				       (DRV_DIAG_TX_DRV | lane_bits), val);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       DRV_DIAG_TX_DRV, val);
 		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].mgnfs_mult;
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_TXCC_MGNFS_MULT_000 | lane_bits),
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_TXCC_MGNFS_MULT_000,
 				       val);
 		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].cpost_mult;
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_TXCC_CPOST_MULT_00 | lane_bits),
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_TXCC_CPOST_MULT_00,
 				       val);
 
-		val = cdns_torrent_phy_read(cdns_phy,
-					    (TX_DIAG_ACYA | lane_bits));
+		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
+					    TX_DIAG_ACYA);
 		/*
 		 * Write 0 to register bit TX_DIAG_ACYA[0] to allow the state of
 		 * analog TX driver to reflect the new programmed one.
 		 */
 		val &= ~TX_DIAG_ACYA_HBDC_MASK;
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_DIAG_ACYA | lane_bits), val);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_DIAG_ACYA, val);
 	}
 };
 
@@ -797,43 +916,45 @@ static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy)
 static
 void cdns_torrent_dp_pma_cmn_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy)
 {
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
 	/* refclock registers - assumes 19.2 MHz refclock */
-	cdns_torrent_phy_write(cdns_phy, CMN_SSM_BIAS_TMR, 0x0014);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLPRE_TMR, 0x0027);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLLOCK_TMR, 0x00A1);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLPRE_TMR, 0x0027);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLLOCK_TMR, 0x00A1);
-	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_INIT_TMR, 0x0060);
-	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_ITER_TMR, 0x0060);
-	cdns_torrent_phy_write(cdns_phy, CMN_IBCAL_INIT_TMR, 0x0014);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_INIT_TMR, 0x0018);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_ITER_TMR, 0x0005);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_INIT_TMR, 0x0018);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_ITER_TMR, 0x0005);
-	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_INIT_TMR, 0x0240);
-	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_ITER_TMR, 0x0005);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_INIT_TMR, 0x0002);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_ITER_TMR, 0x0002);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_REFTIM_START, 0x000B);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_PLLCNT_START, 0x0137);
+	cdns_torrent_phy_write(regmap, CMN_SSM_BIAS_TMR, 0x0014);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLPRE_TMR, 0x0027);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLLOCK_TMR, 0x00A1);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLPRE_TMR, 0x0027);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLLOCK_TMR, 0x00A1);
+	cdns_torrent_phy_write(regmap, CMN_BGCAL_INIT_TMR, 0x0060);
+	cdns_torrent_phy_write(regmap, CMN_BGCAL_ITER_TMR, 0x0060);
+	cdns_torrent_phy_write(regmap, CMN_IBCAL_INIT_TMR, 0x0014);
+	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_INIT_TMR, 0x0018);
+	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_ITER_TMR, 0x0005);
+	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_INIT_TMR, 0x0018);
+	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_ITER_TMR, 0x0005);
+	cdns_torrent_phy_write(regmap, CMN_RXCAL_INIT_TMR, 0x0240);
+	cdns_torrent_phy_write(regmap, CMN_RXCAL_ITER_TMR, 0x0005);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_INIT_TMR, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_ITER_TMR, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_REFTIM_START, 0x000B);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_PLLCNT_START, 0x0137);
 
 	/* PLL registers */
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_INIT_TMR, 0x00C0);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_INIT_TMR, 0x00C0);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_REFTIM_START, 0x0260);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_REFTIM_START, 0x0260);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_INIT_TMR, 0x00C0);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_INIT_TMR, 0x00C0);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_REFTIM_START, 0x0260);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_REFTIM_START, 0x0260);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
 }
 
 /*
@@ -844,44 +965,48 @@ static
 void cdns_torrent_dp_enable_ssc_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 					u32 ctrl2_val, u32 ctrl3_val)
 {
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, ctrl3_val);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL4_M0, 0x0003);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, ctrl3_val);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL4_M0, 0x0003);
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl3_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl3_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0003);
 }
 
 static
 void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 					     u32 rate, bool ssc)
 {
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
 	/* Assumes 19.2 MHz refclock */
 	switch (rate) {
 	/* Setting VCO for 10.8GHz */
 	case 2700:
 	case 5400:
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_INTDIV_M0, 0x0119);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_HIGH_THR_M0, 0x00BC);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL0_CTRL_M0, 0x0012);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_INTDIV_M0, 0x0119);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_HIGH_THR_M0, 0x00BC);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL1_CTRL_M0, 0x0012);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x033A,
@@ -891,25 +1016,25 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 	case 1620:
 	case 2430:
 	case 3240:
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_INTDIV_M0, 0x01FA);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_HIGH_THR_M0, 0x0152);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_INTDIV_M0, 0x01FA);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_HIGH_THR_M0, 0x0152);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x05DD,
@@ -918,25 +1043,25 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 	/* Setting VCO for 8.64GHz */
 	case 2160:
 	case 4320:
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_INTDIV_M0, 0x01C2);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_HIGH_THR_M0, 0x012C);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_INTDIV_M0, 0x01C2);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_HIGH_THR_M0, 0x012C);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x0536,
@@ -944,25 +1069,25 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 		break;
 	/* Setting VCO for 8.1GHz */
 	case 8100:
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_INTDIV_M0, 0x01A5);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVL_M0, 0xE000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_HIGH_THR_M0, 0x011A);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_INTDIV_M0, 0x01A5);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVL_M0, 0xE000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_HIGH_THR_M0, 0x011A);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x04D7,
@@ -971,88 +1096,90 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 	}
 
 	if (ssc) {
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x025E);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x025E);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
 	} else {
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0260);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0260);
 		/* Set reset register values to disable SSC */
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
 	}
 
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_LOCK_REFCNT_START, 0x0099);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_LOCK_PLLCNT_START, 0x0099);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_LOCK_REFCNT_START, 0x0099);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_LOCK_PLLCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_REFCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x0099);
 }
 
 static
 void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
 	/* refclock registers - assumes 25 MHz refclock */
-	cdns_torrent_phy_write(cdns_phy, CMN_SSM_BIAS_TMR, 0x0019);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLPRE_TMR, 0x0032);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLLOCK_TMR, 0x00D1);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLPRE_TMR, 0x0032);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLLOCK_TMR, 0x00D1);
-	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_INIT_TMR, 0x007D);
-	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_ITER_TMR, 0x007D);
-	cdns_torrent_phy_write(cdns_phy, CMN_IBCAL_INIT_TMR, 0x0019);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_INIT_TMR, 0x001E);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_ITER_TMR, 0x0006);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_INIT_TMR, 0x001E);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_ITER_TMR, 0x0006);
-	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_INIT_TMR, 0x02EE);
-	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_ITER_TMR, 0x0006);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_INIT_TMR, 0x0002);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_ITER_TMR, 0x0002);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_REFTIM_START, 0x000E);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_PLLCNT_START, 0x012B);
+	cdns_torrent_phy_write(regmap, CMN_SSM_BIAS_TMR, 0x0019);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLPRE_TMR, 0x0032);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLLOCK_TMR, 0x00D1);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLPRE_TMR, 0x0032);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLLOCK_TMR, 0x00D1);
+	cdns_torrent_phy_write(regmap, CMN_BGCAL_INIT_TMR, 0x007D);
+	cdns_torrent_phy_write(regmap, CMN_BGCAL_ITER_TMR, 0x007D);
+	cdns_torrent_phy_write(regmap, CMN_IBCAL_INIT_TMR, 0x0019);
+	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_INIT_TMR, 0x001E);
+	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_INIT_TMR, 0x001E);
+	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(regmap, CMN_RXCAL_INIT_TMR, 0x02EE);
+	cdns_torrent_phy_write(regmap, CMN_RXCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_INIT_TMR, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_ITER_TMR, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_REFTIM_START, 0x000E);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_PLLCNT_START, 0x012B);
 
 	/* PLL registers */
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_INIT_TMR, 0x00FA);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_INIT_TMR, 0x00FA);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_REFTIM_START, 0x0317);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_REFTIM_START, 0x0317);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_INIT_TMR, 0x00FA);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_INIT_TMR, 0x00FA);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_REFTIM_START, 0x0317);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_REFTIM_START, 0x0317);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
 }
 
 /*
@@ -1062,33 +1189,37 @@ void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 static void cdns_torrent_dp_enable_ssc_25mhz(struct cdns_torrent_phy *cdns_phy,
 					     u32 ctrl2_val)
 {
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, 0x007F);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL4_M0, 0x0003);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, 0x007F);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL4_M0, 0x0003);
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x007F);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x007F);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0003);
 }
 
 static
 void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
 					   u32 rate, bool ssc)
 {
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
 	/* Assumes 25 MHz refclock */
 	switch (rate) {
 	/* Setting VCO for 10.8GHz */
 	case 2700:
 	case 5400:
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x01B0);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x0120);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_INTDIV_M0, 0x01B0);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_HIGH_THR_M0, 0x0120);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x01B0);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0120);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x01B0);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0120);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x0423);
 		break;
@@ -1096,82 +1227,82 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
 	case 1620:
 	case 2430:
 	case 3240:
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0184);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0xCCCD);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x0104);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_INTDIV_M0, 0x0184);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVL_M0, 0xCCCD);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_HIGH_THR_M0, 0x0104);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0184);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0xCCCD);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0104);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0184);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0xCCCD);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0104);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x03B9);
 		break;
 	/* Setting VCO for 8.64GHz */
 	case 2160:
 	case 4320:
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0159);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x999A);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x00E7);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_INTDIV_M0, 0x0159);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVL_M0, 0x999A);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_HIGH_THR_M0, 0x00E7);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0159);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x999A);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00E7);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0159);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x999A);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00E7);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x034F);
 		break;
 	/* Setting VCO for 8.1GHz */
 	case 8100:
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0144);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x00D8);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_INTDIV_M0, 0x0144);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_HIGH_THR_M0, 0x00D8);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0144);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00D8);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0144);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00D8);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x031A);
 		break;
 	}
 
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
 
 	if (ssc) {
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0315);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0315);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
 	} else {
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0317);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0317);
 		/* Set reset register values to disable SSC */
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
 	}
 
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_LOCK_REFCNT_START, 0x00C7);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_LOCK_PLLCNT_START, 0x00C7);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_LOCK_REFCNT_START, 0x00C7);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_REFCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
 }
 
 static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
@@ -1182,7 +1313,7 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
 	unsigned int i;
 
 	/* 16'h0000 for single DP link configuration */
-	cdns_torrent_phy_write(cdns_phy, PHY_PLL_CFG, 0x0000);
+	regmap_field_write(cdns_phy->phy_pll_cfg, 0x0);
 
 	switch (rate) {
 	case 1620:
@@ -1210,54 +1341,58 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
 		break;
 	}
 
-	cdns_torrent_phy_write(cdns_phy,
+	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
 			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
-	cdns_torrent_phy_write(cdns_phy,
+	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
 			       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
 
 	/* PMA lane configuration to deal with multi-link operation */
 	for (i = 0; i < num_lanes; i++)
-		cdns_torrent_phy_write(cdns_phy,
-				       (XCVR_DIAG_HSCLK_DIV | (i << 11)),
-				       hsclk_div_val);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[i],
+				       XCVR_DIAG_HSCLK_DIV, hsclk_div_val);
 }
 
 static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 					 unsigned int lane)
 {
-	unsigned int lane_bits = (lane & LANE_MASK) << 11;
-
 	/* Per lane, refclock-dependent receiver detection setting */
 	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz)
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_RCVDET_ST_TMR | lane_bits), 0x0780);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_RCVDET_ST_TMR, 0x0780);
 	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz)
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_RCVDET_ST_TMR | lane_bits), 0x09C4);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_RCVDET_ST_TMR, 0x09C4);
 
 	/* Writing Tx/Rx Power State Controllers registers */
-	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A0 | lane_bits), 0x00FB);
-	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A2 | lane_bits), 0x04AA);
-	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A3 | lane_bits), 0x04AA);
-	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A0 | lane_bits), 0x0000);
-	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A2 | lane_bits), 0x0000);
-	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A3 | lane_bits), 0x0000);
-
-	cdns_torrent_phy_write(cdns_phy, (RX_PSC_CAL | lane_bits), 0x0000);
-
-	cdns_torrent_phy_write(cdns_phy,
-			       (RX_REE_GCSM1_CTRL | lane_bits), 0x0000);
-	cdns_torrent_phy_write(cdns_phy,
-			       (RX_REE_GCSM2_CTRL | lane_bits), 0x0000);
-	cdns_torrent_phy_write(cdns_phy,
-			       (RX_REE_PERGCSM_CTRL | lane_bits), 0x0000);
-
-	cdns_torrent_phy_write(cdns_phy,
-			       (XCVR_DIAG_BIDI_CTRL | lane_bits), 0x000F);
-	cdns_torrent_phy_write(cdns_phy,
-			       (XCVR_DIAG_PLLDRC_CTRL | lane_bits), 0x0001);
-	cdns_torrent_phy_write(cdns_phy,
-			       (XCVR_DIAG_HSCLK_SEL | lane_bits), 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       TX_PSC_A0, 0x00FB);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       TX_PSC_A2, 0x04AA);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       TX_PSC_A3, 0x04AA);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_PSC_A0, 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_PSC_A2, 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_PSC_A3, 0x0000);
+
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_PSC_CAL, 0x0000);
+
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_REE_GCSM1_CTRL, 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_REE_GCSM2_CTRL, 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_REE_PERGCSM_CTRL, 0x0000);
+
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       XCVR_DIAG_BIDI_CTRL, 0x000F);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       XCVR_DIAG_PLLDRC_CTRL, 0x0001);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       XCVR_DIAG_HSCLK_SEL, 0x0000);
 }
 
 static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
@@ -1371,14 +1506,142 @@ static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
 			      start_bit))));
 }
 
+static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
+				       u32 block_offset,
+				       u8 reg_offset_shift,
+				       const struct regmap_config *config)
+{
+	struct cdns_regmap_cdb_context *ctx;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->dev = dev;
+	ctx->base = base + block_offset;
+	ctx->reg_offset_shift = reg_offset_shift;
+
+	return devm_regmap_init(dev, NULL, ctx, config);
+}
+
+static int cdns_regfield_init(struct cdns_torrent_phy *cdns_phy)
+{
+	struct device *dev = cdns_phy->dev;
+	struct regmap_field *field;
+	struct regmap *regmap;
+
+	regmap = cdns_phy->regmap_phy_pcs_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pll_cfg);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PLL_CFG reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_pll_cfg = field;
+
+	regmap = cdns_phy->regmap_phy_pma_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pma_cmn_ctrl_2);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PMA_CMN_CTRL2 reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_pma_cmn_ctrl_2 = field;
+
+	regmap = cdns_phy->regmap_phy_pma_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pma_pll_raw_ctrl);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PMA_PLL_RAW_CTRL reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_pma_pll_raw_ctrl = field;
+
+	return 0;
+}
+
+static int cdns_regmap_init_torrent_dp(struct cdns_torrent_phy *cdns_phy,
+				       void __iomem *sd_base,
+				       void __iomem *base,
+				       u8 block_offset_shift,
+				       u8 reg_offset_shift)
+{
+	struct device *dev = cdns_phy->dev;
+	struct regmap *regmap;
+	u32 block_offset;
+	int i;
+
+	for (i = 0; i < MAX_NUM_LANES; i++) {
+		block_offset = TORRENT_TX_LANE_CDB_OFFSET(i, block_offset_shift,
+							  reg_offset_shift);
+		regmap = cdns_regmap_init(dev, sd_base, block_offset,
+					  reg_offset_shift,
+					  &cdns_torrent_tx_lane_cdb_config[i]);
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "Failed to init tx lane CDB regmap\n");
+			return PTR_ERR(regmap);
+		}
+		cdns_phy->regmap_tx_lane_cdb[i] = regmap;
+
+		block_offset = TORRENT_RX_LANE_CDB_OFFSET(i, block_offset_shift,
+							  reg_offset_shift);
+		regmap = cdns_regmap_init(dev, sd_base, block_offset,
+					  reg_offset_shift,
+					  &cdns_torrent_rx_lane_cdb_config[i]);
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "Failed to init rx lane CDB regmap\n");
+			return PTR_ERR(regmap);
+		}
+		cdns_phy->regmap_rx_lane_cdb[i] = regmap;
+	}
+
+	block_offset = TORRENT_COMMON_CDB_OFFSET;
+	regmap = cdns_regmap_init(dev, sd_base, block_offset,
+				  reg_offset_shift,
+				  &cdns_torrent_common_cdb_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init common CDB regmap\n");
+		return PTR_ERR(regmap);
+	}
+	cdns_phy->regmap_common_cdb = regmap;
+
+	block_offset = TORRENT_PHY_PCS_COMMON_OFFSET(block_offset_shift);
+	regmap = cdns_regmap_init(dev, sd_base, block_offset,
+				  reg_offset_shift,
+				  &cdns_torrent_phy_pcs_cmn_cdb_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init PHY PCS common CDB regmap\n");
+		return PTR_ERR(regmap);
+	}
+	cdns_phy->regmap_phy_pcs_common_cdb = regmap;
+
+	block_offset = TORRENT_PHY_PMA_COMMON_OFFSET(block_offset_shift);
+	regmap = cdns_regmap_init(dev, sd_base, block_offset,
+				  reg_offset_shift,
+				  &cdns_torrent_phy_pma_cmn_cdb_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init PHY PMA common CDB regmap\n");
+		return PTR_ERR(regmap);
+	}
+	cdns_phy->regmap_phy_pma_common_cdb = regmap;
+
+	return 0;
+}
+
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
 {
 	struct resource *regs;
 	struct cdns_torrent_phy *cdns_phy;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
+	const struct of_device_id *match;
+	struct cdns_torrent_data *data;
 	struct phy *phy;
-	int err;
+	int err, ret;
+
+	/* Get init data for this PHY */
+	match = of_match_device(cdns_torrent_phy_of_match, dev);
+	if (!match)
+		return -EINVAL;
+
+	data = (struct cdns_torrent_data *)match->data;
 
 	cdns_phy = devm_kzalloc(dev, sizeof(*cdns_phy), GFP_KERNEL);
 	if (!cdns_phy)
@@ -1393,14 +1656,15 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cdns_phy->sd_base = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(cdns_phy->sd_base))
+		return PTR_ERR(cdns_phy->sd_base);
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	cdns_phy->base = devm_ioremap_resource(&pdev->dev, regs);
 	if (IS_ERR(cdns_phy->base))
 		return PTR_ERR(cdns_phy->base);
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	cdns_phy->sd_base = devm_ioremap_resource(&pdev->dev, regs);
-	if (IS_ERR(cdns_phy->sd_base))
-		return PTR_ERR(cdns_phy->sd_base);
 
 	err = device_property_read_u32(dev, "num_lanes",
 				       &cdns_phy->num_lanes);
@@ -1449,6 +1713,17 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 
 	phy_set_drvdata(phy, cdns_phy);
 
+	ret = cdns_regmap_init_torrent_dp(cdns_phy, cdns_phy->sd_base,
+					  cdns_phy->base,
+					  data->block_offset_shift,
+					  data->reg_offset_shift);
+	if (ret)
+		return ret;
+
+	ret = cdns_regfield_init(cdns_phy);
+	if (ret)
+		return ret;
+
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
 	dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
@@ -1459,9 +1734,15 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static const struct cdns_torrent_data cdns_map_torrent = {
+	.block_offset_shift = 0x2,
+	.reg_offset_shift = 0x2,
+};
+
 static const struct of_device_id cdns_torrent_phy_of_match[] = {
 	{
-		.compatible = "cdns,torrent-phy"
+		.compatible = "cdns,torrent-phy",
+		.data = &cdns_map_torrent,
 	},
 	{}
 };
-- 
2.20.1

