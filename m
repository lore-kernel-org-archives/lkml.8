Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC1BC47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD5220838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cYTApWxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgEGGFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:05:40 -0400
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:52182
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbgEGGFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:05:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMB8QKb1uzZju1F6PguZmpgiFWtOJXfckvjF0m3Rm6bcrvX7tuRnIT6k9Sh0V/sSehn/EHhXzvgaPc48k0wJuAoD0LI1w4wLHHimEthLFnUBC/83zMFRnrnTHSgxG3uYOGhIPSFDBY6k/HukNxkDQ1I5ygoYoWIViC7IkPkZTKQKJclsPaKg0bmtHq8pViw6hlHUYmlkYNjYBOP87ncgQDaPkZEphKxPLv+650sVS3wL+YmCAKdz/honEDUtOxm+XwW5rlPhPTWGLYLfwHonVvr8qYJU5Eih7EzJca9njhT0RDenV8Sn/p2kITCQRrIz2O2cmLYhaeXepXH+hLZrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ar6Czx/TezE8j5XbVIC+AYzW2sKAS85fp3d2AJzNPA=;
 b=hGsnKpUQiymTgTqXbi7ECWjPRWURWWFz1biPD44cLrB2l39mkDpeOL0y1tsGzGfNq8PkXXHjIoLnJchPPHMcsWAeRm16u6LbTtwTShJRCOlaJILr903Okamjvh1niB9YvDk/wyZaz4xZyVwIxnmMZUEH8acIv+S3ccTLFyGzfZbZQzZohSif0EZ+IiIyifPEtKXNwcRN2myIPcyuYcKY1PL2gt8tp/8Lo7x6EwTTDjuy+B4OjatuxwORFgfFRuTaMZPs5hys3J0pMRcQ/c1aKeMeIEEs+FvXsnTmlTrWfQ/AJ3BVs7WHIi+Xe5+nKKYOCmWHtI6dtm0KvwzFCRF8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ar6Czx/TezE8j5XbVIC+AYzW2sKAS85fp3d2AJzNPA=;
 b=cYTApWxQ0H6hBwEH+maN8lCMBnZKXtsFbyHgAzUZ0ra9oBA4GzVDMvAV1ZsdpQW/ZdgoryLpCWLwZUssj0YIb3LD1zDFdoSDodEw7szeb+fPQ0OqB0BGW2WS3TnA5keuqxMhRERBVvxaVhNCj+I6tqV8bxhhiS7FjlCtgtWlEdE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2710.eurprd04.prod.outlook.com (2603:10a6:4:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 7 May
 2020 06:05:35 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 06:05:34 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 00/10] clk: imx: fixes and improve for i.MX8M
