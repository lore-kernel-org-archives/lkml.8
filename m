Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59274C352A4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED94206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="COqNIGSH";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="xOhgY+1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBFGLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:11:35 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:9372 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727843AbgBFGL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:27 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01667GUQ008108;
        Wed, 5 Feb 2020 22:11:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=j9x1AAVyw1YqMpK5uZcKPNnjb4nTincs/K6dUDuV2qY=;
 b=COqNIGSHJzzFM6YkJkg+H8f0ipZiWxzUZ/LwzkfKHIi7OntuParv8lFlUao1e2J1r2MZ
 0AY3HeTi5+pcYsJTKD6wC7fgDnU6MUAhyJ729LiVgUoRe4VdVrvNth2BKo7ECNHCWyjz
 mpW1KbYF6Ww4xacuVCIA9APFDOzJHm1yiEdjuF+EgAJNPbROD4F2DihaPlondoa45bR3
 OyBFAgLS+Bu2r/rO2B2lHojlF+AsGE3ZggfgZVjaYCViwswNimz6mLodBWnhXP3ovf3O
 ye/NbFEK1gBBTj8CMzzv3pl7IZ/ITOSxYlZ2yWhmu2cY5m95hbHH4v3ixakadUKByVzY KQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xyhkv5pj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY7VfwFeGtLsb+8raPuw+1KQQE+7Ee8gT8mRYkZncm4uliWgss9U49cvyNS1Lgyg9OTnPuoXasHLSLdBWQcjYtB9X0XEKLXsT5KV7pzYHjq6OxLwAScPYScC9b6GCa3/BiJPt4RfFVYHsG+XJVg6mK3bIrJw7bQQSA1AKsWw/8Jz0W+7Y7QTfzkS4WjyUBzpXSrW/jT2WDiqvjRkLXhi6iN02H3YNdVj2Z86JgpWoq5mgHforiXxtSeiPGAxic/dnYyTPPNmx6LUyaEXP9DUjWTncsv6cx963dDWOxNMTxZqki2zTVjnqfPtBcIH/Qmt/XmZHArJf9/m3aLG3VI3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9x1AAVyw1YqMpK5uZcKPNnjb4nTincs/K6dUDuV2qY=;
 b=kqsN3IKMAMT+6SbKTtK741VREoKYba72nlHgMrPvyT4t6zrU3xjkpqrD39Ve3MK3q10ihBVMQHMeBseulmN3nAIo7t0AcsuN0gM0rBdzTGA0tVL6gqjqWvSgY+OeHYckRLNnedHzi7kyu/Q6IxlLRoLMgYmZ5AgyfN4BJPTZTxJSTgXDT/2oG7WS/Pt2kJB4yOfXNLs/yHEhV+o++xbU7iRvwbN4EggDTsMG3hhGyU0uAcm3NAOp2NwX4wHpmCyJo5WyUDg45k9UZ/8woSTJoY5CcFyiTZe/LfU+2mem2YhfgV5zEFqfDm+YI1jP/oAZv2/A5FWRtbWrd0G5iPTsoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9x1AAVyw1YqMpK5uZcKPNnjb4nTincs/K6dUDuV2qY=;
 b=xOhgY+1BWBgmiQ5OkM1UHG+akb0B3zCUKWX316f1LzLmJ3HeudEJEXwTeahzjwUanO28SLbD0OWgxokA8IMKD6pQJmzhjO1U9ZTJTRqBpSmLdFI/97YYdv9UUIFTZxi/f/6VU3h6u0Lojuikwh81cGg5YBCxelXllkuu55BDMMM=
Received: from DM6PR07CA0067.namprd07.prod.outlook.com (2603:10b6:5:74::44) by
 BY5PR07MB7062.namprd07.prod.outlook.com (2603:10b6:a03:1e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27; Thu, 6 Feb
 2020 06:11:12 +0000
Received: from MW2NAM12FT058.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::202) by DM6PR07CA0067.outlook.office365.com
 (2603:10b6:5:74::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend
 Transport; Thu, 6 Feb 2020 06:11:12 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT058.mail.protection.outlook.com (10.13.181.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Thu, 6 Feb 2020 06:11:12 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0166B5F3174490
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0166B3Of017033;
        Thu, 6 Feb 2020 07:11:03 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0166B3IB017032;
        Thu, 6 Feb 2020 07:11:03 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v4 03/13] phy: cadence-dp: Rename to phy-cadence-torrent
Date:   Thu, 6 Feb 2020 07:10:51 +0100
Message-ID: <1580969461-16981-4-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(189003)(36092001)(199004)(186003)(316002)(5660300002)(54906003)(107886003)(42186006)(26005)(110136005)(4326008)(478600001)(70586007)(70206006)(426003)(36906005)(336012)(2616005)(36756003)(2906002)(8936002)(8676002)(81156014)(81166006)(356004)(6666004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR07MB7062;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 484b870e-ead8-43d2-a780-08d7aacb5d90
X-MS-TrafficTypeDiagnostic: BY5PR07MB7062:
X-Microsoft-Antispam-PRVS: <BY5PR07MB7062CA47AE62C122F297C845D21D0@BY5PR07MB7062.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rijcC3v5m5Jan3xuP31n4scEkwr8bv3vGupGdCPLuUMk+gLylLaIIIN8KrbxamgS0ITZwXVhvK6y6ZLLDqx8gl6R59g4jrznnGsg+QlA2wKxY60qFUQq3rT6XEVpOuqmBtwM9F0HiL+GahQ/TOwfeyeiI3u2FUAyU2LseJenxCsWAYy6SWTX2qtGSkTSgOGa2pwj7/LOGIHQENdc/FZLtrcO34gF5x1Gz8T6OgQfye0yNOgiDEJdPw2xAo61FaNy6GGqbu6QGAwPv1Fb+LgTzsORkBSTDgnMN4Zgx21MGMDp2fLQybm1jJYPRh9qEKnwxKWEqk39363UTnPDyOlt2mTF/QSi5BFnnuc02E0YhTNFg77p/eqrQ2xr+w7NMCWm7MaQFE5i7SZyBqRP/nqYSwZvE3C7Ci9trXv6ci06BFsCg2aqcRJ5SmZuWtydoHOwSLGOughRmSxv9/zeyWS9G7qZZG4rBq/mpwRa4z5JSNNRUF/WVZQHZlOKbuYIY4Lb
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:11:12.0499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484b870e-ead8-43d2-a780-08d7aacb5d90
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7062
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

Rename Cadence DP PHY driver from phy-cadence-dp to phy-cadence-torrent
to make it more generic for future use. Modifiy Makefile and Kconfig
accordingly. Also, change driver compatible from "cdns,dp-phy" to
"cdns,torrent-phy".This will not affect ABI as the driver has never
been functional, and therefore do not exist in any active use case.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/Kconfig                                 | 6 +++---
 drivers/phy/cadence/Makefile                                | 2 +-
 .../phy/cadence/{phy-cadence-dp.c => phy-cadence-torrent.c} | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/phy/cadence/{phy-cadence-dp.c => phy-cadence-torrent.c} (99%)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index b2db916db64b..459545871608 100644
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
index 8f89560f1711..6a7ffc6ea599 100644
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
index bc10cb264b7a..beb80f71a34a 100644
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
2.20.1

