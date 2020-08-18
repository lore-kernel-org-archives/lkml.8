Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B7EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFAA2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r1J9QelD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LEzXeEaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHRN5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:57:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59464 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgHRN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:57:31 -0400
Date:   Tue, 18 Aug 2020 13:57:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597759049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ezjIcedhEqybwNiGtazWvthEwM7d6MfR+WsKt3r72U=;
        b=r1J9QelDf4X3b8G5I+GuzkF94U7lFDuTizJqG8EU9fawuG+G1l64uCq5ZnNT7BFjWFwcCG
        GUzqy/vFkcfJvv6/EeuFUtU/f+srMkEjuvb7XhvT+0pS8/Ga3Gdr32iFP1Vw/Xup5R5aSf
        C6ur6ot/HDuFGkH3nSwsXaaI2LZl2Wcn7O5q4UbHG2P5yzE5itnT+mDdGbP3SEunyf9ZSj
        9hkdY/fZBuxwcklsXxEX9825h5pqJKCQL2fECaK7pbgl9yYhf2H10hrK75IiASvZDb/8S6
        2pE5noCI1CmXyEPlMRK6+cLR7h4lF+IEsTMMOsveN/OZYhYFC7F1/U9hEprNeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597759049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ezjIcedhEqybwNiGtazWvthEwM7d6MfR+WsKt3r72U=;
        b=LEzXeEaExqDf8CfTL/5nm+WU6JtduOVdyN0EnRVXap6jPd8/sX2V84e8OKGgIqlgj3m34D
        GvhZMJJ18msPQADg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Use XGETBV and XSETBV mnemonics in fpu/internal.h
Cc:     Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200707174722.58651-1-ubizjak@gmail.com>
References: <20200707174722.58651-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <159775904832.3192.5970807908188869271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     86109813990b5d6d6cfb8072382ee69d11ea9460
Gitweb:        https://git.kernel.org/tip/86109813990b5d6d6cfb8072382ee69d11ea9460
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 07 Jul 2020 19:47:22 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 18 Aug 2020 15:49:07 +02:00

x86/cpu: Use XGETBV and XSETBV mnemonics in fpu/internal.h

Current minimum required version of binutils is 2.23, which supports
XGETBV and XSETBV instruction mnemonics.

Replace the byte-wise specification of XGETBV and XSETBV with these
proper mnemonics.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200707174722.58651-1-ubizjak@gmail.com
---
 arch/x86/include/asm/fpu/internal.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 0a460f2..21a8b52 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -602,9 +602,7 @@ static inline u64 xgetbv(u32 index)
 {
 	u32 eax, edx;
 
-	asm volatile(".byte 0x0f,0x01,0xd0" /* xgetbv */
-		     : "=a" (eax), "=d" (edx)
-		     : "c" (index));
+	asm volatile("xgetbv" : "=a" (eax), "=d" (edx) : "c" (index));
 	return eax + ((u64)edx << 32);
 }
 
@@ -613,8 +611,7 @@ static inline void xsetbv(u32 index, u64 value)
 	u32 eax = value;
 	u32 edx = value >> 32;
 
-	asm volatile(".byte 0x0f,0x01,0xd1" /* xsetbv */
-		     : : "a" (eax), "d" (edx), "c" (index));
+	asm volatile("xsetbv" :: "a" (eax), "d" (edx), "c" (index));
 }
 
 #endif /* _ASM_X86_FPU_INTERNAL_H */
