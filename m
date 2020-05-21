Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D705520748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axxi3Qx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgEUOWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgEUOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:22:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9306DC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y8so5467869ybn.20
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H2uRSUohXbn7nWhU1m6/8O/OIPFFeT1jA5i34XsZ7o0=;
        b=axxi3Qx/8vKlKRkFvuD31M8fwf7LrlOkxHIrZdlDjzY38oPfn+O2cNDswnD+BhSupD
         JlwQ51nDCg7UbeW4wdTiT/dp8lH9WhF+0iqP4AHedX+6ef9TtcCRnFfIlDuLbBk0qzKM
         70ee6zQUY7I1EQ+xKnkJvn0nhAk3B3aw2SZZir69jsEY5hlKh8INutX42YZXmaGVTxMf
         51YAOYXfi+yz3ZWZv91OaGVrLBgXT4wG/fwE6HXc8GKccSTt6UD5bALGltQ/1/UKN0SY
         Jt3x1z8fGTWLhHGQxAqVOI+xfiSEBSaZqQ2q4ko7JORQ3LCAkNAc+G8NkxXyp/cXoAH5
         wLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H2uRSUohXbn7nWhU1m6/8O/OIPFFeT1jA5i34XsZ7o0=;
        b=agJCYFgmsU2+0HDfmrDcIi4gzBrJvTRmS3NuNyfIzQ2r2aKT1eA/Zl8l+Qgtq8eJFe
         j/VRycoUHLjHyQjmOE6L/e9zINW0/lfqSo3hSmEu34hZyIGehPNOPNSGBSbTUG++H/aF
         CrdR4bc3BCP/cpcmfjCdOGuoMrBDSiNMVuYc9849Cr2ofX4JHObMT94Gy/UKVt5se+of
         srNLXzcwr9WNjzJ2hYNOm/osYdCcZYC9H/hYGOLioF7XAqr9+/ZJtpFOKJfX/Dx3XDnJ
         Od3M4QtG6SEfQbumIEXn3GlF4HKmdYrQuszQo3X3filcCIm3oUPGGF0yMxF9W5GoF/AE
         i/ow==
X-Gm-Message-State: AOAM533bnSKaN7RalubNlUJegaG5UyYfApipT/n7M/JOTvAiu9uLNFJX
        Um/ZBO2L1IY3v5LQ/RyCDsEAc0uKHQ==
X-Google-Smtp-Source: ABdhPJxNZLxnN2ElHcnIQLnQrEgbdR+8u1uOdrPm5b7Uw3WUmW5JKKQjrkM3CzIr9Vt38KnL7G2y4CyUDA==
X-Received: by 2002:a25:3610:: with SMTP id d16mr15626055yba.222.1590070951790;
 Thu, 21 May 2020 07:22:31 -0700 (PDT)
Date:   Thu, 21 May 2020 16:20:41 +0200
In-Reply-To: <20200521142047.169334-1-elver@google.com>
Message-Id: <20200521142047.169334-6-elver@google.com>
Mime-Version: 1.0
References: <20200521142047.169334-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v3 05/11] kcsan: Remove 'noinline' from __no_kcsan_or_inline
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

Some compilers incorrectly inline small __no_kcsan functions, which then
results in instrumenting the accesses. For this reason, the 'noinline'
attribute was added to __no_kcsan_or_inline. All known versions of GCC
are affected by this. Supported version of Clang are unaffected, and
never inlines a no_sanitize function.

However, the attribute 'noinline' in __no_kcsan_or_inline causes
unexpected code generation in functions that are __no_kcsan and call a
__no_kcsan_or_inline function.

In certain situations it is expected that the __no_kcsan_or_inline
function is actually inlined by the __no_kcsan function, and *no* calls
are emitted. By removing the 'noinline' attribute we give the compiler
the ability to inline and generate the expected code in __no_kcsan
functions.

Link: https://lkml.kernel.org/r/CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index e24cc3a2bc3e..17c98b215572 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -276,11 +276,9 @@ do {									\
 #ifdef __SANITIZE_THREAD__
 /*
  * Rely on __SANITIZE_THREAD__ instead of CONFIG_KCSAN, to avoid not inlining in
- * compilation units where instrumentation is disabled. The attribute 'noinline'
- * is required for older compilers, where implicit inlining of very small
- * functions renders __no_sanitize_thread ineffective.
+ * compilation units where instrumentation is disabled.
  */
-# define __no_kcsan_or_inline __no_kcsan noinline notrace __maybe_unused
+# define __no_kcsan_or_inline __no_kcsan notrace __maybe_unused
 # define __no_sanitize_or_inline __no_kcsan_or_inline
 #else
 # define __no_kcsan_or_inline __always_inline
-- 
2.26.2.761.g0e0b3e54be-goog

