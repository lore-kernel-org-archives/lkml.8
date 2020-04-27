Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6AAC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C69D206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiSv8CiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgD0QAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728517AbgD0QAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:00:42 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B4C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:42 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g55so20998081qtk.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vWKjMu4YpZkMxmoaABUBOKf1igZnxFZ9c3Ig1J3O4Og=;
        b=kiSv8CiUDdv0MhnhG7OLvK4HRjHRHD2p5Xk8z4MNjfWWTLx6u3zwpYo+VXYo00s9lQ
         2SiB14ebJv+tpR/lJ6lBiS6NtwBJkpElgf6+/UxLuf4ODhwnkipaZqAOpGAlWYJpWfCS
         z/5ymvrE+OkDEIiguUTShhBQhJ6y715cKJGNQcwyaJsde7L0h/IXtozn5mtgfyeHg/Ym
         H43sTz24QuaAjK8JJGNtzpBldyBrDbq8uPivT4CI9K7/qC+hhiObIxt3J7MJfK5BmrKL
         +bLkpaJXkzjZcdx/s4M6wTt3HBXcwxs7ZUVUd46Y+nf5P0oIYdPegXdb9NdLI9tk1xzd
         GS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vWKjMu4YpZkMxmoaABUBOKf1igZnxFZ9c3Ig1J3O4Og=;
        b=Pi/T2rKc82HAxJg8rAcGSw6/67KDaFiMatumcsqbBeLJK7N0bbqRraGA93NpVXF9/o
         hYtyC3NB6bFGA8lnkE6b5bzrvcoFTDP2F1TwAu5+Y3LkSy115Vi7qv3Vwb+th6vt1oTp
         xiQu8iMtGKw58TC0AmqPKfsUuHh2nRn9A/5XjTOX5ccsQWH5je3lngpCDaJy5A6sGStw
         rYIxBscyWMdbmt5JL6F447o73qse6gouICJ+n5y+aJj9+wXR9G03V4GGA4/97RVc4qnM
         23Yvm1NHQXYCFWbMsPwhpeEKUc9UfOCgpre85tC19jqAwKBmt6eshkE/fChb7KpzDD+y
         fexA==
X-Gm-Message-State: AGi0Pua4eGSaiv1YEzmcbLQKWvCgDJigKQRbQDhc1Y9hTxxDoToSf+2/
        A7WF0Ik8BCLolW/bLqe0s3lppxZtmT1IoKOtlm0=
X-Google-Smtp-Source: APiQypJpHxnUVa+HJ+OCdJz02DOHfWXmMr67lw1U6ExG9PpcAMVbKyAwbyBII6uQ9n51wuhyBZXu9qOSoWBoJcrJ8Lg=
X-Received: by 2002:a05:6214:150e:: with SMTP id e14mr23211009qvy.65.1588003241754;
 Mon, 27 Apr 2020 09:00:41 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:00:11 -0700
In-Reply-To: <20200427160018.243569-1-samitolvanen@google.com>
Message-Id: <20200427160018.243569-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200427160018.243569-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 05/12] arm64: reserve x18 from general allocation with SCS
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
2.26.2.303.gf8c07b1a785-goog

