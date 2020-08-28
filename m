Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB94CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59FE21534
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="F77cC/Q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgH1Tyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgH1Tww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:52 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70922C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:52 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p185so630567qkb.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hAl2Qv+gya0aMStEufG0YmAWHMkijjGFRP91A0YMk2w=;
        b=F77cC/Q7oekktaQh1HPk/9cEPeXkBbnGVVjTA0mTrYSASPzm24/29eun2gNpN9AlPI
         H68xrMBntc0rIDLIDcU94N5t9SSqhYgW+ENQ7Oxxw0FgpWVMOuG4EGiYAo2WuxY5286q
         gr8XoGEyv8nuSrWIUSPAPdQZ+gUL/iDgoBFm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hAl2Qv+gya0aMStEufG0YmAWHMkijjGFRP91A0YMk2w=;
        b=geXc75oJhMytkrxm0BYCljM6XOdvuJ8FddfhaeCi3vr/mMrWHEnElZ30UxAV4vjeVK
         VzTR/wXxGFw2gk/yWaGOcT4xHxky5tP22i96ljWtXudeAQ/VYvbp279t8D0ZnN0gdHWL
         JDA37kogWTRqG75SlIG8az1a09MuHRxbt0bjbdPM0jtBCTqroovWEbO8m+AtRQCku7NG
         qlLmzEqSmv9ybIXmE3s5UM3wkjzvaMQ1/o14HfyksdCn/wVR9d4iHvT8u8I+NNV5bZpZ
         KmJKnIy411xDR4SLTNXbACRLJTRnX4s5n2fshuIW5ILofwKAEVOmMPApaugqyexqaFKJ
         9eYw==
X-Gm-Message-State: AOAM533heJN2PJKfjweLDmHvCnRznPArc9W1fYOQGXAJHZLUCkbvklwV
        f80d0aePZYiVMpz9cZLH1T/I5w==
X-Google-Smtp-Source: ABdhPJzpFTcbPXcK4jxv9h1tbQS26e2ncBTCnnQp+MWLt3nxUW8BBU8AFdHDsgx+aAq4fNW2Gxo6cA==
X-Received: by 2002:a37:6f43:: with SMTP id k64mr799357qkc.212.1598644371664;
        Fri, 28 Aug 2020 12:52:51 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:50 -0700 (PDT)
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
Subject: [RFC PATCH v7 15/23] entry/idle: Add a common function for activites during idle entry/exit
Date:   Fri, 28 Aug 2020 15:51:16 -0400
Message-Id: <05fa01e3d4200a5e3ef224bb56db5b09ecfdd927.1598643276.git.jdesfossez@digitalocean.com>
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

Currently only RCU hooks for idle entry/exit are called. In later
patches, kernel-entry protection functionality will be added.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/entry-common.h | 16 ++++++++++++++++
 kernel/sched/idle.c          | 17 +++++++++--------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index efebbffcd5cc..2ea0e09b00d5 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -369,4 +369,20 @@ void irqentry_exit_cond_resched(void);
  */
 void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
 
+/**
+ * generic_idle_enter - Called during entry into idle for housekeeping.
+ */
+static inline void generic_idle_enter(void)
+{
+	rcu_idle_enter();
+}
+
+/**
+ * generic_idle_enter - Called when exiting idle for housekeeping.
+ */
+static inline void generic_idle_exit(void)
+{
+	rcu_idle_exit();
+}
+
 #endif
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 9c5637d866fd..269de55086c1 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -8,6 +8,7 @@
  */
 #include "sched.h"
 
+#include <linux/entry-common.h>
 #include <trace/events/power.h>
 
 /* Linker adds these: start and end of __cpuidle functions */
@@ -54,7 +55,7 @@ __setup("hlt", cpu_idle_nopoll_setup);
 
 static noinline int __cpuidle cpu_idle_poll(void)
 {
-	rcu_idle_enter();
+	generic_idle_enter();
 	trace_cpu_idle_rcuidle(0, smp_processor_id());
 	local_irq_enable();
 	stop_critical_timings();
@@ -64,7 +65,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 		cpu_relax();
 	start_critical_timings();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
-	rcu_idle_exit();
+	generic_idle_exit();
 
 	return 1;
 }
@@ -158,7 +159,7 @@ static void cpuidle_idle_call(void)
 
 	if (cpuidle_not_available(drv, dev)) {
 		tick_nohz_idle_stop_tick();
-		rcu_idle_enter();
+		generic_idle_enter();
 
 		default_idle_call();
 		goto exit_idle;
@@ -178,13 +179,13 @@ static void cpuidle_idle_call(void)
 		u64 max_latency_ns;
 
 		if (idle_should_enter_s2idle()) {
-			rcu_idle_enter();
+			generic_idle_enter();
 
 			entered_state = call_cpuidle_s2idle(drv, dev);
 			if (entered_state > 0)
 				goto exit_idle;
 
-			rcu_idle_exit();
+			generic_idle_exit();
 
 			max_latency_ns = U64_MAX;
 		} else {
@@ -192,7 +193,7 @@ static void cpuidle_idle_call(void)
 		}
 
 		tick_nohz_idle_stop_tick();
-		rcu_idle_enter();
+		generic_idle_enter();
 
 		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
 		call_cpuidle(drv, dev, next_state);
@@ -209,7 +210,7 @@ static void cpuidle_idle_call(void)
 		else
 			tick_nohz_idle_retain_tick();
 
-		rcu_idle_enter();
+		generic_idle_enter();
 
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
@@ -227,7 +228,7 @@ static void cpuidle_idle_call(void)
 	if (WARN_ON_ONCE(irqs_disabled()))
 		local_irq_enable();
 
-	rcu_idle_exit();
+	generic_idle_exit();
 }
 
 /*
-- 
2.17.1

