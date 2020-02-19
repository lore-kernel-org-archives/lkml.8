Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7F4C3404C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B9024656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qufzpGjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgBSAIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:08:54 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:44434 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgBSAIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:08:52 -0500
Received: by mail-pg1-f202.google.com with SMTP id o2so14859358pgj.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 16:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QniVckAJWtqLmmFgAWqtQvDUqGmhiEDDkK5Atd0uI+w=;
        b=qufzpGjEppDMWPImhTuGEdGT5fSrkUOCFRhcyjZobkamDvVW8lKE7S9n8IfeI9kMjN
         GjSsbQERqiJCrQWg5+yur9ZmpwI3842rBfYePp5EboZsGV0A9NX4KJSaHBYX9WS8TV/B
         YxOPfKJb3HR14olUqNzIghumWLSF9JfupKrwhtKGLhHcH+iy/cZLakuxTBBKr3BSQC+Q
         l/d2gtUBVVI2+sDEnrXi83zlWZ5bO/OYVixaPN92nFcUWQ3ZPH+WoaCJq/ch+3VstHjI
         DDMR+HT+E10IhOJZsyS+YJ4gi2CPv7gIBX5icVylNk3GYCOKGpIchxJrvY+jCKqp3YLe
         pYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QniVckAJWtqLmmFgAWqtQvDUqGmhiEDDkK5Atd0uI+w=;
        b=gD1EbNdmSN3xdDALYMYu0SkdBUjchQH+FAHRIofJxFzLYHGNI0fus/t1RtKDi1uiRV
         QVbAuTkPf7tRtjzmnT1TybQWcHesuYeeXxs3mbl6c2XHX/n0De8TPGGTgG9ua7XzGrwR
         Gollb8GZ2Fhv/h9mfwZmqBF9hd5Pcoi2oEZvb7AuY9/mbu+JbqjHELCAh3azwIs4a3P1
         3zRdfm2VBVti2SCSzwiASHIrjeQFCZaXrP907ZmKnZZNnax1Ct/g1+e/NCOszAlLM6is
         uxmLCloIn+/rgWMUv+rjLB5NYevAal/Y/QH8pHXoCRbboKdcHd6RDRHiM8KGkTg/jNEW
         humw==
X-Gm-Message-State: APjAAAWGELITEMPyrLwKzbTMPwtZWRWtBomQZQhWVbCvENa05j1A4DH+
        froERjo6Rg7oUsI9cdpy/c9Yan5sZMIc9BGnBUM=
X-Google-Smtp-Source: APXvYqwciBBhLealMEWoo9KoEMacGgV/WZH2VTZ4SCan5a+9yYr+272BEeKH1BEVWPC4FCthWzaq/J27w407jXSF4NM=
X-Received: by 2002:a63:bc02:: with SMTP id q2mr24517139pge.174.1582070930907;
 Tue, 18 Feb 2020 16:08:50 -0800 (PST)
Date:   Tue, 18 Feb 2020 16:08:12 -0800
In-Reply-To: <20200219000817.195049-1-samitolvanen@google.com>
Message-Id: <20200219000817.195049-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200219000817.195049-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 07/12] arm64: efi: restore x18 if it was corrupted
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
2.25.0.265.gbab2e86ba0-goog

