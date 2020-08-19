Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C605C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F15208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgHSNeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:34:12 -0400
Received: from foss.arm.com ([217.140.110.172]:36980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbgHSNdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:33:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0749142F;
        Wed, 19 Aug 2020 06:33:41 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 306D33F71F;
        Wed, 19 Aug 2020 06:33:40 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, swboyd@chromium.org,
        sumit.garg@linaro.org, Julien Thierry <julien.thierry@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v6 6/7] arm_pmu: Introduce pmu_irq_ops
Date:   Wed, 19 Aug 2020 14:34:18 +0100
Message-Id: <20200819133419.526889-7-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819133419.526889-1-alexandru.elisei@arm.com>
References: <20200819133419.526889-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Currently the PMU interrupt can either be a normal irq or a percpu irq.
Supporting NMI will introduce two cases for each existing one. It becomes
a mess of 'if's when managing the interrupt.

Define sets of callbacks for operations commonly done on the interrupt. The
appropriate set of callbacks is selected at interrupt request time and
simplifies interrupt enabling/disabling and freeing.

Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 drivers/perf/arm_pmu.c | 86 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index df352b334ea7..17e5952d21e4 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -26,8 +26,46 @@
 
 #include <asm/irq_regs.h>
 
+static int armpmu_count_irq_users(const int irq);
+
+struct pmu_irq_ops {
+	void (*enable_pmuirq)(unsigned int irq);
+	void (*disable_pmuirq)(unsigned int irq);
+	void (*free_pmuirq)(unsigned int irq, int cpu, void __percpu *devid);
+};
+
+static void armpmu_free_pmuirq(unsigned int irq, int cpu, void __percpu *devid)
+{
+	free_irq(irq, per_cpu_ptr(devid, cpu));
+}
+
+static const struct pmu_irq_ops pmuirq_ops = {
+	.enable_pmuirq = enable_irq,
+	.disable_pmuirq = disable_irq_nosync,
+	.free_pmuirq = armpmu_free_pmuirq
+};
+
+static void armpmu_enable_percpu_pmuirq(unsigned int irq)
+{
+	enable_percpu_irq(irq, IRQ_TYPE_NONE);
+}
+
+static void armpmu_free_percpu_pmuirq(unsigned int irq, int cpu,
+				   void __percpu *devid)
+{
+	if (armpmu_count_irq_users(irq) == 1)
+		free_percpu_irq(irq, devid);
+}
+
+static const struct pmu_irq_ops percpu_pmuirq_ops = {
+	.enable_pmuirq = armpmu_enable_percpu_pmuirq,
+	.disable_pmuirq = disable_percpu_irq,
+	.free_pmuirq = armpmu_free_percpu_pmuirq
+};
+
 static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
+static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
 
 static inline u64 arm_pmu_event_max_period(struct perf_event *event)
 {
@@ -544,6 +582,19 @@ static int armpmu_count_irq_users(const int irq)
 	return count;
 }
 
+static const struct pmu_irq_ops *armpmu_find_irq_ops(int irq)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(cpu_irq, cpu) == irq
+		    && per_cpu(cpu_irq_ops, cpu))
+			return per_cpu(cpu_irq_ops, cpu);
+	}
+
+	return NULL;
+}
+
 void armpmu_free_irq(int irq, int cpu)
 {
 	if (per_cpu(cpu_irq, cpu) == 0)
@@ -551,18 +602,18 @@ void armpmu_free_irq(int irq, int cpu)
 	if (WARN_ON(irq != per_cpu(cpu_irq, cpu)))
 		return;
 
-	if (!irq_is_percpu_devid(irq))
-		free_irq(irq, per_cpu_ptr(&cpu_armpmu, cpu));
-	else if (armpmu_count_irq_users(irq) == 1)
-		free_percpu_irq(irq, &cpu_armpmu);
+	per_cpu(cpu_irq_ops, cpu)->free_pmuirq(irq, cpu, &cpu_armpmu);
 
 	per_cpu(cpu_irq, cpu) = 0;
+	per_cpu(cpu_irq_ops, cpu) = NULL;
 }
 
 int armpmu_request_irq(int irq, int cpu)
 {
 	int err = 0;
 	const irq_handler_t handler = armpmu_dispatch_irq;
+	const struct pmu_irq_ops *irq_ops;
+
 	if (!irq)
 		return 0;
 
@@ -584,15 +635,26 @@ int armpmu_request_irq(int irq, int cpu)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		err = request_irq(irq, handler, irq_flags, "arm-pmu",
 				  per_cpu_ptr(&cpu_armpmu, cpu));
+
+		irq_ops = &pmuirq_ops;
 	} else if (armpmu_count_irq_users(irq) == 0) {
 		err = request_percpu_irq(irq, handler, "arm-pmu",
 					 &cpu_armpmu);
+
+		irq_ops = &percpu_pmuirq_ops;
+	} else {
+		/* Per cpudevid irq was already requested by another CPU */
+		irq_ops = armpmu_find_irq_ops(irq);
+
+		if (WARN_ON(!irq_ops))
+			err = -EINVAL;
 	}
 
 	if (err)
 		goto err_out;
 
 	per_cpu(cpu_irq, cpu) = irq;
+	per_cpu(cpu_irq_ops, cpu) = irq_ops;
 	return 0;
 
 err_out:
@@ -625,12 +687,8 @@ static int arm_perf_starting_cpu(unsigned int cpu, struct hlist_node *node)
 	per_cpu(cpu_armpmu, cpu) = pmu;
 
 	irq = armpmu_get_cpu_irq(pmu, cpu);
-	if (irq) {
-		if (irq_is_percpu_devid(irq))
-			enable_percpu_irq(irq, IRQ_TYPE_NONE);
-		else
-			enable_irq(irq);
-	}
+	if (irq)
+		per_cpu(cpu_irq_ops, cpu)->enable_pmuirq(irq);
 
 	return 0;
 }
@@ -644,12 +702,8 @@ static int arm_perf_teardown_cpu(unsigned int cpu, struct hlist_node *node)
 		return 0;
 
 	irq = armpmu_get_cpu_irq(pmu, cpu);
-	if (irq) {
-		if (irq_is_percpu_devid(irq))
-			disable_percpu_irq(irq);
-		else
-			disable_irq_nosync(irq);
-	}
+	if (irq)
+		per_cpu(cpu_irq_ops, cpu)->disable_pmuirq(irq);
 
 	per_cpu(cpu_armpmu, cpu) = NULL;
 
-- 
2.28.0

