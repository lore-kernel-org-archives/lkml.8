Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51542C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3485920848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCFOmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53877 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgCFOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEBA-0006Qh-AT; Fri, 06 Mar 2020 15:42:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1AF081C21DE;
        Fri,  6 Mar 2020 15:42:15 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:14 -0000
From:   "tip-bot2 for Peter Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Allow smp_call_function_single_async() to insert
 locked csd
Cc:     Peter Xu <peterx@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191216213125.9536-2-peterx@redhat.com>
References: <20191216213125.9536-2-peterx@redhat.com>
MIME-Version: 1.0
Message-ID: <158350573482.28353.599979818559142437.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     5a18ceca63502546d6c0cab1f3f79cb6900f947a
Gitweb:        https://git.kernel.org/tip/5a18ceca63502546d6c0cab1f3f79cb6900f947a
Author:        Peter Xu <peterx@redhat.com>
AuthorDate:    Mon, 16 Dec 2019 16:31:23 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 13:42:28 +01:00

smp: Allow smp_call_function_single_async() to insert locked csd

Previously we will raise an warning if we want to insert a csd object
which is with the LOCK flag set, and if it happens we'll also wait for
the lock to be released.  However, this operation does not match
perfectly with how the function is named - the name with "_async"
suffix hints that this function should not block, while we will.

This patch changed this behavior by simply return -EBUSY instead of
waiting, at the meantime we allow this operation to happen without
warning the user to change this into a feature when the caller wants
to "insert a csd object, if it's there, just wait for that one".

This is pretty safe because in flush_smp_call_function_queue() for
async csd objects (where csd->flags&SYNC is zero) we'll first do the
unlock then we call the csd->func().  So if we see the csd->flags&LOCK
is true in smp_call_function_single_async(), then it's guaranteed that
csd->func() will be called after this smp_call_function_single_async()
returns -EBUSY.

Update the comment of the function too to refect this.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20191216213125.9536-2-peterx@redhat.com
---
 kernel/smp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index d0ada39..97f1d97 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -329,6 +329,11 @@ EXPORT_SYMBOL(smp_call_function_single);
  * (ie: embedded in an object) and is responsible for synchronizing it
  * such that the IPIs performed on the @csd are strictly serialized.
  *
+ * If the function is called with one csd which has not yet been
+ * processed by previous call to smp_call_function_single_async(), the
+ * function will return immediately with -EBUSY showing that the csd
+ * object is still in progress.
+ *
  * NOTE: Be careful, there is unfortunately no current debugging facility to
  * validate the correctness of this serialization.
  */
@@ -338,14 +343,17 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 
 	preempt_disable();
 
-	/* We could deadlock if we have to wait here with interrupts disabled! */
-	if (WARN_ON_ONCE(csd->flags & CSD_FLAG_LOCK))
-		csd_lock_wait(csd);
+	if (csd->flags & CSD_FLAG_LOCK) {
+		err = -EBUSY;
+		goto out;
+	}
 
 	csd->flags = CSD_FLAG_LOCK;
 	smp_wmb();
 
 	err = generic_exec_single(cpu, csd, csd->func, csd->info);
+
+out:
 	preempt_enable();
 
 	return err;
