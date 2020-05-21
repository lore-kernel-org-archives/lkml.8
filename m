Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC04C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF9920721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T69G5vfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgEUIih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgEUIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:38:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FE6C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 01:38:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z72so5526229wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ICBVafLE15N6RE6NiYESqsB45efF3uHjjBUC58tdlE8=;
        b=T69G5vfHEI+TC9e9KPqy9+EIss6vp4NUxgRENi298dy7Rk3YUiDItZnJBmtPpkVeKm
         /oi0X+d5kL73OUQsR1VtIX3vCqkcHgzWYf4FTAXdL12NJSx/1IDcbAY2dGOuiBmAAVeH
         /lHrhqEvjPlc2pcZPQOpdc6KZ3tiXvM0rfoGcttN3Tnzvh45akMly6OqvgB1pkc5ldlK
         +jxIJFbsq4JBI9HYbLcqAGZYLDjbx920Oc/aa9XB4o5gLO9y9xmF31IXZIbjVucMt8BN
         hFU4RVX3ntWGsm/sSynCm99C2UgdFZ8Fn5Tdlt/+oDKcBjNJcuh8wJRN2ZEKdsp/Zagm
         Q8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ICBVafLE15N6RE6NiYESqsB45efF3uHjjBUC58tdlE8=;
        b=f1aNq327qeLVbjjPPJew9AEned1ZkzPWTns/kYdhN12F9vcAK0ky+JBbGFgVFB1V0u
         Jmv/Qm27nA7hpHtl8/RYD5K4SuakMXoBh0IaFyWDlSEKYcYmDt/rSDtJPYoH0HS+kNiU
         98rDp3WeSbEJtxBtXaAaINyYrg5eE/uZXwmsH1Q59JkyccmBvaqbrkhcJbYY+/L+L0iT
         ASXKvycS9E5Y8X5gBC/PLutPV9XgdjuiME4sxaCDcfTcR4F35xxRqovhmZLNqc6BWaN4
         2cSuVK/uqI/o6JVHlDTxQyNXZUeM0ErqMgB/KeT6/rW39VEGNvjxV8SiERmkSMldfTrQ
         Dz0A==
X-Gm-Message-State: AOAM531xyz5sCFtX1CF/AP/TI8EYSUourYWcxPxaD7JsuK9cysuWRIln
        h8N5csVwreXeovWL2WlNGnM=
X-Google-Smtp-Source: ABdhPJwneZw5HMNfN68Z3/57dXJXGsZ2TJevfBxASPda0mJ3XT6RD4TgaEPdCEizzAQdxmLhC58Q/Q==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr7859451wmk.168.1590050313897;
        Thu, 21 May 2020 01:38:33 -0700 (PDT)
Received: from ?IPv6:2a00:23c6:9e09:2900:4423:7d1b:b637:c183? ([2a00:23c6:9e09:2900:4423:7d1b:b637:c183])
        by smtp.gmail.com with ESMTPSA id g6sm5497649wrp.75.2020.05.21.01.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 01:38:33 -0700 (PDT)
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wojciech Kudla <wk.kernel@gmail.com>
From:   Wojciech Kudla <wk.kernel@gmail.com>
Subject: [PATCH] smp: Function call tracepoints
Message-ID: <e6141d56-1da1-6c00-198f-cbe4385327ff@gmail.com>
Date:   Thu, 21 May 2020 09:38:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the feedback after the first approach:
https://lkml.kernel.org/r/20200520135156.GO317569@hirez.programming.kicks-ass.net

This patch introduces generic SMP function call trace points:
- smp:function_call_issue (captures target cpumask and function pointer)
- smp:function_call_execute (captures executing cpu and function pointer)

Events show function symbols instead of pointers when printk()-ed

Signed-off-by: Wojciech Kudla <wk.kernel@gmail.com>
---
 include/trace/events/smp.h | 67 ++++++++++++++++++++++++++++++++++++++
 kernel/smp.c               | 18 +++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/smp.h

diff --git a/include/trace/events/smp.h b/include/trace/events/smp.h
new file mode 100644
index 000000000000..ecbd2bb7613b
--- /dev/null
+++ b/include/trace/events/smp.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM smp
+
+#if !defined(_TRACE_SMP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SMP_H
+
+#include <linux/tracepoint.h>
+
+/**
+ * function_call_issue - called when an smp call is made
+ *
+ * @mask: mask of recipient CPUs for the SMP  function call
+ * @function: pointer to the function to be executed
+ *
+ */
+TRACE_EVENT(function_call_issue,
+
+	TP_PROTO(const struct cpumask *mask, smp_call_func_t func),
+
+	TP_ARGS(mask, func),
+
+	TP_STRUCT__entry(
+		__bitmask(target_cpus, nr_cpumask_bits)
+		__field(smp_call_func_t, func)
+	),
+
+	TP_fast_assign(
+		__assign_bitmask(target_cpus, cpumask_bits(mask), nr_cpumask_bits);
+		__entry->func = func;
+	),
+
+	TP_printk("target_mask=%s, function=%pS", 
+		__get_bitmask(target_cpus), __entry->func)
+);
+
+
+/**
+ * function_call_execute - called when smp call is executed on the target cpu
+ *
+ * @cpu: cpu the SMP function call is being executed on
+ * @function: pointer to the function to be executed
+ *
+ */
+TRACE_EVENT(function_call_execute,
+
+	TP_PROTO(int cpu, smp_call_func_t func),
+
+	TP_ARGS(cpu, func),
+
+	TP_STRUCT__entry(
+		__field(int, cpu)
+		__field(smp_call_func_t, func)
+	),
+
+	TP_fast_assign(
+		__entry->cpu = cpu;
+		__entry->func = func;
+	),
+
+	TP_printk("cpu=%d, function=%pS", __entry->cpu, __entry->func)
+);
+
+#endif /* _TRACE_SMP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/smp.c b/kernel/smp.c
index 7dbcb402c2fc..acb20bd118e0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -21,6 +21,9 @@
 #include <linux/sched/idle.h>
 #include <linux/hypervisor.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/smp.h>
+
 #include "smpboot.h"
 
 enum {
@@ -176,8 +179,12 @@ static int generic_exec_single(int cpu, call_single_data_t *csd,
 	 * locking and barrier primitives. Generic code isn't really
 	 * equipped to do the right thing...
 	 */
-	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
+	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu))) {
+		if (trace_function_call_issue_enabled())
+			trace_function_call_issue(cpumask_of(cpu), func);
+
 		arch_send_call_function_single_ipi(cpu);
+	}
 
 	return 0;
 }
@@ -241,10 +248,17 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 
 		/* Do we wait until *after* callback? */
 		if (csd->flags & CSD_FLAG_SYNCHRONOUS) {
+			if (trace_function_call_execute_enabled())
+				trace_function_call_execute(smp_processor_id(), func);
+
 			func(info);
 			csd_unlock(csd);
 		} else {
 			csd_unlock(csd);
+
+			if (trace_function_call_execute_enabled())
+				trace_function_call_execute(smp_processor_id(), func);
+
 			func(info);
 		}
 	}
@@ -474,6 +488,8 @@ void smp_call_function_many(const struct cpumask *mask,
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
 
+	trace_function_call_issue(cfd->cpumask_ipi, func);
+
 	/* Send a message to all CPUs in the map */
 	arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
 
-- 
2.17.1

