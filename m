Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1CFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C6E2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgHSNd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:33:59 -0400
Received: from foss.arm.com ([217.140.110.172]:36996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbgHSNds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:33:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 649E71435;
        Wed, 19 Aug 2020 06:33:43 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E42F63F71F;
        Wed, 19 Aug 2020 06:33:41 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, swboyd@chromium.org,
        sumit.garg@linaro.org, Julien Thierry <julien.thierry@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v6 7/7] arm_pmu: arm64: Use NMIs for PMU
Date:   Wed, 19 Aug 2020 14:34:19 +0100
Message-Id: <20200819133419.526889-8-alexandru.elisei@arm.com>
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

Add required PMU interrupt operations for NMIs. Request interrupt lines as
NMIs when possible, otherwise fall back to normal interrupts.

NMIs are only supported on the arm64 architecture with a GICv3 irqchip.

Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
[Added that NMIs only work on arm64 + GICv3]
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 drivers/perf/arm_pmu.c | 62 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 17e5952d21e4..dd9d7f61ee29 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -45,6 +45,17 @@ static const struct pmu_irq_ops pmuirq_ops = {
 	.free_pmuirq = armpmu_free_pmuirq
 };
 
+static void armpmu_free_pmunmi(unsigned int irq, int cpu, void __percpu *devid)
+{
+	free_nmi(irq, per_cpu_ptr(devid, cpu));
+}
+
+static const struct pmu_irq_ops pmunmi_ops = {
+	.enable_pmuirq = enable_nmi,
+	.disable_pmuirq = disable_nmi_nosync,
+	.free_pmuirq = armpmu_free_pmunmi
+};
+
 static void armpmu_enable_percpu_pmuirq(unsigned int irq)
 {
 	enable_percpu_irq(irq, IRQ_TYPE_NONE);
@@ -63,6 +74,31 @@ static const struct pmu_irq_ops percpu_pmuirq_ops = {
 	.free_pmuirq = armpmu_free_percpu_pmuirq
 };
 
+static void armpmu_enable_percpu_pmunmi(unsigned int irq)
+{
+	if (!prepare_percpu_nmi(irq))
+		enable_percpu_nmi(irq, IRQ_TYPE_NONE);
+}
+
+static void armpmu_disable_percpu_pmunmi(unsigned int irq)
+{
+	disable_percpu_nmi(irq);
+	teardown_percpu_nmi(irq);
+}
+
+static void armpmu_free_percpu_pmunmi(unsigned int irq, int cpu,
+				      void __percpu *devid)
+{
+	if (armpmu_count_irq_users(irq) == 1)
+		free_percpu_nmi(irq, devid);
+}
+
+static const struct pmu_irq_ops percpu_pmunmi_ops = {
+	.enable_pmuirq = armpmu_enable_percpu_pmunmi,
+	.disable_pmuirq = armpmu_disable_percpu_pmunmi,
+	.free_pmuirq = armpmu_free_percpu_pmunmi
+};
+
 static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
 static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
@@ -633,15 +669,29 @@ int armpmu_request_irq(int irq, int cpu)
 			    IRQF_NO_THREAD;
 
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
-		err = request_irq(irq, handler, irq_flags, "arm-pmu",
+
+		err = request_nmi(irq, handler, irq_flags, "arm-pmu",
 				  per_cpu_ptr(&cpu_armpmu, cpu));
 
-		irq_ops = &pmuirq_ops;
+		/* If cannot get an NMI, get a normal interrupt */
+		if (err) {
+			err = request_irq(irq, handler, irq_flags, "arm-pmu",
+					  per_cpu_ptr(&cpu_armpmu, cpu));
+			irq_ops = &pmuirq_ops;
+		} else {
+			irq_ops = &pmunmi_ops;
+		}
 	} else if (armpmu_count_irq_users(irq) == 0) {
-		err = request_percpu_irq(irq, handler, "arm-pmu",
-					 &cpu_armpmu);
-
-		irq_ops = &percpu_pmuirq_ops;
+		err = request_percpu_nmi(irq, handler, "arm-pmu", &cpu_armpmu);
+
+		/* If cannot get an NMI, get a normal interrupt */
+		if (err) {
+			err = request_percpu_irq(irq, handler, "arm-pmu",
+						 &cpu_armpmu);
+			irq_ops = &percpu_pmuirq_ops;
+		} else {
+			irq_ops = &percpu_pmunmi_ops;
+		}
 	} else {
 		/* Per cpudevid irq was already requested by another CPU */
 		irq_ops = armpmu_find_irq_ops(irq);
-- 
2.28.0

