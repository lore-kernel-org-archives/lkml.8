Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBB6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6D722CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fhk+wVb8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qJzIge7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgH0Hyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:54:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36502 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgH0HyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:18 -0400
Date:   Thu, 27 Aug 2020 07:54:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wbn1+5gr2L/3s1Z4vMTGKHm4sfvoBAtLywzf7x6kL4=;
        b=Fhk+wVb8jjYx3+gXDuU/cPbpxCoJ/Jvz3qTjff81l9lHf75dFz3INASMcir+E6E9UwM3IX
        epL+86yAc/xl5BUrBMY9Gq3x8MExfATveoH+PtfY5oSj4a+KG8a37VWWh6SGQzLRX/3GsJ
        zW9jZpxGw+CU3lTXAYwYJegBIqpCPwfh1hlky8jPPDTcmMvhQJ6Mb8O908+WD/Mb/vouZ5
        DNk4JEwaKLG0cUC6K1V3kAskKr9qsMLuhQ/Ik6BGMZBLCTQhj0m9y19N6dfb+PE5EdFxLL
        iEwI1kOj6H03uznFvnkqZ0CYFyj1tr2NOmVcSb4hgsTV2fgDAKuNlnvOjqZzEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wbn1+5gr2L/3s1Z4vMTGKHm4sfvoBAtLywzf7x6kL4=;
        b=qJzIge7sMJjx9ecpkws/CY4D+YLlEMc59FvaPMZt3pFTrs608Kxe3rdjgx9jXg9l3TW35i
        7JXpdIiuc4P9bMCw==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/selftest: Add test cases for queued_read_lock()
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-19-boqun.feng@gmail.com>
References: <20200807074238.1632519-19-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485506.20229.16118500942576736080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ad56450db86413ff911eb527b5a49e04a4345e61
Gitweb:        https://git.kernel.org/tip/ad56450db86413ff911eb527b5a49e04a4345e61
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:37 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:07 +02:00

locking/selftest: Add test cases for queued_read_lock()

Add two self test cases for the following case:

	P0:			P1:			P2:

				<in irq handler>
	spin_lock_irq(&slock)	read_lock(&rwlock)
							write_lock_irq(&rwlock)
	read_lock(&rwlock)	spin_lock(&slock)

, which is a deadlock, as the read_lock() on P0 cannot get the lock
because of the fairness.

	P0:			P1:			P2:

	<in irq handler>
	spin_lock(&slock)	read_lock(&rwlock)
							write_lock(&rwlock)
	read_lock(&rwlock)	spin_lock_irq(&slock)

, which is not a deadlock, as the read_lock() on P0 can get the lock
because it could use the unfair fastpass.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-19-boqun.feng@gmail.com
---
 lib/locking-selftest.c | 104 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 4264cf4..17f8f6f 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2201,6 +2201,108 @@ static void ww_tests(void)
 	pr_cont("\n");
 }
 
+
+/*
+ * <in hardirq handler>
+ * read_lock(&A);
+ *			<hardirq disable>
+ *			spin_lock(&B);
+ * spin_lock(&B);
+ *			read_lock(&A);
+ *
+ * is a deadlock.
+ */
+static void queued_read_lock_hardirq_RE_Er(void)
+{
+	HARDIRQ_ENTER();
+	read_lock(&rwlock_A);
+	LOCK(B);
+	UNLOCK(B);
+	read_unlock(&rwlock_A);
+	HARDIRQ_EXIT();
+
+	HARDIRQ_DISABLE();
+	LOCK(B);
+	read_lock(&rwlock_A);
+	read_unlock(&rwlock_A);
+	UNLOCK(B);
+	HARDIRQ_ENABLE();
+}
+
+/*
+ * <in hardirq handler>
+ * spin_lock(&B);
+ *			<hardirq disable>
+ *			read_lock(&A);
+ * read_lock(&A);
+ *			spin_lock(&B);
+ *
+ * is not a deadlock.
+ */
+static void queued_read_lock_hardirq_ER_rE(void)
+{
+	HARDIRQ_ENTER();
+	LOCK(B);
+	read_lock(&rwlock_A);
+	read_unlock(&rwlock_A);
+	UNLOCK(B);
+	HARDIRQ_EXIT();
+
+	HARDIRQ_DISABLE();
+	read_lock(&rwlock_A);
+	LOCK(B);
+	UNLOCK(B);
+	read_unlock(&rwlock_A);
+	HARDIRQ_ENABLE();
+}
+
+/*
+ * <hardirq disable>
+ * spin_lock(&B);
+ *			read_lock(&A);
+ *			<in hardirq handler>
+ *			spin_lock(&B);
+ * read_lock(&A);
+ *
+ * is a deadlock. Because the two read_lock()s are both non-recursive readers.
+ */
+static void queued_read_lock_hardirq_inversion(void)
+{
+
+	HARDIRQ_ENTER();
+	LOCK(B);
+	UNLOCK(B);
+	HARDIRQ_EXIT();
+
+	HARDIRQ_DISABLE();
+	LOCK(B);
+	read_lock(&rwlock_A);
+	read_unlock(&rwlock_A);
+	UNLOCK(B);
+	HARDIRQ_ENABLE();
+
+	read_lock(&rwlock_A);
+	read_unlock(&rwlock_A);
+}
+
+static void queued_read_lock_tests(void)
+{
+	printk("  --------------------------------------------------------------------------\n");
+	printk("  | queued read lock tests |\n");
+	printk("  ---------------------------\n");
+	print_testname("hardirq read-lock/lock-read");
+	dotest(queued_read_lock_hardirq_RE_Er, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("\n");
+
+	print_testname("hardirq lock-read/read-lock");
+	dotest(queued_read_lock_hardirq_ER_rE, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("\n");
+
+	print_testname("hardirq inversion");
+	dotest(queued_read_lock_hardirq_inversion, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("\n");
+}
+
 void locking_selftest(void)
 {
 	/*
@@ -2318,6 +2420,8 @@ void locking_selftest(void)
 	/*
 	 * queued_read_lock() specific test cases can be put here
 	 */
+	if (IS_ENABLED(CONFIG_QUEUED_RWLOCKS))
+		queued_read_lock_tests();
 
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
