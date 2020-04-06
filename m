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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBBEC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CD02496D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Et7gqyUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgDFQlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:41:47 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:53732 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgDFQln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:41:43 -0400
Received: by mail-pl1-f202.google.com with SMTP id 2so81513plb.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9QG25IWAvZkbAzL22nhTW74bT1ay/PnpyS4BHMHWGZk=;
        b=Et7gqyUD+/vBdaTxuXGtUp/T61DuoxfIWoFaBtN3Pan+9c6mJeAvmtTBqFUxV+t/h4
         LN0HQT9+KjSaqn7Mixerv+7k7S7BD4mkDsLs/o8wZMIjVa09HJA7KFSGB/TtuXU7FvlL
         6uPHdyBl7z3cK9g1xF6YKJ4HL90gk6SiklDTGe+TeqWBho/vNNZIxuxtDhoiNjjP56EE
         VSD6bCJZy8gm1psKtCCT8FCp/6jDu2WpsQ5TdwxuxinTh/gByzaJiThF8xLLt1HhDfgN
         opEo0Vvbom6U7ovVNJ2IYajd7Ohq17yrtIacfoTmqzq2KcnP242dGSb7nqvNQr4W2sOL
         fQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9QG25IWAvZkbAzL22nhTW74bT1ay/PnpyS4BHMHWGZk=;
        b=KVihb4EiKGBzRPpcKDBVnGIlnfYcHxO12h7HFYx8GeNNDY32/RLozdsxFZ9SDM6HDm
         qqJKRaWiyZBQeh2MtC/CEm1OAQJ+YXUgx3ljHdqSmOuPMCeXIpcV1j6eRywlJVTxtTEv
         9WTUGQ4ZzVsVNjznkpd9t02V28ZHwiu7NBuZuxmcQ4Trg1quRBPnX92bm7hrcAnDZrYh
         MgDBCs0S6YStdKXFEu4p+XY42H1GLuvr45PJ3AHs9yXUBj8vRTeU9INLJfuW+SojbL13
         RaW0JJiEQUcq3ujYDSuCAMKKvnNJuwgQPRNXxex8halzX0efs/u52spBwgLa5bovVjWm
         ci3w==
X-Gm-Message-State: AGi0PuYGPAbinQ3dp+fb8+dp786dgCfkuBTSsmxRlLvZkWlM8+LaHHF+
        u3bn17dO+jBqDhw42Sgd67I53N0IWzGeGwcQLrs=
X-Google-Smtp-Source: APiQypKOUCwdutCrbx5jsB7oXvfPBtLmcNStpAuGEoVRC2rwC/xHSN2ipZVV7C3tJFoLyJ5tV7qmBNnr17/luexyr1s=
X-Received: by 2002:a17:90a:1b4f:: with SMTP id q73mr169352pjq.188.1586191301528;
 Mon, 06 Apr 2020 09:41:41 -0700 (PDT)
Date:   Mon,  6 Apr 2020 09:41:13 -0700
In-Reply-To: <20200406164121.154322-1-samitolvanen@google.com>
Message-Id: <20200406164121.154322-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200406164121.154322-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v10 04/12] scs: disable when function graph tracing is enabled
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
index 691a552c2cc3..c53cb9025ad2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -542,6 +542,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
 
 config SHADOW_CALL_STACK
 	bool "Clang Shadow Call Stack"
+	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
 	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
 	help
 	  This option enables Clang's Shadow Call Stack, which uses a
-- 
2.26.0.292.g33ef6b2f38-goog

