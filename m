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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E897C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173FB20857
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGvQz7rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgDPQOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506859AbgDPQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:13:03 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FF7C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:13:02 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l1so3158777pld.14
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jhbZSy8N7pmIKGLCoqfuWjSb1n91/ddT1S0YkqMO/sE=;
        b=aGvQz7rpj1gmlNot9DGOyVfFExMSMhcz9FOTIfJbSo6J2eaS4Q9EvaTX97Nd1b7Is2
         Bi/uzVXKD8nyy0gdnni7g4rNQaOUONSHCDbXi1JxVmjuSDUSR9C3hyS6ONRIgdqe5A7o
         KRFqaiwPkP7F+S6duXdhRB2xtAeRc18dKkptU+TW+VkoS72brWS3gLP1uLJyWKMa1apq
         6GOIGu4r7BbAhSSQiEldxlhfcpZpwS7Ujq6MBf2bUhjBlcqdRF1nhMsPi7t9S8NV1SxC
         8eUuHSdrmpT1WtCHfSF0mYe/M0/QauT7xIFnKzHxZWJuc08m/q50qVVerwI3cu0X+K2t
         149A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jhbZSy8N7pmIKGLCoqfuWjSb1n91/ddT1S0YkqMO/sE=;
        b=G4cX/L/cevo3lyH20+6ca5pjUAlePX7BF+Fm25uURQv27W2g5d9yHIZTcYfHAaTLeH
         2rJ7rxb8HBq880I2Envb2Yf2yfT0ti+JvExDVh7cpm2vmZh9A/pzkdsA/3hClbsmqeD2
         sqhHcUPDoIMb9FxbEunbWxt8XsBBB70ru0hnCLGnHHrS/MEbP6KLrJ2XkinKZ+NbrmBP
         vIYoTIS2/KKIBtemaVIghNh+jDsRaavW8E7zXDb4mXRxZjeJjE3XwWOE/nPYTzjps1xc
         cxf9ScAieVPPHqaGVdDSbwb51g8EwwuiZqxsqGXTy9T83WylgB0t0E4R0C5b+8MhjGSz
         CQtw==
X-Gm-Message-State: AGi0Pua7hald+gopWTZFCS9HTnrL95BCwSEmZqV9BVu6l8LrKXM5X35u
        Ep7K1/kG4fwywHUS5isdQDWK93PG9ZsL0Q0vBqI=
X-Google-Smtp-Source: APiQypL8a8EcwgkAdr2i3smmJxOyKHY3RiUFRcgoCxLBedFlxJV/kyUEcY4a7Jl+ITX16xXqRHQjeNwR/jbT4qE4WrI=
X-Received: by 2002:a65:68c7:: with SMTP id k7mr33098346pgt.248.1587053582058;
 Thu, 16 Apr 2020 09:13:02 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:12:38 -0700
In-Reply-To: <20200416161245.148813-1-samitolvanen@google.com>
Message-Id: <20200416161245.148813-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200416161245.148813-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v11 05/12] arm64: reserve x18 from general allocation with SCS
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

