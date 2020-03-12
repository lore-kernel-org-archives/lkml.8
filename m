Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ECCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6970A206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SrHUvGlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCLJIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:08:17 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:43142
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbgCLJIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/r2CACUh1RM9nI1W5bQijlRC1AtFcWnf6zTwheavIi4CrGfPvLPnf80w5M7uvcrarpU1d/1LmX0Im/KjdnnybDL0Wq9iDfHj21Riuo2iMjdtauG4mJ8icLDKCm6Z6eR8YpkitIzzwy5fXNwseLir71VKEZMmVqD3RwKrKd/K8yK9AxVsR5atFmtk1XOyvcBA1NoBXOo2caLi3pbiLvPSv+3vyI/FrmARqjLiTsmEzSJ12aEmbUEtfgLkdLDirdAH5mzB369LMwpTbUfcLllIvb03ljuoRwd1IRJoVw4ZBj3wrkJ6xWIPbRor9mJayjD/zpa8nNeapqIu+9tvTsUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRjLCQJWrM1aPkx/Qqdka0pExz6sPTgr302SVuR4obY=;
 b=VT4mehY2aglw9xtdKPEkLICk0iy7l88gS5pl7q7We3M+qxXpppmciXOrKbfqbz7mxN5MxRZQMMkakHIIhfrdlmbuI8I+30viScsm8czq+olfQPblbYH8t88gltfSg0IeWJlqiTl9Qg3P9QUz6FohKQAwCYwxrtR4xQqKtqBiW+d2ynb1njiX/0qcI71RU2sE7FimZ1mNEybdORVkB1yyeEdd/BbpKAcJ9vAQMk5rHkAaWnWbJQbsWzLGHAY6ElG9k7P/BkVN4pvVKKy+s8mc193qnvm91I3Nehbzh6kopjKQlc50mi0IIRIVBF1bZ4no/qVUWMOqXmVUixhA729llQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRjLCQJWrM1aPkx/Qqdka0pExz6sPTgr302SVuR4obY=;
 b=SrHUvGlkPVTsaSpr1ojRNuaD2cDB5TJiMTyipAIYibR8KfG3L9cM/8MrJMG70SzwvNEWoZZg4K0CNv3iqNpuIUuaYMdepfjll+j1xhYG3QLTA/HiRIzH6SzBmX3INBlOvLIF6G/ixHxG10jeb3w5LkCjUMmgHVgDmZOIwAMdoWg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5795.eurprd04.prod.outlook.com (20.178.118.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 09:08:12 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:08:12 +0000
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
Subject: [PATCH 00/10] clk: imx: fixes and improve for i.MX8M
Date:   Thu, 12 Mar 2020 17:01:22 +0800
Message-Id: <1584003692-25523-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0052.apcprd02.prod.outlook.com (2603:1096:4:54::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.14 via Frontend Transport; Thu, 12 Mar 2020 09:08:05 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a7531ae-7f73-4deb-7c05-08d7c664e3da
X-MS-TrafficTypeDiagnostic: AM0PR04MB5795:|AM0PR04MB5795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5795E3C95540454B1ACC2E8188FD0@AM0PR04MB5795.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(6666004)(52116002)(66946007)(6506007)(9686003)(6486002)(86362001)(66476007)(66556008)(6512007)(5660300002)(4326008)(956004)(36756003)(966005)(16526019)(26005)(186003)(478600001)(7416002)(2906002)(316002)(81166006)(2616005)(81156014)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5795;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ko4X6I1e7/wyVEJ5G8njboCQRBwnSnDJq33vVSQ2UawEnDKVlC+mzN1+x+uKEb1FVfDKx1EVeL38duEEXWsOP0X06enhnrTPaN/zd/bGPyVFmWagh9YFbR9rzBgsCq7quEE92kwx0daaPJF6p2TCwMZRbxLjcFZiHbJN3jPTyM9q9uy3iz80iAT41u7zIe/mLuDWUtlFcOtfvgCbyLteptQp8EiIf67MuEjLTvvVJFNYVcIrsXp9tUXyCSFS055kBxDTamgOYzf2GGrpeMgo7EVYZ4MXQp4Muk7TCRLChwTr1P/gnthnLxUKHHcbWrldRq8wIBZY/OmAxEZVkorAsQQay8Cm8tkgBUfa7ldGH9PJIyZS9bgRXiz4Yt5K2YDGTquZlzQtNl6b17Y+ZW2BFfHGopHhSXrIQAXSXuhRCkrQDvZ+K+WdGG2yF5EAbtXQo6Ri/abB9MY0Yx1Ifi8PH29pZsyaK9/DkE0qVBDCLldxx6r+sQq572I+wUx395W2i3FofyKpkGdObEF3QMINYw==
X-MS-Exchange-AntiSpam-MessageData: zyzREH5ALsEHE7vGFoDL+3FlPHD4Xttcybn6y3fMhJJY76LHHjHOgWnt7dQGbpbKWZVvwzAiaMP0fDX9p3lbOG6X3L7LAMJc4iyviOIvYdkK1ROY9rJ2gMnCBhW51mmyyJbgk+zCqY2OKgVMAx4scg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7531ae-7f73-4deb-7c05-08d7c664e3da
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:08:12.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yr4TFWN5N8rSTPnIUoNO0/zHQx2kcRsvjJStYA+i3AQvUUmivM2RCjIaXat0H/fTns4cblpESsknjg1aNnmXrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Patches based on for-next

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

 Not expect this merge in 5.6 release. Since this patchset is
 worked out based on for-next and for-next will have conflicts
 if the patchset based on master. And to make things easier,
 we let all core/bus use composite api.

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
 drivers/clk/imx/clk-composite-8m.c        |  74 ++++++++++++++-
 drivers/clk/imx/clk-imx8mm.c              |  27 +++---
 drivers/clk/imx/clk-imx8mn.c              |  25 +++--
 drivers/clk/imx/clk-imx8mp.c              | 150 +++++++++++++++---------------
 drivers/clk/imx/clk-imx8mq.c              |  29 +++---
 drivers/clk/imx/clk.h                     |   7 ++
 include/dt-bindings/clock/imx8mp-clock.h  |  28 +++++-
 11 files changed, 247 insertions(+), 133 deletions(-)

-- 
2.16.4

