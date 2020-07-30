Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A87FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D0720829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bS33mlwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgG3Uvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgG3Uva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:51:30 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50F6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:51:30 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x20so11154855plm.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U0OUPTDRNGhh0ydoN6VkhJdiruQZ6OtwNxR4N39C4f8=;
        b=bS33mlwdf/DJIQD28epPbEI7pJZXa1xHzvIjvbrwJsYvNRprRL04EmCMO8BY7c7vyR
         ofLXj+EecJitrlsOgIRSeYox7Ze/fCWlAwsLoJGJXNxJhm1Jzit1E25lLOIc4Zq4SNtH
         vDVgxSSFKjr6Dev1jNeB+/y6/4/TPRX9evR1RJBCof4kAi7IzZUb1z4wOFHcPt1MDXS1
         UMmiVxWsDAo7fDiJWj5rZyAePJEpkaW+/xc4T//YX/DRcxFqZMlHsEZewHwkWf3ZE5Bn
         pEZzlVLo2QFc9P0WbNbGGnsimIfk/QgsbAfVHpxvfHt3Lp7csq8m7P0gUJ1850oZa06/
         oWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U0OUPTDRNGhh0ydoN6VkhJdiruQZ6OtwNxR4N39C4f8=;
        b=PgUv3NtfaAZGS8LwTjoaWZ/oyCysugre2kxHSBHNTpFkGGaeD6jPtB3Fbis7072XFm
         /QcIa/EYa0tXhivfgH63ypFykYcnOdbAJyxXifMU8qbGrPTEXbwi1eZS5huNnD9gNzid
         0EtFmQr/UEWlv7ga+03BQveTcPjR88Gh4TArCFRathJ/WGdi5FULTW3LcLVLCTYzz/Qi
         c40G7dnrKnDHtq7zmz4JlwPycQB2jKqb9acPFDl+1EGuTu63RCYwL8S1/BupHRwqoGv8
         vUNre9+L7X8CBXcV3vktmFka4bLDdOrzPJ+kybD1FCwee8dYUp0Ijsx2Gdhccr+cO9bQ
         wGHA==
X-Gm-Message-State: AOAM532kQ/cpI9tTJZeZWXhUx82y0DbXiwj+My/hjegayWW2uYFMHECM
        Mp6FWAXsFvzRJtmu+Gu+CwcrV/Ue5Ql3PmRN2RA=
X-Google-Smtp-Source: ABdhPJwCEyx+wmqrFUv640p8yJy8eY2sYOEIDXEj/DD5NDhOwWleNVqKa5yzVDKQryUe9mvaALl+3zlHBVcQT43pRDg=
X-Received: by 2002:a17:90b:4d0b:: with SMTP id mw11mr923395pjb.4.1596142290243;
 Thu, 30 Jul 2020 13:51:30 -0700 (PDT)
Date:   Thu, 30 Jul 2020 13:51:10 -0700
In-Reply-To: <20200730205112.2099429-1-ndesaulniers@google.com>
Message-Id: <20200730205112.2099429-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200730205112.2099429-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 2/4] ARM: backtrace-clang: add fixup for lr dereference
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Nathan Huckleberry <nhuck15@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        clang-built-linux@googlegroups.com,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Lvqiang Huang <lvqiang.huang@unisoc.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miles Chen <miles.chen@mediatek.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the value of the link register is not correct (tail call from asm
that didn't set it, stack corruption, memory no longer mapped), then
using it for an address calculation may trigger an exception.  Without a
fixup handler, this will lead to a panic, which will unwind, which will
trigger the fault repeatedly in an infinite loop.

We don't observe such failures currently, but we have. Just to be safe,
add a fixup handler here so that at least we don't have an infinite
loop.

Cc: stable@vger.kernel.org
Fixes: commit 6dc5fd93b2f1 ("ARM: 8900/1: UNWINDER_FRAME_POINTER implementation for Clang")
Reported-by: Miles Chen <miles.chen@mediatek.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/lib/backtrace-clang.S | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
index 5388ac664c12..40eb2215eaf4 100644
--- a/arch/arm/lib/backtrace-clang.S
+++ b/arch/arm/lib/backtrace-clang.S
@@ -146,7 +146,7 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 
 		tst	sv_lr, #0		@ If there's no previous lr,
 		beq	finished_setup		@ we're done.
-		ldr	r0, [sv_lr, #-4]	@ get call instruction
+prev_call:	ldr	r0, [sv_lr, #-4]	@ get call instruction
 		ldr	r3, .Lopcode+4
 		and	r2, r3, r0		@ is this a bl call
 		teq	r2, r3
@@ -206,6 +206,13 @@ finished_setup:
 		mov	r2, frame
 		bl	printk
 no_frame:	ldmfd	sp!, {r4 - r9, fp, pc}
+/*
+ * Accessing the address pointed to by the link register triggered an
+ * exception, don't try to unwind through it.
+ */
+bad_lr:		mov	sv_fp, #0
+		mov	sv_lr, #0
+		b	finished_setup
 ENDPROC(c_backtrace)
 		.pushsection __ex_table,"a"
 		.align	3
@@ -214,6 +221,7 @@ ENDPROC(c_backtrace)
 		.long	1003b, 1006b
 		.long	1004b, 1006b
 		.long   1005b, 1006b
+		.long	prev_call, bad_lr
 		.popsection
 
 .Lbad:		.asciz	"%sBacktrace aborted due to bad frame pointer <%p>\n"
-- 
2.28.0.163.g6104cc2f0b6-goog

