Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F02DC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110B720A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCXJQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:16:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43970 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgCXJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:48 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffx-000839-M3; Tue, 24 Mar 2020 10:16:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E2D051C04D1;
        Tue, 24 Mar 2020 10:16:39 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:39 -0000
From:   "tip-bot2 for Jules Irenge" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add missing annotation for exit_tasks_rcu_finish()
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139960.28353.10219398307584932917.tip-bot2@tip-bot2>
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

Commit-ID:     90ba11ba99e0a4cc75302335d10a225b27a44918
Gitweb:        https://git.kernel.org/tip/90ba11ba99e0a4cc75302335d10a225b27a44918
Author:        Jules Irenge <jbi.octave@gmail.com>
AuthorDate:    Mon, 20 Jan 2020 22:41:54 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:00:45 -08:00

rcu: Add missing annotation for exit_tasks_rcu_finish()

Sparse reports a warning at exit_tasks_rcu_finish(void)

|warning: context imbalance in exit_tasks_rcu_finish()
|- wrong count at exit

To fix this, this commit adds a __releases(&tasks_rcu_exit_srcu).
Given that exit_tasks_rcu_finish() does actually call __srcu_read_lock(),
this not only fixes the warning but also improves on the readability of
the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index a04fe54..ede656c 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -809,7 +809,7 @@ void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
 }
 
 /* Do the srcu_read_unlock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_finish(void)
+void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
 {
 	preempt_disable();
 	__srcu_read_unlock(&tasks_rcu_exit_srcu, current->rcu_tasks_idx);
