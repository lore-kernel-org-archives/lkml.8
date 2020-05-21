Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CED3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E99520826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3EpQ4+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgEUOWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbgEUOWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:22:36 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0206DC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:35 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o11so7782080qti.23
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rIPGL9CFOAkyWr2JAZKyWj8DzpuO2OFpo2ndoPyjdsU=;
        b=u3EpQ4+DaitcF6BfOJ8L8O5D8YznSLVYui3gWbo4ol1Bv19OlOKDU7YIk9m1I5uwwW
         aB8VH88v3QKRSnwwkLsJ9o0SPi/gzHOAKKoxH7xJoZKLKB90G3rJnTaxOqhy3S+evbtq
         WTEB5Hkk+oGlmadxXwSBA/Cu4NzApZeRJecmVPOcvaMENE3GfZ7LU3NZIzMsqp9En6SN
         3FIjQNHQyudeI4ITrQTT3OcKAYSdb8TTrBcXxI8OqZfb1biNIoezpzI1yuX0HjipEJsU
         VwPAEcgwvr1cUVyCR3rmkyUlj7dl9mW/FMH85th/AioFSAxZGKmKhJ9blkPbLpEnP9J7
         ZR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rIPGL9CFOAkyWr2JAZKyWj8DzpuO2OFpo2ndoPyjdsU=;
        b=DE8Y9LJverfTxAM1fIBz65qGlXaiWu283TCVSXDS2HMN0Z550ZNDlg6U8p2ktxJ73R
         dodfg1IW/vAGuyaDTTD+Tr7yqvzhqY6MnQcIESjT2IOIPlfj1siJ3l0Oc9Y7Z14wm+sd
         uUaIPEoGg3ky055pqbwTZqn9BWGCKMWl5ZILyckdraQrpVWXMXfQAlJCqHzcFGfnpnA7
         qpHjvV5T5qEJdNRv4+QnD0HtgFIbKuPR1pxTxRORN3R8uuLihYDlhWCOFlLM2SKt0HuQ
         oEf1+5EOte20hIU9WwjLKlb4K4W3GgpyFaASfoisKkhBQHGGEa1ilW98AzuskPitwGck
         ETsA==
X-Gm-Message-State: AOAM533uDFOMRAfme86E8ev8xKTe4+xbRhvacmcT73zO/6B8LhA98/iU
        LOHygILuPGDvnlrhFvhtAhLowqW2UQ==
X-Google-Smtp-Source: ABdhPJyZmrVOqLiL3evUkiHtoGSXiJ19F4wBwnc3t3gYg+oCWeueOPjFXkWp6QQ+cxWdL0mSYqclJv/vJA==
X-Received: by 2002:a0c:a184:: with SMTP id e4mr9612716qva.153.1590070954160;
 Thu, 21 May 2020 07:22:34 -0700 (PDT)
Date:   Thu, 21 May 2020 16:20:42 +0200
In-Reply-To: <20200521142047.169334-1-elver@google.com>
Message-Id: <20200521142047.169334-7-elver@google.com>
Mime-Version: 1.0
References: <20200521142047.169334-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v3 06/11] kcsan: Restrict supported compilers
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
Acked-by: Will Deacon <will@kernel.org>
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

