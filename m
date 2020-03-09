Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36797C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0842B2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k1ZDZQ2x";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jroRj2ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCILDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:03:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16330 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCILDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583751801; x=1615287801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=eDCq6hgO6BP0CMSbIqfQ+z1NMIpz4hoXCdRAJ/rG1AQ=;
  b=k1ZDZQ2xWLRXgOh9QoRpvU3LleHkx3F9sbyRrKAYy3sx+ccNoseqzn3K
   aFHT0MsmX+uiXqrjnqfYg6ljV2hz9QI2Vtd5tWzThj+g3x1Y182sYsl3o
   fnLiwI6aY5x7BUAJvMLhb3TPsgoXs6U06U0sFI0geHz7FWTrdkR9y9R8o
   GGcl4wTE6FDX1mMC5mC8vmH9b3XJXTAAgqkD646GiLovYoBt3Z2UxuvX7
   SB8wRdVQWBJdNaEdZ65eQIUaHj2OwDu7APt8WJnqx5CUHu0nPdbzEz9wJ
   xdMZH2VN23IHPUE7sUGKn5H61m2Yfs7YeHnloHI6Wgrb1CeaZpP/98CzM
   w==;
IronPort-SDR: X6vJLSJ3jwxQ60hoyWf2Jr2gCL13s9PdMpMBMC9n94M0h+O5sAsJZeHJcwVdaVbuvq+dHSB9M5
 PGRpVo5kgnK34euS62F1dcncw79GS0EtIjfXSkkxwAEuiQVRUo1n1qxaguuLfFihdx+fBujJ7H
 J5b3zRUV9sJcse7vt1Gbww+q3YcHaFAD9AykDvcUMtuybtFBBAZ+wmqNc6PuQf+ZDGI5yxy2M2
 8Uh3tyktv/uEWwRDYkiqAogmI3rm9oNWfk1Fhla/55VIvBe0HC2KY9eMywWkGfHjxV8LOt3PVz
 HdE=
X-IronPort-AV: E=Sophos;i="5.70,533,1574092800"; 
   d="scan'208";a="240225772"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2020 19:03:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3+9WzgwolGuPXXz5QjZyIPQPTYY+onz1HRDYKt69BfalhpFPvLPHtXPc4/tSN+j1Z2p8fq2Yv/uD9B8Np9wv0Q4jSl3/AwMnN3R3bl7MQD4IAyXq7kiMiyGV/NbkPGLOlNYURn+xnOWYAPIEvpJuq8bVzlO4rWt8TpPpMThfRk5YwVDPLoXVf0zmMWjlCM9AraDVR/Y5VK3cSqK9xL6+w2r63hbCIhcVCl6TZzR7ZHA5iPlmCtxNe2a11HUdl8AucKWJnb14lH60rRBGZAwyEPSgiFs+8Qi0P+LeUtiZvg8AHRy659Tn7jDC/r/Kl9DtxM25XOH+qHmyR420YC+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azisuRchUpkDHzyN6E9l860Ijb+O/ixQMfTAWFoyAEM=;
 b=RU21rFHud1onTGgGfIaVjNofLiQgj4FKB3L2El+cFfRMFovKU8yXqnyECwvEml63/5yqHC0aqDlfwZqoFKZWnb/mI7CYuFDIUsbChDpNoOnDU75+Sp6/tQJLI/xhAlv5j/ox1CjsM3y25kjdMnjc8veP1+ETLxchi74pU50ve34vB1xf+N0Xy0Nc8Rb4OqAy5l+vd+gyicsBbqcUxdNCPAafXcvv1AvBLkUgl75R+yK99ZFvFnQFnsssLD8yZ08cbfg2KB1PmOGewHId7Fd2L9HK0xEa4nT1e05dloeEVAiJwO1WZOa1iCNYBJPyXyD9R8C98OuiRPsFCHS7RKg6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azisuRchUpkDHzyN6E9l860Ijb+O/ixQMfTAWFoyAEM=;
 b=jroRj2ksVUGCX6wYvI63pBqDi2vI9u5KjSJxteyVGn56th0zhoWJ/NXAYKYNlCGM7EnfHDALcGrwGz9Xo/5h8tvbiswTCMZiVuKRkozInxBlJbnRQKL6xzyzc52zqEhHqAddXs8mczHrDGI1Db0+qFZtKxLqjb3kwxSlhBv1TGA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
 by MN2PR04MB6685.namprd04.prod.outlook.com (2603:10b6:208:1ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Mon, 9 Mar
 2020 11:03:20 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 11:03:19 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v4 5/5] RISC-V: Remove do_IRQ() function
