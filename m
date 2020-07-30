Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4955BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C152084D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNXCOzxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbgG3Uvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbgG3Uvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:51:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:51:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x10so16748181ybj.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QONIUax01BTjdO9Ra0WL2SaVjevDM7EFtQflcDkiZpw=;
        b=KNXCOzxZ5pBdanQWFcSr/OXE5B2/MHBDkzE0HeXydXqmchbCVf1W+UZq4r4Psxg/Wk
         1DEQowbCu9uiGpRhB/dKS68WmrNs9kpD8hFn8AFd9ehaQ+aESTZaHw/5spbgKV2A8+hh
         gPvh6rRe3QytXFvyoUDWs9xZdj9sIJaHtZ1y1PJbwcXaIx9mdZ/Y3Xjw9DwXmEjNWo4/
         2UHVOrmwIJ0roULI0LVnH1Rym+desYivmDF40KeGKX9Tl0bEe2Awjztl/Vxjw3CZlc67
         sNbngbmuxGMjWzDi+NpTTHb8LppYudA+15WmYdcxDCVNRvEZpo0kOAEryTzieodpJD6r
         Ikpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QONIUax01BTjdO9Ra0WL2SaVjevDM7EFtQflcDkiZpw=;
        b=mvdP77WfD6bC+5CcJTlEHj4QmhwFQi4F03CcdK6EC18sxr94oj06EkwkzIeZiZQbml
         jVm0dVjdRPNdl29tv9sDvbBV4yURt9W9uScDKAFKoe/cXE933oF2jOwrBrjYeor7F+Yk
         tXbr4gTbcSn6MGhzHWhqm06vJtfOBC/VBKgZeyS37qicmEl4Uzxz1KC70krZJuvlU9se
         r+o3zQAxC/JvraASS7KFuwLLbu4ir/jtIRAlF4eBC4PQ33OwegqmVRu9H2EHeNyoDpJm
         95lBpDnRPyLAbZTi8U/cBwIDJRXy2Mg75Wnkk9QPBhS/n0tCR4EqJ/Woz5KyQ9UF0M+0
         uUGA==
X-Gm-Message-State: AOAM530qNSWbFI5VzdhaEYkv2kSUtiJj5QqTVHRDFzXsxpDECH7TmCsr
        0WuZIsKe6+gltyBQPFTKswi6qWOC4+2m3kUkPCo=
X-Google-Smtp-Source: ABdhPJxNBCENw+3kJpkaLmevqSScT/aVOmfpWZ+6QdeX2ScuiXo2KHy5MFNiKfuHDYstF0PZx795gbSwSo9qT61KX4Q=
X-Received: by 2002:a25:aba2:: with SMTP id v31mr1236236ybi.138.1596142298407;
 Thu, 30 Jul 2020 13:51:38 -0700 (PDT)
Date:   Thu, 30 Jul 2020 13:51:12 -0700
In-Reply-To: <20200730205112.2099429-1-ndesaulniers@google.com>
Message-Id: <20200730205112.2099429-5-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200730205112.2099429-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 4/4] ARM: backtrace: use more descriptive labels
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
        Miles Chen <miles.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't necessarily need the `b` suffixes used to disambiguate between
non-unique local labels. Give these labels more descriptive names.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/lib/backtrace.S | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
index 872f658638d9..138e961ff033 100644
--- a/arch/arm/lib/backtrace.S
+++ b/arch/arm/lib/backtrace.S
@@ -37,9 +37,9 @@ ENDPROC(c_backtrace)
  THUMB(		orreq	mask, #0x03		)
 		movne	mask, #0		@ mask for 32-bit
 
-1:		stmfd	sp!, {pc}		@ calculate offset of PC stored
+store_pc:	stmfd	sp!, {pc}		@ calculate offset of PC stored
 		ldr	r0, [sp], #4		@ by stmfd for this CPU
-		adr	r1, 1b
+		adr	r1, store_pc
 		sub	offset, r0, r1
 
 /*
@@ -60,14 +60,14 @@ ENDPROC(c_backtrace)
 for_each_frame:	tst	frame, mask		@ Check for address exceptions
 		bne	no_frame
 
-1001:		ldr	sv_pc, [frame, #0]	@ get saved pc
-1002:		ldr	sv_fp, [frame, #-12]	@ get saved fp
+load_pc:	ldr	sv_pc, [frame, #0]	@ get saved pc
+load_fp:	ldr	sv_fp, [frame, #-12]	@ get saved fp
 
 		sub	sv_pc, sv_pc, offset	@ Correct PC for prefetching
 		bic	sv_pc, sv_pc, mask	@ mask PC/LR for the mode
 
-1003:		ldr	r2, [sv_pc, #-4]	@ if stmfd sp!, {args} exists,
-		ldr	r3, .Ldsi+4		@ adjust saved 'pc' back one
+load_stmfd:	ldr	r2, [sv_pc, #-4]	@ if stmfd sp!, {args} exists,
+		ldr	r3, .Lopcode + 4	@ adjust saved 'pc' back one
 		teq	r3, r2, lsr #11		@ instruction
 		subne	r0, sv_pc, #4		@ allow for mov
 		subeq	r0, sv_pc, #8		@ allow for mov + stmia
@@ -79,15 +79,15 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 		bl	dump_backtrace_entry
 
 		ldr	r1, [sv_pc, #-4]	@ if stmfd sp!, {args} exists,
-		ldr	r3, .Ldsi+4
+		ldr	r3, .Lopcode + 4
 		teq	r3, r1, lsr #11
 		ldreq	r0, [frame, #-8]	@ get sp
 		subeq	r0, r0, #4		@ point at the last arg
 		mov	r2, loglvl
 		bleq	dump_backtrace_stm	@ dump saved registers
 
-1004:		ldr	r1, [sv_pc, #0]		@ if stmfd sp!, {..., fp, ip, lr, pc}
-		ldr	r3, .Ldsi		@ instruction exists,
+reload_stmfd:	ldr	r1, [sv_pc, #0]		@ if stmfd sp!, {..., fp, ip, lr, pc}
+		ldr	r3, .Lopcode		@ instruction exists,
 		teq	r3, r1, lsr #11
 		subeq	r0, frame, #16
 		mov	r2, loglvl
@@ -100,7 +100,7 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 		mov	frame, sv_fp		@ above the current frame
 		bhi	for_each_frame
 
-1006:		adr	r0, .Lbad
+bad_frame:	adr	r0, .Lbad
 		mov	r1, loglvl
 		mov	r2, frame
 		bl	printk
@@ -109,15 +109,15 @@ ENDPROC(c_backtrace)
 		
 		.pushsection __ex_table,"a"
 		.align	3
-		.long	1001b, 1006b
-		.long	1002b, 1006b
-		.long	1003b, 1006b
-		.long	1004b, 1006b
+		.long	load_pc, bad_frame
+		.long	load_fp, bad_frame
+		.long	load_stmfd, bad_frame
+		.long	reload_stmfd, bad_frame
 		.popsection
 
 .Lbad:		.asciz	"%sBacktrace aborted due to bad frame pointer <%p>\n"
 		.align
-.Ldsi:		.word	0xe92dd800 >> 11	@ stmfd sp!, {... fp, ip, lr, pc}
+.Lopcode:	.word	0xe92dd800 >> 11	@ stmfd sp!, {... fp, ip, lr, pc}
 		.word	0xe92d0000 >> 11	@ stmfd sp!, {}
 
 #endif
-- 
2.28.0.163.g6104cc2f0b6-goog

