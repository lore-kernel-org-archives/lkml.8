Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0A8C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6537020767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RrcyI2Cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgIBW7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgIBW7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 18:59:31 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC47C061246
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 15:59:31 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y187so448793qka.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=a4tZCER4et/ZOnqo0bwgxKeJi/AmG4wV7j4nx2O9a/E=;
        b=RrcyI2CwZNT3X5GAqgqiZXGZju0PRzTwK589pkyiuhlKah9yC2vJ5Mano/bO0o4auN
         PeIgXcYBujGIb8QGchbbL1pCA6G4WEAlGIXxGG2CpBsRCLrQAzkLLb2d/WT5h2qISN7v
         66+m9otTSCsomB4KhTK6YKANnqE9UBsjXAz30MfpbcJUCKbrg5FHp6CnfE1+MrO1V1Cq
         jqxtzmas5oViJOOGN6d7elPXGnngddP9oB9w0ZbTsDDYm7fC2/zvFP4CuzfeBP81dHCr
         nde9xukTPLJwj3GR0bPHz8KJlAVtu0ZJOLrKcapKaMGujhrfo/FFqeDJt89INz/wqpZT
         xM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a4tZCER4et/ZOnqo0bwgxKeJi/AmG4wV7j4nx2O9a/E=;
        b=C95psgc8timPsHKUGRanu4ywqj4d1NgfRPj7ezYMUr7NVX+o656V6KFSd8gXn6o4R7
         9K1ci/xnSFJToD8CfGfAHY/07yCkl4faEpEv2+3r93lRz4Jtl3tW7SjN2/FP+1QSSXkE
         kjYN5rQSzKOkI9zW3XlKczFw5F3tdnu/FHlY5iEAMC31CLNZO2/ckvuZv9wEybf6j2wb
         9YCPOUHUoh8QSQiOXrvjn0GZDzqyG/he2NUQAp0i0IpC8xGzp5Se7P/BspqtYHMlg7br
         muuR8Pbxlc4RL8tyKsIlIsgqkud1r5HON/gzhANo4hm1J33o95NUj/ZStWa9Al43tPgL
         PpLw==
X-Gm-Message-State: AOAM531IZdeJ1Oris+oXaYyQVALHgrb25sqbXGHE9R9SWHJlRBOhJ8lN
        W3bU/8ZtDxCDPNFexQ+i1GcFclS7nl76oXLuWH0=
X-Google-Smtp-Source: ABdhPJyar+QZinYrvh1B+O87J7oQ62bttnlZOOJQnWAc5e5nV0SswX1z41FlI6BIJmKrWUBGsu56LeCyRBu1kiU6mT0=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:c207:: with SMTP id
 l7mr105339qvh.239.1599087570306; Wed, 02 Sep 2020 15:59:30 -0700 (PDT)
Date:   Wed,  2 Sep 2020 15:59:09 -0700
In-Reply-To: <20200902225911.209899-1-ndesaulniers@google.com>
Message-Id: <20200902225911.209899-6-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200902225911.209899-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v3 5/7] Partially revert "ARM: 8905/1: Emit __gnu_mcount_nc
 when using Clang 10.0.0 or newer"
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
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

