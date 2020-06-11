Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BA1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC1620814
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YlaVkSVp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yfhtwwBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgFKGOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:14:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22169 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFKGOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591856071; x=1623392071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oXBz3QIOjsPX0jC03lUnIYjb1i91Mp9oQG+63oZwEUA=;
  b=YlaVkSVpzq0/jOJm39XxsjTKlcXAawF2Px5FDTXU+aNZx8VohykGbp6r
   YikYjQHLiQiJ1akYhnLMjJ9F3jEGDmrqiO/4iO5xgbsU5V907jMYFOvtb
   Ebijl2A/+cyqWit/IndsEt2Xan7ZSCV6kxMPF3FYDWcjPzfeiQ45KFnOy
   9zJWAhMhobq8/uw7R0gSi5/CDOMBqWfW0wDXKQznzLg0PoGQS/rIZW27L
   FQT3ntsMPlBwel8tD6nuqZTEaA82Ofj9NisrvKxqVIXBDB0K3knkEkVz7
   ia3R2Eeaou/eVx6sNYgy3rQKJ8zAAghR9xLRAlZZ8yPCFcD0Onm2/80uk
   A==;
IronPort-SDR: QS7hgjxF6+orURD0S3gQFUSNNI5yFbdpSlObFVAPDBegnxRbVSsekPv1ug8ByP7KzckmodbxP6
 odxsmsKBG+wHtzTkHKwaKXaf45gK4iZc7OJL+YW2Xgw8LkPcnjpvtKWAae2FJ4QDX3l9Z6L7Z9
 mJ12dr8EmGTKYsX9Fy8iqUpxvqbQ/tCWUXkJNH5AyV24tIKgUQCmFd3SDLO6lwQtRtUNVyb++m
 sko2RaGm0hEYGXiRLFUA6o6/In0oMT5g5/aE6E1C3wdc9aB/qR0S087DXftywV1hLUdJ5irKZv
 3OA=
X-IronPort-AV: E=Sophos;i="5.73,498,1583164800"; 
   d="scan'208";a="141117306"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 14:14:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl5oHoUZgyi02cjMmhwlPIJXzChXR/Az6UUlum/Xg/PBXq82cMMJoA+SEBK4rFBCinWHFkR/gX7jE+jcCeFpVRr8qSS12e872NFhhnIqZmslbHlGJ//f10V3Na0op5pSlIswiriGVPQe46HouTUAxRotKrI0j68Tqd1eMORVHz1o+JMpGBStXQYzOKZVw6v3e9c1LN+7dxeaABv2i/+10UbhSfdMMdgEtoyXlmOqhmbVgVr5SDUL3HLyMOsgb2DukxZbKdEEXJtegdExi1y3+nO09U2kLWHrnrT48jNEqJho37+WfO/caJSfGN7zjvBe98XsQcAlZeIYvGNSE2N4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3+d5bWmeqvTvhrryR30c9HWFWaDlvIbgYTQqFLfo8Q=;
 b=AewErGXdAt8AJcFY2NurW4oLG6Y+pj5xwnNMtHA8gEI99kpfhBd6c8aZPb1MBufgQTRDoby1Xkb8KslL9l0LJvAm6gplJa3WGswlU7wAx1B4QjjcNXtsNcPrjgBmFXnc/BvlPy2wvZ2YFB+fRbaLcI9hWghYNQwbbVw8mp7krtyZXWVEpV9PpWzQkaLfNDxvmhFBnO+vbwe9Ccp7GmAcpYX7f9FNsg033jpLLER7WSRDMx/RtdguNhZMdopb4QjQq8SGnsX+l+KAbEIiOZQ7CMijj4AEY8N3h6wKkvoKpz8O3aKrCW+YTfde98ubqv9VX5lRRSS5R3xJpGrGDLH1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3+d5bWmeqvTvhrryR30c9HWFWaDlvIbgYTQqFLfo8Q=;
 b=yfhtwwBSBoKzplV6zBs/7KRPRxHtdFY4emJgaBQmRQbb50SBX1zCbIHsHCt9+YnSQlt+YU//f56PaY8SlK6TdI3hOj8ey1pqyrfKRRusnZCfxewDqi+7GLJoqTK/potzASDgNaPDckmXsLOA02Zr7xwBfTLkEevbWpKxJ8je23g=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6332.namprd04.prod.outlook.com (2603:10b6:5:1e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 11 Jun
 2020 06:14:28 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 06:14:28 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v8 1/6] RISC-V: self-contained IPI handling routine
Date:   Thu, 11 Jun 2020 11:43:45 +0530
Message-Id: <20200611061350.434293-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611061350.434293-1-anup.patel@wdc.com>
References: <20200611061350.434293-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17)
 To DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.182.246.89) by MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 06:14:23 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.182.246.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 702b8489-7a2b-4756-bcbb-08d80dceb25a
