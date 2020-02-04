Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BE0C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860ED21744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aTQdMg9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgBDNlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:41:19 -0500
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:61311
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727189AbgBDNlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:41:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ43OzHw4fAlkMdHzhZlUxbzDV9TWj8SRguWckDaVO18XV2IcktGKNlV/CturLqC1/tMbk7r5vVGQnMBCypNAXTjqO0Ddvp153ZgYrHsXtmKsO5GOUwdL/WLdSyTPa9/mNYpGB5NYu4r4n9LPI6ybleUCzRVNrqUYHdY7H9YiZlWsHv9txfBEHT/QQMQ8ipZ346RAKY1QZrx7S+drqTfT3TXqDpUVMkHm1/iT3HAcuzpyIOP9XlL1jM3woW/v/qzwa3+iyeybw6bLUafZ0f6DbkPDiD2MdwrioiIlKugGakTmTlUsWCfOYSitFlo5o7cGMbSdghd/UW3NP129OASvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfZ44Kb0NxQ+7sVLy7y6S4fCrQNN8UZjk8uRJkhLVhU=;
 b=VQ2H69mGoXUldovjb/W+z7McHXZg8w5D++GXOcezThFNBwoknxuvZCtqrLMLdNlyxAY2woDAl+JgjdwrP5kPPK/0HMtoERH11oJpornMpjcKFxHPwtLYNMKrqfpLO3OfVt1gGedfddo0TdgY59DXkhre+fezc0QRvwugf4CNepCtecQE4CzVGImZsY86Pv1PlhkqTD4EIIBkrV6j2vwOx4iyF0jlWFXiewG9JfFzZ7Pk9s4vZyNxjE3URmBqRESjZdFJwUmG0MLBlkQFZ24kxk13sGQN2ygS1S+mk6Wlb6FicpZgKlLEJJ7jGrDqJ/IrfBnNk+rcOIysGbdMh2nolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfZ44Kb0NxQ+7sVLy7y6S4fCrQNN8UZjk8uRJkhLVhU=;
 b=aTQdMg9vJlA9Cs3sfw9Lge/fSjGrBOuVhB/6gemz+tVCMox2WAehaFT5X410V2XeBrCBz85EstZrnQ5ovjKt5TErrgDt13N4cQWIx4QFTFvwVjqss1P9DPGDXC3gnb/Zvp+B7BkKDK/rJP9fV0Bnxb8y3nAZ0JDcr2WsRWiFrV8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4851.eurprd04.prod.outlook.com (20.176.215.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 13:41:14 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 13:41:13 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        abel.vesa@nxp.com, aisheng.dong@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/7] clk: imx: Fix division by zero warning on pfdv2
