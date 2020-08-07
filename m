Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0727DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EAC2075A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WoKT11jR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHGTlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:41:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89412C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:41:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v65so3995811ybv.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5n0w4AsANVZZcp3jIgW7OYwnXyM3bWVVuSXkfYvbUl4=;
        b=WoKT11jR5jq/vQb3JNLV25H6iflkXWudcxfP6rTqgMokNc8wuvhdV871BhnFNvsvhq
         qcUCcS3CyBMPMYSk00SqeMIFCim9HusgHp5n9bI/UVP4PKlenKWo5Ow+d98zN6ESLN1f
         ptGrXZMrKbm7sc+l+aI760IdJO+JrbC+N6J3qHbTqNd2vv/Erj9AoVGphW45V7pA0bYC
         ROFWsOCvNbBWZ5KmrSJK005wiXxh4RRVcqE1W6A7RN4OanMO/fF5ZnNW3fUOKEd0ZrPw
         db/osdd+sp9woxBRA+k9CuwBske9+y1Hbj7J0mB2Le4sNL5evawsrlaGNWRZQtsx6JVp
         r1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5n0w4AsANVZZcp3jIgW7OYwnXyM3bWVVuSXkfYvbUl4=;
        b=QIdxjkOU6LB+jEGxVdh7tOnY3Rys2OTnpRd5IyjTt+rdUX/bIIpGx+6rjNqnG5F+tR
         ayZXNa7wNRclvOBwiyvc/jP/MRQld2WjphS5rYeSdfQhIJjW7DxF8evQMF+GZc7YFEaH
         R9mquFrgUMLJUNlK8GGhJf9X/xzJ7qDbIbxdIQLnXrw/3vTzDMiiZq43KGFM7GEosHSj
         VrGboh+Qkc3agME/H5Q5YVRzBFZPqC8PTVqey/jpsw0eAgnFyVXaAgq33RuFv7FKcJhs
         mFF6g1qFnS8y/CsXpizpsgHWcKsfwWivIzkx9CJeb8j2mVuxFFPiazLWIF8fQBJzaFpM
         6/Yg==
X-Gm-Message-State: AOAM532CZqwqPV0FdSSgw2OGMBf7YfjpXJLz79pb8/kpNGLcMpnP/PV3
        pyWKHGwUqD/yhjB2Fsw5JCwQuKJVZh+vaX3BtCw=
X-Google-Smtp-Source: ABdhPJzHB9j8QRSntH63NyIOH3Co/ruEv4R6/7xZwQZKx/N+UI6YkVvblAovxmcitH8ymcMlGDm584LWnU0RrQFQP18=
X-Received: by 2002:a25:d8c3:: with SMTP id p186mr24793342ybg.50.1596829273517;
 Fri, 07 Aug 2020 12:41:13 -0700 (PDT)
Date:   Fri,  7 Aug 2020 12:41:00 -0700
Message-Id: <20200807194100.3570838-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH] x86/boot: avoid relaxable symbols with Clang
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Fangrui Song <maskray@google.com>,
        clang-built-linux@googlegroups.com, e5ten.arch@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dmitry Golovin <dima@golovin.in>,
        Marco Elver <elver@google.com>, Nick Terrell <terrelln@fb.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change to a default value of configuration variable
(ENABLE_X86_RELAX_RELOCATIONS OFF -> ON) in LLVM now causes Clang's
integrated assembler to emit R_X86_64_GOTPCRELX/R_X86_64_REX_GOTPCRELX
relocations. LLD will relax instructions with these relocations based on
whether the image is being linked as position independent or not.  When
not, then LLD will relax these instructions to use absolute addressing
mode (R_RELAX_GOT_PC_NOPIC). This causes kernels built with Clang
and linked with LLD to fail to boot.

Also, the LLVM commit notes that these relocation types aren't supported
until binutils 2.26. Since we support binutils 2.23+, avoid the
relocations regardless of linker.

The proper solution is to build the compressed boot image as position
independent.  There's a series working its way through code review
currently that does that, but it's unlikely to be backported to stable,
due to its size.  For now, cut a smaller patch that's more likely to be
easily picked up into stable, so that we can get our kernels booting
again.

Cc: stable@vger.kernel.org # 4.14.y
Link: https://github.com/ClangBuiltLinux/linux/issues/1121
Link: https://reviews.llvm.org/rGc41a18cf61790fc898dcda1055c3efbf442c14c0
Link: https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/builds/178868465
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
https://lore.kernel.org/lkml/20200731230820.1742553-7-keescook@chromium.org/
is the patch I'm hopeful for building the compressed image as -pie, but
I don't think the series will be backported. Regardless, we probably
want this for older binutils support.

 arch/x86/boot/compressed/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3962f592633d..ab0f7e7dabf9 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -44,6 +44,13 @@ KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 
+# Until we can build arch/x86/boot/compressed/vmlinux as -Wl,-pie, don't emit
+# R_X86_64_GOTPCRELX or R_X86_64_REX_GOTPCRELX relocations that LLD will relax
+# into absolute addressed operands, and that BFD didn't support until 2.26.
+ifdef CONFIG_CC_IS_CLANG
+KBUILD_CFLAGS += -Wa,-mrelax-relocations=no
+endif
+
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
-- 
2.28.0.236.gb10cc79966-goog

