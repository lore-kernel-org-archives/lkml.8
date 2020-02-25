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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F47C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E1B20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcZDangc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgBYRkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:40:00 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:46144 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbgBYRj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:39:58 -0500
Received: by mail-qv1-f74.google.com with SMTP id l1so46985qvu.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=euAiLk7SvDA/PnGZzpLLTI9flOv+YzdznFtW1y3XFgk=;
        b=rcZDangcxdPLQ8c/UeSJooK9TmmcaDC40GzTyXoR+zBGLCamuGVic+lOltfCliyqYp
         Qy8x3/XWiF5TB8IYJLOgBrOoaX/kfXC+FQpjknL3PmAvzLsHKIG8DFoA74qXXIQXcNUZ
         0OPMc9Q6heNg+Um6Kgciy/F5zEx8rAtsKgU3ZM7obRhY5/2A+Kk5A2CEjGk/5z4KifOG
         9Z6jS9mj4n9vzgOcBl5JrDZVyk1nzFBi2cDuhhMmE7njtr4mtFSRw2VEqaau0AxfNwT+
         T7LcR9LbC/GlbWKawMf7nnsCnVxQ4M+uxzYY1Vt1qL5/aWpfYaqxMkUArMyYV5gLmZTm
         3Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=euAiLk7SvDA/PnGZzpLLTI9flOv+YzdznFtW1y3XFgk=;
        b=N3nqoPyZz2XKFA1UrMsK7BGfwZiNDQhykfDuzguAOiUv6SD32iXDFKogPGylAxOgvn
         5WA9cCxN0KtiQ47V6DCFUM77F+1NDfW0Nks17agyL9AVy2bmYAAfoFOJ+a+JN8sB0k9X
         3b7x7f2eGYQ5/i51eSIHFZlS5BCP26IyNvSjc2lc5NaTsUaWtiM4opeCxjh5PO7Fd5Mr
         G7u/+4pyvRt/dQgpmX0aeB7cTOl8Ge88MmS0qGPcI0I3ZQHl9BeWjCdbpAxgMcYaGFmt
         l4o1pbTdvA0O0NYEA0KA8M4plFNvMZvA8W9gMBmbbJqRLcdQ2WuLPvETNwKqbuQy3DgM
         /FOg==
X-Gm-Message-State: APjAAAU1O728dVHkACBHALbh38NAfAzMFezQ66tkMymHYtVTE29wXXBf
        YjK9JzrvvTFvcDMMYYHJtyAId6dIl/mTrqFS9k4=
X-Google-Smtp-Source: APXvYqxlqJxQl5BI1MzivwW+BHpAHu+yoCC0b4OSIv8tWhwsj+eyaqOdONKRweH1H/aDrmbR0wf2esPZBfRljhjv3g8=
X-Received: by 2002:ac8:3aa6:: with SMTP id x35mr39983775qte.38.1582652397221;
 Tue, 25 Feb 2020 09:39:57 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:39:25 -0800
In-Reply-To: <20200225173933.74818-1-samitolvanen@google.com>
Message-Id: <20200225173933.74818-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200225173933.74818-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v9 04/12] scs: disable when function graph tracing is enabled
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

The graph tracer hooks returns by modifying frame records on the
(regular) stack, but with SCS the return address is taken from the
shadow stack, and the value in the frame record has no effect. As we
don't currently have a mechanism to determine the corresponding slot
on the shadow stack (and to pass this through the ftrace
infrastructure), for now let's disable SCS when the graph tracer is
enabled.

With SCS the return address is taken from the shadow stack and the
value in the frame record has no effect. The mcount based graph tracer
hooks returns by modifying frame records on the (regular) stack, and
thus is not compatible. The patchable-function-entry graph tracer
used for DYNAMIC_FTRACE_WITH_REGS modifies the LR before it is saved
to the shadow stack, and is compatible.

Modifying the mcount based graph tracer to work with SCS would require
a mechanism to determine the corresponding slot on the shadow stack
(and to pass this through the ftrace infrastructure), and we expect
that everyone will eventually move to the patchable-function-entry
based graph tracer anyway, so for now let's disable SCS when the
mcount-based graph tracer is enabled.

SCS and patchable-function-entry are both supported from LLVM 10.x.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index a67fa78c92e7..d53ade0950a5 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -535,6 +535,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
 
 config SHADOW_CALL_STACK
 	bool "Clang Shadow Call Stack"
+	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
 	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
 	help
 	  This option enables Clang's Shadow Call Stack, which uses a
-- 
2.25.0.265.gbab2e86ba0-goog

