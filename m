Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F76BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E06C20812
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ROMLsMG7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Vs4nsohn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgFKGOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:14:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7315 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFKGOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591856086; x=1623392086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CsGAY4kTkSFUBrIlQPzb+WF83yurQ823cHywkzHVYLw=;
  b=ROMLsMG710tl098b7UjsDLCC7NmB/IKg9HxUlL2bGAboHqqRt+fB1qhX
   oBXRQRCCy5pYzYMSnDvF9QvJocsaZ8eQj/ZxlO4xYKpPk8Chlp7KHEpMe
   ingF6CaidKF5HJFlTA5pmbUPpKY0h652X/Z9U8+ZnpkHgBhpf5yJaKOQO
   00/ULNfbKksoXkG5AkkNvTxC1IaFReZ1DhupZO1VNJRMUSpv8S1yeG+ky
   /4fhP+W+xjN8YpVR0f25d1NQM4DQXVVceXmnZdy16J1rIMxZvi8amHI5c
   GAd1HxniWSheqeH1QQPptjPTtMq3BrBxCLQguPKwS1IPu6oMufJSJ7M07
   g==;
IronPort-SDR: B2rS967zzCcF/nABztvjwAG+ABOsWbu2NhJtOtgL+xKUYkUnS9Cca4OEG7MZcJEcuP8Ulev9Qb
 MEECj/2WNYfSCMn/O0/+VUDz0XFwKhY++2LpOqDf4giHblT0T8YQTdcbVDYzunZgKI2tsczSi4
 G9MnO50+TXWfz4Zx4JbdahWpJp9nsBHuN1NCiRIMe8BohEhkxiQ8pgeSyeTH2HjhVqwVuXmAzE
 SEiETYdWQPgmEHuEYlwJoDiLMxq0KMMN+sV8yILKcN+TBVmjBgOiBKkL77zx3WzavAH5ivajIb
 kWk=
X-IronPort-AV: E=Sophos;i="5.73,498,1583164800"; 
   d="scan'208";a="248852974"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 14:14:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG0UUE4ZAE1fORMxhzv/0SmVNj+s4O6SiXiUAw5v5w4oqV51i9pbv6GvMkgnXSKPQD4yqtjXqJxuAYuh6JKmgioM+7HSDAOBDCxHyXAzpUOnfcPyolIfG6/0QYca7hl1loZWZmDs3KCcWSA/hTvf93O0gDu3jYIXgUsTIYNF5VUNFwt7GG9nFHxJDwLUcBQuVZ7N9T47/QWL5816os4g0gwqRvbXAwFs7sLwPiQrbHDl24o7qntFIEyUdTr3yDPChBuSid4Re2l8HOe9kTbE0MAsLba2wMaAGgYsIKBqjwjzvSArlnHCCDbfGue1XBPc4cuATUuvWClZ2xiLwuJ23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjjXdh+Kv559xSuyfQBtUJFdzt7V5EoEUkE4sllTOd8=;
 b=LfnWgbzFlEmF2ecFjslXgB6OfpbX33qoKyOu94Ba39o64eoBOXM3O88xBg1SMkZQCs9O9Jn48/fbDcXDi+UrXAPtlv1gmKIWQqekmqqoM/kLiT5tG7Xx5oz55iMOqABfZJo8vfDLfADqY6t29q2J+iUwnnHntQ0AItdZc5ZdpFexbSmNMaq27kfuSife1nxFD46GxObuBumwp2hSlyTFn3qymFevcjLpyvFn0sacCoSnoMsl8c2yrPxixsJj4L3D1fW8D5BFaN1SHtb47itOrrOEd/6YnpP535gwbi23D0gmpNfK8oKFo8cyOlYFL8uofOk+jPqXWc5zoTdYWujNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjjXdh+Kv559xSuyfQBtUJFdzt7V5EoEUkE4sllTOd8=;
 b=Vs4nsohntxFudDTbQ808WvCKWAqB2zDI06a8ZyLHNaN+rdkCQCHDLS8cgtoVNXKhlEQYJdMkh1+JdvFF8+D4sX+pOSKrT4QpYSp6jMOlfVyXc9bXx6ABRj4mWbTLF9Jhz4SBJM++Cfk6jvo9j27b3wX4LUfMMVUu+HJWvznrhEE=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6332.namprd04.prod.outlook.com (2603:10b6:5:1e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 11 Jun
 2020 06:14:44 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 06:14:44 +0000
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
Subject: [PATCH v8 4/6] clocksource/drivers/timer-riscv: Use per-CPU timer interrupt
Date:   Thu, 11 Jun 2020 11:43:48 +0530
Message-Id: <20200611061350.434293-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611061350.434293-1-anup.patel@wdc.com>
References: <20200611061350.434293-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17)
 To DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.182.246.89) by MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 06:14:39 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.182.246.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c8d9890-51e3-44c4-1d15-08d80dcebb9e
