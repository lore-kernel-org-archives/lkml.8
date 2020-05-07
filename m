Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D66C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA00A2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgEGPQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726029AbgEGPQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:16:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1613C05BD09;
        Thu,  7 May 2020 08:16:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWiGb-0004pZ-Ci; Thu, 07 May 2020 17:16:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED5A81C001A;
        Thu,  7 May 2020 17:16:52 +0200 (CEST)
Date:   Thu, 07 May 2020 15:16:52 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idt: Remove address operator on function machine_check()
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200419144049.1906-3-laijs@linux.alibaba.com>
References: <20200419144049.1906-3-laijs@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <158886461280.8414.11339623726235449124.tip-bot2@tip-bot2>
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

Commit-ID:     3dcdb8e0c83b9502f669106e17bfa795f19f8d9b
Gitweb:        https://git.kernel.org/tip/3dcdb8e0c83b9502f669106e17bfa795f19f8d9b
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Sun, 19 Apr 2020 14:40:48 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 17:12:40 +02:00

x86/idt: Remove address operator on function machine_check()

machine_check is function address, the address operator on it is nop for
compiler.

Make it consistent with the other function addresses in the same file.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200419144049.1906-3-laijs@linux.alibaba.com

---
 arch/x86/kernel/idt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 87ef69a..98bcb50 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -93,7 +93,7 @@ static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_DB,		debug),
 
 #ifdef CONFIG_X86_MCE
-	INTG(X86_TRAP_MC,		&machine_check),
+	INTG(X86_TRAP_MC,		machine_check),
 #endif
 
 	SYSG(X86_TRAP_OF,		overflow),
@@ -186,7 +186,7 @@ static const __initconst struct idt_data ist_idts[] = {
 	ISTG(X86_TRAP_NMI,	nmi,		IST_INDEX_NMI),
 	ISTG(X86_TRAP_DF,	double_fault,	IST_INDEX_DF),
 #ifdef CONFIG_X86_MCE
-	ISTG(X86_TRAP_MC,	&machine_check,	IST_INDEX_MCE),
+	ISTG(X86_TRAP_MC,	machine_check,	IST_INDEX_MCE),
 #endif
 };
 
