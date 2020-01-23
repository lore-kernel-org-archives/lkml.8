Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16BAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5322253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgAWLEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:04:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39685 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWLEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:04:53 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iuaI3-0006g1-Fk; Thu, 23 Jan 2020 12:04:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F04A61C1A13;
        Thu, 23 Jan 2020 12:04:46 +0100 (CET)
Date:   Thu, 23 Jan 2020 11:04:46 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/boot: Simplify calculation of output address
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200107194436.2166846-1-nivedita@alum.mit.edu>
References: <20200107194436.2166846-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <157977748674.396.4073029577161163163.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     183ef7adf4ed638ac0fb0c3c9a71fc00e8512b61
Gitweb:        https://git.kernel.org/tip/183ef7adf4ed638ac0fb0c3c9a71fc00e8512b61
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 07 Jan 2020 14:44:34 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 23 Jan 2020 11:58:43 +01:00

x86/boot: Simplify calculation of output address

Condense the calculation of decompressed kernel start a little.

Committer notes:

before:

ebp = ebx - (init_size - _end)

after:

eax = (ebx + _end) - init_size

where in both ebx contains the temporary address the kernel is moved to
for in-place decompression.

The before and after difference in register state is %eax and %ebp
but that is immaterial because the compressed image is not built with
-mregparm, i.e., all arguments of the following extract_kernel() call
are passed on the stack.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200107194436.2166846-1-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/head_32.S | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index f2dfd6d..1cc55c7 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -240,11 +240,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 				/* push arguments for extract_kernel: */
 	pushl	$z_output_len	/* decompressed length, end of relocs */
 
-	movl    BP_init_size(%esi), %eax
-	subl    $_end, %eax
-	movl    %ebx, %ebp
-	subl    %eax, %ebp
-	pushl	%ebp		/* output address */
+	leal	_end(%ebx), %eax
+	subl    BP_init_size(%esi), %eax
+	pushl	%eax		/* output address */
 
 	pushl	$z_input_len	/* input_len */
 	leal	input_data(%ebx), %eax
