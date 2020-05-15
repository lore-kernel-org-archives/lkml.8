Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942CAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E72207D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsQ711Ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgEOPDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726563AbgEOPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:03:51 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9C7C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:03:51 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id h1so2733784qtu.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=COp0SyeTFByf68VoAMfHccz/8jBHCco/jZeKm/gYFRA=;
        b=nsQ711Ia2jlbtHNCJmse6Fr9iDhQ1jzR6gifpl6SPj7zlIkXjg5ZokHRtBTlLNteyS
         ogTEDUdKLgbsG0UBr05OFrcOgE11hcyIgXDmt8iW3GhRoctOFonw+5TiSCqMvSrOiviU
         ZM3gPBFzkD6FX2E0qUwfUkPj7e+4KKRPbB1uuIz16ZszHzeWkCSsqYMXwdgBkp+YPZ/F
         NtS2gT1xQbNozbdupwdBcZSlYQuP9bJyl1Szu0iaI307UIadVFvd+tX7HyQjZSUeVF+0
         YZg4tigw+DGbnOFNMgDCaRi7Nb1VZuFX1SbbhqbIi3dzid5HduSjHHQM43s3q+wx1Ezc
         6WcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=COp0SyeTFByf68VoAMfHccz/8jBHCco/jZeKm/gYFRA=;
        b=oZlp8Erc4wZMqxnhuk8lAWZ3f1MERs6mdP90uEdGfsboHTeyvlBgDeLHzpGu8Nwsqk
         LVXNT3dl7NljDMUm3jkC+vPWaje5/Sh0UwXPg3BeJjPT9Dz4D9kprBy8m19wmVB0q+WS
         a6WA0ht1HQ83fl04RqyWAQWDQBFCKGcRK1OXEvp3hRk+9rOOzgKC7lGg1qUP5Ew9G8mQ
         QVq/yBZJfH9bbKnSQKmn2uczuNSNT0cef7kDxm8Guq9ZKqIiicRzp9l45BC5vdRcI+SZ
         gXGvcb8akMaU6Yu3aBsg4n1t2he2cVEGbdpZ2MHHFr4HfKypI0DFeU6Qsleq92nX5PxF
         npWQ==
X-Gm-Message-State: AOAM532AVT6ftTlkToD/6/Dgu4uK9WfgkWi7+zHwMMLxqHJJXZOPuA2N
        j55+r65W/+UlonYaPCKanoW39E7SZg==
X-Google-Smtp-Source: ABdhPJycaTfgDS+L9b/rOUELImUqkWlnzirVWIlyBZpqqowgL8oq9yxGgXPx3xQ9M5Rj2JVyEgcoCjXluQ==
X-Received: by 2002:a05:6214:3ee:: with SMTP id cf14mr4069665qvb.128.1589555030260;
 Fri, 15 May 2020 08:03:50 -0700 (PDT)
Date:   Fri, 15 May 2020 17:03:30 +0200
In-Reply-To: <20200515150338.190344-1-elver@google.com>
Message-Id: <20200515150338.190344-3-elver@google.com>
Mime-Version: 1.0
References: <20200515150338.190344-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip 02/10] kcsan: Avoid inserting __tsan_func_entry/exit if possible
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com
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

