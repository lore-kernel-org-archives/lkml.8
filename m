Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C88C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F59B206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1EyvPoG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N0mS93g6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGXUMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:12:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40240 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGXULo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:11:44 -0400
Date:   Fri, 24 Jul 2020 20:11:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595621502;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgEhe2xKmBx6bGkHyWN4MMGdg/XYN639maFaa3NJwVk=;
        b=j1EyvPoGvoz9L6SNbZd4MHPWirjzXphKDEBE+eiQb1C5amghcZytbmMiRm7QaN1OWMZf30
        1e82NjarIWUReY2ZTUyo3o4iXeNAZIAD+K76oFMaqHukvJk/Tb9KnV52XoiAlgOUrELhfl
        fsZgE0TFdxV8DUFdN3KRuKfbJGaF8FPbfybH2fzdK7shOAX2JQiVGsxSDfa1OkpwV4Jnro
        qeWLD3XE/MJYuU901Gn8sFwG2g+F5Zkw5JL5a2Bu9EjPuGUfG2SWV4jaL4SfA85JUl2USe
        NQcJBR/J+Qphp/MjEF9D7PGi4gGZ+YfiwF3ywIhJ26fGCtFxsl5LG4Wtz6NAug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595621502;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgEhe2xKmBx6bGkHyWN4MMGdg/XYN639maFaa3NJwVk=;
        b=N0mS93g6IHACVTVPeFsPJK25Ow42ZmhGrWRIFeLU8W3glpitfP9djbQ4hPnR7fWyCDprtl
        F0EvP6pTa5ftwzCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Move user return notifier out of loop
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220520.159112003@linutronix.de>
References: <20200722220520.159112003@linutronix.de>
MIME-Version: 1.0
Message-ID: <159562150201.4006.16095309587701890873.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     a377ac1cd9d7b9ac8d546dceb3d74956fbfd443f
Gitweb:        https://git.kernel.org/tip/a377ac1cd9d7b9ac8d546dceb3d74956fbfd443f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Jul 2020 00:00:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 15:04:58 +02:00

x86/entry: Move user return notifier out of loop

Guests and user space share certain MSRs. KVM sets these MSRs to guest
values once and does not set them back to user space values on every VM
exit to spare the costly MSR operations.

User return notifiers ensure that these MSRs are set back to the correct
values before returning to user space in exit_to_usermode_loop().

There is no reason to evaluate the TIF flag indicating that user return
notifiers need to be invoked in the loop. The important point is that they
are invoked before returning to user space.

Move the invocation out of the loop into the section which does the last
preperatory steps before returning to user space. That section is not
preemptible and runs with interrupts disabled until the actual return.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200722220520.159112003@linutronix.de


---
 arch/x86/entry/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 68d5c86..9415ae5 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -208,7 +208,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 #define EXIT_TO_USERMODE_LOOP_FLAGS				\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
-	 _TIF_NEED_RESCHED | _TIF_USER_RETURN_NOTIFY | _TIF_PATCH_PENDING)
+	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING)
 
 static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 {
@@ -242,9 +242,6 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 			rseq_handle_notify_resume(NULL, regs);
 		}
 
-		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
-			fire_user_return_notifiers();
-
 		/* Disable IRQs and retry */
 		local_irq_disable();
 
@@ -273,6 +270,9 @@ static void __prepare_exit_to_usermode(struct pt_regs *regs)
 	/* Reload ti->flags; we may have rescheduled above. */
 	cached_flags = READ_ONCE(ti->flags);
 
+	if (cached_flags & _TIF_USER_RETURN_NOTIFY)
+		fire_user_return_notifiers();
+
 	if (unlikely(cached_flags & _TIF_IO_BITMAP))
 		tss_update_io_bitmap();
 
