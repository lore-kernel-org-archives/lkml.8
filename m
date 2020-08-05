Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F6EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D9C22CA0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7usL0VO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgHESUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgHESTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:19:31 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3763C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 11:19:25 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id c4so9506383qvq.15
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uiS4vK1ED9a+VphuuXYAfxefFTXitmOIurQShIFya8E=;
        b=b7usL0VOL7PPQfXINDo8SSR5TInSgE9RLT/VD3I8RopG0mUBvlQtznYdBEPztuPJ9U
         3keS4RjqtSWdqfSbLa4Y7pTcdCA9i9nOJce9Pw45+koPewzc9wEF5vEg5Lz3PCdpsAnl
         Q+ICX0WmjChTnMC3e3Pajz5ertwDBxhYdq7nEWOKN+rKuQIux6gg9yP6FcSF4EWLjufW
         mwe5GRvQI8xDDRGsF+1rzmIm/wizRihcSJ+Zb2fzs0wljgsgmaBfu+2tuauQE5+bTLOP
         88GoLKesxhmArXOPcwI5XqE1Q0EpSpJnT3WoAHX5/Ll5KOKYAXAuXjjePQ0wDKvb8Cea
         ommw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uiS4vK1ED9a+VphuuXYAfxefFTXitmOIurQShIFya8E=;
        b=pUKET2oi+pvJAMQH8Kc7XtDRJwB4XyOgBughnwG/ZarvF4ljZiiFkltgX2x0vJvypG
         jabPXiGJ6ohuFR0PjZ3+qTI5MyCgFDRNdRRzI9LmMUpQ45XYKqdxnC+CxzGcbCGkA4Qh
         L823rJicJo8sUECRhdvFjOtfL9hclY/hSW92t4mkqMdpv9mySAJUIFvAZufdOW7+P55j
         mqR68/EBSEt/eQFoHeSkTYtvp4Wicq6xIQf9nsvpxxS+Imtoy/XwFZp4J8xhFQD8MVqF
         A11+Z/4W4PoO2QcxtL1xzsfXMWEGrFrcD83wF95v8IkiLmX1OHD+mn2oixjsqIk15Eq8
         QUCg==
X-Gm-Message-State: AOAM532DxUvgb8UJsB9xQH4LkQDtK9yg1WjHyT1xTZxMgdeuetC3Fqua
        3qTPpQzioyyRzP6rbqDuJWfYqLsAinBlMRHn7H4=
X-Google-Smtp-Source: ABdhPJyQlgl//n+4oh/u/DXcrOj6zGvBkKmeLit3yZipK/1vtNk4x1r35x11Qpx6dqyegtQzgfRH5nJ0UHRADBro3FQ=
X-Received: by 2002:a05:6214:8a:: with SMTP id n10mr5030949qvr.13.1596651564177;
 Wed, 05 Aug 2020 11:19:24 -0700 (PDT)
Date:   Wed,  5 Aug 2020 11:19:20 -0700
Message-Id: <20200805181920.4013059-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] arm64: tlb: fix ARM64_TLB_RANGE with LLVM's integrated assembler
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

As binutils doesn't support .arch_extension tlb-rmi, this change adds
.arch armv8.4-a to __TLBI_0 and __TLBI_1 to fix the issue with both LLVM
IAS and binutils.

Fixes: 7c78f67e9bd9 ("arm64: enable tlbi range instructions")
Link: https://github.com/ClangBuiltLinux/linux/issues/1106
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/tlbflush.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index d493174415db..66c2aab5e9cb 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -16,6 +16,16 @@
 #include <asm/cputype.h>
 #include <asm/mmu.h>
 
+/*
+ * Enable ARMv8.4-TLBI instructions with ARM64_TLB_RANGE. Note that binutils
+ * doesn't support .arch_extension tlb-rmi, so use .arch armv8.4-a instead.
+ */
+#ifdef CONFIG_ARM64_TLB_RANGE
+#define __TLBI_PREAMBLE	".arch armv8.4-a\n"
+#else
+#define __TLBI_PREAMBLE
+#endif
+
 /*
  * Raw TLBI operations.
  *
@@ -28,14 +38,16 @@
  * not. The macros handles invoking the asm with or without the
  * register argument as appropriate.
  */
-#define __TLBI_0(op, arg) asm ("tlbi " #op "\n"				       \
+#define __TLBI_0(op, arg) asm (__TLBI_PREAMBLE				       \
+			       "tlbi " #op "\n"				       \
 		   ALTERNATIVE("nop\n			nop",		       \
 			       "dsb ish\n		tlbi " #op,	       \
 			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
 			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
 			    : : )
 
-#define __TLBI_1(op, arg) asm ("tlbi " #op ", %0\n"			       \
+#define __TLBI_1(op, arg) asm (__TLBI_PREAMBLE				       \
+			       "tlbi " #op ", %0\n"			       \
 		   ALTERNATIVE("nop\n			nop",		       \
 			       "dsb ish\n		tlbi " #op ", %0",     \
 			       ARM64_WORKAROUND_REPEAT_TLBI,		       \

base-commit: 4834ce9d8e074bb7ae197632e0708219b9f389b5
-- 
2.28.0.163.g6104cc2f0b6-goog

