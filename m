Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF48C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E81C4205CB
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="as6+iIYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHOWHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgHOVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:48 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84005C061373
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:25 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t23so8490805qto.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8ebdvedIOE71xQx+NB6UqCSp41vA2Jjo0EpqbQtKMU=;
        b=as6+iIYvWIrEGoo9b3lcWbxApBD513L3D44Wq6RnC31tsfB9Xhp3pYjQ6fCyi6qqAQ
         ZXoAXAAfi+XFzMN+jipQ3qEHczeydx0rmMZD/oGYw+V7imHqB72erKEa2QY8+N1rg+VH
         XwmPDZ+YYHT0TcABO2DV+B8SKUbdQdSVHi9R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8ebdvedIOE71xQx+NB6UqCSp41vA2Jjo0EpqbQtKMU=;
        b=eF/I0TYl3NVoVCIoZbSy6s0DZck6P718Y3TMzjtusNiqnRnQrBs7ZCppHHd2gWQ7qJ
         GZOmtP33I2u5mA8lLU+RmlPAzAp8T8MBEmeprFa5+l8RN2lnIO1ZG5jnJtHikEpt6LJ6
         NZaMY7huYTg6mhTWqq4/NCiG8u9eYInADrJDnGUebq1g20R4mT0mUnA5AitIvrCWKgSu
         H0LFKGAFBXUaex9fb02L7zszTfleoHeQdpZDudX2OxaBt15x12hYAb2+2Jjqi5Iw+tiQ
         lsdydxdRBB5iWTVZVTYK1zPkG2D9p8OFtW36hO2ogdJ+1X357WmRoCyoy+6kmu4RjCD1
         5hPg==
X-Gm-Message-State: AOAM533nOuKzaxmKXApn5yhhuVvWm+3HqM4kn6ikybDNtbIZrfCa11mp
        N/zJn/rwY5apfAi2Q8nYv2b6DCy3Mfl6nA==
X-Google-Smtp-Source: ABdhPJxEXPvjWqG/2R4JnUoqDPhLEmjL1XYpJrOO/Sx2vu/lWlmvx8W82TsGBVhX8LtdyDhFhDroKw==
X-Received: by 2002:ac8:3a82:: with SMTP id x2mr4739680qte.161.1597461564540;
        Fri, 14 Aug 2020 20:19:24 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:24 -0700 (PDT)
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
Subject: [PATCH RFC 02/12] entry/idle: Add a common function for activites during idle entry/exit
Date:   Fri, 14 Aug 2020 23:18:58 -0400
Message-Id: <20200815031908.1015049-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200815031908.1015049-1-joel@joelfernandes.org>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 3b03bedee280..5db5a946aa3b 100644
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
2.28.0.220.ged08abb693-goog

