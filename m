Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89706C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595BF20825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jNC1/Oxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgH0UgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0UgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 16:36:16 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2D9C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:36:16 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 130so5227154pga.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HHXt/e3Y/DBXqTOlWL3tdRnya/aQz5KwWbw/CbYxzno=;
        b=jNC1/OxovNEwVedmoS/Prz/A5pGiPz6dHyPI3ourIte//Xk38vIQ6df4R1+Ojlkdci
         d2EdpmSF4Ex3jKn0ytCVQtKn3RQsiQbqwSzOCNutVbdIZiz/Y2myioT/3dA3I5XnLbFF
         DXBS60XqKI+PFMyVaBAkojt1gep/mXGR76p7IpNdn7VeOMFzHmuC+OncFBtom7NhLa7M
         vhbOwahe/he/L1s1iBxmRtFFPCb6loHmqblzo/4OIkS/gc9CSpWPdmDHbrc0WrQWxvof
         8Ni9R29ug7Q2Yp3+uOI61Bc/TzWESDizDP35GGyLI7EZdX2N4TvFkzN5XzjGElMSnd3X
         6OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HHXt/e3Y/DBXqTOlWL3tdRnya/aQz5KwWbw/CbYxzno=;
        b=kkGSRrH/eauE4npYFTVcJosgPPxzNOaE3WTdBawt2yIzS9Pt626gE5JMEZZ3f8RF/c
         beMdzY6mWqU8P0bHvZpFJvqwQOHizChLohrsbVyxwAs5SYJdOj1sArGND1K7ieu12IVv
         PqGMk/60W+qbJd7QNO/37B1VvJPKsOhIcDxTs8QrlcH5uD2B3iaI4SsS3WJUZaPaINFO
         KRztOzlRbprBh0KgzoWBzAZXZthKebNXVBPObb8KtXY/GsY/VRnDFwg3TmsJXhRIXxaL
         M1LkyLou/QQzKXuRt3rNw/DL4mEz+g2JZdypwt+KXfCPS37IhOrkMMWRIdeTFp+Ur1Kf
         SbQA==
X-Gm-Message-State: AOAM531iRHPb2Zs5QYR1qo2wOlffBcgbtijpl1CAYV/qFwXAt16MGpUj
        /05NxhLFZJWxFI5KSRbWES6CyAp/1mwkbauu484=
X-Google-Smtp-Source: ABdhPJyxl5TMK2SUm9h46ZANnye/+5/WOOuR7KZgzWalZ6y5JkBzVInl5tRoHWGjPdbWuS4/cH+y0cdiqLsxV2zB3f0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:10f:: with SMTP id
 15mr18031937plb.232.1598560575542; Thu, 27 Aug 2020 13:36:15 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:36:08 -0700
In-Reply-To: <20200805181920.4013059-1-samitolvanen@google.com>
Message-Id: <20200827203608.1225689-1-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200805181920.4013059-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2] arm64: use a common .arch preamble for inline assembly
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7c78f67e9bd9 ("arm64: enable tlbi range instructions") breaks
LLVM's integrated assembler, because -Wa,-march is only passed to
external assemblers and therefore, the new instructions are not enabled
when IAS is used.

This change adds a common architecture version preamble, which can be
used in inline assembly blocks that contain instructions that require
a newer architecture version, and uses it to fix __TLBI_0 and __TLBI_1
with ARM64_TLB_RANGE.

Fixes: 7c78f67e9bd9 ("arm64: enable tlbi range instructions")
Link: https://github.com/ClangBuiltLinux/linux/issues/1106
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
Changes in v2:
- Switched to a standard preamble for the architecture version.

---
 arch/arm64/Makefile               | 11 ++++++++---
 arch/arm64/include/asm/compiler.h |  6 ++++++
 arch/arm64/include/asm/tlbflush.h |  6 ++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b45f0124cc16..20ab5c9375a5 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -82,8 +82,8 @@ endif
 # compiler to generate them and consequently to break the single image contract
 # we pass it only to the assembler. This option is utilized only in case of non
 # integrated assemblers.
-ifneq ($(CONFIG_AS_HAS_ARMV8_4), y)
-branch-prot-flags-$(CONFIG_AS_HAS_PAC) += -Wa,-march=armv8.3-a
+ifeq ($(CONFIG_AS_HAS_PAC), y)
+asm-arch := armv8.3-a
 endif
 endif
 
@@ -91,7 +91,12 @@ KBUILD_CFLAGS += $(branch-prot-flags-y)
 
 ifeq ($(CONFIG_AS_HAS_ARMV8_4), y)
 # make sure to pass the newest target architecture to -march.
-KBUILD_CFLAGS	+= -Wa,-march=armv8.4-a
+asm-arch := armv8.4-a
+endif
+
+ifdef asm-arch
+KBUILD_CFLAGS	+= -Wa,-march=$(asm-arch) \
+		   -DARM64_ASM_ARCH='"$(asm-arch)"'
 endif
 
 ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
index 51a7ce87cdfe..6fb2e6bcc392 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -2,6 +2,12 @@
 #ifndef __ASM_COMPILER_H
 #define __ASM_COMPILER_H
 
+#ifdef ARM64_ASM_ARCH
+#define ARM64_ASM_PREAMBLE ".arch " ARM64_ASM_ARCH "\n"
+#else
+#define ARM64_ASM_PREAMBLE
+#endif
+
 /*
  * The EL0/EL1 pointer bits used by a pointer authentication code.
  * This is dependent on TBI0/TBI1 being enabled, or bits 63:56 would also apply.
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index d493174415db..cc3f5a33ff9c 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -28,14 +28,16 @@
  * not. The macros handles invoking the asm with or without the
  * register argument as appropriate.
  */
-#define __TLBI_0(op, arg) asm ("tlbi " #op "\n"				       \
+#define __TLBI_0(op, arg) asm (ARM64_ASM_PREAMBLE			       \
+			       "tlbi " #op "\n"				       \
 		   ALTERNATIVE("nop\n			nop",		       \
 			       "dsb ish\n		tlbi " #op,	       \
 			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
 			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
 			    : : )
 
-#define __TLBI_1(op, arg) asm ("tlbi " #op ", %0\n"			       \
+#define __TLBI_1(op, arg) asm (ARM64_ASM_PREAMBLE			       \
+			       "tlbi " #op ", %0\n"			       \
 		   ALTERNATIVE("nop\n			nop",		       \
 			       "dsb ish\n		tlbi " #op ", %0",     \
 			       ARM64_WORKAROUND_REPEAT_TLBI,		       \

base-commit: 15bc20c6af4ceee97a1f90b43c0e386643c071b4
-- 
2.28.0.297.g1956fa8f8d-goog

