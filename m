Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F83C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4EC2078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kHS9kTsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgIBW7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgIBW73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 18:59:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5778DC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 15:59:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v77so888840ybi.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 15:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kC9uVdCEcRAgEe8ChNSdUEhwx4IluKYz275BuoXca/s=;
        b=kHS9kTsjdyybrPRRh1qzo1Q9p5HXl97DTyQi8Ig7QdwFanfBMMRYPubiF4wXhWjx/B
         G//9aTswJOah0M6r4u8L37aVWGM7WPSl6VMiT1j+014KpVFyreLGoAgOpwaY/Gw7ZoJw
         p3MUJsaUTes9X/AGRZGjKtyARBD036fW3y+OqjSwqoylryW0fxU+pFInGIlwYJYlTfVP
         NGtlSMYpV6CTuctHEHN/rmeYWsovW6rjGgO5V6ZG3u5Sq9kuwgGQ6SSa/j0StnOn89q5
         Cy99SWCoEx48IofSzObJSD0Qd8MHnxLj9omD4FyC+T7eCdaC9jL/FlYhCqtqfa8SBtQ3
         jqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kC9uVdCEcRAgEe8ChNSdUEhwx4IluKYz275BuoXca/s=;
        b=T2JPxgW9jV4CYOWJTll+oZypqp+oGb20rOQX2ALdXFgu88U5y37jMZY33IdA14f1c/
         tPhpuGzKzhwCLwPkskCzrd4eyNHaZRDK1IZX3UTJaxrKbS2D7FN8evyhe+WqJnin2bwM
         4wJzATPcrLtsF2CotH0oO4EpTIcnCRWVKg2ZFWX2vVl7+Dm3556ZOZWnO3dDRbSRl8Pm
         tpk75a0K6eRcNRwnk1gXNkSN6ycZsRMFBZhJ42N9/w6QifYS03BTgIqoop2y7gPPHClB
         lGR8cPElGcJUcA0bB4BdFhhwAQ46aQz+rTtUs8mZtljKlo+OMuRxk62j/8WeqE7e18Rm
         NgHg==
X-Gm-Message-State: AOAM530sAK+LDcheYNl3oaJXJB+8ofoT1LXavnFZzC48JQtGei+hSEt4
        g/7bnBzmaWEIx6UgnA1Zy1wdhlRi/gSyaWCv2iI=
X-Google-Smtp-Source: ABdhPJznmOvdxoCVGAwsxIwXXqRye+xTVNB/6ZAZtay1MiRq594GhkAr2a9QSmIABurLBYgNAT93Dhv/FB5gsu0Q3U8=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:8b09:: with SMTP id
 i9mr1026ybl.149.1599087566495; Wed, 02 Sep 2020 15:59:26 -0700 (PDT)
Date:   Wed,  2 Sep 2020 15:59:07 -0700
In-Reply-To: <20200902225911.209899-1-ndesaulniers@google.com>
Message-Id: <20200902225911.209899-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200902225911.209899-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v3 3/7] Revert "arm64: bti: Require clang >= 10.0.1 for
 in-kernel BTI support"
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

This reverts commit b9249cba25a5dce5de87e5404503a5e11832c2dd.

The minimum supported version of clang is now 10.0.1.

Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm64/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..2a70b85b1a61 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1630,8 +1630,6 @@ config ARM64_BTI_KERNEL
 	depends on CC_HAS_BRANCH_PROT_PAC_RET_BTI
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94697
 	depends on !CC_IS_GCC || GCC_VERSION >= 100100
-	# https://reviews.llvm.org/rGb8ae3fdfa579dbf366b1bb1cbfdbf8c51db7fa55
-	depends on !CC_IS_CLANG || CLANG_VERSION >= 100001
 	depends on !(CC_IS_CLANG && GCOV_KERNEL)
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
 	help
-- 
2.28.0.402.g5ffc5be6b7-goog

