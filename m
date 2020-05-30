Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B7BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EF920776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iYhrfFd+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D41oLxUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgE3KIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 06:08:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3443 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgE3KIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 06:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590833301; x=1622369301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=InDoWY8f2xO/RElNkzxlDBeH+8ys34GZlwup/58O3Jg=;
  b=iYhrfFd+ljhmbgKxOu/0ZZb8SWIFwYSUuMV67zN08ijMSahl3Ais5pt2
   DoMM7YEmfhf5CAx/mBhtNETVhCDONNTa8aUSzFXzc7LlwVIn/LWLho4pv
   1TZgiLv+7YpBV93McAokMW1tJiMNUlftH4+4cco8SUeMSfpdUEWxR5QK8
   gXyj2VxkEhKcGJZsSWdu9Zf19xGWse1U5zINUHc/ugfvTgr2/3kJyvrcj
   QRTuqcyBuQ+toT2n59vBBFARRLfPkjWdAyqGkoZZScXiLwQpdkekWjcGd
   DQjr0j+pGBQNM4whiEgs4hUy3Tjy1D8XZTvZI3QumVKSU2/xIalxawKjb
   g==;
IronPort-SDR: vT6yfxCq/Kd0vVpeSMsUL4MISgShSsbixfmBLDrkgRV914teBO4n0fOEK4qWmwC/3zum9eYMY0
 UT4kZO4MMwgzgi7hp4Q0PfMwzRsNHNeAL4y4h1BeyT28bFWV/Pn46jZ3Hik6gUgZVok9c+sR/y
 wCRMMeXzz7jcI66eUDItSag8DpJxY5N75Z6yvXt5NIzVMWyU+ltOgWG3t5iOBwKl5rEQ3k2DOm
 sQ3NB6/qXPb/OwLWHCVM8RzVWGM77OqxiRWUVezDgoTR/Cs499ZPCZu/NUNhshKC6aBmB0lo7a
 TmU=
