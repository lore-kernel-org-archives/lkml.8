Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74619C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E4220828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XIyakozD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FO7XotOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgCILDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:03:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8810 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCILDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583751797; x=1615287797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=EdDs6hKVpqLSqFdHzXYP4zs3GOB0PXFxuZtxBudSytw=;
  b=XIyakozDBTtNpZV1gVkbInmX2LM/YrXBxAPyK47aJpcLHvVXUVY2Ba35
   meaxiNPdYZzq/XrgN0fMw70z8p40IdGz/NvuIrXp9BswYlFvg2C8UL/r0
   aS8m6ECSgLF10nsi4iDLhWUxvgWvcMONpaw9nG6WLMxoaN/t2VFMsB4ZQ
   d0f7qv9qGBFAdJuSGB91JtdtJWRe+QElIp+ZaPZdkS23WH0M3EFoeAUIQ
   v7g2ESMxVObvohH+inraFBdgFaJj0VOpTBUTRmp/RuCtn/bSkkcGr9MVH
   ydEBOyNUwVS5fm/xQEwTXxshaUW+DSUirPutc4AFcF0WV0WK32sWFwn28
   w==;
IronPort-SDR: XHYmpJ45J8AvCs9apdqJPxUvh9XAxFe7Qwh6T/0tdj3T29brTF6pBMVJrBkXxir898N9yVcGH9
 ez/aU2y3YpgT3RS0fjIqDDrD4ZgkpX9h1N81tYzJSMoSwFzkOvDXHxsKwDYnwVmhSh2QbWDPCk
 J4KfSHWGoN0PkOBWSE4isX5XVYssLiK5KIR60Bdk2z9XcDmKvyD6jOXTt3L/ijzNPfw/YIqavn
 hoAd4B2UrJ1suyh4yAHrjVzwtOFwsmHlAhbXlJDh2A249od1M+rsYC81i5nKZqypvdk6DH/TOo
 OTs=
