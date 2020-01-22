Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CC0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDE52468A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gTq0JxoR";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="HsPCB61J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgAVKpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:45:39 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:31794 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729353AbgAVKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:37 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAissu016512;
        Wed, 22 Jan 2020 02:45:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=nAZtrsAw0uzKhDYLkgRocotJBgH9dA615J9cFc6rb84=;
 b=gTq0JxoR4I0PaUS9L9M70YZm7JA3R6/dMRR2rZ1sEW2uAF+3UQpKPTC61yLR8TIMybjh
 UO1Wrus1jDZ9uuLHRIiHg/iWxjv5dI7iIfxXDFeQRxskQlUYnvOIFLJKIqlUWywrlYVU
 n5vx415BfLI8q3Nm8Yc2eyD/e7yDa+u/96ccsJJnZ+n0OxY8NccvcyS0YRSwdphK1umB
 6uGom3oGfUprotTVLVZiLKj7j3u4GKAi3xoszdqyToclVB4a3dep3+Ja6nEcZjsadMdU
 xs3bDKsHSHdv1/mazF6I2zDxOu+Z8GN82LWIF1C+2ydRSYHJJDBRcJM3AgFJqgOPoquk gQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xkxg3vssq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:45:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQzkgZ3W3tOdXLlsc1AEndFjuQtW9QYFJpGNvsStju638OMdsekFgInqBDpQbgqJ8Gd6tvD+zV6FILxf+qqFVs4YPhvgfMiWTLLZwXPY7K/feqE9wfDk2ObF5j3LMHiqKUSVGd0AP6ALEs29wrV7uLTrosU6LvZRMnnN3eD1h/hMC4azSxzTA6Eeq+oScuqE6AmiE+lR7718YCMp0k9YDFi9/bbATuowO6jckLyk8lC0oQtOZqGLp/SuYdEE7bUT9tfuqEckg1XJkZvQh7NbDsYyabfIupyZp0jJsVYIJNnX7NNhwXP0DXLt/zruGM35aaI0qTtMTWsgTVmvKpJFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAZtrsAw0uzKhDYLkgRocotJBgH9dA615J9cFc6rb84=;
 b=XuLNpOYj/8G1QS2Kshe+MeQw5/aUCP0iEdHlRvYuk/vFCdERQ7lO2yFJ9nAjPJsbTLUVOsnWpSNOtPemNmTHVfmBtWJQH2yesMR1zJNCfm911RMgckLwnNmFbXTvwi/az0WwYfOSH2aTuvWK8+pqt2GNkPYKz56yVh2DQEDjWhzebQaKeClpl3iU/vPNnbZwh4VjhcuPDf6QzeoZ1fFRn6LC8fo2mhID8uCLg8v+zsmGjX2qd0MDhJtAT0N57lJ2gkIJYzibyWYxe+Js1VefPbVA2hTUPKMJd5vYIMyB8MftYm9abTKiJptJbKdNR/XLZPGG8d9OfwobHCj0CKDblQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAZtrsAw0uzKhDYLkgRocotJBgH9dA615J9cFc6rb84=;
 b=HsPCB61JBkAEQdVRhJi6/8PxX4glEJl15666HbjDi2dzzBL2sZy9gwqccfTQtJ7gVPdPyyiaRxSJO1/ctCsw/ZN797iZt6BGTNhJG7+rWsuyDX82nH4sEDd6xrtl66WxrR6tYFonijIBH3E8XxbgaGIpLn3geFYk8vl3VO0tY/c=
Received: from CY1PR07CA0010.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::20) by DM6PR07MB6170.namprd07.prod.outlook.com
 (2603:10b6:5:154::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Wed, 22 Jan
 2020 10:45:26 +0000
Received: from MW2NAM12FT061.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::209) by CY1PR07CA0010.outlook.office365.com
 (2a01:111:e400:c60a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Wed, 22 Jan 2020 10:45:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 MW2NAM12FT061.mail.protection.outlook.com (10.13.181.253) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:45:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKBE001726
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 22 Jan 2020 02:45:25 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:45:21 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:45:21 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjLLI007256;
        Wed, 22 Jan 2020 11:45:21 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAjLqR007254;
        Wed, 22 Jan 2020 11:45:21 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 05/14] phy: cadence-torrent: Add wrapper for DPTX register access
Date:   Wed, 22 Jan 2020 11:45:09 +0100
Message-ID: <1579689918-7181-6-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(36092001)(2616005)(36756003)(26005)(336012)(186003)(2906002)(54906003)(5660300002)(316002)(110136005)(4326008)(426003)(42186006)(8676002)(86362001)(356004)(26826003)(107886003)(6666004)(246002)(478600001)(70586007)(70206006)(8936002)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB6170;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 822385a5-c406-49d1-8b3a-08d79f2830b3
X-MS-TrafficTypeDiagnostic: DM6PR07MB6170:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6170E7BB19C2556C65179843D20C0@DM6PR07MB6170.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Re/LAdqTXlksZqNJqzb9rDitFgWPQFiTf/q2y/3TKsiesDlsWYCmJtc+WqlBACknWf3HoqazvaBZvEKUepf2dXqoRsYmw9dqjas9CS7hphfJWFl9os7ZpeujBpNlmiaEYUKss8+6XZF+JN+DI4MLioCYKcLf6v9GIRKI6GnJY0JaDoSrtMpd4sbIsYc/6fdMYQ80i+xg3sNWbH0EX4OP2+wqE859TGysBn+oVhWXxHh+6uMyTXp5j4lUgdAex1niAapuWPsrW4b9wwEFdEmiREPWs8wdN+HugnbGncTlbkzU4aBmD9cNrivQLdY17EklYpozlNXz25MED/hpIziiRb4HLuP0o/NPy5IUzdr+Wdo98UznXObVX1dBXpCujH2d1U7LTSXBmQF8xxJQwYsCjEOjw+syDX5RuPBXHfyDYMP1kf7B/uAD7KDa6eVvyLvD3Ve85KNi9ZmpVrHMq4DbhBpUO3NUAZrmxAqFkLl7JJmFMUQRIKstqzjTNby7fS/
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:45:26.0206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 822385a5-c406-49d1-8b3a-08d79f2830b3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6170
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

Add wrapper functions to read, write DisplayPort specific PHY registers to
improve code readability.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 71 ++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 59c85d8..5c7c185 100644
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
2.4.5