X-MS-TrafficTypeDiagnostic: DM6PR04MB6332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB633216A1188027305ED45F5F8D800@DM6PR04MB6332.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPDa0coE1KPb4Akd6pTeOP0Z7USseXAa0oigQM22opUFev1MqvzB2rkoXBL6DjqDdoabYFLecveHYL351ZtK9Uz1j56NvfNsx7+jCwrGWE2zcDCkHjA1o/uhZmqQ65oaoOSDGsfxjymbuFuFCPOlBgWu043P5qqfaHxS5iAofBw2TUa1XJpBAtXGA1cYfu9jZjUAHXxsxyKAMS9GWefIXuxXhJYfsJvV0bCl1sOz37iwbr7Zvg/5iZfXiKoMUURtBIfz96vbchcPm+n2u2yct6xTJL9xxckhcd13YmZSlPftJQxSbe11CEykzNbKLtuAPp5x5VrhwE1IFm3oHHe76w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(36756003)(16526019)(4326008)(186003)(44832011)(2616005)(55016002)(8936002)(1076003)(5660300002)(956004)(7696005)(110136005)(7416002)(83380400001)(478600001)(52116002)(8886007)(86362001)(316002)(6666004)(54906003)(66556008)(2906002)(8676002)(26005)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: DaMbqh7/GVCAN2rCxkt6KjNKuSiNslh5dZWAJEkN9d55J2/s/YrH9lBOAcmxUcJ5T6sAFaklYMHU1dgbBVTp3/WdZEV7uU9MJC4G9cbVOhqrWuMxPS/OoKY83N5mC2CJbNZs+5du3r58ZyjW/WKdnb3WH6+xfHlVBTnYWalXxtGbivCDVZX3yExXxAtIaULAIzS9kwRGOmiCb4BuTpB7O07AfTqTV3eUkIxUWKfzrKhqDEumk01vUOkZUAz4neHaX5kOeHgBgg1g9D6J9h9jT3gUjkAv2hzfur0dVi9Q3qzuS/nL0teXByInuyfEs+e63WY9qWst0OhPpXU4RMKEK7L0jfgFc9yNbbgWBJgqat+8HL9vt2zUOwTQFknv5h7BSHEG1ZFvvyfbu+DYdXIhXp3SpWN/NXAt8c0fhBNs6HgBZxtsgRBinxD1xWos0RNSI6f8zVbqcAdjeySt6zUGor7u4StNe2PMnTEMZhRklnY0Y3iBUA/pO3COCJ/4wM6a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702b8489-7a2b-4756-bcbb-08d80dceb25a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 06:14:28.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVemtEt9cOFrNMQW3+CWKa9E9Jdp4kByXCrdENbJknjwAc6zwtCja5jT6f3QbvLL73tneoc2lalV9bVv6KAK+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the IPI handling routine riscv_software_interrupt() does
not take any argument and also does not perform irq_enter()/irq_exit().

This patch makes IPI handling routine more self-contained by:
1. Passing "pt_regs *" argument
2. Explicitly doing irq_enter()/irq_exit()
3. Explicitly save/restore "pt_regs *" using set_irq_regs()

With above changes, IPI handling routine does not depend on caller
function to perform irq_enter()/irq_exit() and save/restore of
"pt_regs *" hence its more self-contained. This also enables us
to call IPI handling routine from IRQCHIP drivers.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/irq.h |  1 -
 arch/riscv/include/asm/smp.h |  3 +++
 arch/riscv/kernel/irq.c      | 16 ++++++++++------
 arch/riscv/kernel/smp.c      | 11 +++++++++--
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 6e1b0e0325eb..0183e15ace66 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -13,7 +13,6 @@
 #define NR_IRQS         0
 
 void riscv_timer_interrupt(void);
-void riscv_software_interrupt(void);
 
 #include <asm-generic/irq.h>
 
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index f4c7cfda6b7f..40bb1c15a731 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -28,6 +28,9 @@ void show_ipi_stats(struct seq_file *p, int prec);
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
 
+/* Called from C code, this handles an IPI. */
+void handle_IPI(struct pt_regs *regs);
+
 /* Hook for the generic smp_call_function_many() routine. */
 void arch_send_call_function_ipi_mask(struct cpumask *mask);
 
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 345c4f2eba13..bb0bfcd537e7 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -19,12 +19,15 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
+	struct pt_regs *old_regs;
 
-	irq_enter();
 	switch (regs->cause & ~CAUSE_IRQ_FLAG) {
 	case RV_IRQ_TIMER:
+		old_regs = set_irq_regs(regs);
+		irq_enter();
 		riscv_timer_interrupt();
+		irq_exit();
+		set_irq_regs(old_regs);
 		break;
 #ifdef CONFIG_SMP
 	case RV_IRQ_SOFT:
@@ -32,19 +35,20 @@ asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
 		 * We only use software interrupts to pass IPIs, so if a non-SMP
 		 * system gets one, then we don't know what to do.
 		 */
-		riscv_software_interrupt();
+		handle_IPI(regs);
 		break;
 #endif
 	case RV_IRQ_EXT:
+		old_regs = set_irq_regs(regs);
+		irq_enter();
 		handle_arch_irq(regs);
+		irq_exit();
+		set_irq_regs(old_regs);
 		break;
 	default:
 		pr_alert("unexpected interrupt cause 0x%lx", regs->cause);
 		BUG();
 	}
-	irq_exit();
-
-	set_irq_regs(old_regs);
 }
 
 void __init init_IRQ(void)
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index a65a8fa0c22d..b1d4f452f843 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -123,11 +123,14 @@ static inline void clear_ipi(void)
 		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
 }
 
-void riscv_software_interrupt(void)
+void handle_IPI(struct pt_regs *regs)
 {
+	struct pt_regs *old_regs = set_irq_regs(regs);
 	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
 	unsigned long *stats = ipi_data[smp_processor_id()].stats;
 
+	irq_enter();
+
 	clear_ipi();
 
 	while (true) {
@@ -138,7 +141,7 @@ void riscv_software_interrupt(void)
 
 		ops = xchg(pending_ipis, 0);
 		if (ops == 0)
-			return;
+			goto done;
 
 		if (ops & (1 << IPI_RESCHEDULE)) {
 			stats[IPI_RESCHEDULE]++;
@@ -160,6 +163,10 @@ void riscv_software_interrupt(void)
 		/* Order data access and bit testing. */
 		mb();
 	}
+
+done:
+	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 static const char * const ipi_names[] = {
-- 
2.25.1