X-IronPort-AV: E=Sophos;i="5.70,533,1574092800"; 
   d="scan'208";a="136341870"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2020 19:03:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy2C2pofrJHnm92qfyjDYmNFk3EJYpvkjXOsg2JZx6dxC+vgEN3945gsaSSACGWzrN3e1Y65+xe1wKrOJ3qqvQF6/3xa2nQLy19Idn9aOb3rdBXfK703Wi9S1kqv4sJk2dvxsrJNf5dsphhHUcmUPFsVMqyXNlD8RehFjK6yZTN/zRW82JUAphzZuf4Xsvr+tWpkDrfqorUPQ+upMPpV00sdYZVaGckUhEX9RG7DLYqpXi0Qv2+97pjQFheTy/sIxYYS7kJhi8HkIkAF+W0Rx5ohYeiHCCf3N/xm4QAjoXfxKGBm/Rk86MICwjBnQa1R7+yvObUyFwIRQ/Qgg77ECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoInDR6pWHGD+nuzsBp2UW9cUrjOOnmaowv8rQURudY=;
 b=JGt3yQXerlKNE/NhfplkwdSOx74dXo9o5jFtdGTmYxxammpckkLj0QWmagy2m03CjNTUOVK8dUoO0S9V0EqghvaAqKshA7P3gmSm9W5mflBZU1ZPHXy2Q0rgvO5+9DcCZO0kin/Drhii34WnLTGNsP3Mg2YdTFy0SI8BMtpvLrJKOcbYdJJF6HB32j+onlWBM/mwS97F4PSrcqCo57ukHiNuq1J4LG+pYhhKBPle9yzf99zw66L3pBWm8IDdOmJunAJam2CT3KBBW+lRt3Sj2mmNxq8sCsVietNGg9GhlzEQtQjg4GZvJKBRSrgI37UNsvOExsNb5bYk6NHlfsH6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoInDR6pWHGD+nuzsBp2UW9cUrjOOnmaowv8rQURudY=;
 b=FO7XotOmfQLKYrzN9z6RkW9YQGUrZViD1OUf6iN6YylaG8TDFKEphwPb7ppFpjOiNAk6rGtNPdrqMgUsCz1HhJNGl4rY4Gek7XtRq/ZZzb02XTysjC/fPOqoseNPofnMCCehpyuxlNzt03ox5uBidvgqKGhbhNdfEv7mFAijzzo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
 by MN2PR04MB6685.namprd04.prod.outlook.com (2603:10b6:208:1ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Mon, 9 Mar
 2020 11:03:13 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 11:03:13 +0000
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
Subject: [PATCH v4 4/5] clocksource: timer-riscv: Make timer interrupt as a per-CPU interrupt
Date:   Mon,  9 Mar 2020 16:32:10 +0530
Message-Id: <20200309110211.91130-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309110211.91130-1-anup.patel@wdc.com>
References: <20200309110211.91130-1-anup.patel@wdc.com>
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::13) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.22.61) by MAXPR01CA0071.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 11:03:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [106.51.22.61]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf403bdd-63ba-4970-afbe-08d7c419763c
X-MS-TrafficTypeDiagnostic: MN2PR04MB6685:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB66858EC7BA507263C20F71DF8DFE0@MN2PR04MB6685.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(16526019)(5660300002)(186003)(1076003)(36756003)(2906002)(478600001)(26005)(8886007)(4326008)(55236004)(7696005)(52116002)(8936002)(316002)(81156014)(8676002)(44832011)(81166006)(55016002)(956004)(1006002)(110136005)(86362001)(54906003)(66556008)(66476007)(2616005)(66946007)(6666004)(7416002)(32040200004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6685;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0wPt8XhfkF0MJZCztevQACq5HdH359kNWTHL8IbLnItkDmOR5DksvhypZAmJutF0uNfRRPHuRnG+Z3JtocKYTD7riaJDXI2HWIhxmwKnnDeWRdhSqnjJkOKVZxiEXkz19GXNejk4J4JSSHP7/nXO/rsyyQG8PdSAfOhxMTVNThC0x5OS1P7F4f9YZxKjAx6dQLxf7yXBDk14niNVF0Xa8PMMUOUC9hKYv7bw5qIEyW1kYK2IH22sccYPovoiAOzhNbfDMS9tXnYqdgBdbhrDCz62+1PL0AYpNMZDdyPHuZfUIozCokUCDJl7mWDMH+iQ1j22pFGfKfhKoy/eKG4ECeWus4KU5P+JA1onvGOexUmYFc78+HvA/9lKl4zztjwASN6vCbc8V/uWMqX08SelsSBIBUzYLTS7BNLr2SUg8sbw2WBpt53VBukMMnjWaG+57Ikp7DSLg36eKBUOXQFL9yUz+DJ3ptwYd8IiWWsZzKWYs4AkvGsV8Sd1uGWU6uY
X-MS-Exchange-AntiSpam-MessageData: bYPIJfYcb7zpj5Gve/QBio8WrzOKu+qHK0QzPu4RevCiVk0P8AXsDaUUe9/u/iCcqTB1vq2Gm53mKbyLKfrIAIvB2n4n7PoIYTpqODoA8uCm9RKZl+Nm0uxmMoUcC5dwuhCPbaiT4xUzJjZQwPvefA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf403bdd-63ba-4970-afbe-08d7c419763c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 11:03:13.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6UW6luMMPosGRIiRpF5qKC/CNfhsZBUhUUhyeSLRCCSvNNjqEn6B6atGqbf2+z3tAOeWR7JwZPi998dZ+qZ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of directly calling RISC-V timer interrupt handler from
RISC-V local interrupt conntroller driver, this patch implements
RISC-V timer interrupt as a per-CPU interrupt using per-CPU APIs
of Linux IRQ subsystem.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/irq.h      |  2 -
 drivers/clocksource/timer-riscv.c | 79 ++++++++++++++++++++-----------
 drivers/irqchip/irq-riscv-intc.c  |  8 ----
 3 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index a9e5f07a7e9c..9807ad164015 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -10,8 +10,6 @@
 #include <linux/interrupt.h>
 #include <linux/linkage.h>
 
-void riscv_timer_interrupt(void);
-
 #include <asm-generic/irq.h>
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index c4f15c4068c0..6b82f2e41f8e 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -14,7 +14,10 @@
 #include <linux/irq.h>
 #include <linux/sched_clock.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
-#include <asm/smp.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
 #include <asm/sbi.h>
 
 u64 __iomem *riscv_time_cmp;
@@ -39,6 +42,7 @@ static int riscv_clock_next_event(unsigned long delta,
 	return 0;
 }
 
+static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
 	.features		= CLOCK_EVT_FEAT_ONESHOT,
@@ -74,65 +78,86 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
 
 	ce->cpumask = cpumask_of(cpu);
+	ce->irq = riscv_clock_event_irq;
 	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
 
-	csr_set(CSR_IE, IE_TIE);
+	enable_percpu_irq(riscv_clock_event_irq,
+			  irq_get_trigger_type(riscv_clock_event_irq));
 	return 0;
 }
 
 static int riscv_timer_dying_cpu(unsigned int cpu)
 {
-	csr_clear(CSR_IE, IE_TIE);
+	disable_percpu_irq(riscv_clock_event_irq);
 	return 0;
 }
 
 /* called directly from the low-level interrupt handler */
