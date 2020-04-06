Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B12CC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8342496D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6aOOb4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgDFQl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:41:56 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:40109 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbgDFQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:41:54 -0400
Received: by mail-vs1-f73.google.com with SMTP id w2so9975vsf.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P7tRJ6/bRwi2I74AEfEJ7NL6sovvq6Ksezb3luMLZ/I=;
        b=I6aOOb4F+m585U3+RTjXCgdA35wkhP1CN3Uhmh+0KXvkwJcQQrkknIVKYFc21EGa9T
         gXREpmuKmKvxZJQyHbkni+ojnnrEUvsfKtX9CGOGZlTJmkKexDQDF2et3kSeqToQRiKo
         Wt+3R+N5GtS2ABYhkNEB3tNvZvXgtf9rP6ZYtHP7qsABnpKM8zORokraX7ZOWpN6zase
         7NeHFG/CLonjoUheDOHlw7LzXo3Z6KjdaB9CNgPtQJRi3+pdaP4ZaWGXm8Emnc+boObD
         Up/eCuQFeygzhdH7a2SHIC/Eb6fhV//t/0cYReB1Mak0oksza68jY0Bqyf5hZJG0QQMh
         gQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P7tRJ6/bRwi2I74AEfEJ7NL6sovvq6Ksezb3luMLZ/I=;
        b=mxM4jVWc/SacG4CewmwmkTzsXrHLt9ZkPOE1trNOd0XVS/oL3w49Od9I5lCHOV9GE4
         kKA2tY2iMKta8atVs/COFLgPXl2LrdYaljuyHXqQPsgAEVtWJX/5P5EbIi64PzUZkwTj
         BtPCpY6BuouC/Ac0Rr39n54jIH/o2A2zgEu8nNIR30nDh5IIYIN0eJe6ad5UCLhPI6on
         V+ON/3qVYs+vi4pvI4VkzQucI3NwuVYeY81WwHxHQ4Bxhaw4Tl4zaqcI1tWTvP8RjKBB
         jtPP0bVd78nK10O8yljayVbsnwXItuCKW43xY7Xxv9+blGu+OPhOTHNkczXH0LsB6CDW
         Da1A==
X-Gm-Message-State: AGi0PubkhYC1f+rtr+I3O0Ff8C9gnyNffMRlcSMYc9Rkty7QLMDX/zpT
        Z7lK3W2LYvl+sgzr/dic/FErxVG6KHcVHRqxcBM=
X-Google-Smtp-Source: APiQypJJ2vW2BCKCiSZ+xIRCi6v70yfbRRHeakQcdO++WZV928etab2mQBvVqnKPYnI22hBzW364z/buE5ZaeQqgJWo=
X-Received: by 2002:a67:fb0f:: with SMTP id d15mr471360vsr.88.1586191313260;
 Mon, 06 Apr 2020 09:41:53 -0700 (PDT)
Date:   Mon,  6 Apr 2020 09:41:16 -0700
In-Reply-To: <20200406164121.154322-1-samitolvanen@google.com>
Message-Id: <20200406164121.154322-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200406164121.154322-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v10 07/12] arm64: efi: restore x18 if it was corrupted
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

If we detect a corrupted x18, restore the register before jumping back
to potentially SCS instrumented code. This is safe, because the wrapper
is called with preemption disabled and a separate shadow stack is used
for interrupt handling.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/efi-rt-wrapper.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index 3fc71106cb2b..6ca6c0dc11a1 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -34,5 +34,14 @@ ENTRY(__efi_rt_asm_wrapper)
 	ldp	x29, x30, [sp], #32
 	b.ne	0f
 	ret
-0:	b	efi_handle_corrupted_x18	// tail call
+0:
+	/*
+	 * With CONFIG_SHADOW_CALL_STACK, the kernel uses x18 to store a
+	 * shadow stack pointer, which we need to restore before returning to
+	 * potentially instrumented code. This is safe because the wrapper is
+	 * called with preemption disabled and a separate shadow stack is used
+	 * for interrupts.
+	 */
+	mov	x18, x2
+	b	efi_handle_corrupted_x18	// tail call
 ENDPROC(__efi_rt_asm_wrapper)
-- 
2.26.0.292.g33ef6b2f38-goog

