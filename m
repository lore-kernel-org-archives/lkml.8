Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B95C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630D22078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ep/td8sY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgIBXAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgIBW70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 18:59:26 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EC8C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 15:59:25 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id k12so512149pfu.19
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DRVYiI0z9PXOKl07Ogbr3lid1f40nOD0HDkD/1XOSXY=;
        b=Ep/td8sY3naRjvHEhKklgmTTzTFQjUX86VjwOsSgihq/62NRhZeY1SqcuGcmy6Vol+
         lKX3eGWsnxhNSG1NJ0LVMhnK8hPdMkDoCRMqNjVa6lp9FqhQpiKj+5dHlejctuGa1zKT
         nuq9g2Rc/8hAL6ah/mNRNobPF+tLIw8F6z43Pc7fS2Vo2R9544aRP/zkc0D7k0gP/NT7
         O5lzIxmi+Ir2AtRfNvtfiWdSHIbbQIYNgeHJda9RZnI96FNhjeZqo67mhakoiZYoY8gA
         cGZiILWB+CZUjIJQwPd+O6bowjMlX15fEf0jShNCwhmiLp1KgQ3lAIiigHPOkWk6VziN
         vCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DRVYiI0z9PXOKl07Ogbr3lid1f40nOD0HDkD/1XOSXY=;
        b=uOjlBwkhTwZViRZD6xRqxKNRK0LRnoGSZTwC9H34SKfAC8EEQ25NGf60RxEqbi8pGg
         Ke1oZTg/SfooUeG1Cjot7ZqcdCcUwRWKV9sbZRQyP/GJSLjK+rHkjJ7ecA3YESGwiZbu
         fTGNGdbHHxXtFMcnE3fEpp4OSxrFVVaOVGMTEXI6fMvrmYaxv4MDBjLQCcJcTM58AGbu
         Tu2SUWlEaF+otCPyWxAUuZwITnPaHqwcFRGgVxkmjOqUSXK66Mz8Fd/PCrf+hPliwzn9
         s4ZnprjroA8OmxqpTumqM3BahCbzlAGXN+nRD7OxkxnNWGe4qv17+89uKqSGyksucvem
         LPPA==
X-Gm-Message-State: AOAM530+8X2d5qZ6rWUHwVQ/CeJ6AaSRmm3YF9YohFyBr+CWum5vwQkL
        Pw782g8XK2rcjZobbwJ6eQiNj/i+U5IjUhFFlOM=
X-Google-Smtp-Source: ABdhPJxRfhvoHEIgZxcKiGseIUwf/wvGmcDIyEPP5HQG+qy/Aee+r6gkvNVms/ZEE4RqpuALVWmjgJRtDT7P3hrgnzM=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a62:4c5:0:b029:138:413e:3e65 with
 SMTP id 188-20020a6204c50000b0290138413e3e65mr672301pfe.3.1599087564581; Wed,
 02 Sep 2020 15:59:24 -0700 (PDT)
Date:   Wed,  2 Sep 2020 15:59:06 -0700
In-Reply-To: <20200902225911.209899-1-ndesaulniers@google.com>
Message-Id: <20200902225911.209899-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200902225911.209899-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v3 2/7] Revert "kbuild: disable clang's default use of -fmerge-all-constants"
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 87e0d4f0f37fb0c8c4aeeac46fff5e957738df79.

-fno-merge-all-constants has been the default since clang-6; the minimum
supported version of clang in the kernel is clang-10 (10.0.1).

Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Fangrui Song <maskray@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://reviews.llvm.org/rL329300.
Link: https://github.com/ClangBuiltLinux/linux/issues/9
---
 Makefile | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Makefile b/Makefile
index 1cfa5029fd2f..e475650c9599 100644
--- a/Makefile
+++ b/Makefile
@@ -932,15 +932,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)
 
-# clang sets -fmerge-all-constants by default as optimization, but this
-# is non-conforming behavior for C and in fact breaks the kernel, so we
-# need to disable it here generally.
-KBUILD_CFLAGS	+= $(call cc-option,-fno-merge-all-constants)
-
-# for gcc -fno-merge-all-constants disables everything, but it is fine
-# to have actual conforming behavior enabled.
-KBUILD_CFLAGS	+= $(call cc-option,-fmerge-constants)
-
 # Make sure -fstack-check isn't enabled (like gentoo apparently did)
 KBUILD_CFLAGS  += $(call cc-option,-fno-stack-check,)
 
-- 
2.28.0.402.g5ffc5be6b7-goog

