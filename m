Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052A32087D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgESUAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbgEST7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:59:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D6CC08C5C0;
        Tue, 19 May 2020 12:59:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O7-00009l-Hh; Tue, 19 May 2020 21:58:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 627AE1C0859;
        Tue, 19 May 2020 21:58:43 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:43 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Mark enter_from_user_mode() noinstr
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134340.429059405@linutronix.de>
References: <20200505134340.429059405@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832329.17951.8461439060342007920.tip-bot2@tip-bot2>
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

Commit-ID:     8bd73999307ba1bba5152efd327b020ad38f8c13
Gitweb:        https://git.kernel.org/tip/8bd73999307ba1bba5152efd327b020ad38f8c13
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 29 Feb 2020 15:12:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:50 +02:00

x86/entry: Mark enter_from_user_mode() noinstr

Both the callers in the low level ASM code and __context_tracking_exit()
which is invoked from enter_from_user_mode() via user_exit_irqoff() are
marked NOKPROBE. Allowing enter_from_user_mode() to be probed is
inconsistent at best.

Aside of that while function tracing per se is safe the function trace
entry/exit points can be used via BPF as well which is not safe to use
before context tracking has reached CONTEXT_KERNEL and adjusted RCU.

Mark it noinstr which moves it into the instrumentation protected text
section and includes notrace.

Note, this needs further fixups in context tracking to ensure that the
full call chain is protected. Will be addressed in follow up changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134340.429059405@linutronix.de


---
 arch/x86/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 76735ec..d862add 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -41,7 +41,7 @@
 
 #ifdef CONFIG_CONTEXT_TRACKING
 /* Called on entry from user mode with IRQs off. */
-__visible inline void enter_from_user_mode(void)
+__visible inline noinstr void enter_from_user_mode(void)
 {
 	CT_WARN_ON(ct_state() != CONTEXT_USER);
 	user_exit_irqoff();
