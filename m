Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E105C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B7424681
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgBLMEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:04:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48418 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgBLMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:04:42 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1qkw-0003Zy-8B; Wed, 12 Feb 2020 13:04:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D45451C202A;
        Wed, 12 Feb 2020 13:04:37 +0100 (CET)
Date:   Wed, 12 Feb 2020 12:04:37 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed/64: Use LEA to initialize boot
 stack pointer
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200107194436.2166846-2-nivedita@alum.mit.edu>
References: <20200107194436.2166846-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <158150907763.411.16186019828079681497.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     48bfdb9deffdc6b683feb25e15f4f26aac503501
Gitweb:        https://git.kernel.org/tip/48bfdb9deffdc6b683feb25e15f4f26aac503501
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 07 Jan 2020 14:44:35 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 12 Feb 2020 11:11:06 +01:00

x86/boot/compressed/64: Use LEA to initialize boot stack pointer

It's shorter, and it's what is used in every other place, so make it
consistent.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200107194436.2166846-2-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/head_64.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1f1f6c8..d1220de 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -81,9 +81,7 @@ SYM_FUNC_START(startup_32)
 	subl	$1b, %ebp
 
 /* setup a stack and make sure cpu supports long mode. */
-	movl	$boot_stack_end, %eax
-	addl	%ebp, %eax
-	movl	%eax, %esp
+	leal	boot_stack_end(%ebp), %esp
 
 	call	verify_cpu
 	testl	%eax, %eax
