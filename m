Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1AFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6F2207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VtJ/Urbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgEULKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbgEULKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:10:02 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7858EC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:02 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id w6so6806702qvj.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O66Rrrp+JcFi/5yju5R8rYLztnbdicYxc/HcFiSiC0Y=;
        b=VtJ/UrbfaM6BolP1bI6UHyVm0WMy0DeZW5vu94Pik/zWsLIQyXc7r6cA3itlo7S9BD
         nPSwqGFrKd/Wa0Dyp5cVGGm8HhJ3WKm5bRpXU75s2QTlPZPK2Mr0B6Z4VTkziedrzquj
         /x/CBFPyaPINxcDV0Oh5eqasLdlf3KpYGzUz/WyBkTsGQAQIjTidPM2Jv0E/PLf4Zj1L
         p9DbxJdjH4oM76bRlgYijSfmZCFzQ6fvEM1FKnCNKy/k48teiPHk7UFT+0hPBqW/KxB3
         1RzFFdvw6BRXReIT+Z+Za/wGDfy3xyEFMXaAxTH37skANmThgr8Lqbde6K646msGZL5P
         yH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O66Rrrp+JcFi/5yju5R8rYLztnbdicYxc/HcFiSiC0Y=;
        b=WgVSUzQg1SCsLGRlbCFCtzajq2yND0kdWmjR365jYpyIc76NRLh4L3kZofh/TXxmXy
         zUZ192PCN0MCQt++O04UeHB1Ra8cp5JwQjn5k2sJDZBl7DoGB6sBseTxm8ZwkXv8GKQc
         p6SuTKaFx2szdXJM/s1Y646wRH+aoW9FIVrpCO40FXIgPkfBnsVsVhV7Cnl7O7zHM1sp
         A40XeREj27R4uqhddkFDyrzwI8jKhQzH5ZUC2dQWXpkCxBh5iW+ffRfxFU2yxlOsd+Cb
         7NyyefTHT3E9IUt8X0yA0b0+DBs4XUo0ulCLe3oZ3WGW+Ssx+dy+SB0aJXaRlmdAwXKK
         BKLQ==
X-Gm-Message-State: AOAM531W5SVSSyUoIxzJZ6kcs1UQpuXuPsOY7rzoXB3QDw7AMT9Azzat
        BEMS5z8May2L9EDF5tnGdbm8EoLjXQ==
X-Google-Smtp-Source: ABdhPJzHNOZEYn/z1ZMnfkvXrB3RPs4pAA3s5uWP2uklE7iH3A2rCUyzb3cnQ9egSlcx88JUt/1xhyTMKw==
X-Received: by 2002:a0c:90e7:: with SMTP id p94mr9692288qvp.219.1590059401676;
 Thu, 21 May 2020 04:10:01 -0700 (PDT)
Date:   Thu, 21 May 2020 13:08:48 +0200
In-Reply-To: <20200521110854.114437-1-elver@google.com>
Message-Id: <20200521110854.114437-6-elver@google.com>
Mime-Version: 1.0
References: <20200521110854.114437-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v2 05/11] kcsan: Remove 'noinline' from __no_kcsan_or_inline
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

