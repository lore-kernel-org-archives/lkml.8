Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2C1C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384652080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vpdo5MHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgEFRGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729414AbgEFRGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:06:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501BBC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:06:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 186so3366031ybq.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=38D9XAXV7mzVHBBpOcAS7ARBaUBu+dmzE+ZxtJSi07k=;
        b=Vpdo5MHEmM/Z+zw+EZQC/et7d3BOBcK04yt396UAXf4EYchp8p81hgVpWWHHtvD+dw
         VKpdIoiUMGfavJAcMjRkTu/ew5mzMiMbAuESyzFmO94XO1clTnQNFqO9TXMTprL2jAhb
         5nR3rK+jblYJcry7j/dtvDXsLOAJu+I8EiljrGJAF+IkMFzLIvd+AZlbAmKHEoHeWIbn
         quoFL4QuPqfcAuLvFlpaEon62y3uS+iWRxLU+zbJ15Muo5P7sXmSSTvqt6g78AQ0W+2B
         Wa6KcU8oXNrKFVNBpecTO+rJjMjVL3kXNuSghLpR5TN0h4Ww8tbIlo4M4snmTdg1O/js
         xF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=38D9XAXV7mzVHBBpOcAS7ARBaUBu+dmzE+ZxtJSi07k=;
        b=K4iLuyCFAahVAvfV8WeHGw5Z9M7dFJQdakFBpkbXiSH426UQaDT+ep0eUT8TIIzlNU
         cu/oIZ30lbg233JP76WMDxdcaHc8LKHF7ap0ZMznmggVcqmnL31BZWzXVPkixwoJvYj0
         /bBA6Q34NblP/ddZi0T5eVuKi/6DgrjpL9NYfpwo5uMsgnSgM1cddCv0k2HetlR7tmSW
         dMK0INFBC/6BYA96ma/TWBzi12ko73Ms7AvKn3DBoSo2GKTkxV8eUs9d/E/AdwOxbF7M
         BlnHMRF4n8bsBs3PWjDWAg6gwrohyUCousTGzV8xSClNvtVYR7OEsqxm6temcSljJnBz
         +JLA==
X-Gm-Message-State: AGi0PuZeOKkoi5OKG1NChAMM+iblLCOr78OsynUelxKutjY0pMqw7mzD
        04pz9DHv+mjfMgRYR/PJj6iOr3Ql4PoQxtWKe6o=
X-Google-Smtp-Source: APiQypInt/BU46jq8wi/ZYhimpxLP1JDFvRJo0w9nF7/qQSi68WKYGdFx2xxov+fb/dQbp4j01QIGkm7s+50ON1DxsY=
X-Received: by 2002:a25:3555:: with SMTP id c82mr15199015yba.378.1588784761448;
 Wed, 06 May 2020 10:06:01 -0700 (PDT)
Date:   Wed,  6 May 2020 10:05:53 -0700
In-Reply-To: <CAHFW8PQ1jusUS9xNUmiwwTU3x=GCqL3AJwwirhJOAgZUjx9wVA@mail.gmail.com>
Message-Id: <20200506170554.54635-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAHFW8PQ1jusUS9xNUmiwwTU3x=GCqL3AJwwirhJOAgZUjx9wVA@mail.gmail.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v2] x86: bitops: fix build regression
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Axtens <dja@axtens.net>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilie Halip <ilie.halip@gmail.com>

It turns out that if your config tickles __builtin_constant_p via
differences in choices to inline or not, this now produces invalid
assembly:

$ cat foo.c
long a(long b, long c) {
  asm("orb\t%1, %0" : "+q"(c): "r"(b));
  return c;
}
$ gcc foo.c
foo.c: Assembler messages:
foo.c:2: Error: `%rax' not allowed with `orb'

The "q" constraint only has meanting on -m32 otherwise is treated as
"r".

This is easily reproducible via Clang+CONFIG_STAGING=y+CONFIG_VT6656=m.

Without the cast to u8, gcc and clang will not select low-8-bit
registers required for the `b` suffix on `orb` and `andb`, which results
in an assembler error.  Without the mask, sparse will warn about the
upper bytes of the value being truncated.

 [Nick: reworded]

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/961
Link: https://lore.kernel.org/lkml/20200504193524.GA221287@google.com/
Fixes: 1651e700664b4 ("x86: Fix bitops.h warning with a moved cast")
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Reported-by: kernelci.org bot <bot@kernelci.org>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Suggested-by: Ilie Halip <ilie.halip@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* change authorship/signed-off-by to Ilie
* add Nathan's Tested by/reviewed by
* update commit message slightly with info sent to HPA.

 arch/x86/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index b392571c1f1d..139122e5b25b 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "orb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" (CONST_MASK(nr) & 0xff)
+			: "iq" ((u8)(CONST_MASK(nr) & 0xff))
 			: "memory");
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
@@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "andb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" (CONST_MASK(nr) ^ 0xff));
+			: "iq" ((u8)(CONST_MASK(nr) ^ 0xff)));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
-- 
2.26.2.526.g744177e7f7-goog

