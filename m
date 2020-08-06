Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB34122CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qsJnTMnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgHFAP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgHFAOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:14:53 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B208C0617A4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 17:14:50 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y9so33739698plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 17:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1TZQegrBgPNN+SZZCsJyOP7eFX7H3/9/2zydOordKRU=;
        b=qsJnTMnJzhHJ++LUWoW6vocFm9wQINlyHtBzo7IvEhVyEwAtb06Zi9j/kRHMJDwXAY
         c4q3OKOo1paE2JI/Ch8SsUXyeA32JxJfHUdsxjykJaLHZ9uX42l4Ya6TMzSf44/H+eaJ
         d7KsrKFoKq5tHnIMiIRo2p3aO2riXoj8vi5KuvEuqoZqM2UM1f8BH3kG3J0viFBjRptM
         7DpDoV9WspbpLg1CscM1TZRvWdGbvNEMmm8SosvVe2NQdit2xFcP0cWoGAEuuEbQjk01
         wvm1Q64ky28ceB8zE5xbFgyohfzog8hHeE2wpEbMRRKOfuFQSNZEvLUbVXmSjKO8XLFP
         mpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1TZQegrBgPNN+SZZCsJyOP7eFX7H3/9/2zydOordKRU=;
        b=LyeH0EyYC6u0m6b16+LcbLDbdoB4JDEJ+RxVaAL+yteyN0WkgV2nQMoP65d5GAR8lo
         tAkPoB0JJ50Rh71YMBW3iKMje123wt1gTcEb1TypyiUM5InImA54cA2GsqAdXtupqYWD
         rcjgfr7R/ZFX9wbOqig7jLIbCnzJM0DxDfhEk4boUA/Pkt/L+LKjHxmvyiiD2wtFgk5F
         uIpzR5ICc5MjisRA7XWKqkJHtIOTfRgRABDiVMYG4NlWFXylSSkHMkMSg94SQDn2Si6k
         hxhYzCH7zO/nUhppvEOWMxcODtcTu2UE39VWN38bVZmQW/dy+VBJQ5pc7NSJCCa1yy2X
         8aww==
X-Gm-Message-State: AOAM533bctApFWk77z+pFRxvA8+NRP4QAh+AUhuGy5jR+WgS9pxRmFyM
        CoaJlp1iYIlOmSHzKH1OLqJQfvzTqrKnUv+zSMdF0gMLDeB9Z8ZxSI8iIsCFNHAw2/N8WEjniGy
        dnVJWw0EdSplEabhvHAiK04z+COVYm2MLyyLos/eIZtqfURfUuwoKV1/2HdmIM6gxL+9weZA=
X-Google-Smtp-Source: ABdhPJzWesUuEo6x2rN3Nm6v64LxNCg4UBk6LxLot+d7AbyMBxKZ1ILWaBDQ3eW+eSFDwmhwT8OT1FjRpOVL
X-Received: by 2002:a17:902:ee82:: with SMTP id a2mr5234478pld.204.1596672889356;
 Wed, 05 Aug 2020 17:14:49 -0700 (PDT)
Date:   Wed,  5 Aug 2020 17:14:30 -0700
In-Reply-To: <20200806001431.2072150-1-jwadams@google.com>
Message-Id: <20200806001431.2072150-7-jwadams@google.com>
Mime-Version: 1.0
References: <20200806001431.2072150-1-jwadams@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [RFC PATCH 6/7] core/metricfs: expose x86-specific irq information
 through metricfs
From:   Jonathan Adams <jwadams@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add metricfs support for displaying percpu irq counters for x86.
The top directory is /sys/kernel/debug/metricfs/irq_x86.
Then there is a subdirectory for each x86-specific irq counter.
For example:

    cat /sys/kernel/debug/metricfs/irq_x86/TLB/values

Signed-off-by: Jonathan Adams <jwadams@google.com>

---

jwadams@google.com: rebased to 5.8-pre6
	This is work originally done by another engineer at
	google, who would rather not have their name associated with
	this patchset. They're okay with me sending it under my name.
