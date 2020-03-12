Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE9C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A6620724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jdi61jVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCLK1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:27:19 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:48777
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726390AbgCLK1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:27:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeOZuRKBLj0XtHiDWnp2fVJeArI+YOT8p84xoY3aGUXWce6ePtg2zUZFInB8dp/VOLkMzFORQd1aZu4wyvW67v+AZuQo+jA2eDwKm7HxKNuzhTPLkGAB28/NastvHEcwagjePaw1THLRXDjZq0vxEMb/J0bC79Ejfrzqrc2FSJfZ3D8e9F3EQlbWrUCtkQQL7dhnk2RztWYDklOu2Ib+jeYLqO2f6JYh2daFhzUZxYptmyYTYMqtEBbQ3p23jTih1kYlUhdo4l2Mt5aHHrnSSr5VPwUyMVVKL3XBsZxRJ8+ISnHO9ETysReOIAHcKuWJhGv2C2QlvSw5gfHJsSZJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbkXExOQ6OdJBM03LtkPQenHPgYJtGC53UehoF9NoUc=;
 b=lQu4MBk0LxLLNgu3yFmBvbPyRHAPx1zF5NC+lQk4c32oryklRNC4NJRNHf+c/l0/edyQM6OSOKSo3FwEd6qHQQ9/6U+fdm7PH995wApHTKaH1hy/R0yYDgKCHi64KOMn/5GHl1ZN2EAvGsS8VNNbAsPYTkNmeQBPlU5rLchkvCTsQ61XyFYXMyIRSjidiie5TO5m7hdkFvWU9+LUle8uREllioNYV1IGKfgsn8bQ6uQPp0JfkMvAEFPEol+PjoZOZ81gtPLIxgTP2UatklP4pltpKTNUI27cdOV3QrAGbgVimQzuf3hpcVSP7FsCKBwDzW9KNfj9w3A7V7KqljIg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbkXExOQ6OdJBM03LtkPQenHPgYJtGC53UehoF9NoUc=;
 b=Jdi61jVS3s20G5Kve130fVzc3BdiBRaHmKjGFHhvQefWZfEjb+lwgBRAVPuzCRzmQ9U+Eq4qiTnsm0ofgNSmUAoszkL3tFHGY+Yo55vEWTz8kXySUClektZF9sslQdT/qpjkhDzGkP+8LGtYDYQo4hvqGYq6IRB55vzxzdODIJ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4195.eurprd04.prod.outlook.com (52.134.92.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Thu, 12 Mar 2020 10:26:32 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 10:26:32 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        leonard.crestez@nxp.com, sboyd@kernel.org, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anson.Huang@nxp.com, daniel.baluta@nxp.com, aford173@gmail.com,
        ping.bai@nxp.com, jun.li@nxp.com, l.stach@pengutronix.de,
        andrew.smirnov@gmail.com, agx@sigxcpu.org, angus@akkea.ca,
        heiko@sntech.de, fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 00/10] clk: imx: fixes and improve for i.MX8M
