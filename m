Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E064DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9FD207C4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0GnEbiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEOPET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726813AbgEOPEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:04:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB14C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:04:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s8so2830767ybj.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H/UmEzoy3I9ShhHc8I+RGwc8p1HVxWjO5wJlJG19fNM=;
        b=Z0GnEbiUYQjnZjMykpfqkgnqmaKs3ILC/tjOGl38qOIxYGtp8fanXM43InHR6bYogG
         00lbcHPseG9bnq/bWQXaczPWj1sXEuOtZA+5mmpYNinLqR9IyX1uOK5JT11KNlij+7Qz
         11kOUyxwnWgO8b1cc0291gCOeqX8BkLh6/hHhD3lXXu5ci/eMVs4nqDDLQ2DvickYSSN
         K3/PFi9KwCPK3yi/DElRSg1xL3p5iqGe1zU/5DOIZ6vKXTH89dc/Tz/bZlbiLxdQVNf3
         Vsj9Lz1bhUIGdUhrDhYQA+2ugM4I4JKVCnah2vsvlQRlVV9KsPsCb8A9pU0iGQRxqYRy
         AYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H/UmEzoy3I9ShhHc8I+RGwc8p1HVxWjO5wJlJG19fNM=;
        b=YvrpCo97YBtIa0TgoaXOG4qy+tEmXPbkUWvwCBIpiNxq5RMRvC57BZtqEBuNApb6sK
         BRkyd/b8/eLSvktf1uFYGZOwtL4WxZA+ZX757na0xrspiHy4+bpo9Y8dbD//knM8Ihx0
         4VCXU9wiIUcBCs1bClH2eQEsa9khbrSwOdgP3FZZ/KrsjInE5wemY0LdHN1Mq/1FFkH0
         g0ct26Rv6DyUyaSLUY/x0jPmuK9h+VuefLGQQvucaZ4mGDKbOljJBy8IYHJu4yjCekll
         vVLU9+K+ml+o7uHxSXULt9ICtD3DAV+DjCNEV+8hKxD2mmv2CmCEKt/MA45377N1rTDn
         Q+uQ==
X-Gm-Message-State: AOAM531Xn0R78E4J1bw4LgIZG1zGxAVy3r7CbkvJFVardE9R1QzNS9XD
        qhLegDA0gjNQFudfSCwM8F++bnDJ9Q==
X-Google-Smtp-Source: ABdhPJzuFB4Sp6X31bfLcdYQm5Tf7Ek+lRQp2LzheFKIeEHQNcK49DjK+DRHa7apK/UNOpsVLlE0efdWtw==
X-Received: by 2002:a25:b10a:: with SMTP id g10mr6214488ybj.220.1589555040007;
 Fri, 15 May 2020 08:04:00 -0700 (PDT)
Date:   Fri, 15 May 2020 17:03:34 +0200
In-Reply-To: <20200515150338.190344-1-elver@google.com>
Message-Id: <20200515150338.190344-7-elver@google.com>
Mime-Version: 1.0
References: <20200515150338.190344-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip 06/10] kcsan: Restrict supported compilers
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

The first version of Clang that supports -tsan-distinguish-volatile will
be able to support KCSAN. The first Clang release to do so, will be
Clang 11. This is due to satisfying all the following requirements:

1. Never emit calls to __tsan_func_{entry,exit}.

2. __no_kcsan functions should not call anything, not even
   kcsan_{enable,disable}_current(), when using __{READ,WRITE}_ONCE => Requires
   leaving them plain!

3. Support atomic_{read,set}*() with KCSAN, which rely on
   arch_atomic_{read,set}*() using __{READ,WRITE}_ONCE() => Because of
   #2, rely on Clang 11's -tsan-distinguish-volatile support. We will
   double-instrument atomic_{read,set}*(), but that's reasonable given
   it's still lower cost than the data_race() variant due to avoiding 2
   extra calls (kcsan_{en,dis}able_current() calls).

4. __always_inline functions inlined into __no_kcsan functions are never
   instrumented.

5. __always_inline functions inlined into instrumented functions are
   instrumented.

6. __no_kcsan_or_inline functions may be inlined into __no_kcsan functions =>
   Implies leaving 'noinline' off of __no_kcsan_or_inline.

7. Because of #6, __no_kcsan and __no_kcsan_or_inline functions should never be
   spuriously inlined into instrumented functions, causing the accesses of the
   __no_kcsan function to be instrumented.

Older versions of Clang do not satisfy #3. The latest GCC currently doesn't
support at least #1, #3, and #7.

Link: https://lkml.kernel.org/r/CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/Kconfig.kcsan | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index a7276035ca0d..3f3b5bca7a8f 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -3,6 +3,12 @@
 config HAVE_ARCH_KCSAN
 	bool
 
+config HAVE_KCSAN_COMPILER
+	def_bool CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-distinguish-volatile=1)
+	help
+	  For the list of compilers that support KCSAN, please see
+	  <file:Documentation/dev-tools/kcsan.rst>.
+
 config KCSAN_KCOV_BROKEN
 	def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
 	depends on CC_IS_CLANG
@@ -15,7 +21,8 @@ config KCSAN_KCOV_BROKEN
 
 menuconfig KCSAN
 	bool "KCSAN: dynamic data race detector"
-	depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
+	depends on HAVE_ARCH_KCSAN && HAVE_KCSAN_COMPILER
+	depends on DEBUG_KERNEL && !KASAN
 	depends on !KCSAN_KCOV_BROKEN
 	select STACKTRACE
 	help
-- 
2.26.2.761.g0e0b3e54be-goog