---
 arch/x86/kernel/irq.c | 80 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 181060247e3c..ffacbbc4066c 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/irq.h>
+#include <linux/metricfs.h>
 
 #include <asm/irq_stack.h>
 #include <asm/apic.h>
@@ -374,3 +375,82 @@ void fixup_irqs(void)
 	}
 }
 #endif
+
+#ifdef CONFIG_METRICFS
+#define METRICFS_ITEM(name, field, desc) \
+static void \
+metricfs_##name(struct metric_emitter *e, int cpu) \
+{ \
+	int64_t v = irq_stats(cpu)->field; \
+	METRIC_EMIT_PERCPU_INT(e, cpu, v); \
+} \
+METRIC_EXPORT_PERCPU_COUNTER(name, desc, metricfs_##name)
+
+METRICFS_ITEM(NMI, __nmi_count, "Non-maskable interrupts");
+#ifdef CONFIG_X86_LOCAL_APIC
+METRICFS_ITEM(LOC, apic_timer_irqs, "Local timer interrupts");
+METRICFS_ITEM(SPU, irq_spurious_count, "Spurious interrupts");
+METRICFS_ITEM(PMI, apic_perf_irqs, "Performance monitoring interrupts");
+METRICFS_ITEM(IWI, apic_irq_work_irqs, "IRQ work interrupts");
+METRICFS_ITEM(RTR, icr_read_retry_count, "APIC ICR read retries");
+#endif
+METRICFS_ITEM(PLT, x86_platform_ipis, "Platform interrupts");
+#ifdef CONFIG_SMP
+METRICFS_ITEM(RES, irq_resched_count, "Rescheduling interrupts");
+METRICFS_ITEM(CAL, irq_call_count, "Function call interrupts");
+METRICFS_ITEM(TLB, irq_tlb_count, "TLB shootdowns");
+#endif
+#ifdef CONFIG_X86_THERMAL_VECTOR
+METRICFS_ITEM(TRM, irq_thermal_count, "Thermal event interrupts");
+#endif
+#ifdef CONFIG_X86_MCE_THRESHOLD
+METRICFS_ITEM(THR, irq_threshold_count, "Threshold APIC interrupts");
+#endif
+#ifdef CONFIG_X86_MCE_AMD
+METRICFS_ITEM(DFR, irq_deferred_error_count, "Deferred Error APIC interrupts");
+#endif
+#ifdef CONFIG_HAVE_KVM
+METRICFS_ITEM(PIN, kvm_posted_intr_ipis, "Posted-interrupt notification event");
+METRICFS_ITEM(PIW, kvm_posted_intr_wakeup_ipis,
+	"Posted-interrupt wakeup event");
+#endif
+
+static int __init init_irq_metricfs(void)
+{
+	struct metricfs_subsys *subsys;
+
+	subsys = metricfs_create_subsys("irq_x86", NULL);
+
+	metric_init_NMI(subsys);
+#ifdef CONFIG_X86_LOCAL_APIC
+	metric_init_LOC(subsys);
+	metric_init_SPU(subsys);
+	metric_init_PMI(subsys);
+	metric_init_IWI(subsys);
+	metric_init_RTR(subsys);
+#endif
+	metric_init_PLT(subsys);
+#ifdef CONFIG_SMP
+	metric_init_RES(subsys);
+	metric_init_CAL(subsys);
+	metric_init_TLB(subsys);
+#endif
+#ifdef CONFIG_X86_THERMAL_VECTOR
+	metric_init_TRM(subsys);
+#endif
+#ifdef CONFIG_X86_MCE_THRESHOLD
+	metric_init_THR(subsys);
+#endif
+#ifdef CONFIG_X86_MCE_AMD
+	metric_init_DFR(subsys);
+#endif
+#ifdef CONFIG_HAVE_KVM
+	metric_init_PIN(subsys);
+	metric_init_PIW(subsys);
+#endif
+
+	return 0;
+}
+module_init(init_irq_metricfs);
+
+#endif
-- 
2.28.0.236.gb10cc79966-goog

