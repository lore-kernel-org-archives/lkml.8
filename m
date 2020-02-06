Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C697C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE31206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Bhx0HudQ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="W9rcoN/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgBFGMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:12:01 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:25120 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727855AbgBFGL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:27 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01669BNA015926;
        Wed, 5 Feb 2020 22:11:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=gIrdCsvH11r9eRktnVcUoW4HxkeogHVKeWJrIEMT0KE=;
 b=Bhx0HudQX0DDD6s7svu2xY5KwrcfMbgcf35KJwG0zFTw7FWcjSiauDusu9vx2+iJISgT
 uZGZFy20N2qeJHwAP2M/AFQbR0BjjEseJxGOPIRVeOXYXaTK5n82FvwNBJPaZiYloS6n
 AAYUlJIRuPI3b6ebaqrAsKHskK6qJMIdpCtkYkkY02uagaTRssoy+VLLfxF75dxbfWzD
 dgDB7pzlc4Wu6y5RypviafDJ8286PJ1WvKNQ5cDaV438W10iZvYNgtfcpXQp8kryw9mE
 vOoolHFmUYRIXJxhNxP842YYFQD/klXxtptlq5lNyrDNLQrA1z5XkK5rT+PCN/kn6TGc 5Q== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xyhkunrb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWWe207m0q0ULmNHjbWfSvWq5W/TCaidLDdQ4/SN0lhmTkaVwbe7MgrNHSvCvSgquDLT/u4AfyVP316QrU2YT0a7z17giEUfHxiuDeszHUD1FBIhm5fCfbH4yqufjaHMIecXr50KQVUoYMuUj0ik4FD90w2MmejmZr8OmeA4RN9qQwlNWqheDvhfS9LdGGCXKYKCpp0hAit+HP+y6iUnXqy4C5dqmvrnOh0fLgygrrEQAmj0PV4gMhTX09xWwwLG4JbcQ1CaiHWwrCbAgdCDQLwFWcS95Fp/4daKBvhm1CFRw6+LBuq67IazGnnk2HWi2Y0NNP28tbJdjdyYcyC2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIrdCsvH11r9eRktnVcUoW4HxkeogHVKeWJrIEMT0KE=;
 b=GxO59jrne+ffuZXgpWY2YwmkDtFX3KAo7BLuCoM0/P5s+PGIniXaIotbATcly0FmqCFk8NP7fHeuYONH0uOb9nFK9AAONY4izHj4qPGZK8o38yLPTA4N6/Bv93gh0dxCo9fMupQyZRiWHTMyzCdLIH/t8v8hlHo7nFyLy3Lg2CLt7dsCX6CE2AdO7kwHZ7rbNLhBozQgvsTESw/wWOXy7BDh71lWwA5bIeX/TCjw81NGBcgTIgeOuCeHSwUd2XOVMZAUn0v1Rh5e0wPadeLcZVVwEhAVgo5qqjWURPH8sQlYMRqYgfCu4OhEvO0+56zpMmJGLbK6YI7zy49tuZ2mKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIrdCsvH11r9eRktnVcUoW4HxkeogHVKeWJrIEMT0KE=;
 b=W9rcoN/cGRwcnZs6rb1BoWZMz8jgbYyy+lBv7LViEY4soNP5oXZjEq/WmiXAt8DF1FM1Abwy8sOlfjQ1COSKk7KkwmDm13qSF6P+Oiz+BJfu/IR8ZXZnfE9MkvyaqJrLn3H/+F5s5Z2kInN9Saj0nbYs3XCWTRmjp+4rLmKVExI=
