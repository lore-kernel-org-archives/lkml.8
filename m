Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A0AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD15204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="26vl0fo8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MAdTJuUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHUOVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:21:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56900 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgHUOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:21:46 -0400
Date:   Fri, 21 Aug 2020 14:21:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598019702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkk7rIzyXZ0DDTl4UGE9i/qxlnCMtf14eN/AENzJM3k=;
        b=26vl0fo8WsBWmQZEeNqjKjFeg8gND8S4rFZgk8W8piUj0VWHy90y6DYR01A7VFlrCFT7pm
        anM7wQTAkNR1H0HmHpwOV17aRTckJ6j4o9wAhuzEht4ucJkUt6iLkgpQxr+e9MZYF2gN9o
        mzH5LMHN38rHs+sanj8LnaqvgHdJK+y7wJJSuADg7t8pud54GrRFtDWrtSL0gm5ZuApXCn
        2UeZo53yobF31IOiO4/EerTPkFQZSIBGtMDI0IiPm9Gkg0x4UZ5vd+cFhGXfUX9ficGWof
        S3bZQC0QYXGqch/m0vPlobLTncaqFqBSw8MRKcHIub/wP3yb0lMwtNP4LPZo6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598019702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkk7rIzyXZ0DDTl4UGE9i/qxlnCMtf14eN/AENzJM3k=;
        b=MAdTJuUtCO1XK2g47qbI7ZhWxv1ILz60fvc1c9Bf8Ee64+WngE/AjURijtgkls5IAh7KnW
        tSUjVM5TOoPQGsCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] core/entry: Respect syscall number rewrites
Cc:     Kyle Huey <me@kylehuey.com>, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87blj6ifo8.fsf@nanos.tec.linutronix.de>
References: <87blj6ifo8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <159801970100.3192.5947326764367261896.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     d88d59b64ca35abae208e2781fdb45e69cbed56c
Gitweb:        https://git.kernel.org/tip/d88d59b64ca35abae208e2781fdb45e69cbed56c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Aug 2020 21:44:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Aug 2020 16:17:29 +02:00

core/entry: Respect syscall number rewrites

The transcript of the x86 entry code to the generic version failed to
reload the syscall number from ptregs after ptrace and seccomp have run,
which both can modify the syscall number in ptregs. It returns the original
syscall number instead which is obviously not the right thing to do.

Reload the syscall number to fix that.

Fixes: 142781e108b1 ("entry: Provide generic syscall entry functionality")
Reported-by: Kyle Huey <me@kylehuey.com> 
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kyle Huey <me@kylehuey.com> 
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/87blj6ifo8.fsf@nanos.tec.linutronix.de

---
 kernel/entry/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 9852e0d..fcae019 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -65,7 +65,8 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 
 	syscall_enter_audit(regs, syscall);
 
-	return ret ? : syscall;
+	/* The above might have changed the syscall number */
+	return ret ? : syscall_get_nr(current, regs);
 }
 
 noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
