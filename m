Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529DDC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270672223E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLB6uGgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633696AbgDPQOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404738AbgDPQNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:13:01 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7DEC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:13:00 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 18so3398298pfu.22
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v+FpjDALSMEE3YToTyyoSh5dhgN0urRtPwHsB1+RBqo=;
        b=LLB6uGgi081g4dKc+3D/4hphc5jFZuDn5l3K/Cxtfcs3/rhIPXgTzCDJ4HjatU2B34
         JY4fNmY4l5JYswvESy2IHRhqnwuSzzW+BBMx2qv9Y+i4mCamy8HON5fMlGYrckrZs0zi
         zqYykbeZ1nK8/8teogXlHD/G+fEHWxaLjwONYJdsxpHLsGV/uV6CPYJuDeVcg/JjeiqB
         SSqMbSaUnpkdFmw7gIR6KIznWHRwY5meJ2DEzQesEEI4NungE9nWx22c6EzLC3ly+4jk
         MftpYNrj0up2ZWOvkRRAr9cuASUwgpZg2ADv9LJBOB+WmvPbpOHT0hNO3fPOr3IaSvnm
         7NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v+FpjDALSMEE3YToTyyoSh5dhgN0urRtPwHsB1+RBqo=;
        b=OERkFddeNNv45qYYW3uau4UfHTAfzUhLoC1y62PIfN0XjcI/w7z0uPvRMc85oXPJRZ
         17eRUIQEp1z1d2mATRepihwJV+JEx8OgAe9MOPlOWUdkf1HdvJMj8NXfDq9wUlZBibXD
         oRnIMUGMrrH8ovaRfOQJs7m+awd8fEr3yuvz5ThtGXw6sAGcvDAR/i/Xp/1njsQ9cXJM
         Oq6EGVzO97fkHF37FcmVcd8GoYwVlSuyWI/rx530t2sBWJeUikLQZ7+2hTrn9MD8VTgk
         Z+KitzGDmtEe6rT9Kfebqo74DxTg2Mu7fZ21qx5G3ht2Ei97JXpGN6YXqcZ1W0lDMsHk
         vTCw==
X-Gm-Message-State: AGi0PubL+2aNxTQO4cGk8ajn8C3Yqaaffc76kCctyRSjHpSqBOzIhIw9
        Yclox09qKSefVysgMDz2kKph7ZgAMSBo9XRxdGc=
X-Google-Smtp-Source: APiQypJFs2LuRTbNsCDtN/g/2Dzd+U0S8ccpzr5nO2MdW7DPIurrW0+QxGuzgOdLZ6sO3fXFhdLkcQx/1PSGVXyeSjg=
X-Received: by 2002:a17:90a:8989:: with SMTP id v9mr6124346pjn.119.1587053579583;
 Thu, 16 Apr 2020 09:12:59 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:12:37 -0700
In-Reply-To: <20200416161245.148813-1-samitolvanen@google.com>
Message-Id: <20200416161245.148813-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200416161245.148813-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v11 04/12] scs: disable when function graph tracing is enabled
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
2.26.1.301.g55bc3eb7cb9-goog

