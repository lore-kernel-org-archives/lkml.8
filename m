Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C388C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8CC21835
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgDZGrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 02:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726253AbgDZGrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 02:47:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1997BC09B04F;
        Sat, 25 Apr 2020 23:47:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSb4m-0008Qv-Py; Sun, 26 Apr 2020 08:47:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 64CB31C0334;
        Sun, 26 Apr 2020 08:47:40 +0200 (CEST)
Date:   Sun, 26 Apr 2020 06:47:40 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/orc: Prevent unwinding before ORC initialization
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Jones <dsj@fb.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <069d1499ad606d85532eb32ce39b2441679667d5.1587808742.git.jpoimboe@redhat.com>
References: <069d1499ad606d85532eb32ce39b2441679667d5.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158788366000.28353.11850032447179748567.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     98d0c8ebf77e0ba7c54a9ae05ea588f0e9e3f46e
Gitweb:        https://git.kernel.org/tip/98d0c8ebf77e0ba7c54a9ae05ea588f0e9e3f46e
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Sat, 25 Apr 2020 05:03:08 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Apr 2020 12:22:29 +02:00

x86/unwind/orc: Prevent unwinding before ORC initialization

If the unwinder is called before the ORC data has been initialized,
orc_find() returns NULL, and it tries to fall back to using frame
pointers.  This can cause some unexpected warnings during boot.

Move the 'orc_init' check from orc_find() to __unwind_init(), so that it
doesn't even try to unwind from an uninitialized state.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Jones <dsj@fb.com>
Cc: Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lore.kernel.org/r/069d1499ad606d85532eb32ce39b2441679667d5.1587808742.git.jpoimboe@redhat.com
---
 arch/x86/kernel/unwind_orc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index e9f5a20..cb11567 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -148,9 +148,6 @@ static struct orc_entry *orc_find(unsigned long ip)
 {
 	static struct orc_entry *orc;
 
-	if (!orc_init)
-		return NULL;
-
 	if (ip == 0)
 		return &null_orc_entry;
 
@@ -591,6 +588,9 @@ EXPORT_SYMBOL_GPL(unwind_next_frame);
 void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		    struct pt_regs *regs, unsigned long *first_frame)
 {
+	if (!orc_init)
+		goto done;
+
 	memset(state, 0, sizeof(*state));
 	state->task = task;
 
