Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3139CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A30220639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HkprHDs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHOWBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgHOVv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C045AC061343
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:40:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r11so5330117pfl.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8YbwcCQRiiPv0rHg6w+CA5l3N0IrRcn3zSo0R+mj7ww=;
        b=HkprHDs74pJz6IDXZVuwjTU0r3oPGqZI3PiHUeO/XoOHvgK5rQyuL4k5L56uRCPEtv
         9duYQ+pnjmR7YRRCTnV50c+aHuSRgTVrIb57+wwQvhj4gwrGYVKRAdAtJbOMAU2ejAXI
         n0LvbLb67HxDzRW0AelG9fK0p9EfEGvRHfzjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8YbwcCQRiiPv0rHg6w+CA5l3N0IrRcn3zSo0R+mj7ww=;
        b=Hhcj73gAXVy/BWeegiVwXIlFntwH4TiDYMXGrOguqPWyAT9kthDzfxXhFeU5akM1UU
         nZAXZLfX1E9bOaR+10PLPMvMGSh6Ey/4bYYWYp4yQyqPR0evnnNucyZM3izKXVFnAEWf
         Vgz735nJNnuchPY/ztTCMBGQVbg/Tk/FYwtswEMjNpr0OAAaBZy/SlC7AheNGLEszHe4
         azJqc6zk74hPhnO3aQct796RUrzTelkA7Tt2cNR9Fs+S2EN0sP4ePSsivOrLWmRaz8zp
         E40Fhte9Nf3Ud7/Kqj31dehY1inSSGLu1Yp7z/XNcjNU6tNqvn6ICniIErmKwYqcJvrj
         aYgQ==
X-Gm-Message-State: AOAM531/bmXI+pbn0VxwpYAh2JfXfrg6CZFK3+EwmPULOO5nu5caxxmg
        N9m7vfTTFsfAcBQszKgVEJHLnDBXUf4xSQ==
X-Google-Smtp-Source: ABdhPJwvYkwnBKQR8QLhUB27L2pr9oHf4MfxbH9CnPSobs6aWLp66YPwfAqQdaQ+0RUy1HMdnIoXPQ==
X-Received: by 2002:a63:4b5c:: with SMTP id k28mr3236824pgl.356.1597452030070;
        Fri, 14 Aug 2020 17:40:30 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x6sm10577131pfd.53.2020.08.14.17.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 17:40:29 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] treewide: Make all debug_obj_descr's const
Date:   Fri, 14 Aug 2020 17:40:27 -0700
Message-Id: <20200815004027.2046113-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200815004027.2046113-1-swboyd@chromium.org>
References: <20200815004027.2046113-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should make it harder for the kernel to corrupt the debug object
descriptor, used to call functions to fixup state and track debug
objects, by moving the structure to read-only memory.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/i915/i915_active.c   | 2 +-
 drivers/gpu/drm/i915/i915_sw_fence.c | 2 +-
 kernel/rcu/rcu.h                     | 2 +-
 kernel/rcu/update.c                  | 2 +-
 kernel/time/hrtimer.c                | 4 ++--
 kernel/time/timer.c                  | 4 ++--
 kernel/workqueue.c                   | 4 ++--
 lib/percpu_counter.c                 | 4 ++--
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index d960d0be5bd2..839bd53df6e9 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -81,7 +81,7 @@ static void *active_debug_hint(void *addr)
 	return (void *)ref->active ?: (void *)ref->retire ?: (void *)ref;
 }
 
