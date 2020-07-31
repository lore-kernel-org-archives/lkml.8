Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65828C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405B522B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ulU7+gJ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aEVSuc6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbgGaJXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732246AbgGaJWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:50 -0400
Date:   Fri, 31 Jul 2020 09:22:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e/q7g8603tY2wciC0otrbc2M6DYeXdjCjpcxJZy7Cuk=;
        b=ulU7+gJ8KAGJac9vLP10ODRmLe6Uz4w0JNXU9biaGBmivZRJOSyFKsYRzy06McrXGw4IeK
        pXj+M4eRNSud9jHBc9tEDNgMGUdllCkqNKQZrwRJOCQox92q/vNE5OR3abxrPPj5++kkwO
        fObkkCscsRBjpABmULVnARMm0vMf0arV5RHJz2RSJeZ/6L/84IaE76WC2WRpD5dZktzWKl
        QJW/T4wpljZiTHNWDxJOAZultKC0LFFM/6XSnV/2yDdg26gUyl+wQEvmjRjMriRF7tSxFT
        JUXPr/qEUmw0okEeY3iRIWkGIe/ru5BNRK73XqsTZ5dXDzPCBSSKwff1NHW+xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e/q7g8603tY2wciC0otrbc2M6DYeXdjCjpcxJZy7Cuk=;
        b=aEVSuc6eZmYJHu+PPGghXJe7Q1EbSMowFH6zcjkeCwH4ObA8G/27CVxyUMEdC519lJP3CI
        AXKcIsEQrbl9G3Dw==
From:   "tip-bot2 for Zou Wei" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locktorture: Use true and false to assign to bool variables
Cc:     Hulk Robot <hulkci@huawei.com>, Zou Wei <zou_wei@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736800.4006.15688152842342004291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d02c6b52d12fa30eeabfaf5aefe12078eacb94b2
Gitweb:        https://git.kernel.org/tip/d02c6b52d12fa30eeabfaf5aefe12078eacb94b2
Author:        Zou Wei <zou_wei@huawei.com>
AuthorDate:    Mon, 13 Apr 2020 20:02:59 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

locktorture: Use true and false to assign to bool variables

This commit fixes the following coccicheck warnings:

kernel/locking/locktorture.c:689:6-10: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:907:2-20: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:938:3-20: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:668:2-19: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:674:2-19: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:634:2-20: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:640:2-20: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 5efbfc6..8ff6f50 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -631,13 +631,13 @@ static int lock_torture_writer(void *arg)
 		cxt.cur_ops->writelock();
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lwsp->n_lock_fail++;
-		lock_is_write_held = 1;
+		lock_is_write_held = true;
 		if (WARN_ON_ONCE(lock_is_read_held))
 			lwsp->n_lock_fail++; /* rare, but... */
 
 		lwsp->n_lock_acquired++;
 		cxt.cur_ops->write_delay(&rand);
-		lock_is_write_held = 0;
+		lock_is_write_held = false;
 		cxt.cur_ops->writeunlock();
 
 		stutter_wait("lock_torture_writer");
@@ -665,13 +665,13 @@ static int lock_torture_reader(void *arg)
 			schedule_timeout_uninterruptible(1);
 
 		cxt.cur_ops->readlock();
-		lock_is_read_held = 1;
+		lock_is_read_held = true;
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lrsp->n_lock_fail++; /* rare, but... */
 
 		lrsp->n_lock_acquired++;
 		cxt.cur_ops->read_delay(&rand);
-		lock_is_read_held = 0;
+		lock_is_read_held = false;
 		cxt.cur_ops->readunlock();
 
 		stutter_wait("lock_torture_reader");
@@ -686,7 +686,7 @@ static int lock_torture_reader(void *arg)
 static void __torture_print_stats(char *page,
 				  struct lock_stress_stats *statp, bool write)
 {
-	bool fail = 0;
+	bool fail = false;
 	int i, n_stress;
 	long max = 0, min = statp ? statp[0].n_lock_acquired : 0;
 	long long sum = 0;
@@ -904,7 +904,7 @@ static int __init lock_torture_init(void)
 
 	/* Initialize the statistics so that each run gets its own numbers. */
 	if (nwriters_stress) {
-		lock_is_write_held = 0;
+		lock_is_write_held = false;
 		cxt.lwsa = kmalloc_array(cxt.nrealwriters_stress,
 					 sizeof(*cxt.lwsa),
 					 GFP_KERNEL);
@@ -935,7 +935,7 @@ static int __init lock_torture_init(void)
 		}
 
 		if (nreaders_stress) {
-			lock_is_read_held = 0;
+			lock_is_read_held = false;
 			cxt.lrsa = kmalloc_array(cxt.nrealreaders_stress,
 						 sizeof(*cxt.lrsa),
 						 GFP_KERNEL);
