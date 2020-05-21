Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DB5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DAF92072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEt1Ln1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgEUOXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgEUOWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:22:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61ADC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e14so5454702ybh.16
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KOSbRYBxnt/X3aB2qnjtMZzC3fbLoIePjEhBC+KEIRw=;
        b=jEt1Ln1f0p1x0Xnew8yP5hEVk4hMa83NxAhhj8JLB04eWDxme9C9VqzUW0Y+9K0hK7
         Cu7Hglll6I0GWDKP87HeVJCH28TXoijhFvzWv+D0zIlbKZTRVVQZ5Vx21mCJCZEZFvfM
         hgyKJi8FaNVCoaDa6jeQWMYjMD9P0K5+JXlUp/1n+RBUIpx5MUUy009sAja2EqduCDLP
         gJbgO+b88+zWRcEhrkpEkDHRav+TgoydBpD8sW/1WgwevoUF44kKOoInXucrhy5Xmlgl
         KZ2rtLhApVvG/+GrogEW1AEmHEZGtpPYAzTmsHlGL/PEd7XDbKB4rR+IWmJPyFw7b50n
         WguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KOSbRYBxnt/X3aB2qnjtMZzC3fbLoIePjEhBC+KEIRw=;
        b=pLzL7Nc4wmxxRtvMkKbUfshrOhlOZXCY8FnXx07P2ucHJXf7tGkvZDPAdVoaHKb8JT
         4gxwqgQnX0KefmdaC6W/YTLe2oE9iU+gPJ5QNSVIP/WG3znJXCWAF4/M0dp2A4uOGZbE
         H7fTpdL6VG8tPCaKz/cZ+S4uhSttb2lJolHK8n8SXWuuBgRSI9PViiYjQZl82L/M7Dr1
         6DrwyGWiKNydYy1CA9OQCCczig/I3rjO2NXl5S62tRypa9TtcQyghBy8hzWozwswGVqQ
         QjDYeDBb4QH9y0n1I/qkDVP1jFeP/IXaKuSl96ENrxgFSRxPWUs+fQWRIf+pBukgIJqO
         ORxQ==
X-Gm-Message-State: AOAM531ZXeBOmJ2ksKnQ7ECpvLdXi2sBrN9GGcDeiJEHUMg9fhEc0sWs
        Vd8xij2DyxAW8UyfZ2twCP0PCnY4ew==
X-Google-Smtp-Source: ABdhPJzLrO9yFNJo5NjgI1k7wvJTGgSegfPO+V4ZRwAk9LPJoQ19bl0JmipW4+wN4QtUoKW/V+ZzZXiTMQ==
X-Received: by 2002:a25:b103:: with SMTP id g3mr15635243ybj.88.1590070944895;
 Thu, 21 May 2020 07:22:24 -0700 (PDT)
Date:   Thu, 21 May 2020 16:20:38 +0200
In-Reply-To: <20200521142047.169334-1-elver@google.com>
Message-Id: <20200521142047.169334-3-elver@google.com>
Mime-Version: 1.0
References: <20200521142047.169334-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v3 02/11] kcsan: Avoid inserting __tsan_func_entry/exit
 if possible
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid inserting  __tsan_func_{entry,exit}, add option if supported by
compiler. Currently only Clang can be told to not emit calls to these
functions. It is safe to not emit these, since KCSAN does not rely on
them.

Note that, if we disable __tsan_func_{entry,exit}(), we need to disable
tail-call optimization in sanitized compilation units, as otherwise we
may skip frames in the stack trace; in particular when the tail called
function is one of the KCSAN's runtime functions, and a report is
generated, might we miss the function where the actual access occurred.
Since __tsan_func_{entry,exit}() insertion effectively disabled
tail-call optimization, there should be no observable change. [This was
caught and confirmed with kcsan-test & UNWINDER_ORC.]

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/Makefile.kcsan | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index caf1111a28ae..20337a7ecf54 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 ifdef CONFIG_KCSAN
 
-CFLAGS_KCSAN := -fsanitize=thread
+# GCC and Clang accept backend options differently. Do not wrap in cc-option,
+# because Clang accepts "--param" even if it is unused.
+ifdef CONFIG_CC_IS_CLANG
+cc-param = -mllvm -$(1)
+else
+cc-param = --param -$(1)
+endif
+
+CFLAGS_KCSAN := -fsanitize=thread \
+	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls)
 
 endif # CONFIG_KCSAN
-- 
2.26.2.761.g0e0b3e54be-goog

