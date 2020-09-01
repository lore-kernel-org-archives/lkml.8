Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEDAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574502073A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nDE4gJkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgIAAXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 20:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgIAAXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:23:42 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C6AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:41 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l1so6515272qvr.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UYhwqzzKZ0/ALhGvtSLUxxGQ4j8cmcIi3OxNm3DV3ws=;
        b=nDE4gJkToPEJC6LQr4iA8LZNx0E8KgNe/yeFPBSvnquJ3+lPVQXk/AmYqKC2Zt59Kw
         aHj0uerJJbFZzXi9y0BCcFTjBjuFczKH52KW9I4V+e78BzqO6UZXab+hBc3qxR3L59Kv
         XMc9ZR6Cp1gmLQP1RLHt01FmGXLGIQLkjqOu/Lwps8qO5BlbdzLSrYqaU8vuO7fblZy+
         poOuNb6+CfKzegovFzqnaL655owDzC7nWGQGTN44WT+aQrUNo9uUct73b9F2uDfCBF6u
         tyBSAqeWVSjJQVw2lrjfFBhUR1nDVuKOUEuCXUADY/nwOvB00B/BaLAGnqo1JBi69+9C
         i6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UYhwqzzKZ0/ALhGvtSLUxxGQ4j8cmcIi3OxNm3DV3ws=;
        b=im8yKbdFV7r0h55SIL6MvIrUceWmilAus3kiCTnrb+G83CT+G4alpkYC+bLehM3Mhd
         b2KHpTkta2p6g8m+AHLcVHl4aTO1+zDeCGi7pFJGQp3G9Ay1Z6EuYpIavruMZFCWFwVz
         NVn+R6CHbR6ghp0j6nkIYc5LaPHXNnfpK2eeLcV1RxGqtN/SBe0Dk6JqNzMwGH/jGS80
         ESYFJxmtRMncwdXXMINHDtQryF/RbMqf+pk9xoee8hxJtc7012T9ja0IyAvFIyrMvDOc
         C22fkrxJzWPyZjCoYN1mILR0VbU017dNwCyjGZ4s8XpZszDJDBPwJIXMFuseCHNW+udn
         4JcQ==
X-Gm-Message-State: AOAM532kKv4PlwA69p3+0SmjATqHCtcff9+XrCXW7Gg3Ek7mik8etnxQ
        ZXbQUzG1LM4ocX+Cz3Jl9ArpfMJoN4HASVT2DUY=
X-Google-Smtp-Source: ABdhPJyDXaA+DJw4ZDyS3Tp5+pLhSSuyNyarjcRyyGtm8dTA3b+eGG6qfiLwrt1zg2Gz7mH2LK48uZzPRWyhdPtCh+k=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:b626:: with SMTP id
 f38mr921855qve.0.1598919821103; Mon, 31 Aug 2020 17:23:41 -0700 (PDT)
Date:   Mon, 31 Aug 2020 17:23:24 -0700
In-Reply-To: <20200901002326.1137289-1-ndesaulniers@google.com>
Message-Id: <20200901002326.1137289-6-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200901002326.1137289-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 5/7] Partial revert "ARM: 8905/1: Emit __gnu_mcount_nc when
 using Clang 10.0.0 or newer"
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
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partially reverts commit b0fe66cf095016e0b238374c10ae366e1f087d11.

The minimum supported version of clang is now clang 10.0.1. We still
want to pass -meabi=gnu.

Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 82c197a248dd..09a7669eea1d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -83,7 +83,7 @@ config ARM
 	select HAVE_FAST_GUP if ARM_LPAE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
-	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && (CC_IS_GCC || CLANG_VERSION >= 100000)
+	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
 	select HAVE_IDE if PCI || ISA || PCMCIA
-- 
2.28.0.402.g5ffc5be6b7-goog

