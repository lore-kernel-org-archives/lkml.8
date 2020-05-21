Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170E1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA65620721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNkmtlLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgEULKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgEULKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:10:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C3CC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k15so4933970ybt.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Mg9xxMrsMAxLq6dAWJl0xfMkvPwKVEQaVFcZauCDO10=;
        b=qNkmtlLUQp34dW//OmOATccOQwlZefG+jY8YFa4/HdaB0TmP6XRXs6hknLWH/1OiNA
         x8Cb7LP496KxytxDtdbBBPVCVedt40khGhBt2dIpR5tkSU4reItW+touF03FFbmuWMot
         bTJkVvjoUL7ymkbXxCTykvhLb+xKGV46MHB7k+b3VIgqMdU0W5isJq0dsFcB9+mVno9d
         ANjiH4ft0zOpHFv14nPLtPlqmtcCG7MuGxCNgQZMulP6kocQ5V7MTdO69w2u49BunWr+
         /U2a35lfLyJi3O5lGa2JjsoSJwoc+JP6KPsG7srBQi3F2Yg3RIc9w9d8WmU3iygstkzF
         RLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mg9xxMrsMAxLq6dAWJl0xfMkvPwKVEQaVFcZauCDO10=;
        b=q7oSTs8A8ZjKx4PAfdx5csT2cKWSLwjwIFNvTeA4AgnxrmRss16PdkNPBMuVdh6OgE
         HNs86IIEBsqSUEtn9sPN5ZmHrqLN9rIn2pTcHxTYWemRNIzeig3rLsMKMME0OpbfERwC
         9c8CWV5u2E2HBa/dIPR2qw5IXH5Uw2Gg147TxAorw++8k5JPVOJN+6qYarzZY5sEykhK
         vXxJ2gX0iJlkLYZbENKkgPHpELm6N/J+DvKwojOs7CUc36bbl/Ea/aCHjzpb/8waEPZl
         n8mylW+AzKxfycdgumAUP3EqMttGAKmDLhk1zO04Ra0932TfMkxUHOxwzFuApW5swSIu
         3puw==
X-Gm-Message-State: AOAM531yfynd+2crv4kYPnUI9Oaz9HuIFNP+DWXnbnCWdJHAg+x2mbYK
        b1rfSFz83H1A+RkneTBqTiwxbb2Xcw==
X-Google-Smtp-Source: ABdhPJyCEOkS+Zjf1JCKHpbOw2b7PI8Nok4pmDqyytfQdzGORwkGc/4GiBWNGNKwSojAv5yeX/LBI8kSrg==
X-Received: by 2002:a25:392:: with SMTP id 140mr15229297ybd.507.1590059415347;
 Thu, 21 May 2020 04:10:15 -0700 (PDT)
Date:   Thu, 21 May 2020 13:08:54 +0200
In-Reply-To: <20200521110854.114437-1-elver@google.com>
Message-Id: <20200521110854.114437-12-elver@google.com>
Mime-Version: 1.0
References: <20200521110854.114437-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v2 11/11] compiler_types.h, kasan: Use
 __SANITIZE_ADDRESS__ instead of CONFIG_KASAN to decide inlining
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

Like is done for KCSAN, for KASAN we should also use __always_inline in
compilation units that have instrumentation disabled
(KASAN_SANITIZE_foo.o := n). Adds common documentation for KASAN and
KCSAN explaining the attribute.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler_types.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index b190a12e7089..5faf68eae204 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -167,7 +167,14 @@ struct ftrace_likely_data {
  */
 #define noinline_for_stack noinline
 
-#ifdef CONFIG_KASAN
+/*
+ * Sanitizer helper attributes: Because using __always_inline and
+ * __no_sanitize_* conflict, provide helper attributes that will either expand
+ * to __no_sanitize_* in compilation units where instrumentation is enabled
+ * (__SANITIZE_*__), or __always_inline in compilation units without
+ * instrumentation (__SANITIZE_*__ undefined).
+ */
+#ifdef __SANITIZE_ADDRESS__
 /*
  * We can't declare function 'inline' because __no_sanitize_address conflicts
  * with inlining. Attempt to inline it may cause a build failure.
@@ -182,10 +189,6 @@ struct ftrace_likely_data {
 
 #define __no_kcsan __no_sanitize_thread
 #ifdef __SANITIZE_THREAD__
-/*
- * Rely on __SANITIZE_THREAD__ instead of CONFIG_KCSAN, to avoid not inlining in
- * compilation units where instrumentation is disabled.
- */
 # define __no_kcsan_or_inline __no_kcsan notrace __maybe_unused
 # define __no_sanitize_or_inline __no_kcsan_or_inline
 #else
-- 
2.26.2.761.g0e0b3e54be-goog

