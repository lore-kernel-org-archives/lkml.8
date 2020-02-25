Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A19FC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0097620CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+O8aB/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgBYRkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:40:04 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34449 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbgBYRkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:40:01 -0500
Received: by mail-pf1-f202.google.com with SMTP id q5so9747702pfh.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jVKqEF9zEsFZTQz5E/s7PAlXyZsbPgu1MND2Fom4HAc=;
        b=V+O8aB/kkUO8xqMJE51PIQtZsppsJth+56C9mzqs3rHEUWYqsaBskb5C8HPCIPzcS0
         KLPMyT4P8jAjhfw3HtS6Zd2Bb5U4/swuVVbMREAIk3jxj7rYDCvJV69tJYOtu8AUZqQf
         z2JnJ+dqNTgOx86Zx5X0AKcPG1QBderHLqB7MhI+u/50ASt0GTaqJITfIYTKWJX1nDlb
         MH5KYE7gNzyqd1gGbRsR7gUtF6BdQMWSviF1MHJ423kF5K89MmBFjiBcyN5dmGhPgq/S
         lhVwlyp4UFisGTJT9QGrdtvE2NZMU8DEbTuhfkbOuZMSqCeD2QDwyktTVpa+TfqPqQwZ
         EwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jVKqEF9zEsFZTQz5E/s7PAlXyZsbPgu1MND2Fom4HAc=;
        b=bB0643tpw48pF10lIm5f4CF9ObcLJ4YLTmtYsr0DeLVWoTy9PuUAJrS8MEDcTxNTnV
         iX0sAKBHcjKLwdbceRaI6Pf2El7XR/TVzUPb3M1krrQZC3U/HgmdclY/GqVsp/M63N3v
         Akr0/+uIhltJF6cKW3TYcD6ZUjLW90h9et7D4T6sUWSn3m7V4H13X8LZkeGnDtCY+3f5
         3FixSqnuVs1QzrNoAz/lECrlgIhxwbHzBXsw1lFHMSz6Yi5zmttDv3B4ZcDKnFQs9MrZ
         pH7QSID5nhPg28alRs5uk+9RPZzaEirulC9A50pY5EaPufZBulCk8LqIVnEB48ZaCvwW
         qXyw==
X-Gm-Message-State: APjAAAVXDpKSIfln8HWUrtIVHg3sB6a3jGsEvf/GUshoDuVQwwxrjo1G
        hsn3HPjzuAAQYWBZw7AYxbp6xZYqUZUwUuAGR2A=
X-Google-Smtp-Source: APXvYqx9O9w9/ihBrjsk0SyFNaEZNd7Lr04/IUqXXK96nskmhLx3/ywlCS6EAR4FJpxoJjOrSsMx/Wn5T6BL4+LTzRE=
X-Received: by 2002:a63:e04a:: with SMTP id n10mr57879618pgj.341.1582652401052;
 Tue, 25 Feb 2020 09:40:01 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:39:26 -0800
In-Reply-To: <20200225173933.74818-1-samitolvanen@google.com>
Message-Id: <20200225173933.74818-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200225173933.74818-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v9 05/12] arm64: reserve x18 from general allocation with SCS
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

Reserve the x18 register from general allocation when SCS is enabled,
because the compiler uses the register to store the current task's
shadow stack pointer. Note that all external kernel modules must also be
compiled with -ffixed-x18 if the kernel has SCS enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index dca1a97751ab..ab26b448faa9 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -65,6 +65,10 @@ stack_protector_prepare: prepare0
 					include/generated/asm-offsets.h))
 endif
 
+ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
+KBUILD_CFLAGS	+= -ffixed-x18
+endif
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
-- 
2.25.0.265.gbab2e86ba0-goog