Date:   Mon,  9 Mar 2020 16:32:11 +0530
Message-Id: <20200309110211.91130-6-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309110211.91130-1-anup.patel@wdc.com>
References: <20200309110211.91130-1-anup.patel@wdc.com>
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::13) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.22.61) by MAXPR01CA0071.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 11:03:14 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [106.51.22.61]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e8fa8f0-50c0-4eff-cc9a-08d7c41979d5
X-MS-TrafficTypeDiagnostic: MN2PR04MB6685:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB6685470045A7BCD1EF629A348DFE0@MN2PR04MB6685.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(16526019)(5660300002)(186003)(1076003)(36756003)(2906002)(478600001)(26005)(8886007)(4326008)(55236004)(7696005)(52116002)(8936002)(316002)(81156014)(8676002)(44832011)(81166006)(55016002)(956004)(1006002)(110136005)(86362001)(54906003)(66556008)(66476007)(2616005)(66946007)(6666004)(7416002)(32040200004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6685;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7QFz2EaHg3ktehMKTKPSVm+zloWQrmsxRzjmutPuMxFzLcFF1+M31iQfbanRdCY2OmA7vnl3rflCN50dhexTBJ15EuQXcL/kPWBfJIeloBZZ09BZRD1OF/kN6HknJZK9ALWLKIEBmgmeCKoLdVAZml0Jl/WvOF1DslsSypzBhT5KdlGH3jDV3hTKrd6V9gmw0zyIHnNcaEwAuWvOIHrTOF/2tPPAMMoXv2/yLFPOS0dX/v3pHgnWSbz4WZV0JmzcO4JOvhWF82HTxMDC6Lpe7OMq4qqhF1hl4vyd7w2+vt7KdxaXF/tNsV2hWr9n4Migzt4aNbpTaFFXzL/cGxabrJoBfNAGOh+PvDXX11pn8A/aMvRuVhCg2xpOChXZm8St1vDPR2gryEEY4fQVtMYu+wR8dzUiRbcsWHegkVKc1pva36hxqKg9arHIhRkTLHOGudSp8Fj/qeuT3d7kbs6ulaeLX4ECDu+rhAmXi7SCnZdYyf+hjsUXimO9V8OtVAv
X-MS-Exchange-AntiSpam-MessageData: jKYaZpqYIzfGboEJeyF+u60+9iFyd2YfYeTDh0fKQ46Xe2VaNbBN4tbRxBxSaq2EtRx5SqOXlEpO2cEOyooPfi+O7Z50jxcK1inMeVDkbymqlLwNJ+qMWMwa4j/uqrwAwF5VxkRpCQLp0l8FW4VA+A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8fa8f0-50c0-4eff-cc9a-08d7c41979d5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 11:03:19.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IB34S95RjVtT2Q8yq0t8aeJyTxashxxnWqoIzjHuHkmf/uixfieIGghHi3jVGoBhQSpGVSzq4DXu5F5/aRRVyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only thing do_IRQ() does is call handle_arch_irq function
pointer. We can very well call handle_arch_irq function pointer
directly from assembly and remove do_IRQ() function hence this
patch.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/entry.S | 4 +++-
 arch/riscv/kernel/irq.c   | 6 ------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 208702d8c18e..238f0ca070db 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -183,7 +183,9 @@ ENTRY(handle_exception)
 
 	/* Handle interrupts */
 	move a0, sp /* pt_regs */
-	tail do_IRQ
+	la a1, handle_arch_irq
+	REG_L a1, (a1)
+	jr a1
 1:
 	/*
 	 * Exceptions run with interrupts enabled or disabled depending on the
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index eb8777642ce6..7207fa08d78f 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -16,12 +16,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
-asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
-{
-	if (handle_arch_irq)
-		handle_arch_irq(regs);
-}
-
 void __init init_IRQ(void)
 {
 	irqchip_init();
-- 
2.17.1

