Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9F5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3303620838
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMtJW6G+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgHNR2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgHNR14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:27:56 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9CFC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:55 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id z1so6476747qkg.23
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S5YYe9chzXhia6NqEOtjeZEypr/bcyFxBA6eDjcJbWc=;
        b=ZMtJW6G+Vjha52m+bEG09co9CtryzgL92nDzZ++ZiTa8iJ6DYjw3OCDj9xTihkEr1I
         gGc/1/u7JnJPQLkFrkXN54ykyGBlBoTHLDg7oxca2j6jqnk9eB7BKwzjLbZiLgzGFjMW
         mSR7YIOPjXKEZNppDVeRKjsKqRJh2BX3+7C6XhaUbTOii4BPGgZPhEsEzx+iWc3fUPx5
         QCzpWdH7hU7h+C4XleqHesY8jAdxFvnYkTVPQlwWcGL2LXF5kumXQYDVdNQ4eP+wOPKw
         nTDtI6/GRorUo+yG99BJZhM1+v7k9LVKwRT0EfI9g93HSCuEN+isPRSs4pjk6Kp430SO
         BB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S5YYe9chzXhia6NqEOtjeZEypr/bcyFxBA6eDjcJbWc=;
        b=oGMMpvMik1LkGo07IXk5I3+b6+siiKXF5eMyzUvewDkgJayVvnrzfpGzJ9kozp680r
         JP453Ag/iJgnt2X9oXT8sqf2DCuai3nOlUI82ZWHETWREKQLoOCSm9GJ0K0ClV06y6W0
         3i2t/Toy98Vr0Fybu73DYzJ9euLrz/MXSxUDxmoPM9iqA7UC+UkTTwK5IRmgnRLMy+J5
         DC8+vvVk3VswhVTMFAWqK+7s0FXgKLKJCuSCcCNTTqpF3whC2q23wCsXkpySfJ8R89Dn
         gDfUSthDaBro6QIHDiXs9ZOdsFrluxx2ALnV7KNdCmGGYa/TVLHtPQ2fpadeorN7M0TF
         TGoQ==
X-Gm-Message-State: AOAM5335EaOEdIeTWKC4D/cY68akYgZCI2QEkUUD+i1fzO5KW+r0QppW
        BKQTqYXxZFynXcrQvlRggO2PHOLCf2zoHN08
X-Google-Smtp-Source: ABdhPJzo2cKJbLBbPoHcwIWfnbiF7pfkJX4TFp4oMthnEZbbluD+IcgMHo2qi+w+eaber0F/RXEscXOcwKfwrJML
X-Received: by 2002:ad4:49a1:: with SMTP id u1mr3592719qvx.245.1597426074976;
 Fri, 14 Aug 2020 10:27:54 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:55 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <35c9e6ff0b5cc69cf97ba7dda143f3ca14af6b5c.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 13/35] kasan, arm64: only use kasan_depth for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Hardware tag-based KASAN won't use kasan_depth. Only define and use it
when one of the software KASAN modes are enabled.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/kasan_init.c | 11 ++++++++---
 include/linux/kasan.h      | 14 ++++++++++----
 include/linux/sched.h      |  2 +-
 init/init_task.c           |  2 +-
 mm/kasan/common.c          |  2 ++
 mm/kasan/report.c          |  2 ++
 6 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 4d35eaf3ec97..b6b9d55bb72e 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -273,17 +273,22 @@ static void __init kasan_init_shadow(void)
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 }
 
+void __init kasan_init_depth(void)
+{
+	init_task.kasan_depth = 0;
+}
+
 #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) */
 
 static inline void __init kasan_init_shadow(void) { }
 
+static inline void __init kasan_init_depth(void) { }
+
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 void __init kasan_init(void)
 {
 	kasan_init_shadow();
-
-	/* At this point kasan is fully initialized. Enable error messages */
-	init_task.kasan_depth = 0;
+	kasan_init_depth();
 	pr_info("KernelAddressSanitizer initialized\n");
 }
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 18617d5c4cd7..894f4d9163ee 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -52,7 +52,7 @@ static inline void kasan_remove_zero_shadow(void *start,
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 /* Enable reporting bugs after kasan_disable_current() */
 extern void kasan_enable_current(void);
@@ -60,6 +60,15 @@ extern void kasan_enable_current(void);
 /* Disable reporting bugs for current task */
 extern void kasan_disable_current(void);
 
+#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+static inline void kasan_enable_current(void) {}
+static inline void kasan_disable_current(void) {}
+
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+#ifdef CONFIG_KASAN
+
 void kasan_unpoison_memory(const void *address, size_t size);
 
 void kasan_unpoison_task_stack(struct task_struct *task);
@@ -110,9 +119,6 @@ static inline void kasan_unpoison_memory(const void *address, size_t size) {}
 
 static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 
-static inline void kasan_enable_current(void) {}
-static inline void kasan_disable_current(void) {}
-
 static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
 static inline void kasan_free_pages(struct page *page, unsigned int order) {}
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 692e327d7455..6dca19f2516c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1194,7 +1194,7 @@ struct task_struct {
 	u64				timer_slack_ns;
 	u64				default_timer_slack_ns;
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	unsigned int			kasan_depth;
 #endif
 #ifdef CONFIG_KCSAN
diff --git a/init/init_task.c b/init/init_task.c
index 15089d15010a..13f1cf21412b 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -171,7 +171,7 @@ struct task_struct init_task
 	.numa_group	= NULL,
 	.numa_faults	= NULL,
 #endif
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	.kasan_depth	= 1,
 #endif
 #ifdef CONFIG_KCSAN
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a2321d35390e..41c7f1105eaa 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -51,6 +51,7 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags)
 	track->stack = kasan_save_stack(flags);
 }
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 void kasan_enable_current(void)
 {
 	current->kasan_depth++;
@@ -60,6 +61,7 @@ void kasan_disable_current(void)
 {
 	current->kasan_depth--;
 }
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
 {
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index ddaf9d14ca81..8463e35b489f 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -295,8 +295,10 @@ static void print_shadow_for_address(const void *addr)
 
 static bool report_enabled(void)
 {
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	if (current->kasan_depth)
 		return false;
+#endif
 	if (test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
 		return true;
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
-- 
2.28.0.220.ged08abb693-goog

