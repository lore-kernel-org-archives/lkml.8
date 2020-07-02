Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2542AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB00720702
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rzsd6kfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgGBJcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:32:02 -0400
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:35201
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726790AbgGBJb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:31:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=av3jw22mBMkdxBqGEzRC9/sUuuqCNQU0JT8x9/7ibjqbT5bnryBUvE0AF/fRJJBJxcFJluzUGNZnvwa9n5jUgCHLRXDDfr1s3KJvGRbw3JrAcGbKLxBp4LGFwUEQRa/NpvixeWKhxJlpikKHdKLhbC4UnkeloKsNY+xGy8hCRVqwkLUCvIBAN725wevGFAcbh2CtBHMH8w3aAAXHLu2F/WeYwj+aq+xvgeSv72FJdjHX2RE8JRpotqSwlShiQCWOPDDIHzp82SnKCGgAT6fkY7a4ahUrQa/tc9sCs3UnPQWOCD15lm0TOkWj4pIwRRHeuWLo/gla8SsTgsJyeQLVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsEfPZVkADMxTgsywC24Fue4YtOam2T5qjRPj/F6E80=;
 b=XI5XUdcB6DF7+fwnhVYBednClLVE+E49wc9SxfxvEiavKj0VJt4F1AbeDTUer11YzQQh0GiOkIIfOqWTQwi8bwfiUTm9f6+bUxa9gZPd28DDGHusLy36okmEr0Ez9votQ2cjSaTlsHtoeEMYl37rjZCgdojULJ3NgnjeRlhJ1IrJRqpTFdf0knZALD4USO8NSAD7EvJW4FBLhDlj1EtdyxKmy/8Fe0oEIeimYz17Yz22EYr68ZITCp+yOu5HvdU9r0J3nT/k0hcF7VY2NfM3/vv5ZUExTXvZKADUQ5wO3h5G1fH5WX68qgj84WgbFy/UqP2fLrw50W4H5ckuCH6LOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsEfPZVkADMxTgsywC24Fue4YtOam2T5qjRPj/F6E80=;
 b=Rzsd6kfJVMU9pL6kgpm29ubcIy2xN5UxCHbJX6HCSYXF7lD1a4QgegHLK/0GQTiLPiICytjixIkx8+ERjo5wub8ckDvkdQ0NzRjMX2f0St1nHFVpL1zZP7wDw6BQxh90lQMg6t1XFgv2UP0+zZDq6/7J/HGtBF2BNDnHoINhSZg=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 (2603:10a6:803:22::18) by VI1PR04MB3039.eurprd04.prod.outlook.com
 (2603:10a6:802:b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 2 Jul
 2020 09:31:55 +0000
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::3854:92a5:f662:2def]) by VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::3854:92a5:f662:2def%6]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 09:31:55 +0000
From:   Jason Liu <jason.hui.liu@nxp.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it already masked
Date:   Thu,  2 Jul 2020 17:27:22 +0800
Message-Id: <20200702092722.31354-1-jason.hui.liu@nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0251.apcprd06.prod.outlook.com
 (2603:1096:4:ac::35) To VI1PR0402MB3824.eurprd04.prod.outlook.com
 (2603:10a6:803:22::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lava2.ap.freescale.net (119.31.174.67) by SG2PR06CA0251.apcprd06.prod.outlook.com (2603:1096:4:ac::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend Transport; Thu, 2 Jul 2020 09:31:53 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d77ad4c2-a520-47fd-4dca-08d81e6ac24e
X-MS-TrafficTypeDiagnostic: VI1PR04MB3039:
X-Microsoft-Antispam-PRVS: <VI1PR04MB3039885203558855CD53F800AE6D0@VI1PR04MB3039.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHx6zj2bO5f8PebwrWeG4mQwAHbCv3KcwgavLQmfnrNJT2xcT3zDFe1wngYDCHLj8G1qgU23Tu1b7/J5+TArefMp14MxpbfAL7piuK4+ckO2GRRLoqYfWG70JDqcfv56P2/Gge8kfLD+w4fX4exwNvg+DrKaB5/fq2XXh9QOFimKFlpE2aQE++WmwU4W5tzqm6U7VL5nq1RwjRawJD4U3oZvpAMKssTKfcIuhxG9+9FDPQ09D89A6Q1AQ2kAAZkkLAkhM4Bml6Ih94H7Lggqg2SHpCoDCqr3UcQ3Crvx52x6nmCkj0YMZ3TgNPi3vLOHhc9KVcHV0nIGpLO/5fP3MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3824.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(36756003)(1076003)(4326008)(5660300002)(6916009)(103116003)(316002)(8676002)(8936002)(6486002)(478600001)(66556008)(66946007)(52116002)(66476007)(6512007)(26005)(186003)(956004)(6506007)(83380400001)(45080400002)(2616005)(16526019)(2906002)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: B5B79QBs4862TNUcT7RfZ+7t0emIq627K/z2bTybvL176jUzKt4uZk2CIClOhjeyhwr9t1NbnQ00CIY2IPv+IDgfUIagYo84Vyky13EgiwIhrdEFZ/ZAnK5cRzzCse6UY4jmHLxRfQ/daioeU6jHYdXZraNrq1JfeGh21ryDTgZFxdkfftWCR+4zsF3WaDM8c0Dtjl/pqdQqoteeJXJi+tMoXIN5XWJCZmfYjAdX1jF38eeQm/EXdaViTvCadA3UPhMgFzvms68ID7z9PoO/5gd9UxCu82YuhiONJE4tNSLLJz3DlNxESz71rm2qvKVlfQdlP2+kDHAzUxR91GDO0UVLwd5ljNs9bHF6CihnIZrIkRiSl6MK+xUZUo7gnqW0buwyXi7EO5SkmzYZaoV06aPTaR5/KseQA64NsYucoaRV9h/MfOIpuynPRIQXauY8lzBlKr/+wNA/ycgif//9uAPFejqgjapuBUK6Mld2+P0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77ad4c2-a520-47fd-4dca-08d81e6ac24e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3824.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:31:55.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqNERWcBONMV16iTvuD6Ufmx2NcpPeVLD2iZwKXCGyAbGEJsElLbcc9/J3KdQ07xvZY0RAyYGeJJ6nZlhp1tTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3039
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

