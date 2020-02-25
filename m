Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF66C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE62E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgBYXar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:30:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55477 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgBYXZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:45 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6ja2-0004Xw-2s; Wed, 26 Feb 2020 00:25:34 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 6426210408F;
        Wed, 26 Feb 2020 00:25:29 +0100 (CET)
Message-Id: <20200225220216.933457250@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 22:36:44 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 08/10] x86/entry/32: Remove the 0/-1 distinction from exception entries
References: <20200225213636.689276920@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing cares about the -1 "mark as interrupt" in the errorcode anymore. Just
use 0 for all excpetions which do not have an errorcode consistently.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
 
 	SAVE_ALL switch_stacks=1
 	ENCODE_FRAME_POINTER

