Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C60DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F8620781
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="a0Rw2bBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgHOWE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgHOVvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:02 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D02EC061374
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:27 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k18so8453649qtm.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sr87OpKcgqeQcj7Lut9VQ6DF03EgC9rXR/oozlPl9I0=;
        b=a0Rw2bBSyqjyxtQEVYDJF5UDSoxnf31h9xYjxTorXrRsufS12jJhrWyPwlAQraVyu8
         Eig+m2NceIZJfgxrM622A/TDW9fiqWVxjSN5/7SyLFyNmMcf0MOtJ79gBJCQzjMavIwi
         FHQNEoxMgoQZZuK3w0rBVgisOjO1HcfBwhA3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sr87OpKcgqeQcj7Lut9VQ6DF03EgC9rXR/oozlPl9I0=;
        b=XA7dLx9g3LymuCJtEAPl6Hzg5vYNzKvChPOUPVZ1jn4ey7SQ9osW9kAzJDXb9nyMRE
         43+Y42OZsL8qnd3MmFb7e+8HvrIpCZ4rRDSidSj8PBUO1DOZyU+tV5cj9sI+aWyv/rXq
         sTKKiGzNooUgbkCi72O9PLDprFHTrjnYEm/1jd/Nr9OARg/a3qw2XbFGxFv8zNWamjbA
         dYWDr+JFrifIsvo8CqxQ/uySs3/je4+taeUKNK/BOqewjJIzWInrp2SgzQ1g830nOtGx
         cKuNJ38pCs6ueWkZrFriY+0oXgPPsejPLdOSHr0Q77/hxQ0mWBzR7XJeUDck0JIFsbMc
         TlCQ==
X-Gm-Message-State: AOAM530CVZBEWj9WTHU+iMt2FYz6inW51VcZhoDAwDjB1ma1RU8+ui4G
        I1SGczaCDqKPRKdD0wK56ItTygpm8je7YA==
X-Google-Smtp-Source: ABdhPJzfuzPtyeMnMLHksEthsmRZwJK64n9qnDfflen8t0uv+egsOcthSALyKs2aNX7pgnP3PF3LeA==
X-Received: by 2002:aed:3b57:: with SMTP id q23mr4961944qte.150.1597461565702;
        Fri, 14 Aug 2020 20:19:25 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RFC 03/12] arch/x86: Add a new TIF flag for untrusted tasks
Date:   Fri, 14 Aug 2020 23:18:59 -0400
Message-Id: <20200815031908.1015049-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200815031908.1015049-1-joel@joelfernandes.org>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 3575edc7dc43..1901d11a6f41 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2680,3 +2680,9 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 
 void swake_up_all_locked(struct swait_queue_head *q);
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+
+#ifdef CONFIG_SCHED_CORE
+#ifndef TIF_UNSAFE_RET
+#define TIF_UNSAFE_RET (0)
+#endif
+#endif
-- 
2.28.0.220.ged08abb693-goog