Date:   Tue,  4 Feb 2020 21:34:31 +0800
Message-Id: <1580823277-13644-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
References: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0107.apcprd03.prod.outlook.com (2603:1096:203:b0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2686.28 via Frontend Transport; Tue, 4 Feb 2020 13:41:09 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0dcdd428-2816-4a69-4c8f-08d7a977e6f2
X-MS-TrafficTypeDiagnostic: AM0PR04MB4851:|AM0PR04MB4851:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB48516B7E06E54F5E6D00565588030@AM0PR04MB4851.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(189003)(26005)(956004)(2616005)(316002)(6486002)(186003)(16526019)(8676002)(2906002)(69590400006)(81156014)(36756003)(6506007)(81166006)(86362001)(6666004)(8936002)(478600001)(66946007)(66476007)(66556008)(4326008)(52116002)(9686003)(5660300002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4851;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UyPLrvuSh2iv8/eVYilLOSHoklSJ6VpAar8OqDh+0Ra5zB/x7ZMcQjw6D4K6llyrkTmFpOUCtxMLj0O6BFvVDeq1J0CVIfb909zJPqy2QLbwWiI8cin1jXKoDSjWLyhteQZegpyJ+Z5VoZsmKsgNtWk7zh4HGahUCb3zMq3U5En7/YDobeLOLP7zo8Lhr4KnhsbTowE74UZdx5EGVh9hhamSeb03vBltetXuk4H1KsRtO4YlmzQ/t3oe7I64NFFJDmrWA1OePxVFXij/7nSxZUZSSAuBjPFnIhRNxPY5hdrBh1kKaZ3Lrj13/AkRDWCo1b3LBWWdZrgC01Urb0hWpsucRtIT19zB/g3KLc7B7tGPhj8sW6w+kI5mGdIIcEeTvPBSIeG6UO/Ns6sqp18prXOI2+4+CxlUI67+45uTUs2ql8YtmQSeEeDnqMNBIlQ12OdYIgp3UecSi1aVayi9a0TxJCZxx9bw5v8PM5VH5/b4KwUlebiwNvBiKCMLiuKRjoJu0Vsdz3ZkqN4uL9Tiki6KtqxqimqSCYWQn/VLgbE=
X-MS-Exchange-AntiSpam-MessageData: qfEs+7Q6AiYnFjgxKAZaX/u4+pgmdRigfg1rZMqmaAJloBoOElIQfWJnVHx1Mm/oNEG7TlQm6sVorsqxLLmEZwdUCx0gW0bsle2lKavilugSGGgZ+NCD73aETX2xQHeR2bTrwJTg62yryqYK+QPaWg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcdd428-2816-4a69-4c8f-08d7a977e6f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:41:13.8734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utvxhXN0jpUOcgvOFgZHsXQ7hk7RUtW9NuU+spnm3kaQZ9i59vfJUr+Wexg0bXtuHsDuFna0LsB1/BuB4osAUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Fix below division by zero warning:

[    3.176443] Division by zero in kernel.
[    3.181809] CPU: 0 PID: 88 Comm: kworker/0:2 Not tainted 5.3.0-rc2-next-20190730-63758-ge08da51-dirty #124
[    3.191817] Hardware name: Freescale i.MX7ULP (Device Tree)
[    3.197821] Workqueue: events dbs_work_handler
[    3.202849] [<c01127d8>] (unwind_backtrace) from [<c010cd80>] (show_stack+0x10/0x14)
[    3.211058] [<c010cd80>] (show_stack) from [<c0c77e68>] (dump_stack+0xd8/0x110)
[    3.218820] [<c0c77e68>] (dump_stack) from [<c0c753c0>] (Ldiv0_64+0x8/0x18)
[    3.226263] [<c0c753c0>] (Ldiv0_64) from [<c05984b4>] (clk_pfdv2_set_rate+0x54/0xac)
[    3.234487] [<c05984b4>] (clk_pfdv2_set_rate) from [<c059192c>] (clk_change_rate+0x1a4/0x698)
[    3.243468] [<c059192c>] (clk_change_rate) from [<c0591a08>] (clk_change_rate+0x280/0x698)
[    3.252180] [<c0591a08>] (clk_change_rate) from [<c0591fc0>] (clk_core_set_rate_nolock+0x1a0/0x278)
[    3.261679] [<c0591fc0>] (clk_core_set_rate_nolock) from [<c05920c8>] (clk_set_rate+0x30/0x64)
[    3.270743] [<c05920c8>] (clk_set_rate) from [<c089cb88>] (imx7ulp_set_target+0x184/0x2a4)
[    3.279501] [<c089cb88>] (imx7ulp_set_target) from [<c0896358>] (__cpufreq_driver_target+0x188/0x514)
[    3.289196] [<c0896358>] (__cpufreq_driver_target) from [<c0899b0c>] (od_dbs_update+0x130/0x15c)
[    3.298438] [<c0899b0c>] (od_dbs_update) from [<c089a5d0>] (dbs_work_handler+0x2c/0x5c)
[    3.306914] [<c089a5d0>] (dbs_work_handler) from [<c0156858>] (process_one_work+0x2ac/0x704)
[    3.315826] [<c0156858>] (process_one_work) from [<c0156cdc>] (worker_thread+0x2c/0x574)
[    3.324404] [<c0156cdc>] (worker_thread) from [<c015cfe8>] (kthread+0x134/0x148)
[    3.332278] [<c015cfe8>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
[    3.339858] Exception stack(0xe82d5fb0 to 0xe82d5ff8)
[    3.345314] 5fa0:                                     00000000 00000000 00000000 00000000
[    3.353926] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.362519] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pfdv2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-pfdv2.c b/drivers/clk/imx/clk-pfdv2.c
index de93ce73101b..f8707278aad9 100644
--- a/drivers/clk/imx/clk-pfdv2.c
+++ b/drivers/clk/imx/clk-pfdv2.c
@@ -139,6 +139,12 @@ static int clk_pfdv2_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 val;
 	u8 frac;
 
+	if (!rate)
+		return -EINVAL;
+
+	/* PFD can NOT change rate without gating */
+	WARN_ON(clk_pfdv2_is_enabled(hw));
+
 	tmp = tmp * 18 + rate / 2;
 	do_div(tmp, rate);
 	frac = tmp;
-- 
2.16.4

