Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9903DC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CA92076A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKKOaYv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgD0QAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728517AbgD0QAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:00:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08C3C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j14so20900637ybt.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s5XAabWLI2BrMJh1ovnuwgRiP/5q7kOCrh3Tv97TlA0=;
        b=aKKOaYv8P84S78HqqnTCVvsVcMXU5SuB2uvNssb9dPS+wTPsWhzH4tykYH1PsvII8g
         Jd/hsa/Mgbp25Jeg8kQqz5FruH6lUYId1eE5kTscIN8QaYWmGyGrs5QWCnBs4rAdSgXQ
         zC0Nlt1KC7ARBPh/nOWpPnDWG0rRtqwjW8jYc28CX08RgkR6SRw7KhBHzjhgOoqClVSa
         24U1Bn/ippHj5neJKtLWLh9eYKgPspBRD588z3b2ONTvZ+YfHBsPfig2qNeCQSypkVrT
         Yzp1OhGBKTNMPpcFLH0mbf95THoQkUSgEmKq+w0AYmnWxJt379tb0t0TUMJlMmHfTMKd
         cfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s5XAabWLI2BrMJh1ovnuwgRiP/5q7kOCrh3Tv97TlA0=;
        b=OjTgQxAVRqe7V4wvCXuyrnq+0WHzP4+dlQ1BJPGuZghUzoEGyzNcVKdLWXfVf4QcfK
         AvEr4CDBUMwMMs0Nb2DvpkRoCNDdgcIhvkEzX7GDza/RAiX3GkKBCqX4FOKQO+eXLfnG
         HXPeXkI7eYyRJvvozBV5lufwlo6p1yfkKGPFHFBQA/14JQyazgoN8AWx+hW4GtOsOt8h
         FTBG/bcHz5rEWMFMg8/PVG/xhp5lMZh7ChihuMh6PpIvj355g0RIPCsSrCDbXFLEs/Gz
         gIbTsRDDPt0FDicz2y8tFWBQZnGNfuvEFZlOkvby+hKgMI36YkeT+S2WxSL7vd0qKnft
         Mcmg==
X-Gm-Message-State: AGi0PuYAxWHkWNwg+0Uofs9bOCh0gucBsQwLaPLwNtS6bMeE4g8dl1A9
        BnRNlYMiDZvL3v0QmQaTQLN7c8pQ17rs+tU84dA=
X-Google-Smtp-Source: APiQypIC7qXsP5qbhdeCuYbEm/RDRXHOxeiSr4jdV4m9YjAk4hfpiSrYO6gGIVT/CP156YV9CFT4O6s/Zh/4ptwP/o4=
X-Received: by 2002:a25:abed:: with SMTP id v100mr3797424ybi.96.1588003251771;
 Mon, 27 Apr 2020 09:00:51 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:00:14 -0700
In-Reply-To: <20200427160018.243569-1-samitolvanen@google.com>
Message-Id: <20200427160018.243569-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200427160018.243569-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 08/12] arm64: vdso: disable Shadow Call Stack
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
2.26.2.303.gf8c07b1a785-goog

