Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C28FC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EC920A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgCXJSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:18:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbgCXJRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg9-00087B-E7; Tue, 24 Mar 2020 10:16:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E81571C0493;
        Tue, 24 Mar 2020 10:16:43 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:43 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locktorture: Use private random-number generators
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140357.28353.10447478189057385832.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c0e1472d80784206ead1dd803dd4bc10e282b17f
Gitweb:        https://git.kernel.org/tip/c0e1472d80784206ead1dd803dd4bc10e282b17f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 24 Jan 2020 12:58:15 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:59:59 -08:00

locktorture: Use private random-number generators

Both lock_torture_writer() and lock_torture_reader() use the "static"
keyword on their DEFINE_TORTURE_RANDOM(rand) declarations, which means
that a single instance of a random-number generator are shared among all
the writers and another is shared among all the readers.  Unfortunately,
this random-number generator was not designed for concurrent access.
This commit therefore removes both "static" keywords so that each reader
and each writer gets its own random-number generator.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 687c1d8..5baf904 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -618,7 +618,7 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
 static int lock_torture_writer(void *arg)
 {
 	struct lock_stress_stats *lwsp = arg;
-	static DEFINE_TORTURE_RANDOM(rand);
+	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
 	set_user_nice(current, MAX_NICE);
@@ -655,7 +655,7 @@ static int lock_torture_writer(void *arg)
 static int lock_torture_reader(void *arg)
 {
 	struct lock_stress_stats *lrsp = arg;
-	static DEFINE_TORTURE_RANDOM(rand);
+	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("lock_torture_reader task started");
 	set_user_nice(current, MAX_NICE);
