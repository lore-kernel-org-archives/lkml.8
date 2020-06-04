Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C33BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA032074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLpY/vYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgFDF62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 01:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgFDF60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 01:58:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7872CC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 22:58:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k15so6853417ybt.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NuYIYrAbbNb8cb+ywlNdLoxBFeloVlNH+GnFfXqWSZA=;
        b=kLpY/vYcWlc3f3tgsDeKEZ1ET26FwvIvc+44dkCatzCdP9ZvI02e6f5gcgiWZ6oGXM
         SjXSH+MzBdwitr3H+kgujRYwv9ukYqvR9vlydv7wGWJCA2Tezw4c34HNU27Y71E2AFSH
         +OrqbxmO8UVplGwjyR2MagqxBYCcGQnilbsTbg+7pgK78nTjgm6Hg3CX3S93maoAuIZo
         1u0b3Gc2BSZd/P/JgechVy1XT9nV5lPZwwe8zUuYj64PgVL9z3GA3pYb5MsKBvuiqoaY
         6aZ1kmpsxZRjYGd9Yr1zbLD9d9FpXZ9U9pv/7q4zO2VkOPumMVC4+LvOwRSBga8akEWG
         Z31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NuYIYrAbbNb8cb+ywlNdLoxBFeloVlNH+GnFfXqWSZA=;
        b=tTwhRhKNoWfdh0AfBEsRPuflgqShHbqptM5Xx+dkJcHZADaNSOiGxeHUSJKyx5R9Nf
         vxr3tPGZk2ngelG/nq6yo20EwIIUYnxtSe5GyufHbgnf8wNBXmPOjJapO9I+XT8/Pp0z
         /8hcPRtzAu2R8000SkQLMiwU0WRwTMOYwWp/4IABhLE6m5wOd6Xw+5gaG6Uc/AgLl+3O
         cWNbvdcThfMmhN9TPS36Eni5lg44THV77c4HDtuZynR2dAkGBN225qKZMYV/qbWEiadp
         IaZ9hE1ecYHz1PkMt/P64V00CAa/gN2vHANChdFjS67jo1lXahqeupquYDBRNEXMcUsU
         nNxw==
X-Gm-Message-State: AOAM53384t/6SL3OKQz9uA85PNSI5N3ZaF54NhubyOuX41J44dt26DLN
        8ZIDk/XJJ6eLan8ptMqGRqBFW/g+ig==
X-Google-Smtp-Source: ABdhPJwUw0SUorskQKH7aB/iKpSf4dQTzroTfyBchleSP8od+QgF3fceEuLeKVsMVKiQWng6UdJA3jhrYA==
X-Received: by 2002:a25:c186:: with SMTP id r128mr5951332ybf.92.1591250305693;
 Wed, 03 Jun 2020 22:58:25 -0700 (PDT)
Date:   Thu,  4 Jun 2020 07:58:11 +0200
In-Reply-To: <20200604055811.247298-1-elver@google.com>
Message-Id: <20200604055811.247298-2-elver@google.com>
Mime-Version: 1.0
References: <20200604055811.247298-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH -tip v2 2/2] compiler_types.h: Add __no_sanitize_{address,undefined}
 to noinstr
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     will@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org,
        clang-built-linux@googlegroups.com, paulmck@kernel.org,
        dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the portable definitions for __no_sanitize_address, and
__no_sanitize_undefined, and subsequently changes noinstr to use the
attributes to disable instrumentation via KASAN or UBSAN.

Link: https://lore.kernel.org/lkml/000000000000d2474c05a6c938fe@google.com/
Reported-by: syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com
Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Marco Elver <elver@google.com>
---

Note: __no_sanitize_coverage (for KCOV) isn't possible right now,
because neither GCC nor Clang support such an attribute. This means
going and changing the compilers again (for Clang it's fine, for GCC,
it'll take a while).

However, it looks like that KCOV_INSTRUMENT := n is currently in all the
right places. Short-term, this should be reasonable.

v2:
* No change.
---
 include/linux/compiler-clang.h | 8 ++++++++
 include/linux/compiler-gcc.h   | 6 ++++++
 include/linux/compiler_types.h | 3 ++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 2cb42d8bdedc..c0e4b193b311 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -33,6 +33,14 @@
 #define __no_sanitize_thread
 #endif
 
+#if __has_feature(undefined_behavior_sanitizer)
+/* GCC does not have __SANITIZE_UNDEFINED__ */
+#define __no_sanitize_undefined \
+		__attribute__((no_sanitize("undefined")))
+#else
+#define __no_sanitize_undefined
+#endif
+
 /*
  * Not all versions of clang implement the the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 7dd4e0349ef3..1c74464c80c6 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -150,6 +150,12 @@
 #define __no_sanitize_thread
 #endif
 
+#if __has_attribute(__no_sanitize_undefined__)
+#define __no_sanitize_undefined __attribute__((no_sanitize_undefined))
+#else
+#define __no_sanitize_undefined
+#endif
+
 #if GCC_VERSION >= 50100
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 02becd21d456..89b8c1ae18a1 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -198,7 +198,8 @@ struct ftrace_likely_data {
 
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text"))) __no_kcsan
+	noinline notrace __attribute((__section__(".noinstr.text")))	\
+	__no_kcsan __no_sanitize_address __no_sanitize_undefined
 
 #endif /* __KERNEL__ */
 
-- 
2.27.0.rc2.251.g90737beb825-goog

