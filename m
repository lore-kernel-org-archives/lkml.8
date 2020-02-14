Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC22CC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBFB222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ja3/jRqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgBNVKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:10:43 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:54319 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNVKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:10:43 -0500
Received: by mail-wm1-f74.google.com with SMTP id u11so4126769wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ufl0bc7Q05nhLG68rp3n5GYIY7pKcd3WxY8W5KB8D0U=;
        b=Ja3/jRqi3H8SbY4iZzkqwIaoa89gOiMULArohdIbSDwZQCNiQ5ZsZC5+VWmkL88sdZ
         PWQwwY42FWNbo68AHnxmzlxYhD/8iR1XgpwHrHTEhJircE764r0Yipvy09RpPVGMJh2B
         DI8Gbt5OSm6H6Say7XBwPahD4g7KLrCmRvo7t++Wn2PM8oD+W1Gnl6qqSUZuOWhVuV1f
         HeYesHmDWR2XR+sINWSDYbhpE+PFGllJxwiuAM1fmA9cnt4rM+zK4HvAba4KKUBe3m2I
         ASKvdWZmItNpmOybiWtaBygVvpSf7ANeIujV8IR840oYxUPPgAeRFQ1pk44EMHMhbG6b
         5xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ufl0bc7Q05nhLG68rp3n5GYIY7pKcd3WxY8W5KB8D0U=;
        b=ICO9PU/5XkMQcRZLc0FB079Rw6RzJXxsrilIOf23K/w34CxVWOZvckezlJU7zn6abq
         +sG60Ux2mRNGt3kRgZwkTstbaML57CYNRWhW/yV7bXoRSkAWfS9EcS5xxU2MPxdEqZ6e
         ac/oCfjorzfLF11L+Q1Js7QLTqiKFMJL2b3hsFbi1yQSTkBHj6KrLbz14LN2XXBTUy8A
         WqAZHSAS0L4DO0ResDkRaWeVW4Y3i0oKGkPIDMaX+penfYzXeL45vfXHK2ZO+wZ8sVmA
         3CivSKWBKhGv/19gMzNCpowtvhNY1zjlM9wOnlb8ezq05qzidQMspdUu9WqduOBMOSKT
         Kqig==
X-Gm-Message-State: APjAAAV7ndlZBHRoJZCIu0/14eKP+D34sFhD4boXtSEXaa8t5pE6Oslk
        9oPoT0y8R3ENaD+ERy13tVTnAWQY9g==
X-Google-Smtp-Source: APXvYqxS7IxeYTUhs8pxxQv6jrECGsddxUhZmC5J40/VMMI9lfbjgR7F/D+mvLKjGi7gG75VQ3keibUvIA==
X-Received: by 2002:a5d:5485:: with SMTP id h5mr1534876wrv.346.1581714641597;
 Fri, 14 Feb 2020 13:10:41 -0800 (PST)
Date:   Fri, 14 Feb 2020 22:10:35 +0100
Message-Id: <20200214211035.209972-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] kcsan, trace: Make KCSAN compatible with tracing
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, x86@kernel.org, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the system would lock up if ftrace was enabled together with
KCSAN. This is due to recursion on reporting if the tracer code is
instrumented with KCSAN.

To avoid this for all types of tracing, disable KCSAN instrumentation
for all of kernel/trace.

Furthermore, since KCSAN relies on udelay() to introduce delay, we have
to disable ftrace for udelay() (currently done for x86) in case KCSAN is
used together with lockdep and ftrace. The reason is that it may corrupt
lockdep IRQ flags tracing state due to a peculiar case of recursion
(details in Makefile comment).

Signed-off-by: Marco Elver <elver@google.com>
Reported-by: Qian Cai <cai@lca.pw>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
v2:
*  Fix KCSAN+lockdep+ftrace compatibility.
---
 arch/x86/lib/Makefile | 5 +++++
 kernel/kcsan/Makefile | 2 ++
 kernel/trace/Makefile | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 432a077056775..6110bce7237bd 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -8,6 +8,11 @@ KCOV_INSTRUMENT_delay.o	:= n
 
 # KCSAN uses udelay for introducing watchpoint delay; avoid recursion.
 KCSAN_SANITIZE_delay.o := n
+ifdef CONFIG_KCSAN
+# In case KCSAN+lockdep+ftrace are enabled, disable ftrace for delay.o to avoid
+# lockdep -> [other libs] -> KCSAN -> udelay -> ftrace -> lockdep recursion.
+CFLAGS_REMOVE_delay.o = $(CC_FLAGS_FTRACE)
+endif
 
 # Early boot use of cmdline; don't instrument it
 ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index df6b7799e4927..d4999b38d1be5 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -4,6 +4,8 @@ KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
 
 CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
 
 CFLAGS_core.o := $(call cc-option,-fno-conserve-stack,) \
 	$(call cc-option,-fno-stack-protector,)
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f9dcd19165fa2..6b601d88bf71e 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -6,6 +6,9 @@ ifdef CONFIG_FUNCTION_TRACER
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
 
+# Avoid recursion due to instrumentation.
+KCSAN_SANITIZE := n
+
 ifdef CONFIG_FTRACE_SELFTEST
 # selftest needs instrumentation
 CFLAGS_trace_selftest_dynamic.o = $(CC_FLAGS_FTRACE)
-- 
2.25.0.265.gbab2e86ba0-goog

