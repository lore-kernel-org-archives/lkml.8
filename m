Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845B5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8F1206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwOWdDcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391766AbgDNQdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391745AbgDNQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:33:09 -0400
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CC1C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:33:09 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id x14so172770vsn.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=C/WMPxWmNKBqJ/Zz9SNZ/9dLp/Pjl7eWvbmkGXyv5l8=;
        b=gwOWdDcr8K2xj9bCTj7H5OL85GAIl6qKwa9aYWhyWu1Rn5CPfXHvSHlcLupYSb+aNy
         Hhvbi7HVhzDRTVj1FQJhmoVvVW0EJ45dX1P6BDPkSE/+XklQDRWskVCf0zeCRRdQvXog
         iBOjzhbsYUBtOdcFJnwtrxajIPEzSc58MWMoqofCIGjCmQuLE4DKZhCRSNAydisOSAhj
         ILLq36JK5Ke6AD0l/kg/Z6WzFiIqOig6iBOEeLGDDrBw762y0GBLAH+Bb0+ynatGlrkS
         C+e9T2LfS+F5yZTVUFEwAnkfN0fe5gOmUNc7Bcu1aYgve/Lj9EmOsoX83Q5BObCWGYjs
         0M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=C/WMPxWmNKBqJ/Zz9SNZ/9dLp/Pjl7eWvbmkGXyv5l8=;
        b=BFjyM1ZzKOEEsC5PetRhaHNFyjlfGzNMNC2BXd0r9iIuJnW/IV9szMzwcq8HMFNOo+
         UTtfnZEFi3Q7dCgvqn+CbGdzlMRk93txQjIm/mI+luWeZC7sZJe1cEl+RkkfDGcUE4Hu
         8CuqkVX4qg4DzE/pqE6w5s6ovvp56nc3mICxPj1/mt71WAJfez73eJOrqqwBTZs9e30y
         gCdzJIapg6cfCygolZl7UMQqEFICARgpHYaAQONjvInz3zPqJ1TqoNXSREJZ0dNYgIgv
         7sxaAp55GY/InGTwgZpibWjwfd/kWvU6VHquWrVi9BUu66Sa5GI3Y7fm3UAE2H+pfU/W
         V65A==
X-Gm-Message-State: AGi0PuZq1btV7YxA8uExi5Gsi8Urlz8w7USd4cIRush9FgyWYMOA6zNQ
        0SOVSKI5GjddnDMBn1mr3teHo0cTunl1
X-Google-Smtp-Source: APiQypL2292vcdQOPgM/pbOZPk9A8GWPQ48YdWAzRpisGiQjViIba//xyUIANE+PSCLKQ5rg8OUQVFnSzjm+
X-Received: by 2002:a67:2284:: with SMTP id i126mr890118vsi.223.1586881988191;
 Tue, 14 Apr 2020 09:33:08 -0700 (PDT)
Date:   Tue, 14 Apr 2020 09:32:55 -0700
Message-Id: <20200414163255.66437-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v2] arm64: Delete the space separator in __emit_inst
From:   Fangrui Song <maskray@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Ilie Halip <ilie.halip@gmail.com>,
        Jian Cai <jiancai@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In assembly, many instances of __emit_inst(x) expand to a directive. In
a few places __emit_inst(x) is used as an assembler macro argument. For
example, in arch/arm64/kvm/hyp/entry.S

  ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)

expands to the following by the C preprocessor:

  alternative_insn nop, .inst (0xd500401f | ((0) << 16 | (4) << 5) | ((!!1) << 8)), 4, 1

Both comma and space are separators, with an exception that content
inside a pair of parentheses/quotes is not split, so the clang
integrated assembler splits the arguments to:

   nop, .inst, (0xd500401f | ((0) << 16 | (4) << 5) | ((!!1) << 8)), 4, 1

GNU as preprocesses the input with do_scrub_chars(). Its arm64 backend
(along with many other non-x86 backends) sees:

  alternative_insn nop,.inst(0xd500401f|((0)<<16|(4)<<5)|((!!1)<<8)),4,1
  # .inst(...) is parsed as one argument

while its x86 backend sees:

  alternative_insn nop,.inst (0xd500401f|((0)<<16|(4)<<5)|((!!1)<<8)),4,1
  # The extra space before '(' makes the whole .inst (...) parsed as two arguments

The non-x86 backend's behavior is considered unintentional
(https://sourceware.org/bugzilla/show_bug.cgi?id=25750).
So drop the space separator inside `.inst (...)` to make the clang
integrated assembler work.

Suggested-by: Ilie Halip <ilie.halip@gmail.com>
Signed-off-by: Fangrui Song <maskray@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/939
---
 arch/arm64/include/asm/sysreg.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index ebc622432831..c4ac0ac25a00 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -49,7 +49,9 @@
 #ifndef CONFIG_BROKEN_GAS_INST
 
 #ifdef __ASSEMBLY__
-#define __emit_inst(x)			.inst (x)
+// The space separator is omitted so that __emit_inst(x) can be parsed as
+// either an assembler directive or an assembler macro argument.
+#define __emit_inst(x)			.inst(x)
 #else
 #define __emit_inst(x)			".inst " __stringify((x)) "\n\t"
 #endif
-- 
2.26.0.110.g2183baf09c-goog

