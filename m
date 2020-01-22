Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12AFC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9FE24688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="faFRRIT9";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="oNM//wVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgAVKph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:45:37 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43686 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729066AbgAVKpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:36 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAgqZW009274;
        Wed, 22 Jan 2020 02:45:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=14v69BrqcMHMe86Ri5j+rc6yPlFS1lQe7RrjA9qkd94=;
 b=faFRRIT93S1LuEOkx3J5hkE3k7HV/9oet4s5Cj9bzXmVA17cJk+8PVL/9K5lKezWIX3m
 un2KbjUOnE9WO/w+QrYhxBuSLE2KnWvMolSIuQZIlN8ZWIAmC+QSwvdMsDSd8HktSP2I
 y35iBK42PrPS6f50dv56qQID0rStrVJgXTO5tCmL/0s0P+65Qr6lhxuFyRwKFRp3xzVs
 RlX4uxPTLXbKeRE8C4h0BZOFIPhQOByOFfj1DJ+hOzQb/+6KHv4sbB6ushaoCXF06Rq5
 DNA1zm5rkXbeO/J3xmn9DJhu1Zj7X5aTjuNsjjE3UhkW1kA0ZAIXvmNatnSHmuCDDweM 3g== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xkyf5mgy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:45:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAPlp3Y206o4rrEzsXqmTzaSUYUsIq6fAJ2tG8WOSX5D35yd91K9hmfpzCSYzTmi8FM0j8fbHMIopbzSKFctLg20cybg6zOi/1g/oKoK0c8Othn+1iXO+5RCCNejjE6gkuA8RsiJQKqZRS5InZ67bqDEvo+y7DVYnVtZYEFNMWLuv4twDTSYKmw6OSkVFyiCM8oTI0zynGF1sIrGLdjaxgWkNJYq+H44L9rsAHwfIE7Ehm8KdBM27ZiSZKyc1ojYOEGlDsurq4/ISQmA/9RjQo/l4tIXqZ2VnE6TAZPOzPMDvFyEyLUGjnYTsEWZSQZRmVbdmLiHqX8rD8wvcJLZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14v69BrqcMHMe86Ri5j+rc6yPlFS1lQe7RrjA9qkd94=;
 b=MaVaHO3H3WeFn4Q/0WjRUx6dJcMwtTlRcGOY8kH1r227C29UTWV2nGdFnIKh/dLtsDkWY6PH3cktLVbn/+DphkbWb3m7JqpDYSMsmMk9Bevx8kAkLYQ/Ccn5WMmiswA1gGw2VjExPKysI+dGvTif3oOYur4ldoz6nXAuMfnQiXHYt6SxQRrM9/WxxeEj17VVsrqFMhw3NTxftCbq5HmV28rwI6C6IVtcPYFG22C9QJbCdFXgJKhioxUja0YrZPoLCpMC4ogBuzMrtS727kprjFozRGwc01kna5RV9h91D2UTDTD+BPx7rYL3Nl1uW1PfY50czrvDrY7DwjGCA+g4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14v69BrqcMHMe86Ri5j+rc6yPlFS1lQe7RrjA9qkd94=;
 b=oNM//wVDWcUaEHmYAYeQDbDzrNtXTU3K3HsSJy8BpGh8Ameh1+g8nkSOebh2A7cvFjkHeRq9GmGP+ABO1dgbOLR3tkvx1CkMBW13A0t8WNOvKyb8xTgUxdMUvYqqoNIvat4BsWHllVXYCgdjpWT3jGLlXS7cRkrq6vgiQ3c6pks=
