Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DFDC3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 11:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80A42469C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 11:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgB2Lt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 06:49:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39034 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgB2Lt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 06:49:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j80cU-0007f3-SA; Sat, 29 Feb 2020 12:49:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 859371C219A;
        Sat, 29 Feb 2020 12:49:22 +0100 (CET)
Date:   Sat, 29 Feb 2020 11:49:22 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/32: Remove the 0/-1 distinction from
 exception entries
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87mu94m7ky.fsf@nanos.tec.linutronix.de>
References: <87mu94m7ky.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <158297696222.28353.18163314498317163313.tip-bot2@tip-bot2>
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

Commit-ID:     e441a2ae0e9e9bb12fd3fbe2d59d923fadfe8ef7
Gitweb:        https://git.kernel.org/tip/e441a2ae0e9e9bb12fd3fbe2d59d923fadfe8ef7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 27 Feb 2020 15:24:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 29 Feb 2020 12:45:54 +01:00

x86/entry/32: Remove the 0/-1 distinction from exception entries

Nothing cares about the -1 "mark as interrupt" in the errorcode of
exception entries. It's only used to fill the error code when a signal is
delivered, but this is already inconsistent vs. 64 bit as there all
exceptions which do not have an error code set it to 0. So if 32 bit
applications would care about this, then they would have noticed more than
a decade ago.

Just use 0 for all excpetions which do not have an errorcode consistently.

This does neither break /proc/$PID/syscall because this interface examines
the error code / syscall number which is on the stack and that is set to -1
(no syscall) in common_exception unconditionally for all exceptions. The
push in the entry stub is just there to fill the hardware error code slot
on the stack for consistency of the stack layout.

A transient observation of 0 is possible, but that's true for the other
exceptions which use 0 already as well and that interface is an unreliable
snapshot of dubious correctness anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/87mu94m7ky.fsf@nanos.tec.linutronix.de

---
 arch/x86/entry/entry_32.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 0753f48..ddc87f2 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1290,7 +1290,7 @@ SYM_CODE_END(simd_coprocessor_error)
 
 SYM_CODE_START(device_not_available)
 	ASM_CLAC
-	pushl	$-1				# mark this as an int
+	pushl	$0
 	pushl	$do_device_not_available
 	jmp	common_exception
 SYM_CODE_END(device_not_available)
@@ -1531,7 +1531,7 @@ SYM_CODE_START(debug)
 	 * Entry from sysenter is now handled in common_exception
 	 */
 	ASM_CLAC
-	pushl	$-1				# mark this as an int
+	pushl	$0
 	pushl	$do_debug
 	jmp	common_exception
 SYM_CODE_END(debug)
@@ -1682,7 +1682,7 @@ SYM_CODE_END(nmi)
 
 SYM_CODE_START(int3)
 	ASM_CLAC
-	pushl	$-1				# mark this as an int
+	pushl	$0
 	pushl	$do_int3
 	jmp	common_exception
 SYM_CODE_END(int3)
