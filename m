Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77456C7291B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509EE24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbgB0OYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:24:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34485 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730366AbgB0OYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:24:43 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j7K5W-0005uK-CM; Thu, 27 Feb 2020 15:24:30 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7766A1040A9; Thu, 27 Feb 2020 15:24:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch V2 08/10] x86/entry/32: Remove the 0/-1 distinction from exception entries
In-Reply-To: <87y2spb1nr.fsf@nanos.tec.linutronix.de>
References: <20200225213636.689276920@linutronix.de> <20200225220216.933457250@linutronix.de> <6dd020cd-e20a-be12-aba7-bfa9e1a94795@kernel.org> <87blpli40i.fsf@nanos.tec.linutronix.de> <CALCETrXbNQJyvDEkfi0f0P3r+zrz8h7cPMaWB0PM_eTkFEAF0w@mail.gmail.com> <87y2spb1nr.fsf@nanos.tec.linutronix.de>
Date:   Thu, 27 Feb 2020 15:24:29 +0100
Message-ID: <87mu94m7ky.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing cares about the -1 "mark as interrupt" in the errorcode of
exception entries. It's only used to fill the error code when a signal
is delivered, but this is already inconsistent vs. 64 bit as there all
exceptions which do not have an error code set it to 0. So if 32bit
applications would care about this, then they would have noticed more
than a decade ago.

Just use 0 for all excpetions which do not have an errorcode consistently.

This does neither break /proc/$PID/syscall because this interface
examines the error code / syscall number which is on the stack and that
is set to -1 (no syscall) in common_exception unconditionally for all
exceptions. The push in the entry stub is just there to fill the
hardware error code slot on the stack for consistency of the stack
layout.

A transient observation of 0 is possible, but that's true for the other
exceptions which use 0 already as well and that interface is an unreliable
snapshot of dubious correctness anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
V2: Amend changelog. Rebased on top of tip x86/entry 
---
 arch/x86/entry/entry_32.S |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
