Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEBBC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755192070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ilBB9v9x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yvj4VlOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgGXULr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgGXULn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:11:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BA8C0619E4;
        Fri, 24 Jul 2020 13:11:43 -0700 (PDT)
Date:   Fri, 24 Jul 2020 20:11:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595621502;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LRt+j3H4BS2qWkDiZ1E5bFH3T6rDKuwtVcLEW8lggM=;
        b=ilBB9v9xU429glAccmdseqIVk40PFuF7xxRt7eYfDi4Zb1ml8Hk9vjULyB0rTf8YGdy7wi
        bfBj0lszTEgBgM32gGqB1Hz9W0RZ1AI4Ykw1Rsnq5ye6+Y9ta8/yNutNOu5Q3RJX8tXb4n
        qZEoewElMP3YgzLkIl0UbaG9EOVyZLIEP06E5NT+1c4qenoJWSD1UtXekNHrumZXjMPub7
        GP0GVsPrrA8l9LRQdOkri6J9aU0WSV9WU1cggEuf4dzfXFPR+ZiX1PRbJ+fTNqPmZvBeuD
        xKU4yb/obFXtEiCPqXfdeuX7/KphKfytZL/m7ItcA7n64Z+ClO6S4iYRnX0BwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595621502;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LRt+j3H4BS2qWkDiZ1E5bFH3T6rDKuwtVcLEW8lggM=;
        b=Yvj4VlOMEYti2S7+842vf9uO55Kko/pmlVjD+P9p/R4IwfsB63/lPsrAP+93drvU7ZZP5a
        g7ZFwz3q9J0eO4BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/ptrace: Provide pt_regs helper for entry/exit
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220520.258511584@linutronix.de>
References: <20200722220520.258511584@linutronix.de>
MIME-Version: 1.0
Message-ID: <159562150141.4006.14534452272792255017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     0bf019ea59e330770883ede4499d7f711d8c3adf
Gitweb:        https://git.kernel.org/tip/0bf019ea59e330770883ede4499d7f711d8c3adf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Jul 2020 00:00:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 15:04:58 +02:00

x86/ptrace: Provide pt_regs helper for entry/exit

As a preparatory step for moving the syscall and interrupt entry/exit
handling into generic code, provide a pt_regs helper which retrieves the
interrupt state from pt_regs. This is required to check whether interrupts
are reenabled by return from interrupt/exception.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200722220520.258511584@linutronix.de


---
 arch/x86/include/asm/ptrace.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 255b2dd..40aa69d 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -209,6 +209,11 @@ static inline void user_stack_pointer_set(struct pt_regs *regs,
 	regs->sp = val;
 }
 
+static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
+{
+	return !(regs->flags & X86_EFLAGS_IF);
+}
+
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
 extern const char *regs_query_register_name(unsigned int offset);
