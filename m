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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66961C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B12422B48
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBtomVXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgBSAIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:08:47 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:39355 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgBSAIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:08:47 -0500
Received: by mail-yb1-f202.google.com with SMTP id y123so18770924yby.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 16:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jVKqEF9zEsFZTQz5E/s7PAlXyZsbPgu1MND2Fom4HAc=;
        b=YBtomVXuPE9YKWIcFgIRjcpY7OwDiCsLehztaXeVLAlEBdRDN03lZks7iNSYV/g7SR
         YxwyOOS2qE1ncX0EtkhevaGgA4eK4/d1kVR8Hg7OyAFSsLcG+8dnY5snFDfpsTQCIxxk
         Y1QycxeImvPDBmdy/cdMsuRQ2xS8Byv29lIb2/F1iUiQ5v3EISXk2V2SZMi7+fb/+sgz
         yIlIllB9gAQECO2n6q3OXLzyGO6GXq0pDWI7W3azU/OOkDwoEA2BZeS9Am6cgqPFhcwW
         o5TiUUKtIpgyX4x2xGMPYUpfPZtDjUB8KEwnztoM4IaZg/X+0h3EF1cv4rd2sQGo8WFP
         UaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jVKqEF9zEsFZTQz5E/s7PAlXyZsbPgu1MND2Fom4HAc=;
        b=lkh0sJmo3HhkvN8rmD+LjTEFectk0RVYrKo481nx5MSW2jbQPAGfxq7euy2lozR+Rv
         XOwlH22eqEctrN1bgB0im5TLA1PeNp+jZZDra2LOsAE9mi1KVBpu6gWV5+FZpM5UJ7Xz
         ogUZ49bOTQF5W3WGX8R0XcnOAFelUAxjs+ohtiRNB0YYI03Le/oyNROptuvby82GL7wH
         hv48u/N1w/BrJhtG0OYQ7s0yuynGVJhXlTgbI3LGeo3QSuyiAF7i2sZUyRvqzH+7j7/q
         2+wri3xjyWCnG/vs1Sb0P99S/tXhaRviKBOLoVJcrrdev8Tnw1ifEzcjGDB5YJdqWySE
         fTsw==
X-Gm-Message-State: APjAAAWWQDs5t6Ua+3ukztSAd1rOybmr7RvWB1b+710v94LWdK6pj/Gw
        nRTQKa3rDVJ9u4PRh7Nh354UQkbV+5dB8EL0OgE=
X-Google-Smtp-Source: APXvYqwoqUB80JmAoZThMz7yQ2pLfU65+z1jN6RLHc1bXGITJSutpnUGpHwwmYx4HZQIhCgNm8jd0wWugPtH2DIPEJs=
X-Received: by 2002:a81:57ce:: with SMTP id l197mr19086954ywb.235.1582070924606;
 Tue, 18 Feb 2020 16:08:44 -0800 (PST)
Date:   Tue, 18 Feb 2020 16:08:10 -0800
In-Reply-To: <20200219000817.195049-1-samitolvanen@google.com>
Message-Id: <20200219000817.195049-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200219000817.195049-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 05/12] arm64: reserve x18 from general allocation with SCS
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