Received: from SN4PR0701CA0033.namprd07.prod.outlook.com
 (2603:10b6:803:2d::27) by MN2PR07MB6015.namprd07.prod.outlook.com
 (2603:10b6:208:109::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23; Wed, 22 Jan
 2020 10:45:25 +0000
Received: from BN8NAM12FT011.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5b::208) by SN4PR0701CA0033.outlook.office365.com
 (2603:10b6:803:2d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 22 Jan 2020 10:45:24 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BN8NAM12FT011.mail.protection.outlook.com (10.13.183.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:45:24 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKBB001726
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 22 Jan 2020 02:45:23 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:45:20 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:45:20 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKQM007242;
        Wed, 22 Jan 2020 11:45:20 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAjJLq007241;
        Wed, 22 Jan 2020 11:45:19 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 02/14] phy: cadence-dp: Rename to phy-cadence-torrent
Date:   Wed, 22 Jan 2020 11:45:06 +0100
Message-ID: <1579689918-7181-3-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(36092001)(6666004)(8936002)(70206006)(70586007)(5660300002)(356004)(4326008)(107886003)(2616005)(86362001)(478600001)(8676002)(426003)(26826003)(7636002)(36756003)(336012)(246002)(186003)(26005)(42186006)(54906003)(316002)(110136005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB6015;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.Cadence.COM;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b66e909-cfc4-429a-03c8-08d79f282fef
X-MS-TrafficTypeDiagnostic: MN2PR07MB6015:
X-Microsoft-Antispam-PRVS: <MN2PR07MB6015C71C2CE8FD5A8271AD7DD20C0@MN2PR07MB6015.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NtkVjCR8hkDWbSIJZzI68Fg9gYC9bv5EwZNFx3TV3hLktqrSK8RJJZfHnmYbJV4EwYOcPMFs0VNAtKURTNbJ80GoaQmWOj34iv8hxO+c1JO17s/EU4yqnr2mKHTKwO9a382Zy5nUCBK2CwUkEMJqQRq8q0DNfCgptFutjQOdBCO+A/HbFhiKPAHz9e1RtPYy65E5JteMWHSJTwkNC1pNC2QCwSVG7ifDaF9N6CDVhywE1P5PDHMqgPnkBaLFKbKz73+FZlB333mZ00VRnQqumNE31RVIUFrxCYGziPk33tFGmFgIllrfg7eAP70auNTJtpbZNf2XZl4XJIuoGtllfPcimGTflrG9run8tFIi8YKK3FAiVQkULyXlhAWlpVnPSL/c+L3xhIzv91E0U0huPlell+cVydkWIebT7/Lq09pdXME5JVVodR610N50Tycui0sxZxlELtM280R82RhlW5t2E8rU5HACsoFsx0DkZtbvRi3Qq9l/TfF5S4S+WLW9
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:45:24.6486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b66e909-cfc4-429a-03c8-08d79f282fef
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6015
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename Cadence DP PHY driver from phy-cadence-dp to phy-cadence-torrent
to make it more generic for future use. Modifiy Makefile and Kconfig
accordingly. Also, change driver compatible from "cdns,dp-phy" to
"cdns,torrent-phy".This will not affect ABI as the driver has never
been functional, and therefore do not exist in any active use case.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/Kconfig                                     | 6 +++---
 drivers/phy/cadence/Makefile                                    | 2 +-
 drivers/phy/cadence/{phy-cadence-dp.c => phy-cadence-torrent.c} | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/phy/cadence/{phy-cadence-dp.c => phy-cadence-torrent.c} (99%)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index b2db916d..4595458 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -3,13 +3,13 @@
 # Phy drivers for Cadence PHYs
 #
 
-config PHY_CADENCE_DP
-	tristate "Cadence MHDP DisplayPort PHY driver"
+config PHY_CADENCE_TORRENT
+	tristate "Cadence Torrent PHY driver"
 	depends on OF
 	depends on HAS_IOMEM
 	select GENERIC_PHY
 	help
-	  Support for Cadence MHDP DisplayPort PHY.
+	  Support for Cadence Torrent PHY.
 
 config PHY_CADENCE_DPHY
 	tristate "Cadence D-PHY Support"
diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
index 8f89560..6a7ffc6 100644
--- a/drivers/phy/cadence/Makefile
+++ b/drivers/phy/cadence/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_PHY_CADENCE_DP)	+= phy-cadence-dp.o
+obj-$(CONFIG_PHY_CADENCE_TORRENT)	+= phy-cadence-torrent.o
 obj-$(CONFIG_PHY_CADENCE_DPHY)	+= cdns-dphy.o
 obj-$(CONFIG_PHY_CADENCE_SIERRA)	+= phy-cadence-sierra.o
diff --git a/drivers/phy/cadence/phy-cadence-dp.c b/drivers/phy/cadence/phy-cadence-torrent.c
similarity index 99%
rename from drivers/phy/cadence/phy-cadence-dp.c
rename to drivers/phy/cadence/phy-cadence-torrent.c
index bc10cb2..beb80f7 100644
--- a/drivers/phy/cadence/phy-cadence-dp.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -521,7 +521,7 @@ static int cdns_dp_phy_probe(struct platform_device *pdev)
 
 static const struct of_device_id cdns_dp_phy_of_match[] = {
 	{
-		.compatible = "cdns,dp-phy"
+		.compatible = "cdns,torrent-phy"
 	},
 	{}
 };
-- 
2.4.5