Date:   Thu, 12 Mar 2020 18:19:34 +0800
Message-Id: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0113.apcprd03.prod.outlook.com (2603:1096:4:91::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.7 via Frontend Transport; Thu, 12 Mar 2020 10:26:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8161573-37f6-4c49-4149-08d7c66fd521
X-MS-TrafficTypeDiagnostic: AM0PR04MB4195:|AM0PR04MB4195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB41953EF5A08C4B27B65BA0D688FD0@AM0PR04MB4195.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(956004)(26005)(6512007)(9686003)(2616005)(86362001)(8676002)(186003)(6506007)(81166006)(6666004)(8936002)(7416002)(6486002)(478600001)(52116002)(966005)(316002)(66946007)(66476007)(16526019)(5660300002)(66556008)(36756003)(81156014)(4326008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4195;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jP/xVVRLle46Zq1Xh0P6Fe+EuSOTciMreig57MPO+HL0GGQsbSQ18laSxbZjrCsymrnnJQu/0bnWqfFVObDB3ZQJQXxNfedejBZ6ZE6NUhpaSy+RFtSB1gaG0xdt9af8c1IXlGRdoDebZJ2G9jGLg/+NAoold02HM5aYsoBAZwNhS/s58cDy2epgtiYKUpTIe4BH542o45Xmt8W3dTdSRqiw4PAMsxGohy3RbJMyGrtmQczLw2n02xflcrErt/SjqcaWxy/XrjYVKJWtNZ7D/HP9G8Y5waa42kGoSWYrlH4aARm77MHWEkBV7SZxAbCTz4YlqrZYF5ljE4A/OPKXulGxOMQVYOfHrF8LOW7ldV/H2/0PFyTlY5QgLIpvLa1GnULa4FlrxS2oufHwOiF36OS5sldmuP9d9Q3f7avVIglqDK5af/bk0kzEdX8g7GaFG9uQoe99SCs4OBvFvrIvllRHQ3yHn2oNKCJ9KD9AHlyTB1aRToNLZVquvdfrLD53RtCm5OKx598w7LICrSSmfA==
X-MS-Exchange-AntiSpam-MessageData: sJ0933m+EOJNiA1RiiipkRMzYdT+3e9Ce6MR+6WTMqZT+LKAeLQ6E0Q1cusLOjqYd6ppqM/FweqFxxjUez1DKw9HAZzhxwqIU7oaKo9gyEeG474ukDYYz7SlgXhCF/CGaQqdtmwRtwSyfjNaup011g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8161573-37f6-4c49-4149-08d7c66fd521
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 10:26:31.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LpjFS/tYmj3L2XeIm71Jl5/55XOf3TfEXyHgDiWqzIxNrakSMd6LJBl1h18eRqMuzmBQYj17mphcA+/BkvbHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Patches based on for-next

V2:
 Patch 7, drop wait after write, add one line comment for write twice

V1:
Patch 1,2 is to fix the lockdep warning reported by Leonard
Patch 3 is to fix pll mux bit
Patch 4 is align with other i.MX8M using gate
Patch 5 is to simplify i.MX8MP clk root using composite

Patch 3~5 is actually https://patchwork.kernel.org/patch/11402761/
with a minimal change to patch 5 here.

Patch 6 is to use composite core clk for A53 clk root
Patch 7,8,9 is actually to fix CORE/BUS clk slice issue.
 This issue is triggerred after we update U-Boot to include
 the A53 clk fixes to sources from PLL, not from A53 root clk,
 because of the signoff timing is 1GHz. U-Boot set the A53 root
 mux to 2, sys pll2 500MHz. Kernel will set the A53 root mux to
 4, sys pll1 800MHz, then gate off sys pll2 500MHz. Then kernel
 will gate off A53 root because clk_ignore_unsed, A53 directly sources
 PLL, so it is ok to gate off A53 root. However when gate off A53
 root clk, system hang, because the original mux sys pll2 500MHz
 gated off with CLK_OPS_PARENT_ENABLE flag.

 It is lucky that we not met issue for other core/bus clk slice
 except A53 ROOT core slice. But it is always triggerred after
 U-Boot and Linux both switch to use ARM PLL for A53 core, but
 have different mux settings for A53 root clk slice.

 So the three patches is to address this issue.

Patch 10 is make memrepair as critical.

Peng Fan (10):
  arm64: dts: imx8m: assign clocks for A53
  clk: imx8m: drop clk_hw_set_parent for A53
  clk: imx: imx8mp: fix pll mux bit
  clk: imx8mp: Define gates for pll1/2 fixed dividers
  clk: imx8mp: use imx8m_clk_hw_composite_core to simplify code
  clk: imx8m: migrate A53 clk root to use composite core
  clk: imx: add mux ops for i.MX8M composite clk
  clk: imx: add imx8m_clk_hw_composite_bus
  clk: imx: use imx8m_clk_hw_composite_bus for i.MX8M bus clk slice
  clk: imx8mp: mark memrepair clock as critical

 arch/arm64/boot/dts/freescale/imx8mm.dtsi |  10 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi |  10 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi |  11 ++-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi |   9 +-
 drivers/clk/imx/clk-composite-8m.c        |  67 ++++++++++++-
 drivers/clk/imx/clk-imx8mm.c              |  27 +++---
 drivers/clk/imx/clk-imx8mn.c              |  25 +++--
 drivers/clk/imx/clk-imx8mp.c              | 150 +++++++++++++++---------------
 drivers/clk/imx/clk-imx8mq.c              |  29 +++---
 drivers/clk/imx/clk.h                     |   7 ++
 include/dt-bindings/clock/imx8mp-clock.h  |  28 +++++-
 11 files changed, 240 insertions(+), 133 deletions(-)

-- 
2.16.4

