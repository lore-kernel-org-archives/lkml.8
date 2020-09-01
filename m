Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5C2C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E3E2220B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HHKuANEC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eReN3eVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIAOuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:50:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgIALs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:27 -0400
Date:   Tue, 01 Sep 2020 11:47:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqX1DJ93ypmdQacngw88cyyZgMtx+C7YS/Ea8KuhB0o=;
        b=HHKuANECbLS4y6mGG6rYC4l/BPb5FCO7oGJ9w4XiNDpSEamIPpzuBC6Jdy7o3hgQSa1stX
        hlTQH1MQzFSx5UN8H4Tfk12sBq86+AOiwciqLV0jm09x2Y1Sj8d2W/DWdE21nQQguzHXGu
        /dneyVxv0e4+NmX9/lXF2NqDopHQA6kpI5gMnDOKIYb0PWEOjM5gMPHaKGgZT/czuXqvHz
        ydgoDtoxT8iaXpID5lyZcd4AGmAlUPQv4fjc+m8xYcJ86sEBsA+aMOmzEtkYJqwH+D0M7A
        DU0l6rIptJfAmrc7E0YOuD1yn4wVjClKHugGEyc3Bo/MkqqM4E9UW07eD697Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqX1DJ93ypmdQacngw88cyyZgMtx+C7YS/Ea8KuhB0o=;
        b=eReN3eVCWHNguW0IXbDvWWmOjIUwTgtnEclUmWf+ny5RguyOgIfEW3YRQIS9/K84iKY1a8
        +RSjHqfVvHaHuwCw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] x86/asm: Avoid generating unused kprobe sections
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-23-keescook@chromium.org>
References: <20200821194310.3089815-23-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087422.20229.4981553506787808707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     a850958c072404f75dd41782cb4ff34b8625b47d
Gitweb:        https://git.kernel.org/tip/a850958c072404f75dd41782cb4ff34b8625b47d
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:43:03 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 10:03:18 +02:00

x86/asm: Avoid generating unused kprobe sections

When !CONFIG_KPROBES, do not generate kprobe sections. This makes
sure there are no unexpected sections encountered by the linker scripts.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200821194310.3089815-23-keescook@chromium.org
---
 arch/x86/include/asm/asm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 5c15f95..4712206 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -138,11 +138,15 @@
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
-# define _ASM_NOKPROBE(entry)					\
+# ifdef CONFIG_KPROBES
+#  define _ASM_NOKPROBE(entry)					\
 	.pushsection "_kprobe_blacklist","aw" ;			\
 	_ASM_ALIGN ;						\
 	_ASM_PTR (entry);					\
 	.popsection
+# else
+#  define _ASM_NOKPROBE(entry)
+# endif
 
 #else /* ! __ASSEMBLY__ */
 # define _EXPAND_EXTABLE_HANDLE(x) #x
