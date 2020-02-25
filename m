Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95458C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFCC2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xi2ZbcU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbgBYRkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:40:15 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41086 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731080AbgBYRkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:40:09 -0500
Received: by mail-pl1-f202.google.com with SMTP id p19so7891955plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W8ajq15Euo0CBn6HLEY8Ur3IDCmQBKzronvmXuYJ1Wc=;
        b=Xi2ZbcU5w4xAMDBbk+3G0M7WhFEvev3QQQmayIYq12lXrXU0TZY00WT8V3tl6EBeFs
         4YY+WNru1RHx9Rtv7WI7GU9OFbC0kpv1arYQcLbeOtalBIzT9bzfvmjebvYpIQYGN0iz
         ohwXof/jSEC3zwPA+NUbVqZJ7ozto76pl8Tl3GYn7Wj0oBFcPxmvhAMiLDwhWBcd/dtK
         oQCsutUGRHGUPUXm6ZqfV5QbrWXnb7sD4ecMMfiyZisuKFBUhFGQatODjW3Cdm3VhZZA
         ET4mX4w5o/xHxsjJresFyuImLMlTwnQvGNeTqx3ZIqe9K0l8H2+6zMTkYnV/LRZbxSrS
         sfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W8ajq15Euo0CBn6HLEY8Ur3IDCmQBKzronvmXuYJ1Wc=;
        b=c0x1EwHzYRFWFJMHVwtojG7Kv7HUL1OhuYL+W9jEYf21ocuup9Lm4x3bBgsU/L7ltJ
         RADGJbVjYm0/B+gjQvVL2EM0Fe3eBMkLTH+oI2Gzrqq298EpjujQ8yJubyFF2SEAVk3a
         baOIOovoE8xAtWC9Xh5Vy2/MDCK8AylstybKbwgkJ/Ob853XQiS49VtiKeurN7MQdoH8
         qi2WwgIDT1BgBiBi98MHJsiJAcl83nQgJ5BC79Z6v5fUarAX6ZTV1tJzfiZid/8P/Lv3
         wgL0UjqY5J7ZuRQ7qJWF7gdhJhT5LEaYDCz25L8aZGUXFo7MQkFAOLyi6l4+95hdeVFN
         DVhw==
X-Gm-Message-State: APjAAAWW5nyNZlwkAI9/REL7ptcM4RZF6tBZEYNKCLGfavxYuq25bWwk
        D+ch28mLN5RKTpl0hBru4ADvNZSJf4xPP2PJ1NQ=
X-Google-Smtp-Source: APXvYqwvqENHxbX/ovgpjf0ZVx0mLlUs8H8QzWYeq0EOjlcVEkkcC9/C+tlcnWHubokdElLT2kLplCW3jEbNjcX6X1w=
X-Received: by 2002:a63:3207:: with SMTP id y7mr3943460pgy.344.1582652409047;
 Tue, 25 Feb 2020 09:40:09 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:39:29 -0800
In-Reply-To: <20200225173933.74818-1-samitolvanen@google.com>
Message-Id: <20200225173933.74818-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200225173933.74818-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v9 08/12] arm64: vdso: disable Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
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
2.25.0.265.gbab2e86ba0-goog