Received: from DM5PR07CA0037.namprd07.prod.outlook.com (2603:10b6:3:16::23) by
 MWHPR07MB3454.namprd07.prod.outlook.com (2603:10b6:301:64::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 06:11:15 +0000
Received: from MW2NAM12FT068.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::202) by DM5PR07CA0037.outlook.office365.com
 (2603:10b6:3:16::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 06:11:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT068.mail.protection.outlook.com (10.13.181.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Thu, 6 Feb 2020 06:11:13 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0166B5F5174490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 22:11:12 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0166B3tm017046;
        Thu, 6 Feb 2020 07:11:03 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0166B33J017045;
        Thu, 6 Feb 2020 07:11:03 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v4 06/13] phy: cadence-torrent: Add wrapper for DPTX register access
Date:   Thu, 6 Feb 2020 07:10:54 +0100
Message-ID: <1580969461-16981-7-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(36092001)(5660300002)(86362001)(6666004)(356004)(478600001)(4326008)(2906002)(107886003)(54906003)(26005)(70586007)(316002)(8676002)(426003)(70206006)(186003)(81166006)(36756003)(81156014)(2616005)(110136005)(8936002)(336012)(36906005)(42186006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3454;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a3ca54b-bb8d-4c87-903c-08d7aacb5e33
X-MS-TrafficTypeDiagnostic: MWHPR07MB3454:
X-Microsoft-Antispam-PRVS: <MWHPR07MB3454204F6E8E1BCE33E3CC3FD21D0@MWHPR07MB3454.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aojrHTYDY1qRBfoi+MJJHOSZkwR08X27xvZJBzldBtzKW4gYMDWUCypwz/ZWAzyw2O2W/0ISDRba61tuGdF2zvnaoIg1JMxIlpQT3SeYd/X2lCDfh6/We4U5wJucXj/LBQa4zgFZ/S3qMPOL5MMr5WQGhiu+FU8SZ/iPHn2lI+ucxPK7BQvfBPfymHMQaIzwk8T4t6WMmPLUTkY0mRc3efDBtSTaB2eduFHIOs+bNQ9Z0ZF4kgYESbg3UNw+t6qaqad2k2R74n4Px47Br3HVwz3WZuPQL2o7ONDgyu7BZYI+MqjlFPBMqP/MPOmb2/edqJgbwFS+8fhjDFWq3wEQoozkIowYKCOeCfHEKHhgOHAKeFDbu+mDrWmsjZjP+exRRvlC48Ef4rU3MkS6Fxtoq+MX8gIA2KR1XLd90RRwqUpjwOgx/q6q5Yhnuzipk/a+Zk13lvv1EP3w9zLvs/xhRxf1Fe54Y0f/lBvpDibPSqG1VOGBy0CXM9Hkqm+Sq/9o
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:11:13.1175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3ca54b-bb8d-4c87-903c-08d7aacb5e33
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3454
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add wrapper functions to read, write DisplayPort specific PHY registers to
improve code readability.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 71 ++++++++++++++++-------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 59c85d8b9e16..5c7c185ddbfe 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -140,13 +140,31 @@ static void cdns_torrent_phy_write(struct cdns_torrent_phy *cdns_phy,
 	writel(val, cdns_phy->sd_base + offset);
 }
 
+/* DPTX mmr access functions */
+
+static void cdns_torrent_dp_write(struct cdns_torrent_phy *cdns_phy,
+				  u32 offset, u32 val)
+{
+	writel(val, cdns_phy->base + offset);
+}
+
+static u32 cdns_torrent_dp_read(struct cdns_torrent_phy *cdns_phy, u32 offset)
+{
+	return readl(cdns_phy->base + offset);
+}
+
+#define cdns_torrent_dp_read_poll_timeout(cdns_phy, offset, val, cond, \
+					  delay_us, timeout_us) \
+	readl_poll_timeout((cdns_phy)->base + (offset), \
+			   val, cond, delay_us, timeout_us)
+
 static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
 
 	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
 
-	writel(0x0003, cdns_phy->base + PHY_AUX_CTRL); /* enable AUX */
+	cdns_torrent_dp_write(cdns_phy, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
 	/* PHY PMA registers configuration function */
 	cdns_torrent_dp_pma_cfg(cdns_phy);
@@ -195,11 +213,11 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	 * used lanes
 	 */
 	lane_bits = (1 << cdns_phy->num_lanes) - 1;
-	writel(((0xF & ~lane_bits) << 4) | (0xF & lane_bits),
-	       cdns_phy->base + PHY_RESET);
+	cdns_torrent_dp_write(cdns_phy, PHY_RESET,
+			      ((0xF & ~lane_bits) << 4) | (0xF & lane_bits));
 
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
-	writel(0x0001, cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN);
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
 
 	/* PHY PMA registers configuration functions */
 	cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy);
@@ -219,8 +237,8 @@ void cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 	unsigned int reg;
 	int ret;
 
-	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_CMN_READY, reg,
-				 reg & 1, 0, 500);
+	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy, PHY_PMA_CMN_READY,
+						reg, reg & 1, 0, 500);
 	if (ret == -ETIMEDOUT)
 		dev_err(cdns_phy->dev,
 			"timeout waiting for PMA common ready\n");
@@ -391,8 +409,10 @@ static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 	 * waiting for ACK of pma_xcvr_pllclk_en_ln_*, only for the
 	 * master lane
 	 */
-	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN_ACK,
-				 read_val, read_val & 1, 0, POLL_TIMEOUT_US);
+	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
+						PHY_PMA_XCVR_PLLCLK_EN_ACK,
+						read_val, read_val & 1, 0,
+						POLL_TIMEOUT_US);
 	if (ret == -ETIMEDOUT)
 		dev_err(cdns_phy->dev,
 			"timeout waiting for link PLL clock enable ack\n");
@@ -417,28 +437,35 @@ static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 		break;
 	}
 
-	writel(write_val1, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	cdns_torrent_dp_write(cdns_phy,
+			      PHY_PMA_XCVR_POWER_STATE_REQ, write_val1);
+
+	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
+						PHY_PMA_XCVR_POWER_STATE_ACK,
+						read_val,
+						(read_val & mask) == write_val1,
+						0, POLL_TIMEOUT_US);
 
-	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_ACK,
-				 read_val, (read_val & mask) == write_val1, 0,
-				 POLL_TIMEOUT_US);
 	if (ret == -ETIMEDOUT)
 		dev_err(cdns_phy->dev,
 			"timeout waiting for link power state ack\n");
 
-	writel(0, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ, 0);
 	ndelay(100);
 
-	writel(write_val2, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	cdns_torrent_dp_write(cdns_phy,
+			      PHY_PMA_XCVR_POWER_STATE_REQ, write_val2);
 
-	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_ACK,
-				 read_val, (read_val & mask) == write_val2, 0,
-				 POLL_TIMEOUT_US);
+	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
+						PHY_PMA_XCVR_POWER_STATE_ACK,
+						read_val,
+						(read_val & mask) == write_val2,
+						0, POLL_TIMEOUT_US);
 	if (ret == -ETIMEDOUT)
 		dev_err(cdns_phy->dev,
 			"timeout waiting for link power state ack\n");
 
-	writel(0, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ, 0);
 	ndelay(100);
 }
 
@@ -450,9 +477,11 @@ static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
 {
 	unsigned int read_val;
 
-	read_val = readl(cdns_phy->base + offset);
-	writel(((val << start_bit) | (read_val & ~(((1 << num_bits) - 1) <<
-		start_bit))), cdns_phy->base + offset);
+	read_val = cdns_torrent_dp_read(cdns_phy, offset);
+	cdns_torrent_dp_write(cdns_phy, offset,
+			      ((val << start_bit) |
+			      (read_val & ~(((1 << num_bits) - 1) <<
+			      start_bit))));
 }
 
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
-- 
2.20.1

