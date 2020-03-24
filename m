Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BB3C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C8B20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCXJRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:17:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44059 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbgCXJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:03 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgC-0008Bp-5I; Tue, 24 Mar 2020 10:17:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AB0C91C0451;
        Tue, 24 Mar 2020 10:16:48 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:48 -0000
From:   "tip-bot2 for Amol Grover" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rculist: Add brackets around cond argument in
 __list_check_rcu macro
Cc:     Amol Grover <frextrite@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140839.28353.7116236861803686306.tip-bot2@tip-bot2>
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

Commit-ID:     4dfd5cd83dc4458049c7f6eb9c4f361acc4239ea
Gitweb:        https://git.kernel.org/tip/4dfd5cd83dc4458049c7f6eb9c4f361acc4239ea
Author:        Amol Grover <frextrite@gmail.com>
AuthorDate:    Sat, 18 Jan 2020 22:24:18 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:23 -08:00

rculist: Add brackets around cond argument in __list_check_rcu macro

Passing a complex lockdep condition to __list_check_rcu results
in false positive lockdep splat due to incorrect expression
evaluation.

For example, a lockdep check condition `cond1 || cond2` is
evaluated as `!cond1 || cond2 && !rcu_read_lock_any_held()`
which, according to operator precedence, evaluates to
`!cond1 || (cond2 && !rcu_read_lock_any_held())`.
This would result in a lockdep splat when cond1 is false
and cond2 is true which is logically incorrect.

Signed-off-by: Amol Grover <frextrite@gmail.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 9f313e4..8214cdc 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -60,9 +60,9 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
 #define __list_check_rcu(dummy, cond, extra...)				\
 	({								\
 	check_arg_count_one(extra);					\
-	RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),		\
+	RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(),		\
 			 "RCU-list traversed in non-reader section!");	\
-	 })
+	})
 #else
 #define __list_check_rcu(dummy, cond, extra...)				\
 	({ check_arg_count_one(extra); })