-static struct debug_obj_descr active_debug_desc = {
+static const struct debug_obj_descr active_debug_desc = {
 	.name = "i915_active",
 	.debug_hint = active_debug_hint,
 };
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index 295b9829e2da..93a649324ce0 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -34,7 +34,7 @@ static void *i915_sw_fence_debug_hint(void *addr)
 
 #ifdef CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS
 
-static struct debug_obj_descr i915_sw_fence_debug_descr = {
+static const struct debug_obj_descr i915_sw_fence_debug_descr = {
 	.name = "i915_sw_fence",
 	.debug_hint = i915_sw_fence_debug_hint,
 };
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index cf66a3ccd757..e01cba5e4b52 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -167,7 +167,7 @@ static inline unsigned long rcu_seq_diff(unsigned long new, unsigned long old)
 # define STATE_RCU_HEAD_READY	0
 # define STATE_RCU_HEAD_QUEUED	1
 
-extern struct debug_obj_descr rcuhead_debug_descr;
+extern const struct debug_obj_descr rcuhead_debug_descr;
 
 static inline int debug_rcu_head_queue(struct rcu_head *head)
 {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 2de49b5d8dd2..3e0f4bcb558f 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -469,7 +469,7 @@ void destroy_rcu_head_on_stack(struct rcu_head *head)
 }
 EXPORT_SYMBOL_GPL(destroy_rcu_head_on_stack);
 
-struct debug_obj_descr rcuhead_debug_descr = {
+const struct debug_obj_descr rcuhead_debug_descr = {
 	.name = "rcu_head",
 	.is_static_object = rcuhead_is_static_object,
 };
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index c4038511d5c9..099e0447daa3 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(ktime_add_safe);
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 
-static struct debug_obj_descr hrtimer_debug_descr;
+static const struct debug_obj_descr hrtimer_debug_descr;
 
 static void *hrtimer_debug_hint(void *addr)
 {
@@ -401,7 +401,7 @@ static bool hrtimer_fixup_free(void *addr, enum debug_obj_state state)
 	}
 }
 
-static struct debug_obj_descr hrtimer_debug_descr = {
+static const struct debug_obj_descr hrtimer_debug_descr = {
 	.name		= "hrtimer",
 	.debug_hint	= hrtimer_debug_hint,
 	.fixup_init	= hrtimer_fixup_init,
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a16764b0116e..2deccfb1ee5e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -611,7 +611,7 @@ static void internal_add_timer(struct timer_base *base, struct timer_list *timer
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 
-static struct debug_obj_descr timer_debug_descr;
+static const struct debug_obj_descr timer_debug_descr;
 
 static void *timer_debug_hint(void *addr)
 {
@@ -707,7 +707,7 @@ static bool timer_fixup_assert_init(void *addr, enum debug_obj_state state)
 	}
 }
 
-static struct debug_obj_descr timer_debug_descr = {
+static const struct debug_obj_descr timer_debug_descr = {
 	.name			= "timer_list",
 	.debug_hint		= timer_debug_hint,
 	.is_static_object	= timer_is_static_object,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c41c3c17b86a..ac088ce6059b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -427,7 +427,7 @@ static void show_pwq(struct pool_workqueue *pwq);
 
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
 
-static struct debug_obj_descr work_debug_descr;
+static const struct debug_obj_descr work_debug_descr;
 
 static void *work_debug_hint(void *addr)
 {
@@ -477,7 +477,7 @@ static bool work_fixup_free(void *addr, enum debug_obj_state state)
 	}
 }
 
-static struct debug_obj_descr work_debug_descr = {
+static const struct debug_obj_descr work_debug_descr = {
 	.name		= "work_struct",
 	.debug_hint	= work_debug_hint,
 	.is_static_object = work_is_static_object,
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index a2345de90e93..f61689a96e85 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -17,7 +17,7 @@ static DEFINE_SPINLOCK(percpu_counters_lock);
 
 #ifdef CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER
 
-static struct debug_obj_descr percpu_counter_debug_descr;
+static const struct debug_obj_descr percpu_counter_debug_descr;
 
 static bool percpu_counter_fixup_free(void *addr, enum debug_obj_state state)
 {
@@ -33,7 +33,7 @@ static bool percpu_counter_fixup_free(void *addr, enum debug_obj_state state)
 	}
 }
 
-static struct debug_obj_descr percpu_counter_debug_descr = {
+static const struct debug_obj_descr percpu_counter_debug_descr = {
 	.name		= "percpu_counter",
 	.fixup_free	= percpu_counter_fixup_free,
 };
-- 
Sent by a computer, using git, on the internet

