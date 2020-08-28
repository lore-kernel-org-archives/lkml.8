Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC879C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A305D208A9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Q6C73yC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgH1Tyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgH1Twz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:55 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF344C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:54 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id d30so194684qvc.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dlz2m5qSPSa6Ni1OVuKysxEN8NVgaPytYk+ngscvXG0=;
        b=Q6C73yC/hltE1BhwugQQAlOHrzpwOMbjgLD2Q4xCKyhfsYL5HAn5z3zRwhBm3WHAI7
         M9sKFCXLcEnynwzDNA1nE/vgOnJMWx2GOuqRwYxEs8cf0bqFnu01VE6IKr8SOEJTW9HC
         kxUAtmY2aNjEq/tCotVXXh1ZR7V92HIMIz27M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dlz2m5qSPSa6Ni1OVuKysxEN8NVgaPytYk+ngscvXG0=;
        b=AfZ/2knFW9UfgiNUzpNmVUB+LB1XNAIxi/0kJCqobpZF1jIWMfaXc+AE6PUA3XkwYb
         8CQjNHE1yY0WOdW1fcfc5lwcGvJjovyVGMzVxX74wvJeW1Cbg4EutZG8ccg6sMt9ByBq
         94olwbvQTNFm1yz4Z3+XiWY1dt2yYFKOskT2DJrWfa6MrzZmO2sI57VV8FKovTLn7QIi
         nNQsLjvESy64yg8cHiUUWwQAOnoUEDv2yRrg/mrU9I5zx4cfX7RmS1xLJ89S+XqBB9+7
         OCZWGyo0bXwpEI8ttnu5ClQvMCqGooqtSYnJBHdVN1lrrWItrRigtavw37ncdW3JuHnN
         CbVw==
X-Gm-Message-State: AOAM532vb0AkoK1JfyvbXrFCjAH/LqMa+UJT+djl3xXHnFRcQAGgLKu7
        m8ZUYE6aKkZjulY0PNmm6ss2pg==
X-Google-Smtp-Source: ABdhPJxlluzTX5iMSl3+GGbCbrb9Zrz6gbD8jpjn1+4zcTZGhsbpmv+JLxOM7n+EvJ3/1u4j6E2mRw==
X-Received: by 2002:ad4:576c:: with SMTP id r12mr167172qvx.232.1598644374060;
        Fri, 28 Aug 2020 12:52:54 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:53 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
Subject: [RFC PATCH v7 16/23] arch/x86: Add a new TIF flag for untrusted tasks
Date:   Fri, 28 Aug 2020 15:51:17 -0400
Message-Id: <c20359c28c9352271f50a6a7bff9300d0aaca94c.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Add a new TIF flag to indicate whether the kernel needs to be careful
and take additional steps to mitigate micro-architectural issues during
entry into user or guest mode.

This new flag will be used by the series to determine if waiting is
needed or not, during exit to user or guest mode.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/include/asm/thread_info.h | 2 ++
 kernel/sched/sched.h               | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 267701ae3d86..42e63969acb3 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -98,6 +98,7 @@ struct thread_info {
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
+#define TIF_UNSAFE_RET   	26	/* On return to process/guest, perform safety checks. */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
@@ -127,6 +128,7 @@ struct thread_info {
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
+#define _TIF_UNSAFE_RET 	(1 << TIF_UNSAFE_RET)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1c94b2862069..59827ae58019 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2760,3 +2760,9 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 
 void swake_up_all_locked(struct swait_queue_head *q);
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+
+#ifdef CONFIG_SCHED_CORE
+#ifndef TIF_UNSAFE_RET
+#define TIF_UNSAFE_RET (0)
+#endif
+#endif
-- 
2.17.1

