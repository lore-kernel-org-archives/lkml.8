Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551CEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C980214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgEST6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgEST6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1387AC08C5C0;
        Tue, 19 May 2020 12:58:40 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nm-0008Gz-Qr; Tue, 19 May 2020 21:58:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2CCF71C0178;
        Tue, 19 May 2020 21:58:27 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:27 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/int3: Avoid atomic instrumentation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135313.517429268@linutronix.de>
References: <20200505135313.517429268@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830703.17951.7301728008554770838.tip-bot2@tip-bot2>
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

Commit-ID:     a53a1d0435cdc2b66f41f75fa1cee31e8fe6d99e
Gitweb:        https://git.kernel.org/tip/a53a1d0435cdc2b66f41f75fa1cee31e8fe6d99e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 24 Jan 2020 22:08:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:05 +02:00

x86/int3: Avoid atomic instrumentation

Use arch_atomic_*() and __READ_ONCE() to ensure nothing untoward
creeps in and ruins things.

That is; this is the INT3 text poke handler, strictly limit the code
that runs in it, lest it inadvertenly hits yet another INT3.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135313.517429268@linutronix.de


---
 arch/x86/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 1f4cb2c..686c8ac 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -960,9 +960,9 @@ static struct bp_patching_desc *bp_desc;
 static __always_inline
 struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
 {
-	struct bp_patching_desc *desc = READ_ONCE(*descp); /* rcu_dereference */
+	struct bp_patching_desc *desc = __READ_ONCE(*descp); /* rcu_dereference */
 
-	if (!desc || !atomic_inc_not_zero(&desc->refs))
+	if (!desc || !arch_atomic_inc_not_zero(&desc->refs))
 		return NULL;
 
 	return desc;
@@ -971,7 +971,7 @@ struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
 static __always_inline void put_desc(struct bp_patching_desc *desc)
 {
 	smp_mb__before_atomic();
-	atomic_dec(&desc->refs);
+	arch_atomic_dec(&desc->refs);
 }
 
 static __always_inline void *text_poke_addr(struct text_poke_loc *tp)