-void riscv_timer_interrupt(void)
+static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
 
 	csr_clear(CSR_IE, IE_TIE);
 	evdev->event_handler(evdev);
+
+	return IRQ_HANDLED;
 }
 
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
-	int cpuid, hartid, error;
-
-	hartid = riscv_of_processor_hartid(n);
-	if (hartid < 0) {
-		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
-			n, hartid);
-		return hartid;
-	}
-
-	cpuid = riscv_hartid_to_cpuid(hartid);
-	if (cpuid < 0) {
-		pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
-		return cpuid;
-	}
-
-	if (cpuid != smp_processor_id())
+	int error;
+	struct of_phandle_args oirq;
+
+	/*
+	 * Either we have one INTC DT node under each CPU DT node
+	 * or a single system wide INTC DT node. Irrespective to
+	 * number of INTC DT nodes, we only proceed if we are able
+	 * to find irq_domain of INTC.
+	 *
+	 * Once we have INTC irq_domain, we create mapping for timer
+	 * interrupt HWIRQ and request_percpu_irq() on it.
+	 */
+
+	if (!irq_find_host(n) || riscv_clock_event_irq)
 		return 0;
 
-	pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
-	       __func__, cpuid, hartid);
+	oirq.np = n;
+	oirq.args_count = 1;
+	oirq.args[0] = RV_IRQ_TIMER;
+	riscv_clock_event_irq = irq_create_of_mapping(&oirq);
+	if (!riscv_clock_event_irq)
+		return -ENODEV;
+
 	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
 	if (error) {
-		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
-		       error, cpuid);
+		pr_err("registering clocksource failed [%d]\n", error);
 		return error;
 	}
 
 	sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
 
+	error = request_percpu_irq(riscv_clock_event_irq,
+				   riscv_timer_interrupt,
+				   "riscv-timer", &riscv_clock_event);
+	if (error) {
+		pr_err("registering percpu irq failed [%d]\n", error);
+		return error;
+	}
+
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
-	if (error)
+	if (error) {
 		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
 		       error);
-	return error;
+		return error;
+	}
+
+	pr_info("running at %lu.%02luMHz frequency\n",
+		(unsigned long)riscv_timebase / 1000000,
+		(unsigned long)(riscv_timebase / 10000) % 100);
+
+	return 0;
 }
 
-TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
+TIMER_OF_DECLARE(riscv_timer, "riscv,cpu-intc", riscv_timer_init_dt);
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index e8f7af6dd3c2..93d9d2a38059 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -20,20 +20,12 @@ static struct irq_domain *intc_domain;
 
 static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs;
 	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
 
 	if (unlikely(cause >= BITS_PER_LONG))
 		panic("unexpected interrupt cause");
 
 	switch (cause) {
-	case RV_IRQ_TIMER:
-		old_regs = set_irq_regs(regs);
-		irq_enter();
-		riscv_timer_interrupt();
-		irq_exit();
-		set_irq_regs(old_regs);
-		break;
 #ifdef CONFIG_SMP
 	case RV_IRQ_SOFT:
 		/*
-- 
2.17.1

