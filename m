Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA194C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31A42081A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aDW4LooL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgETCOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:14:53 -0400
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:27374
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728012AbgETCOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:14:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCxc0z7k59hOmF0No7d1k47tHy+yDkaaaIzRzfck3DRUnvAUJPFURN7UkW0m5SYQmZX0//DUf3vyBKmaZgsD45MKq65fwYV3/rja5EEcajY3d2Olw7mLDyFogqNXNwqqh8QO50goIrvahzUrcMTL1SsAQy7wBmuHNG92ZB2O4jw/0BR8NmLdvAFMyJtBRoEdHOa1TqWwOk8f6fCQxCAdX/hOI7I8y8Z2SN6P0a0vNljfJRb3ktwLH0KdoI8TS6QkGvVVD+uM46+mAKVyJT8KqLTnqE9nY3ME9yfOohu/xvg5S1bqSu/oU1HAqMhTtK2tG9RpQsMT1F/elDOBD6P9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwF2bybrQPuGgmDDwk2tOfoLguieuORkyd7njF5NCkw=;
 b=hmFRbtw3zXnizXctBgO+fMdLKP3VrHJxcKM7XENm6natcvlS26VwGhlcsuF24wS41j0GJ+BRcVjPd1k1jPnGLE9lPafzMxITPUjDuPvyBUgBN+y6PJeI2Wi2BbTubSUDC9r9vKBTvKZZ1Ib7T8tMrd7kVjUR4A8rvmg4FdwgDZhK4K5xk1g1e/hRQIt+239N92ZY7j9W3hnJbPWv/zVpWEW7r7X2+gIAZ4tmhXGIsqPLrSW26rrQRjvQr/h978olM83EnoFu3+5kqybD4pPYaP3mrSIJ4k2E86rJvR/GpI4w5AV6flCpzRYEcE7auECuDHQdf9B1VLCDXkEGLYFkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwF2bybrQPuGgmDDwk2tOfoLguieuORkyd7njF5NCkw=;
 b=aDW4LooLx+2kFgdAFgiqIUKtqzfIDZUjbIU1NyOHin/JVHxm+pTCMSu44FGsIcRFZmBZAqXLzgkXn4RFQNAByxZm35YDi2yfFU1LorS4xyc6BzN39F0obX3JyFf2iLfx6MsXkfn5S0v7qogytEa7nwOsay0SE9NTdl+BSTT2S0k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2741.eurprd04.prod.outlook.com (2603:10a6:4:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 02:14:48 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 02:14:48 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] clk: imx8mp: add mu root clk
Date:   Wed, 20 May 2020 10:04:37 +0800
Message-Id: <1589940278-3680-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589940278-3680-1-git-send-email-peng.fan@nxp.com>
References: <1589940278-3680-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0011.apcprd06.prod.outlook.com (2603:1096:3::21)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0601CA0011.apcprd06.prod.outlook.com (2603:1096:3::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.25 via Frontend Transport; Wed, 20 May 2020 02:14:42 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a3d8537-c8ba-42b6-7831-08d7fc639214
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2741:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2741A324A8B1B7C916C894A688B60@DB6PR0402MB2741.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9LrhbqbZ/StRV84E0AMkOxnqk8vGAowBduTIj1/bivknjwzQ4TbQRnPvW3vLDpWJlrrv35sMwCK2EwivbFyRMqOj/yiQEKj0YlltpwWvb9yvnAF3fYm264XRa4o94uBGJRLVq1CzFEu0Hy/pJ/qZXeSqbWPzkdojnv4CaciHWeX17OmlLHaVtmXRBvEpxCgYbaha4SlLwLWYkxVPaC188r93i7lOrwpFCpo24eW8QNlV4spTRPqlhPYRujveq0wKY7Rnz8WaCVpK3+sHcNjIks6W0ku4lJTImJFRrdkWDUcqMeESgnOn3FTlebDW501KoSFaS/Y6M/Cu57NoCbTTTLgWSu3AE0MtzS3G4WobY1ZcA/hx3l8NQL1uIxyhKKH/9likPxyJpXUQvHPUK7KABbo6bOxaRvOHdqhXDKMDLf7mdJCwXSwtPyUEIIpf7N7GSgKMNX2A1SXTwpdhN6BBbH+Fj0+4wlKPMhdcvkLbRmdu67IJCpmbIdpCRhFI+LCbeipiuO/e6QMw639Prb2JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(36756003)(8676002)(6512007)(86362001)(6666004)(52116002)(9686003)(66946007)(66556008)(66476007)(8936002)(478600001)(316002)(5660300002)(26005)(6486002)(69590400007)(6506007)(4326008)(2616005)(956004)(2906002)(186003)(16526019)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BbyUm2nIhxS6fUBn4f89e/vhCN10seNU78/TOAEbA3W+++ZPZEy8412OsouwFPIV4DpVxVSP95sLF4xJJQ62aQRkocy8yspQvjx54EYz+BzuGRyzuNQeTxSxK62TEJ5aiK5vax6GydbP98JcGzH93Z/KOHss0KUg+pFfKBE5GWL7DflBAYvEfrxORenDhEa3GFsTKzFzKYAOW5S0zcPFdlIbkqmENjvUORbtvZoSUfI+RERLofZJcidZmadK76yWOg/MIJGuxeoSdbjTWmolckwUMddDaWYW+UPYplAuViFd56XCQhvEGbJR85HAtPKQxyITUBO8s0pCOAe+Tyoor1r9e+Lt6n8PUY/SRxqPXgWBD2WovWv9/DD8ZgKpIR9+nmDuVyrmdc34y8P/B7dLqqZ+DCaBl0w4LBfjnn4C0fBzdhqTpSNPQZ6I6AiPxHC4oDpchN/9cBg68LMfTQc/R6QaSyTwTbGozKp1dNN4YbW8+O1vBjWi+RwWtwyw7LzP
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3d8537-c8ba-42b6-7831-08d7fc639214
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 02:14:48.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgbF3a9pISzYT2I0f0gmk5npxvq2+SRWaeBjoAepkHMh4/lhM9ducyk+kxUH2PyUGxcC/hbdRbMvd8Nnz74ViQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mu root clk for mu mailbox usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 41469e2cc3de..95eeb9eef70c 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -677,6 +677,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_I2C2_ROOT] = imx_clk_hw_gate4("i2c2_root_clk", "i2c2", ccm_base + 0x4180, 0);
 	hws[IMX8MP_CLK_I2C3_ROOT] = imx_clk_hw_gate4("i2c3_root_clk", "i2c3", ccm_base + 0x4190, 0);
 	hws[IMX8MP_CLK_I2C4_ROOT] = imx_clk_hw_gate4("i2c4_root_clk", "i2c4", ccm_base + 0x41a0, 0);
+	hws[IMX8MP_CLK_MU_ROOT] = imx_clk_hw_gate4("mu_root_clk", "ipg_root", ccm_base + 0x4210, 0);
 	hws[IMX8MP_CLK_OCOTP_ROOT] = imx_clk_hw_gate4("ocotp_root_clk", "ipg_root", ccm_base + 0x4220, 0);
 	hws[IMX8MP_CLK_PCIE_ROOT] = imx_clk_hw_gate4("pcie_root_clk", "pcie_aux", ccm_base + 0x4250, 0);
 	hws[IMX8MP_CLK_PWM1_ROOT] = imx_clk_hw_gate4("pwm1_root_clk", "pwm1", ccm_base + 0x4280, 0);
-- 
2.16.4

