Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC39C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C612467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iDoWJGqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgA1SuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:50:00 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:42127 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgA1St5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:49:57 -0500
Received: by mail-qk1-f201.google.com with SMTP id m13so9004283qka.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 10:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SyMS6kTKxjGvSfy1yskMuy1o1NPxNd1pRRReN/eh/Yw=;
        b=iDoWJGqwVEP2tHMWm4+bS9TCXvecvsiZmIGPR2wyOSJfmTsLMvUaQm2ursorFU3Ra7
         NuHDNghwRgHXAAk9m9KAPMbK4uTyIcT9xr9wE2QiZ1dUFfX57GqHyiEoehb3XJLjS98N
         YFNOY7pkup2SOO21fY5am9qSl3hqr7M+8fKeSXR1JT8QJuNrKvAgik306CX6uTTelKVO
         jSwC4WXDfkQ4RkIwPUjXYeg4cRSfyvTDlYYopLdqGGEns5H+6Co2aSHsmd2TRUBwb4ST
         Jn0rsT+JOm35IDm2DnWe8BFGBEW8Lny+TWpjqr/yQiw7tMRlFt978M/BMe3aSyd1G4ZY
         ck+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SyMS6kTKxjGvSfy1yskMuy1o1NPxNd1pRRReN/eh/Yw=;
        b=fg6JM4pWuQjKVeYtUIuG0eQDgKwoP9WbJm1Re4gTFpOyKOSri/Kdh7B2AOQLh1S7oN
         HJ8EsQluLkoIYB0MkqHpNVVv38RfANANN4RkdIdSPmD67eAoX8+UIQ3+bTew/9oANxnu
         Xi3AAY3MjRjVTl/PVUvodDucJhmftZPEbD/eJfkmjezcwgd1+KfElmIeeR+MYoR5Y087
         olaapKIuTfog5Futgo1JurWr+gKZR83/huJQ8ugfMIM4pcIIG2qN6pG6UA/YOKpJO9+l
         0nSo2usiEbBhgpcGsskR8dVCJhqtC7Ho4IY47Bl4EwYeAnX84hFYnC3xKMS1Ad+p8G7B
         zj/Q==
X-Gm-Message-State: APjAAAX23ZRiThGAnuyMtADtCcKcNmYpysOemynHonQcM+83mtsSCuX9
        80eRu11gQZ7hFDjdtz14ab/us2qRWCJrNg317ng=
X-Google-Smtp-Source: APXvYqwBDfyzeAgl4Hbq75PkVeA00YwL16x26LdN4T6C4RXjAAHG16RhCosHW83/V2HMDMrDJF1ZlFrzqFIRTexeGxM=
X-Received: by 2002:a0c:eacb:: with SMTP id y11mr24452398qvp.68.1580237396348;
 Tue, 28 Jan 2020 10:49:56 -0800 (PST)
Date:   Tue, 28 Jan 2020 10:49:30 -0800
In-Reply-To: <20200128184934.77625-1-samitolvanen@google.com>
Message-Id: <20200128184934.77625-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200128184934.77625-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v7 07/11] arm64: efi: restore x18 if it was corrupted
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
2.25.0.341.g760bfbb309-goog

