Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEC1C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DB8205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRokN2oO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgD0QBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728616AbgD0QBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:01:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFE0C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:01:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t2so20785172ybq.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qkETA9PcFfLLgtHJjON9o2tnpUEMYOCdGfYROMcqbgY=;
        b=CRokN2oO5qHaIwDnfhPQm4WUGN3dL/7L085WmXGBSTSWdMgIglwt0wRRJelCXVTkUE
         evOGTcMnXuR7Gjk4FVLYN7tW5CCc6BokYtvDyoKf0BZkGqxaFodx3U9MT4v6NLYHqmZ3
         iKYOMczKSYycS/Y78HO0iUKm+Cybr6RYQTwonAcmpQMj4NBDWRV7rBluW3RDsp+lkYsB
         XjiNReA/J9iMZUvAfy9f6Kp0qq+eqtAmtSd9c8FAhrtbFh6vgYjxE0lF9hnWHmvKb9K6
         9WkijNUXXW4KO1tiyvrcZh1oyagjEj80iU2m3X3BlmfDkqRZqoPzeopP0mihx1UMFM7T
         1fAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qkETA9PcFfLLgtHJjON9o2tnpUEMYOCdGfYROMcqbgY=;
        b=CSthLJ/DvUcnPHpGcJ+KXtIbGcE4+PAgdcK/qZ2g+kRQLt6p9JlJQpyOCnbnTwnv63
         J0GfLsT6+AUcgcOFR80Xuy+kqdvjO18li9sMpa2iqeX9VXiZXaLYymNQEPy4rpTk4uhu
         mc/GSQFhKXDQEjDdbf74NAotHbdWAtfw3x44Ejkg26R/H3OVkqM/2clEJ81EvzOAgAKO
         yeRXmigWs4CtPNaKpBCdzt5wpbc/eh4PdvFzpITeUH7XCjf6dFmg5wB2T/WoNwT5OmP7
         b3mKAhW20KTfNa3IHnupWRt/370nlpthlrv+evMrMHI5t+StS/2VXpKUmOdANpjCtJzP
         /h5w==
X-Gm-Message-State: AGi0PubDdw1gYOzLhwtjnfJYL+v8h8jJ4kWIn/ZDGmsk2AeUn9LqFldT
        DrCZyExnLiPJx0GrMVyf/iV0ORiZbbYSlY3QZUw=
X-Google-Smtp-Source: APiQypLYy8Cf6kn4jY7fWjXaYMyZ9zM7eZaWrEh0s8K72Jfk+q/yv/f8RANanjFwMmhFbjtpLFic2YH4QuKkPtwOEog=
X-Received: by 2002:a25:d14c:: with SMTP id i73mr9231289ybg.116.1588003258779;
 Mon, 27 Apr 2020 09:00:58 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:00:17 -0700
In-Reply-To: <20200427160018.243569-1-samitolvanen@google.com>
Message-Id: <20200427160018.243569-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200427160018.243569-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 11/12] arm64: scs: add shadow stacks for SDEI
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

This change adds per-CPU shadow call stacks for the SDEI handler.
Similarly to how the kernel stacks are handled, we add separate shadow
stacks for normal and critical events.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/entry.S | 14 +++++++++++++-
 arch/arm64/kernel/scs.c   |  5 +++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 244268d5ae47..cb0516e6f963 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1049,13 +1049,16 @@ SYM_CODE_START(__sdei_asm_handler)
 
 	mov	x19, x1
 
+#if defined(CONFIG_VMAP_STACK) || defined(CONFIG_SHADOW_CALL_STACK)
+	ldrb	w4, [x19, #SDEI_EVENT_PRIORITY]
+#endif
+
 #ifdef CONFIG_VMAP_STACK
 	/*
 	 * entry.S may have been using sp as a scratch register, find whether
 	 * this is a normal or critical event and switch to the appropriate
 	 * stack for this CPU.
 	 */
-	ldrb	w4, [x19, #SDEI_EVENT_PRIORITY]
 	cbnz	w4, 1f
 	ldr_this_cpu dst=x5, sym=sdei_stack_normal_ptr, tmp=x6
 	b	2f
@@ -1065,6 +1068,15 @@ SYM_CODE_START(__sdei_asm_handler)
 	mov	sp, x5
 #endif
 
+#ifdef CONFIG_SHADOW_CALL_STACK
+	/* Use a separate shadow call stack for normal and critical events */
+	cbnz	w4, 3f
+	adr_this_cpu dst=x18, sym=sdei_shadow_call_stack_normal, tmp=x6
+	b	4f
+3:	adr_this_cpu dst=x18, sym=sdei_shadow_call_stack_critical, tmp=x6
+4:
+#endif
+
 	/*
 	 * We may have interrupted userspace, or a guest, or exit-from or
 	 * return-to either of these. We can't trust sp_el0, restore it.
diff --git a/arch/arm64/kernel/scs.c b/arch/arm64/kernel/scs.c
index acc6741d1a40..adc97f826fab 100644
--- a/arch/arm64/kernel/scs.c
+++ b/arch/arm64/kernel/scs.c
@@ -13,3 +13,8 @@
 	DEFINE_PER_CPU(unsigned long [SCS_SIZE/sizeof(long)], name)	\
 
 DEFINE_SCS(irq_shadow_call_stack);
+
+#ifdef CONFIG_ARM_SDE_INTERFACE
+DEFINE_SCS(sdei_shadow_call_stack_normal);
+DEFINE_SCS(sdei_shadow_call_stack_critical);
+#endif
-- 
2.26.2.303.gf8c07b1a785-goog

