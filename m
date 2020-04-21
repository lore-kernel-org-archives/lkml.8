Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6A9C38A30
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58EA22240
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAQ83Kje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgDUCPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726893AbgDUCPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:15:11 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07921C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:10 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t18so5392868pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jhbZSy8N7pmIKGLCoqfuWjSb1n91/ddT1S0YkqMO/sE=;
        b=kAQ83KjeKeymPxC8tFl9LqSOU09wryYOH3Ut5Fp4QtEqnkFBqwDOtM03kprDG/MYPB
         33Qtrj9LQFkGfgRCPCzwJjXpwrT0xmeHSdgRANOUBywF6AxQjg0dKXVmnr0qSWtz50Oa
         bl6qbQyPLNSvkLhEhv06EXy0JtnPBS5QDsma3dbrpedM0dagK+Aiza6GlknaLT2doark
         A4f3m3SHS8DuK6cZNIyUA6UW9ibFykjSJfV8R5iVG2Qz33IqVpOrx5YHGsY9lc6LoHU+
         hVBFXM0Zwuqzbb8qvTwTgmmU/ReSXVtmuKGFUe3ewBrMDv3cClvqp6ELYlJQekoGEWrC
         3irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jhbZSy8N7pmIKGLCoqfuWjSb1n91/ddT1S0YkqMO/sE=;
        b=EGunVGj+Y6FPxyxwQJbtS6JjC+zZgQAq6A4dvD1Tch9BwF8C09RDG8uqajfpXd3eLp
         vZd95oDHaBV3UnBynaQQ08Fa3lopOzKe9FG8Y1p6G0XOb9ylE++3d3p6l1HHkl13bBSj
         nIubXI6EbDt2rzM3hA95t1gkqNfx+zX0qDHwR0UMcHPS7oF+IRV5HMiKwiFZAwVwpR+w
         P0WryI9gO+E/46SGFliLZZCzwI7o3RwIeIdVpmE6E3zYQ8nKFG0nKh68xsG1mZhXU9/m
         Kf6cUJcb0CIfMWiQK0cN73kdXb6OHgE3KPinye5uMA0Jjl6pCGoX/zGJHvm1dTIi28au
         sWJg==
X-Gm-Message-State: AGi0Pub6hBSLXoqr0FakNCqTfJKy+VHGOtLRbNAt6666QSiAEvYUhmhz
        6vXB6pN/NYXcG8MMrlnTsmxw5ueTcqxpkykd3Fg=
X-Google-Smtp-Source: APiQypJeQ51GKYTLWGJ6SQJrs5z0xMQPs0pUmxT6pjND+5RZ1ua5OrG31eM4WHd76TQ1S9eC6oZk5PYVIh7OMeESRco=
X-Received: by 2002:a63:751:: with SMTP id 78mr5125628pgh.259.1587435309529;
 Mon, 20 Apr 2020 19:15:09 -0700 (PDT)
Date:   Mon, 20 Apr 2020 19:14:46 -0700
In-Reply-To: <20200421021453.198187-1-samitolvanen@google.com>
Message-Id: <20200421021453.198187-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200421021453.198187-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v12 05/12] arm64: reserve x18 from general allocation with SCS
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
index 85e4149cc5d5..409a6c1be8cc 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -81,6 +81,10 @@ endif
 
 KBUILD_CFLAGS += $(branch-prot-flags-y)
 
+ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
+KBUILD_CFLAGS	+= -ffixed-x18
+endif
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
-- 
2.26.1.301.g55bc3eb7cb9-goog

