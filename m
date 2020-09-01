Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B48AC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41B9204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OExIabFA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eae08HEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgIAOz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgIALs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74244C061245;
        Tue,  1 Sep 2020 04:47:56 -0700 (PDT)
Date:   Tue, 01 Sep 2020 11:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pA6QutgyvtCbNdLvfwI+2OFUhlLVjQHsEDvQCshtOxA=;
        b=OExIabFAPit8i5zgrkHIXP1Hg/XVdHblSYBBmAbMe2wdE/rLx6W0NPgvd+wV6y0jlMO+sc
        j1wf6azBHmq29bSOYiQPEaCUdpLeyWn3XXV5NUrPsLIf+/NGPbSCDAzAUNacF221ldQcYJ
        h0TyvivEP4Qbqe1EFgrwFQzd/ydSHAinZlkNAH3i5sP8qSVqsh5Fkk+RG/R7rcgGqpC7Bg
        bUDilUG1NkWfBF/z10xXVXvz/gfuLdrI3BwsEjn6LqDrVXPZO75rjNxYa/SeKfUT9JQV4u
        ySYG2QVXPqnSaLjoHpjCqncd2SvwD3uu73cvf3OYoDJVOkV1BwlPof2ONQOLdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pA6QutgyvtCbNdLvfwI+2OFUhlLVjQHsEDvQCshtOxA=;
        b=Eae08HEFbzPePRzHZi4nkVZp3v1NT5qcdDK7OHcv6GmFXw1MFCwuhRTJDIkQmCAXVfu1Nh
        zo7kUissMD2kfVBA==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] x86/build: Enforce an empty .got.plt section
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-24-keescook@chromium.org>
References: <20200821194310.3089815-24-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087384.20229.7620654432209669942.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     815d680771ae09080d2da83dac2647c08cdf99ce
Gitweb:        https://git.kernel.org/tip/815d680771ae09080d2da83dac2647c08cdf99ce
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:43:04 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 10:03:18 +02:00

x86/build: Enforce an empty .got.plt section

The .got.plt section should always be zero (or filled only with the
linker-generated lazy dispatch entry). Enforce this with an assert and
mark the section as INFO. This is more sensitive than just blindly
discarding the section.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200821194310.3089815-24-keescook@chromium.org
---
 arch/x86/kernel/vmlinux.lds.S | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0cc035c..4b1b936 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -414,8 +414,20 @@ SECTIONS
 	ELF_DETAILS
 
 	DISCARDS
-}
 
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the lazy dispatch entries.
+	 */
+	.got.plt (INFO) : { *(.got.plt) }
+	ASSERT(SIZEOF(.got.plt) == 0 ||
+#ifdef CONFIG_X86_64
+	       SIZEOF(.got.plt) == 0x18,
+#else
+	       SIZEOF(.got.plt) == 0xc,
+#endif
+	       "Unexpected GOT/PLT entries detected!")
+}
 
 #ifdef CONFIG_X86_32
 /*
