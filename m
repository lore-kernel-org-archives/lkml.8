Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C76C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA09824654
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgBQPkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:40:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60066 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgBQPkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:40:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3iVs-0000DJ-SJ; Mon, 17 Feb 2020 16:40:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 735C21C20AF;
        Mon, 17 Feb 2020 16:40:48 +0100 (CET)
Date:   Mon, 17 Feb 2020 15:40:48 -0000
From:   "tip-bot2 for Amol Grover" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Pass lockdep expression to RCU lists
Cc:     Amol Grover <frextrite@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200216074330.GA14025@workstation-portable>
References: <20200216074330.GA14025@workstation-portable>
MIME-Version: 1.0
Message-ID: <158195404815.13786.1421372964572283195.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9ea9c60fc23c35f865725ab390ca4308de919bb0
Gitweb:        https://git.kernel.org/tip/9ea9c60fc23c35f865725ab390ca4308de919bb0
Author:        Amol Grover <frextrite@gmail.com>
AuthorDate:    Sun, 16 Feb 2020 13:13:30 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2020 16:39:28 +01:00

posix-timers: Pass lockdep expression to RCU lists

head is traversed using hlist_for_each_entry_rcu outside an RCU read-side
critical section but under the protection of hash_lock.

Hence, add corresponding lockdep expression to silence false-positive
lockdep warnings, and harden RCU lists.

[ tglx: Removed the macro and put the condition right where it's used ]

Signed-off-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200216074330.GA14025@workstation-portable

---
 kernel/time/posix-timers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index ff0eb30..07709ac 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -121,7 +121,8 @@ static struct k_itimer *__posix_timers_find(struct hlist_head *head,
 {
 	struct k_itimer *timer;
 
-	hlist_for_each_entry_rcu(timer, head, t_hash) {
+	hlist_for_each_entry_rcu(timer, head, t_hash,
+				 lockdep_is_held(&hash_lock)) {
 		if ((timer->it_signal == sig) && (timer->it_id == id))
 			return timer;
 	}
