Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920CEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E1820760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B3nro80T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="02SbIAcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGPKsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:48:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60016 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgGPKsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:48:17 -0400
Date:   Thu, 16 Jul 2020 10:48:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594896495;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JCtqpSMiY3xUJef3DDkPQi7kzGOHIVyC/0EPni/LeRc=;
        b=B3nro80TcMgA+TJAXC9NvypjjcexrZBFoQGp7P8SLoNTZn0ZaAQxK8Bv/5g8c2Uwh7/w3w
        72N0t2Q1xUisSRF9VOtZUySgeczicsOSctIoWnBVOG2kCLXAYfMGGQQCMNo8AvpWjKkJS2
        ezhMeXrwp3A6cj/FuGdUcmvnC3JsXftqsoiXA8eEpHslWgLrLO0+rDk/TbRLywETQM7u9H
        /shGusxqozd145MIRbpUTrjpdCJwniOnIc3pc3Ad88miRCBLddrKmwyCG35hIsI1dfIFKr
        2EmVxMsL9Yo6EbIlJrsmp2jV/Uvlzh8cK5NYgtgdCem2asNdRevooQAE16kuKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594896495;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JCtqpSMiY3xUJef3DDkPQi7kzGOHIVyC/0EPni/LeRc=;
        b=02SbIAcSB6RrEYTrzkshN8lzt1tEnDbtSH3Ik/ytOrFW8lTRcbfudWk082ovcAmqvlale0
        R1EaQV+GyAkudmBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idtentry: Remove stale comment
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159489649426.4006.4244079083466119309.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     790ce3b40017bbd759a3d81e23c05d42b3d34b90
Gitweb:        https://git.kernel.org/tip/790ce3b40017bbd759a3d81e23c05d42b3d34b90
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 14 Jul 2020 16:01:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jul 2020 12:44:26 +02:00

x86/idtentry: Remove stale comment

Stack switching for interrupt handlers happens in C now for both 64 and
32bit. Remove the stale comment which claims the contrary.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/idtentry.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 2293b44..50ea186 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -191,11 +191,9 @@ __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
  * to the function as error_code argument which needs to be truncated
  * to an u8 because the push is sign extending.
  *
- * On 64-bit idtentry_enter/exit() are invoked in the ASM entry code before
- * and after switching to the interrupt stack. On 32-bit this happens in C.
- *
  * irq_enter/exit_rcu() are invoked before the function body and the
- * KVM L1D flush request is set.
+ * KVM L1D flush request is set. Stack switching to the interrupt stack
+ * has to be done in the function body if necessary.
  */
 #define DEFINE_IDTENTRY_IRQ(func)					\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
