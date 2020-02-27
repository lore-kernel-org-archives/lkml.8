Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C4AC3F377
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C6D24688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389938AbgB0OWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:22:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34459 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389020AbgB0OQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:16:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7JxF-0005AW-Cp; Thu, 27 Feb 2020 15:15:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 014FF1C216F;
        Thu, 27 Feb 2020 15:15:57 +0100 (CET)
Date:   Thu, 27 Feb 2020 14:15:56 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/entry_32: Route int3 through common_exception
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200225220217.042369808@linutronix.de>
References: <20200225220217.042369808@linutronix.de>
MIME-Version: 1.0
Message-ID: <158281295675.28353.17857855711857005767.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     ac3607f92f70c762e24d0ae731168f7584de51ec
Gitweb:        https://git.kernel.org/tip/ac3607f92f70c762e24d0ae731168f7584de51ec
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 22:36:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 27 Feb 2020 14:48:41 +01:00

x86/entry/entry_32: Route int3 through common_exception

int3 is not using the common_exception path for purely historical reasons,
but there is no reason to keep it the only exception which is different.

Make it use common_exception so the upcoming changes to autogenerate the
entry stubs do not have to special case int3.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200225220217.042369808@linutronix.de

---
 arch/x86/entry/entry_32.S | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index a8b4438..0753f48 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1683,14 +1683,8 @@ SYM_CODE_END(nmi)
 SYM_CODE_START(int3)
 	ASM_CLAC
 	pushl	$-1				# mark this as an int
-
-	SAVE_ALL switch_stacks=1
-	ENCODE_FRAME_POINTER
-	TRACE_IRQS_OFF
-	xorl	%edx, %edx			# zero error code
-	movl	%esp, %eax			# pt_regs pointer
-	call	do_int3
-	jmp	ret_from_exception
+	pushl	$do_int3
+	jmp	common_exception
 SYM_CODE_END(int3)
 
 SYM_CODE_START(general_protection)
