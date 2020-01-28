Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E615BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B918524693
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7KYQSca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgA1SuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:50:06 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:54224 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgA1SuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:50:00 -0500
Received: by mail-qt1-f202.google.com with SMTP id m8so9085820qta.20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 10:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bNCXRmM/yr4GL3yZ1bhHRJc0r5YpsDoQ2qXNiKtbIjQ=;
        b=o7KYQScaTc5r0bWGyHvOSj2qDSparI8nM7EV2GGaR8zJgb85Unw1bAkclg2/3gkVjV
         sWiP8fvXbxWaFa/3ylPd3mUT0DJXJwDNPclKGR0BQxZ4Cc2/1/tkupECkGjVL+qym1xJ
         Ae3JulKZHCqg8uCAc0O9oxR71IRgfwLYrHi5idXDY3EpdKDxL0ypLNFgS5UoGwYlvaVK
         coXWpBTQvrtoEim7i5jhgtRDRSCIEyXek1a+HFz3DKK+zmjORBlTmey8aAdNXMqQeIAI
         9YEW0BDh4vOazWGWstuyBaqYyWx5H8LIDc1PihTJnexHB7ha5NBdEF0GBHhBS0eIc4XK
         0rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bNCXRmM/yr4GL3yZ1bhHRJc0r5YpsDoQ2qXNiKtbIjQ=;
        b=mG1EYUV3zFE5TqARmVwuVwQDKltUcB9Nw0MfQ6SlaPJt7Xe7TZGuXS9zMWhP7FQiMi
         ZE9tdFuK7dcXP46xFHcNHU5yCF9EcnZCmQncm3QAzxzd3iKFFIyhc7IYjBdnQpNkRFg7
         58f6cwfPyCJoVNenAdlh5Fm8tRDjPIibvXDb3xqwgR3Epnul+lEmoUpWJm+RZ+Q9Lb+N
         MIOk0nAs7iIoCKsqv/jcLA0VOSQclYzfNT1n4cEvuhQzGAFkT0EndLguPiDYNOQ/FGRy
         xerKJeNNXwuMmoi2E0rb1Ntin5XUhOv7NktCCC9JhUyyEgYb0Nzda0z1jclrOyP8YF3R
         3SVw==
X-Gm-Message-State: APjAAAWaVJ1hr5ydZNHHSY8goDgqLAVQQAs1e3aUlBm36oc3IMJ/y7hJ
        Zn06sdXnzf6BTyCbEVSp1HXas1vWt5+D9NsnJOc=
X-Google-Smtp-Source: APXvYqx+U9CfKO16wIXNBeeO96dJ60XaZ+hhyoe8kAoit2FdttoilLWi0KpO3nWQj2EBXb7JYYq1XAJT8FXWdsvdaLA=
X-Received: by 2002:aed:2783:: with SMTP id a3mr7863657qtd.284.1580237398897;
 Tue, 28 Jan 2020 10:49:58 -0800 (PST)
Date:   Tue, 28 Jan 2020 10:49:31 -0800
In-Reply-To: <20200128184934.77625-1-samitolvanen@google.com>
Message-Id: <20200128184934.77625-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200128184934.77625-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v7 08/11] arm64: vdso: disable Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shadow stacks are only available in the kernel, so disable SCS
instrumentation for the vDSO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index dd2514bb1511..a87a4f11724e 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -25,7 +25,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING
 
 VDSO_LDFLAGS := -Bsymbolic
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
 KBUILD_CFLAGS			+= $(DISABLE_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
-- 
2.25.0.341.g760bfbb309-goog

