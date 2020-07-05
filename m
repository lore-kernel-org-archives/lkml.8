Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DA9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B56282073E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yhKH9OTM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d5ATdZkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgGEToI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:44:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47004 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgGEToI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:44:08 -0400
Date:   Sun, 05 Jul 2020 19:44:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593978245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kJjqNi98jZ2gWU0Juh5kKC1w6QkusqiMwIY+neDalHo=;
        b=yhKH9OTMlmK9YL5b4llaQDuWUmt4ctnOrCo/9MjQXIH1yjSciFJh8WfavirpU2BjD9ak4D
        JBTpQFtY74vj9BADO+6/Kx7IEUtIIvSaUai+I2g0dZZihbBsNTJQsUXq510mBYKbVLU/nW
        izjniF5UFz75ddqDHi/FSYTKTfWrvsu5FQ/6XfqnPycvSmJB/iQ5Vs2xKLmplN7IsjKBKd
        7f39Rpank/n9GKmkbyxR/mNzou+6UPrFUlOT6lb84qDXuA/1sIgNK+t1zaYfXtfHHmlhXP
        VEEN19eiGgHaV0q9GqbFTjJhblBOJeJG5n0aBoea0MMq4sLc3/wF7iE3uOkldw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593978245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kJjqNi98jZ2gWU0Juh5kKC1w6QkusqiMwIY+neDalHo=;
        b=d5ATdZkrosSwyZ5dvTeP7VMw0hRmSamY+6VmVU2iz5OkZwdAfE66wjOYLeAJcrPADzM5Mm
        Z0YWa0EDjiUCLqAQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/32: Fix XEN_PV build dependency
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>
MIME-Version: 1.0
Message-ID: <159397824429.4006.6604251447325788449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a4c0e91d1d65bc58f928b80ed824e10e165da22c
Gitweb:        https://git.kernel.org/tip/a4c0e91d1d65bc58f928b80ed824e10e165da22c
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 05 Jul 2020 21:33:11 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 05 Jul 2020 21:39:23 +02:00

x86/entry/32: Fix XEN_PV build dependency

xenpv_exc_nmi() and xenpv_exc_debug() are only defined on 64-bit kernels,
but they snuck into the 32-bit build via <asm/identry.h>, causing the link
to fail:

  ld: arch/x86/entry/entry_32.o: in function `asm_xenpv_exc_nmi':
  (.entry.text+0x817): undefined reference to `xenpv_exc_nmi'

  ld: arch/x86/entry/entry_32.o: in function `asm_xenpv_exc_debug':
  (.entry.text+0x827): undefined reference to `xenpv_exc_debug'

Only use them on 64-bit kernels.

Fixes: f41f0824224e: ("x86/entry/xen: Route #DB correctly on Xen PV")
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/idtentry.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index eeac6dc..f3d7083 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -553,7 +553,7 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_MC,	exc_machine_check);
 
 /* NMI */
 DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
-#ifdef CONFIG_XEN_PV
+#if defined(CONFIG_XEN_PV) && defined(CONFIG_X86_64)
 DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,	xenpv_exc_nmi);
 #endif
 
@@ -563,7 +563,7 @@ DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,	exc_debug);
 #else
 DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	exc_debug);
 #endif
-#ifdef CONFIG_XEN_PV
+#if defined(CONFIG_XEN_PV) && defined(CONFIG_X86_64)
 DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	xenpv_exc_debug);
 #endif
 
