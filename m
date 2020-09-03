Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBD7C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4286E2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vWyyppW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgICPMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgICM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:26:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43127C06124F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 05:06:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so2153914pfw.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 05:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6rT3Oq3fCAt3C31zNixC41u1K5vlck9GLS8EDOYTmew=;
        b=vWyyppW7hpygvE/IkGGf/gUhETTigprQq6UV1DJ8NWDb0v+mRfJtrPiVVREDvTmBLE
         9wbVYxBwL7yziCp3zIGYydYwRUYaBmUoWla/7w6E6i7WekurGkRwFVOgFAzuX4EsdWK7
         SgBKTIy7EM9aXrk2pWefgyzvaHDSHZqiySbVvBukeOU9l09HsqE+QVe9pa2IW5Gd3RcA
         0N9szfLficZOOZaiT0Qzu0ekzkT7ttJz62H81vng9XHHjh762SLxUQzRLjfuQmZEa+mw
         v01MFTpWgVsZStU4//S/zrx2uL8iDLqzxfbPuBGKVITP0EfjiLk7cxCHzzs/rYzrKLm5
         mAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6rT3Oq3fCAt3C31zNixC41u1K5vlck9GLS8EDOYTmew=;
        b=kwmyHl1QqRUDfeIW5yI8q5abJmPFNs2apQK1ZGt7NbRNK0dc1AenmweFk/Y/b8zsPz
         6v0BMY44QJKd0F/a8Ve8CjAgKCy1rn++Wl191uYGgbe3JP5WhzL7slklvqcBvyGOuJxy
         X5bw+kacrXAUlJRvdlTUeb1VMW3yUckwKVlfECTj6gJWhFwcxMYmu2HEItnBC4jOXvLT
         cSP4r7f1Yq5Npl87O8ycAc4S53FP192NB7/jN5njpzyY/uX7YuMTGhwnlmQcWEwjufIw
         a5P7VnuhEMiHeILEW6MAKH7G8pFW7gM6ghh+SNMYiH2B/S81WPt9wZvR1RAG9MzkXW4s
         Inrg==
X-Gm-Message-State: AOAM532N0kvVSadaLr1piQHEdqS7vl4pHSAfjpOI5UafrYfhmT3bxBrw
        /0Y9QoNNafTVtdOIC3pp0Cxqmw==
X-Google-Smtp-Source: ABdhPJxmXC2UZJ7VbILNUGeZ4ZMRSdONwYc1dH1QIufwvZKqDdpG8ds3OWY7AMUfJZYq3qtbgunWWw==
X-Received: by 2002:a63:4503:: with SMTP id s3mr2696201pga.119.1599134770782;
        Thu, 03 Sep 2020 05:06:10 -0700 (PDT)
Received: from localhost.localdomain ([117.210.209.248])
        by smtp.gmail.com with ESMTPSA id s1sm2922022pgh.47.2020.09.03.05.06.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 05:06:10 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 4/4] arm64: kgdb: Round up cpus using IPI_CALL_NMI_FUNC
Date:   Thu,  3 Sep 2020 17:35:12 +0530
Message-Id: <1599134712-30923-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
References: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 platforms with GICv3 or later supports pseudo NMIs which can be
leveraged to round up CPUs which are stuck in hard lockup state with
interrupts disabled that wouldn't be possible with a normal IPI.

So instead switch to round up CPUs using IPI_CALL_NMI_FUNC. And in
case a particular arm64 platform doesn't supports pseudo NMIs,
IPI_CALL_NMI_FUNC will act as a normal IPI which maintains existing
kgdb functionality.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/kgdb.h |  8 ++++++++
 arch/arm64/kernel/kgdb.c      | 21 +++++++++++++++++++++
 arch/arm64/kernel/smp.c       |  3 ++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
index 21fc85e..6f3d3af 100644
--- a/arch/arm64/include/asm/kgdb.h
+++ b/arch/arm64/include/asm/kgdb.h
@@ -24,6 +24,14 @@ static inline void arch_kgdb_breakpoint(void)
 extern void kgdb_handle_bus_error(void);
 extern int kgdb_fault_expected;
 
+#ifdef CONFIG_KGDB
+extern void ipi_kgdb_nmicallback(int cpu, void *regs);
+#else
+static inline void ipi_kgdb_nmicallback(int cpu, void *regs)
+{
+}
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 1a157ca3..3a8ed97 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -14,6 +14,7 @@
 #include <linux/kgdb.h>
 #include <linux/kprobes.h>
 #include <linux/sched/task_stack.h>
+#include <linux/smp.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
@@ -353,3 +354,23 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	return aarch64_insn_write((void *)bpt->bpt_addr,
 			*(u32 *)bpt->saved_instr);
 }
+
+void ipi_kgdb_nmicallback(int cpu, void *regs)
+{
+	if (atomic_read(&kgdb_active) != -1)
+		kgdb_nmicallback(cpu, regs);
+}
+
+#ifdef CONFIG_SMP
+void kgdb_roundup_cpus(void)
+{
+	struct cpumask mask;
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(raw_smp_processor_id(), &mask);
+	if (cpumask_empty(&mask))
+		return;
+
+	arch_send_call_nmi_func_ipi_mask(&mask);
+}
+#endif
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 572f8f5..b4760d3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -32,6 +32,7 @@
 #include <linux/irq_work.h>
 #include <linux/kernel_stat.h>
 #include <linux/kexec.h>
+#include <linux/kgdb.h>
 #include <linux/kvm_host.h>
 
 #include <asm/alternative.h>
@@ -941,7 +942,7 @@ static void do_handle_IPI(int ipinr)
 #endif
 
 	case IPI_CALL_NMI_FUNC:
-		/* nop, IPI handlers for special features can be added here. */
+		ipi_kgdb_nmicallback(cpu, get_irq_regs());
 		break;
 
 	default:
-- 
2.7.4