Date:   Thu,  7 May 2020 13:56:09 +0800
Message-Id: <1588830979-11586-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0147.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 06:05:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02a6064c-16a9-43e1-3c33-08d7f24ca7f5
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2710:|DB6PR0402MB2710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB271014BBCD40325ADBBB8C2D88A50@DB6PR0402MB2710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69C5UPZIlP2kpsBMD0rlpsa/vyxXA3k2zWsjnj4/aEmUEP7X9+O2EE4M9OVJYL2cCj2FmVE7HB2EZOajmi3/93eHIn1oRJLm2hIXGUxlWTy+UmcHAHSbJtNdCXHzv+JYUy4S1RSBBV+YzdGnR5VP2nROM338hU68ydkN5EdPywLMZdv0hQuaFfv5eIT17v56mKBKPdarUnspqQyVRKdUDBOtmwbnjJIPcnQA/mlx1lhhakRTt4ELILJ+CoSD6iuwnxhUjBX26HsYhShZ5E+Z5plvXfhtbBdrHZTqFSriAIjFXHWQTOjFtzYENhwptTvyGX7lwfQhGWOpiBUoUZ+NmbNkay31AwW26TSfRAK3tT//+2241v0ZiK4X7qePpsQIORxsaQ4Qb6/34apKNuA4JAF17OHUh/zxBLt7zHmJi56SdRjGHTEXbj+EZ/yLDe82X3E1Rkxl/Qtwb7rEx1EwNTkKWadigy3s4deLIKfsmH7SERhIRKqXzN3W/euPWAXUbMqTfJNnR1kISaa41gkx84UmYM9fMh2YTHtbOqKdn8L52zJVWc8k4+nj11E1iJp5mvGj5d0N3QgMPAWTZ7P3plxhIw7tP4F79XOAT+bhlUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(33430700001)(316002)(33440700001)(478600001)(2616005)(16526019)(966005)(6666004)(4326008)(66476007)(66946007)(86362001)(2906002)(66556008)(956004)(6486002)(52116002)(36756003)(8676002)(26005)(6506007)(8936002)(5660300002)(186003)(6512007)(9686003)(83320400001)(83280400001)(83300400001)(83310400001)(83290400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sDmWfNqIVpa5quykLxRir7anePHe3TZvoWVcKcH2b4kv/K2SV+O/DK5alhs1GATwF7RswsjCaBP/NJvIW+z7JpufZBj9ZDD9WWZMF286uGDkeTojOyQ8ZErShoHlo687dsiV9CwYBPWAEjvpxjMsKsa53RzaBgizJlmmjRbNzBwmXNpFFjsAplp3kD7425kdpSK20HRDNvhdbPLytij8uhJDuE1WWzxQbJd3n72HQrTDUUc6aThaEOBd3z1DdvZhtLKmiYOLBImNu/UYAOm48ZhBdykdds58lmuxPI5TUcWDwCHCD7nJ1LH9yoNmo7bBpdGsnXE9x4DYacUIwPi5kfn8xMdVLfS/uv6Oaijymk0LrpXxfJUeBQESiQGJp+c0jSf6o+HT7J08a2lNe9N0gqCaaP32gr/S4Gyo0N2AR2/N/SnWFr+FPnF85866Ntg6tHGfLIxioizBor6/pha8yl1uYNUtopPk+W7CtBf7OghfF8P8R6ezv77cm3Y1loufWHYDJhS9wH/SqK84qfjZivvmSZoJPZCWTdZGlG1yawcIFfvdrwPetdCl95FSX8hEtZqH6k6mE8YCFRItA9ojUPehLlEGhUNQsVoPql0EOZfjskcrzi+PF7XVS94ZNXh41feloYpn5JXFH4AfribLmHzsPJm4M6FbsAwY4dFA7zXHoR97RDScU7PFYtMpx71pSxlYS3yULTY8UcFpehppg/swmBGZ8GkZ5bGRnLy6jAzZMJcjPz5xBMxAi8LHbac3LwyNEkWS69tW60eofXMTH/rvexqfKD17mnbLeJSNERs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a6064c-16a9-43e1-3c33-08d7f24ca7f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 06:05:34.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJQJWG4lhIZkf/fv4uc6NySBm+ggWBKVrn1vjM3F5sp4SSRdCYYDFs83sJtP5Oj73p2T3ZuylJAytZuimzQRKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Patches rebased on for-next

V3:
 Add R-b tag for patch 1-6,10
 Use clk_mux_ops in patch 7, explain more details in commit log
 Boot test on i.MX8MM/N/MQ/P

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
 drivers/clk/imx/clk-composite-8m.c        |  56 ++++++++++-
 drivers/clk/imx/clk-imx8mm.c              |  27 +++---
 drivers/clk/imx/clk-imx8mn.c              |  25 +++--
 drivers/clk/imx/clk-imx8mp.c              | 150 +++++++++++++++---------------
 drivers/clk/imx/clk-imx8mq.c              |  29 +++---
 drivers/clk/imx/clk.h                     |   7 ++
 include/dt-bindings/clock/imx8mp-clock.h  |  28 +++++-
 11 files changed, 229 insertions(+), 133 deletions(-)

-- 
2.16.4

