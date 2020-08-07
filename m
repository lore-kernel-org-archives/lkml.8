Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7DBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092F920866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ieZHYo04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHGVa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgHGV3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:29:48 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D29C061D7E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 14:29:46 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b142so2786993pfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 14:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1TZQegrBgPNN+SZZCsJyOP7eFX7H3/9/2zydOordKRU=;
        b=ieZHYo04XCdbBogCHiXjbZeFR1bV303kMQGvEtUCo3MyCZv4PiQWUZOtUp5UOdsJms
         OBTC87r+1D0ws9FbjFeU+TDngcJIVQp/zIa7cOyLrT+Kfwkksir2bzMZMZM71wB478Ek
         KoeuqdI4fr1vD4oXtX+BT3zcMk4kACaAfsSllWPfE1XV9+yGzGNku5ufgoJtirVr8ZaS
         pKG4jrzoRlV6GzhJsAabu9U1sMqMRLkG8XujccP5ELANmH4hQZEIMJBKDEnHRH+KpJy8
         hSiEyisrJRZ8PcdacCUH3tpzWxbzlRwGl7dvUMXeAkWcUTPXKhKYFM0reJax5bPpfGFV
         iRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1TZQegrBgPNN+SZZCsJyOP7eFX7H3/9/2zydOordKRU=;
        b=rRCjuBBNnbuV1sUUV32fPPVPKsLF5lbe4nZ4UNZL+mg8+tFFBJAFM+4/NE4mFkPQ7H
         8pbNax60H+XOKFUIVLYOidSMF54t4w51ELqRf8lq0jTQv9zkBEuS1pATyqgXa9Gz6tAW
         12TNPtQ++NgOAY4PiTpzVINp7KzYHPUTMWUOdETOiazMjyl1+R9b2U2fDP1ZhSoVnu+2
         eCYMkDbheubCQNH6cU/ZwG/nZdbTzqSSjnRwPTxGNIhBSz34cT79l5xpxmem5ipHOhPq
         +3jxNqLEXyL4be0pjDdOfX7+h8CfpnZPE42xjhfRZmtLGGqPglRqPkYrdk6LI6rG8G9P
         eR6A==
X-Gm-Message-State: AOAM533ofujkM9cbOz/N+NvXoCXotcOmD/mO4G7GMBGkLv1IF+JtUcVp
        T1BoHk6A6CaBs7vOFj3qNDMhcR/o/XCi1Tork3rZU31ttR3YCV6hu3FSiVG7mj83Rb73lgT8B8Q
        xe66za8TPshUbPH6Ybz2rluQwTG10eMSKyhQQQLDrgwR3DFPChEqKxGFRp8FfffUYJSx+/JY=
X-Google-Smtp-Source: ABdhPJz+2C/PgoKritkxy8QCsvDLemjrofpIEPFwkhIfTB+Eqa7wlcLaV2OWCQg+F4nEAB7Hu1Xv9XgPH0tp
X-Received: by 2002:a17:90b:1254:: with SMTP id gx20mr16269548pjb.117.1596835785342;
 Fri, 07 Aug 2020 14:29:45 -0700 (PDT)
Date:   Fri,  7 Aug 2020 14:29:15 -0700
In-Reply-To: <20200807212916.2883031-1-jwadams@google.com>
Message-Id: <20200807212916.2883031-7-jwadams@google.com>
Mime-Version: 1.0
References: <20200807212916.2883031-1-jwadams@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [RFC PATCH 6/7] core/metricfs: expose x86-specific irq information
 through metricfs
From:   Jonathan Adams <jwadams@google.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
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

