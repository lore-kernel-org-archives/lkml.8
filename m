Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F4EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0928E206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971993;
	bh=d9M///x+pLXFY3usF7TVu3R9BQQHkwl5H+Bd6UsB36Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2HJp+oYRX2tW71qxjSanvkq7B95qS3RkXk8iQhGMarDpJFi6HJ4BjFmeplq6JSODx
	 WdGA2/3i/hH/a8T9iiu+2/uUN9RWNyqJ8O5Acu218xLOdrz0+Qx+4Wx92ZH8uNS6rn
	 lv/iOgYq+nXDlBMQmXEvqq2jA8nZBlGKBYDcXvKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgIAOxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgIAOuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:50:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91DC5206EB;
        Tue,  1 Sep 2020 14:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971850;
        bh=d9M///x+pLXFY3usF7TVu3R9BQQHkwl5H+Bd6UsB36Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+d7ydhJQNG/H0W5Q/dmrGtjd6y9csY6mztdWdzcrSBM34BzD/Og3eWdxF00VyOWK
         2vfSIfiiLRcnZigxeyAxQ5McZMF3jvhM5wEuiiex1bYmNW82caCWRL9cNz+NZUx7Ch
         ntk5wpqHufMu8cbHm6MiQayzf2ettysxIKNpMDrA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD7Ve-008IQP-8r; Tue, 01 Sep 2020 15:43:42 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v3 15/16] ARM: Kill __smp_cross_call and co
Date:   Tue,  1 Sep 2020 15:43:23 +0100
Message-Id: <20200901144324.1071694-16-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200901144324.1071694-1-maz@kernel.org>
References: <20200901144324.1071694-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, saravanak@google.com, kernel-team@android.com, valentin.schneider@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old IPI registration interface is now unused on arm, so let's
get rid of it.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/smp.h |  6 ------
 arch/arm/kernel/smp.c      | 26 +++++++-------------------
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 0e29730295ca..0ca55a607d0a 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -39,12 +39,6 @@ void handle_IPI(int ipinr, struct pt_regs *regs);
  */
 extern void smp_init_cpus(void);
 
-
-/*
- * Provide a function to raise an IPI cross call on CPUs in callmap.
- */
-extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
-
 /*
  * Register IPI interrupts with the arch SMP code
  */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index f21f78483353..d51e64955a26 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -511,14 +511,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-static void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-
-void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
-{
-	if (!__smp_cross_call)
-		__smp_cross_call = fn;
-}
-
 static const char *ipi_types[NR_IPI] __tracepoint_string = {
 #define S(x,s)	[x] = s
 	S(IPI_WAKEUP, "CPU wakeup interrupts"),
@@ -530,11 +522,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_COMPLETION, "completion interrupts"),
 };
 
-static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-{
-	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
-	__smp_cross_call(target, ipinr);
-}
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
 
 void show_ipi_list(struct seq_file *p, int prec)
 {
@@ -713,16 +701,17 @@ static irqreturn_t ipi_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void ipi_send(const struct cpumask *target, unsigned int ipi)
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
-	__ipi_send_mask(ipi_desc[ipi], target);
+	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
+	__ipi_send_mask(ipi_desc[ipinr], target);
 }
 
 static void ipi_setup(int cpu)
 {
 	int i;
 
-	if (!ipi_irq_base)
+	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
 	for (i = 0; i < nr_ipi; i++)
@@ -733,7 +722,7 @@ static void ipi_teardown(int cpu)
 {
 	int i;
 
-	if (!ipi_irq_base)
+	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
 	for (i = 0; i < nr_ipi; i++)
@@ -759,7 +748,6 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 	}
 
 	ipi_irq_base = ipi_base;
-	set_smp_cross_call(ipi_send);
 
 	/* Setup the boot CPU immediately */
 	ipi_setup(smp_processor_id());
@@ -872,7 +860,7 @@ core_initcall(register_cpufreq_notifier);
 
 static void raise_nmi(cpumask_t *mask)
 {
-	__smp_cross_call(mask, IPI_CPU_BACKTRACE);
+	__ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
-- 
2.27.0