X-IronPort-AV: E=Sophos;i="5.73,451,1583164800"; 
   d="scan'208";a="138846371"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2020 18:08:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI3PpIiuOeDrtyv8cYu9FLbU/iXdMrfWCeAOknSGYtMd0cggk+cz8O5ZKQBZgIJbIlJvPvwVIXOmTJ4PyTs8mgwqofdUvyVfnhaIQpG4kkUXC+GoHZL8L6gVSfdd9H0ySpHzAWLRyHCXuFnARH0YePyoVN+sax9s1UQ43rl8iNkBs6XzCCkdh79aZ6UKqSMwpZ78oThIP6qwmrdcbsRnaUaxvxjfx9LS7icppDmBvg/MYNA4XL9Tu1ZWy3EKMajA+YhdsOa6Uy8jyVgGRbBfUq6P58GEywhKB/va0zy6j4QzdvZBeIUqknUB0q68OP4tHcJ5aXtVe/8wJXJGHtZang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC35t79tsLxGd9uRH3iT6OLCE7+HcSkgurQGwuNUT/4=;
 b=KBCDqwcoOVe90tH3HlpkA6wq5Wt88MlbiYMF/jOjLfi4Vx+fAPdG4Hhx26wQdtCJS4v7Z6XvGmaj9M5DwwaBqGX8PzFXKjI9mnsn/PIK5hntlKtziadbgpWbteQMNt2S66B3WYC4e4StacwNwhSiO7fUzeYMgdG5s2HB1QKQHrMttGVZ0AZPtDBQortF4t3Y0B+n9hT443RgUBbX/f+m6M00kL4GIiClMEKKIgddoo41SfadIBDytRw3GKxkqOIngvxYXGx/RD82vUfJv02uYp1+EjQSTGhL2/M6Gt9dNmK+ft7PCRGdXeWXGQWkwOUfro2E7c8PWIYgOaU/b56HyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC35t79tsLxGd9uRH3iT6OLCE7+HcSkgurQGwuNUT/4=;
 b=D41oLxURDlH8LAAPht5lVumOxwY3Qy/DN/qnA/PXa0aRrOhyZQU19N5VBW8ipS835veLjPB8UmzQbuYtXGyfz2tr971cvT4I8dVCsKHatluofLbUqqPaBRyvLEvnKfjxjGIoUf/VY8vEMaQt7KUur/yyaaCiHMpm1yKxsYMU5+c=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4314.namprd04.prod.outlook.com (2603:10b6:5:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Sat, 30 May
 2020 10:08:10 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.022; Sat, 30 May 2020
 10:08:10 +0000
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
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v6 4/6] clocksource/drivers/timer-riscv: Use per-CPU timer interrupt
Date:   Sat, 30 May 2020 15:37:23 +0530
Message-Id: <20200530100725.265481-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200530100725.265481-1-anup.patel@wdc.com>
References: <20200530100725.265481-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::23) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (49.207.61.131) by MAXPR0101CA0037.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21 via Frontend Transport; Sat, 30 May 2020 10:08:06 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.61.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6ca9c63-3fe9-4931-915d-08d804815b3b
X-MS-TrafficTypeDiagnostic: DM6PR04MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4314B177733704115B3CC52F8D8C0@DM6PR04MB4314.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 041963B986
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztAWxmoZRapjFiY38MSYA868uGVOt/eSKWO0puZ2xOXi2lOSaLn44ZiKrsS1ouZYtuFI27bfjFfXINqIPxDnUwReAsUshrcn5h3nqnA6U2FixWevka6FcJsFR7LRVLgy/L+0gpvhLtI61rDzR2yY/8J6TgoFjohKDMaYYfQRllYuA1cJLJsgAfictWxHu/mYc4lpS+8JCw67/DAthRohaQMnqzSqwW7kFRCZWhwu0Y6L1MMXZOYEe1poABf2FlrFdvxJ2U2zDWD2IiQU0j2KnuuVwvJd3rYSURqR8AhFqmSbFQ5JS9sI7Ns9gwRVzJ+5BnEaoYpZKMTnpkRIHGt/Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(26005)(1006002)(186003)(1076003)(6666004)(55236004)(4326008)(956004)(8886007)(16526019)(5660300002)(2616005)(8676002)(8936002)(478600001)(36756003)(44832011)(2906002)(55016002)(7696005)(52116002)(7416002)(54906003)(110136005)(66476007)(66556008)(66946007)(86362001)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: BTREUMgKajCqovQJqKrQgabNIEAzMxbgKfMV6MjqTjkD8Nco4aQuOBcyhkDEwVyjaMFd/7VH/kRW0zXBCT/GEzKZMb04+1QZqAqPgfedr7EpGQ6O1K5B3tZOtwAbpcPNmV5JNrB6/EBCJQfjX5LWSo+jxyFvN5MHNa+nLfJkSfviWQBV57y2leEZGwLGZAoD8BIdwpry9IWJVyHVyageeU177i/1U9Dy0osDY/xEEm4rPxA4s+JH5VCVcW06ArLP82HyeF5P8/g0JIO8VxrynVVHX1vWJBcChAAYSCMG4Qpyi8V3ad9Ls048Of04NYDhmyxdZ2PxsYSHbQxkbjdDnRFJktsD8Au5zQntXL/Jgli4XMXeWIBIFVvWdOKqQ3mLbycd+BF/b9yF0RXoLlsO8ve27qY8wnl9muigVghOv+Dp24gVNG+HnpDTo0IIxndHIxM0/aLZHcObcoeoXTWDjuqfRFRRnboNWKhIx7SedMQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ca9c63-3fe9-4931-915d-08d804815b3b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2020 10:08:10.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzRUtJMhB4Hh3IcsyP45Rtw8ioQUz1F8RLTqoQk3Q04T6EuK0gBlfTiFtf3Eu1w21ZFsc1UB254wVatqPT7qmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4314
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of directly calling RISC-V timer interrupt handler from
RISC-V local interrupt conntroller driver, this patch implements
RISC-V timer interrupt as a per-CPU interrupt using per-CPU APIs
of Linux IRQ subsystem.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/irq.h      |  2 --
 drivers/clocksource/timer-riscv.c | 41 ++++++++++++++++++++++++++++---
 drivers/irqchip/irq-riscv-intc.c  |  8 ------
 3 files changed, 38 insertions(+), 13 deletions(-)

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
index c4f15c4068c0..1fe847983f50 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -12,8 +12,11 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/sched_clock.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
 #include <asm/smp.h>
 #include <asm/sbi.h>
 
@@ -39,6 +42,7 @@ static int riscv_clock_next_event(unsigned long delta,
 	return 0;
 }
 
+static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
 	.features		= CLOCK_EVT_FEAT_ONESHOT,
@@ -74,30 +78,36 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
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
 	int cpuid, hartid, error;
+	struct device_node *child;
+	struct irq_domain *domain;
 
 	hartid = riscv_of_processor_hartid(n);
 	if (hartid < 0) {
@@ -115,6 +125,23 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	if (cpuid != smp_processor_id())
 		return 0;
 
+	domain = NULL;
+	for_each_child_of_node(n, child) {
+		domain = irq_find_host(child);
+		if (domain)
+			break;
+	}
+	if (!domain) {
+		pr_err("Failed to find interrupt domain for node [%pOF]\n", n);
+		return -ENODEV;
+	}
+
+	riscv_clock_event_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
+	if (!riscv_clock_event_irq) {
+		pr_err("Failed to map timer interrupt for node [%pOF]\n", n);
+		return -ENODEV;
+	}
+
 	pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
 	       __func__, cpuid, hartid);
 	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
@@ -126,6 +153,14 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 
 	sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
 
+	error = request_percpu_irq(riscv_clock_event_irq,
+				    riscv_timer_interrupt,
+				    "riscv-timer", &riscv_clock_event);
+	if (error) {
+		pr_err("registering percpu irq failed [%d]\n", error);
+		return error;
+	}
+
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 84e7bda3a090..e6c07d8f3893 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -21,20 +21,12 @@ static struct irq_domain *intc_domain;
 
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
2.25.1

