Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24821C54FCB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D38208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lqh/lP7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgDUCPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727014AbgDUCPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:15:17 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FB8C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:17 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y84so11844012pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MhRn5bu5/kvUh5QzOzRXssMosuq4vthGJuay/ttgTR4=;
        b=Lqh/lP7rPh/rNI0pAGGOPOxjyqNhok1UwLr2vLWD0Yf86f7hnanuLjyGwBzWQZ0KWQ
         adjhQMVagXSOv+hAiNSZhBIWfPo1li8vCHzgaTrsTgbGbcCuhwU8ClDWwy/MAbVy+yHg
         l8kefkpuvonUyJ59cjRiqXX+Uanx+h2rbnnl9u653BbCn+NR54DJuJFS0NBefuFHtWIT
         lpym/WosEzlkC/QEIHKuMb0NkSLOPkiUAyZo7D28AGRidwedpIeP5oIpw/ESTH4LCZkT
         NkLVJcNX/Q4mglETeVx9en79tfKw8n44frdP6yet/Lhi2dlHbLQdxyyqSLgcHBjLnVUO
         IE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MhRn5bu5/kvUh5QzOzRXssMosuq4vthGJuay/ttgTR4=;
        b=ZcPOGJ1Oh8WLU5RiD49NfO243TJTmKZTNmsSnkf9VzyXxYG2xryhKoDaK/uRgdXmQk
         fA+N8JJtALd3XPkj94hrqNGSFq3qt9cVcqcm2HJNEV6FZZLulP/rTAZXobDiKZs+Y1qB
         GKBSZRAX6fZdMLUsZVqmSlYtpCta+zgBfJn2FRBvA2xPCiO23vcbJ0tev45y3tNIzPNW
         FJHh2k6q6DvyXPoSkDV8iFs1AJHBhrLHa7oqv8pqOkc3wlD07r27XCOWaFHsuTchOWTp
         tQghbkki3ae/1P7jKHXrrFKcSVo+H6bXW8lTJzgjlhRElJWfKkmIfDtG9zw+nPhYyQEv
         j+rg==
X-Gm-Message-State: AGi0PuZY3qY0jYmI2Tcg1BwjQIUb4Xg+M0AmAIIZl2Bso06TXNa+EF6d
        Aj2L/lhMiAKG0hI+CNu90cJ7nsFmEbbbSewmWls=
X-Google-Smtp-Source: APiQypL9J2bahRQ34+pQ2Eqpk4jSOHei01Ja/PTphpnst//o5YzkDVHUYrIrIHLrDNmaV4j7WDYWllqGZ9rSI32ZS4A=
X-Received: by 2002:a17:90b:1b05:: with SMTP id nu5mr2791728pjb.110.1587435316700;
 Mon, 20 Apr 2020 19:15:16 -0700 (PDT)
Date:   Mon, 20 Apr 2020 19:14:49 -0700
In-Reply-To: <20200421021453.198187-1-samitolvanen@google.com>
Message-Id: <20200421021453.198187-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200421021453.198187-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v12 08/12] arm64: vdso: disable Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
2.26.1.301.g55bc3eb7cb9-goog