X-MS-TrafficTypeDiagnostic: DM6PR04MB6332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6332CFCCD2A52A796AD0FC018D800@DM6PR04MB6332.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7yjUTWhuzPHhEt5Sl6dSsnOuCtfqgjOkcMVnD02F3dWU2aWhYjI/6D/Yyzs4ZDAvgir3DGqCBhLSBE1w9sOo5/7ZvcWGkQyFF3KZozsX0l2VkuMPj8aOQ3UK+YHpTqi08+oCKhuDVg/eEG+6EMnIdetlAQqykIgPOxmyXXT0/cwMt7U7H5qj3mVmq9vxBwjpZet54q3UbpNSRH6TAhLZ61WDhIa+FpD3O6Ffo0BNsosW5IvFFN5T/cZ+CmB/tnlw3LSOnZm6IrP2/+o0lRTC/RAQ9FF8QV7hvnrxoUTsgojjeBm/86EZlexUqgy383fpkLPY+DUY2OlxacN/48V7Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(36756003)(16526019)(4326008)(186003)(44832011)(2616005)(55016002)(8936002)(1076003)(5660300002)(956004)(7696005)(110136005)(7416002)(83380400001)(478600001)(52116002)(8886007)(86362001)(316002)(6666004)(54906003)(66556008)(2906002)(8676002)(26005)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Bl0CGboeEWjJFdBRuLBkJsypij9on/AhhkaapeElqoh7qdlmrtoE9B8F5lol7earKo1tY/W8uextVKemQu3Pa/+iteTahw5Pk8WNoI3nHbjLeHsBr1yVqgtGirR4FFhuXc+fsmsXmG0KORvio/vtECm3dIVeoPyfSs1HLfbNq2vuKL4ARH7afBKR3az5AzCuKG3XqJBAFmzjYh8yAW1fm6ZhfgphyCK/qG/PCG1QCHru3PAMRsErwcx1ji7xNGwSXK+H8e8dJ9PlXMpl8kj0vysS+AkIJdTMf6gnmCFl5EMUV1eebzZHlGxO5NZcyslP+9K3pUXg3Rs2tAUOVo6B9d4ZGuwxqkrg6xTKRdtbja9YY/vkPEMUx9Yy9vpXp2DoLMFGKbyfso2C/iGoO4JgHiHR3BFETGJBnO/M9oFLj+Rr28wf6lyrfT4RsnufrzZJ+EiYkvIKqbMYWetZWBHnZ8UNDhfK3Xn9BFiVUArV/Nk=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8d9890-51e3-44c4-1d15-08d80dcebb9e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 06:14:43.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl2kV9lfoVkoSL0zqKnZErqHcx0D5p96q71Y8rUQsOZCehtQfxRinWHpEJ7HcRvcWr6pFANyLzUvY3yToad+YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6332
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
Reviewed-by: Marc Zyngier <maz@kernel.org>
---
 arch/riscv/include/asm/irq.h      |  2 --
 drivers/clocksource/timer-riscv.c | 43 ++++++++++++++++++++++++++++---
 drivers/irqchip/irq-riscv-intc.c  |  8 ------
 3 files changed, 40 insertions(+), 13 deletions(-)

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
index c4f15c4068c0..9de1dabfb126 100644
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
@@ -115,6 +125,25 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	if (cpuid != smp_processor_id())
 		return 0;
 
+	domain = NULL;
+	child = of_get_compatible_child(n, "riscv,cpu-intc");
+	if (!child) {
+		pr_err("Failed to find INTC node [%pOF]\n", n);
+		return -ENODEV;
+	}
+	domain = irq_find_host(child);
+	of_node_put(child);
+	if (!domain) {
+		pr_err("Failed to find IRQ domain for node [%pOF]\n", n);
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
@@ -126,6 +155,14 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 
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
index 3e2bca34313c..8017f6d32d52 100644
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

