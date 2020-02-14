Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB38EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916F7206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrlR0/0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbgBNTFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:05:07 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:50764 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgBNTFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:05:07 -0500
Received: by mail-vk1-f201.google.com with SMTP id s205so3665684vka.17
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=y0VpLWlLrgreaXGyU2aGKFidKfIZR/ank1/JutXFGq8=;
        b=hrlR0/0dpvdOoBg0Yt905t4bbTcTQcq9xQg69mS1xQjaH4No60jXbZDPHUNxlglEEG
         RdNAxcITspFUQEUn7Og+ITmYWEt/usvYEHfMC9uK5O9ngbQlqZn6SWPiBoecvpUdXGPf
         ljdhJMiyaEbg2iYFgnKFg6s6s94X3bI19vYbHrZ7HZkrlDm18emzmA3SpyH8Cx81Jedh
         NFEd9F6njHSLnc8X+QW6ONcyrjhzTSBockhoXhJuDV3ogm/H2RuPwUS7t4WQj5BW7YmS
         Qx4pfDPXqzqWVbWqQBhLMYjBXaAzQZ5Wu1ONaGj68kVxnItNWSfdVVQYSOWusAnpO6v8
         CeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=y0VpLWlLrgreaXGyU2aGKFidKfIZR/ank1/JutXFGq8=;
        b=eP7YgyW7FyYxAYLc8Qho0fHBE5cvXkhxwFB/nk7KaQS/sthFYmyIbXlQYprMIAmloK
         2e2khaOhqNOz6rUWFR2uIjySSSngb9nS1NBiOW88Dol/oqFX/hrugpmluY0hDWYpvCr6
         orxMbLwB4B7i6C4vDqEvhLUsFTOHHTSJzlvQ14zaypP5rCYFdBJigKmKZxjaJqaQanEL
         0NH9xxWcS7AcoV9k9cKqu0JTKbdv0v3PSFDdjSuXwAM1/cO9iYeGOo0lWGXiP8pI+6TI
         6DGBLXrWJ5IfYMLPKUiIeInYhyaEwNqnLpsAdhKnzcNVm1SdCDFmbGgXD3WsqUtAyq1V
         xKyA==
X-Gm-Message-State: APjAAAVLUXQ648toMJfFwzmecgscV5COO3Ffn4eK4TsUeM1s95rKmRoH
        KvsBFZKdlCxw1R/lB2UPrQRSPV5maw==
X-Google-Smtp-Source: APXvYqyHys8Qu0vKLMFklWx0OqjfgVb4ec//xnz+N1i1KKmHtaJybiujP8Om4E1Im6JcBzIhUWdEE1k+bQ==
X-Received: by 2002:a67:80d3:: with SMTP id b202mr2286028vsd.142.1581707106155;
 Fri, 14 Feb 2020 11:05:06 -0800 (PST)
Date:   Fri, 14 Feb 2020 20:05:00 +0100
Message-Id: <20200214190500.126066-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] kcsan, trace: Make KCSAN compatible with tracing
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, Qian Cai <cai@lca.pw>
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

Signed-off-by: Marco Elver <elver@google.com>
Reported-by: Qian Cai <cai@lca.pw>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/kcsan/Makefile | 2 ++
 kernel/trace/Makefile | 3 +++
 2 files changed, 5 insertions(+)

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

