Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155DEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8072075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c4o9Mm9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgHDJBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:01:37 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:34279
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729390AbgHDJBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:01:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdkoBISAlROMNPW5QpfFWZcAazvAaMOIa5hf7qjSxRzwjKAsKQ6VwYWvGvlktfyw+nbxdtzx0/Cs9tRJ87KxLazOmWJ2AyMa/ofaIxZKGG/IPCRDUm3Ww5IzXIw6qQhGPrgawhHZopvr4qDbeePDO+OXSvHjgcIExkJ+dWLYAl/9G9y12LctEDlmBb9hZMSKLGUJr2MH6WY1lxQg5srzBsjmQZkl8gmv81Hf4hM/OwOTvmlCfXRYV7UG8GxBa83lQbIw2czdC9pJYyxi8+2GpApmuNk0V9mfx24UMYPlPgEZ6vmD5EomFH6VPNGR0t3mBhWbHO0m+/gExrRj3x3POg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyRyhBM/setJ7srqkTltKvlVpEVy18qC4ZySTpaFkYE=;
 b=am7jvy8u57sioYPKeYdoXhsztko/jgN3H1AhqgDqPCigNpztOb1mXSdfe8a5w0JPxx1j7gIFanbTQRd3thXSWCEdSD9QCsmPT6qCpvtBbxp0B4yZaG4F81qaJNlJb+qo7j2MNaU1gGRHw4cKF9ZI6H+MAfUTU9fwQzcxstf8bQyg1tgDNUsB24pqxgWv6fJNEkbUrLDOgSlkU2d9ywC9/96AD6Wh2byU3hs8xcffTVazikIj3QczC2FAo9bI1oUZwBQP6bZFxOm/JciFj2WKETFm1e8jB5/RgNlSTZ5WYn275JXmCFnnnkDepQH/L+hWTU2l6ekQi3zmM+B6YzqgGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyRyhBM/setJ7srqkTltKvlVpEVy18qC4ZySTpaFkYE=;
 b=c4o9Mm9ShDb80ifJJoKMIcEJDVkttAnD0fBSQ/R2fkwf2U7tsRZ5LDR3jHhe9S1D1mF/r34d8Gi8pBQvkigZfbMVZgD9ouUUZm1R9rtCAdutlByWL9hTCIFd46lwhiXJz7OIPJQ58t5ukp8gCiddtWK68Ztgn2WEp4zIqbtEls8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 (2603:10a6:803:22::18) by VI1PR04MB6206.eurprd04.prod.outlook.com
 (2603:10a6:803:fa::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Tue, 4 Aug
 2020 09:01:34 +0000
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::167:b586:586e:e024]) by VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::167:b586:586e:e024%5]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 09:01:32 +0000
From:   Jason Liu <jason.hui.liu@nxp.com>
To:     will@kernel.org, catalin.marinas@arm.com, ashal@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it already masked
Date:   Tue,  4 Aug 2020 16:56:57 +0800
Message-Id: <20200804085657.10776-1-jason.hui.liu@nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0085.apcprd06.prod.outlook.com
 (2603:1096:3:14::11) To VI1PR0402MB3824.eurprd04.prod.outlook.com
 (2603:10a6:803:22::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lava2.ap.freescale.net (119.31.174.67) by SG2PR06CA0085.apcprd06.prod.outlook.com (2603:1096:3:14::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 09:01:29 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 00ce98e5-e7e6-47d1-3ebb-08d83854fba4
X-MS-TrafficTypeDiagnostic: VI1PR04MB6206:
X-Microsoft-Antispam-PRVS: <VI1PR04MB62068B7EE2F3CBF066019433AE4A0@VI1PR04MB6206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jhxn8SHuN6uTdn/T6FNf3r9TgaTC0VB86VPLl6uYxypZxO2C879Mcbv5rR1ZBbbDmYpyhCf1k6M83rFmOI9OblRR50boO984afkRQhmJU9rtWZXn+VnDGMqAsGHTr+J/sMdhF7dSRsnBKPu8W61vP8sQdtn7ypA8XAfDVLcXY4EGt1liQv0qm9QvsUOCcoLuE39uiYlmn5VYkQpbfmIx4mR1/n2TCiVzP4jhf4arALwz+BNZD7/SvGLA6PFZUVag+F+cbfVqQMMo1FKIgCYCRwVGZmfYrglHQp1j+pCB+yW2zTymAnchFoEXiPWwcVPSchSUR9+7vVa3EkIw14kV2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3824.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(6666004)(16526019)(26005)(66556008)(66946007)(186003)(6506007)(5660300002)(316002)(1076003)(83380400001)(103116003)(66476007)(45080400002)(8936002)(8676002)(86362001)(2616005)(6486002)(36756003)(52116002)(2906002)(956004)(6512007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TGIqv7Dqyo8CyNIFtgN7x172n1QEIu6X/MoOsC2UP0YBFT20UdlcFsHj4w6DaI1ioV7hoPorHwpObLSO5F49h3XXslK0uQwzlX0mpfe2lZ+IFLiRUZNOp5/Mgd4Zjzg4NZhQvcZUdcIsYWEjpdckBbqrU9n6n5jXLs7CZDn5A5rKpCDCTcJZMqw4kAKnQoIP8uRK5ZWdzI/8RQ0OpJEKKqopboXvTyJySiqCf9Vs3mSt1NaG/NQWd9/NvBRM+k4neZyeKbYWu1NN5sAtk/ymlCFlWeqtVT4w/GlneYZiiq36zaUSrDIXcKxsVAePHMeRVfiQGZMO8IvD9MEQ3RTy4dHqB7+2jgUQk2b0U+0Pe46y4x6INwN+jAzVab5+RRDiacoUUSZ+ZusagRhbU4KkSENBB7gT46a0+Hdm5AQ60NXzDY5Puj7n50RHzbyXbAVpfkZaMiyp/Pft6KXrzMBzfpMlLOiC1mxHIoR+nVdBOB9phpDB9/BHeuuyewKA6AVKG+CXOo/RbzUS+wZI30S3amZ/xBPX/ts1hkfZgfRkGJohgoSwWq00Q6T5kVEgjZWSyhnzbK0JCN8gV68hwxL17nW3iTXH3Fj4Iz/j9mga99jhcFUwhabW6bHqMEHiYUuMLh6c/KPa8RzBHVZFuWnJCw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ce98e5-e7e6-47d1-3ebb-08d83854fba4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3824.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 09:01:32.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMPN9WBBMkcYlebUTpbzg5s6BtCeFaVvThcJ2wj2dAVNMCxpG7pECy8LlwyPGQMT6KGTcFmlkSuib6xrtU1OYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to do the irq_chip->irq_mask() if it already masked.
BTW, unconditionally do the irq_chip->irq_mask() will also bring issues
when the irq_chip in the runtime PM suspend. Accessing registers of the
irq_chip will bring in the exceptions. For example on the i.MX:

root@imx8qmmek:~# echo c > /proc/sysrq-trigger
[  177.796182] sysrq: Trigger a crash
[  177.799596] Kernel panic - not syncing: sysrq triggered crash
[  177.875616] SMP: stopping secondary CPUs
[  177.891936] Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
[  177.899429] Modules linked in: crct10dif_ce mxc_jpeg_encdec
[  177.905018] CPU: 1 PID: 944 Comm: sh Kdump: loaded Not tainted
[  177.913457] Hardware name: Freescale i.MX8QM MEK (DT)
[  177.918517] pstate: a0000085 (NzCv daIf -PAN -UAO)
[  177.923318] pc : imx_irqsteer_irq_mask+0x50/0x80
[  177.927944] lr : imx_irqsteer_irq_mask+0x38/0x80
[  177.932561] sp : ffff800011fe3a50
[  177.935880] x29: ffff800011fe3a50 x28: ffff0008f7708e00
[  177.941196] x27: 0000000000000000 x26: 0000000000000000
[  177.946513] x25: ffff800011a30c80 x24: 0000000000000000
[  177.951830] x23: ffff800011fe3af8 x22: ffff0008f24469d4
[  177.957147] x21: ffff0008f2446880 x20: ffff0008f25f5658
[  177.962463] x19: ffff800012611004 x18: 0000000000000001
[  177.967780] x17: 0000000000000000 x16: 0000000000000000
[  177.973097] x15: ffff0008f7709270 x14: 0000000060000085
[  177.978414] x13: ffff800010177570 x12: ffff800011fe3ab0
[  177.983730] x11: ffff80001017749c x10: 0000000000000040
[  177.989047] x9 : ffff8000119f1c80 x8 : ffff8000119f1c78
[  177.994364] x7 : ffff0008f46bedf8 x6 : 0000000000000000
[  177.999681] x5 : ffff0008f46beda0 x4 : 0000000000000000
[  178.004997] x3 : ffff0008f24469d4 x2 : ffff800012611000
[  178.010314] x1 : 0000000000000080 x0 : 0000000000000080
[  178.015630] Call trace:
[  178.018077]  imx_irqsteer_irq_mask+0x50/0x80
[  178.022352]  machine_crash_shutdown+0xa8/0x100
[  178.026802]  __crash_kexec+0x6c/0x118
[  178.030464]  panic+0x19c/0x324
[  178.033524]  sysrq_handle_reboot+0x0/0x20
[  178.037537]  __handle_sysrq+0x88/0x180
[  178.041290]  write_sysrq_trigger+0x8c/0xb0
[  178.045389]  proc_reg_write+0x78/0xb0
[  178.049055]  __vfs_write+0x18/0x40
[  178.052461]  vfs_write+0xdc/0x1c8
[  178.055779]  ksys_write+0x68/0xf0
[  178.059098]  __arm64_sys_write+0x18/0x20
[  178.063027]  el0_svc_common.constprop.0+0x68/0x160
[  178.067821]  el0_svc_handler+0x20/0x80
[  178.071573]  el0_svc+0x8/0xc
[  178.074463] Code: 93407e73 91001273 aa0003e1 8b130053 (b9400260)
[  178.080567] ---[ end trace 652333f6c6d6b05d ]---

Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
Cc: <stable@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index a0b144cfaea7..8ab263c733bf 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -236,7 +236,7 @@ static void machine_kexec_mask_interrupts(void)
 		    chip->irq_eoi)
 			chip->irq_eoi(&desc->irq_data);
 
-		if (chip->irq_mask)
+		if (chip->irq_mask && !irqd_irq_masked(&desc->irq_data))
 			chip->irq_mask(&desc->irq_data);
 
 		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-- 
2.27.0

