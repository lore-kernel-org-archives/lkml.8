Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F97C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E58218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgAYKq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:46:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44113 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbgAYKms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:48 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItk-0008KC-Sg; Sat, 25 Jan 2020 11:42:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1A8C91C1A74;
        Sat, 25 Jan 2020 11:42:40 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:39 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Apply *_ONCE() to ->srcu_last_gp_end
Cc:     syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994895991.396.12412703935829811861.tip-bot2@tip-bot2>
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

Commit-ID:     844a378de3372c923909681706d62336d702531e
Gitweb:        https://git.kernel.org/tip/844a378de3372c923909681706d62336d702531e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 04 Nov 2019 08:08:30 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:33:51 -08:00

srcu: Apply *_ONCE() to ->srcu_last_gp_end

The ->srcu_last_gp_end field is accessed from any CPU at any time
by synchronize_srcu(), so non-initialization references need to use
READ_ONCE() and WRITE_ONCE().  This commit therefore makes that change.

Reported-by: syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 5dffade..21acdff 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -530,7 +530,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	idx = rcu_seq_state(ssp->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
 	cbdelay = srcu_get_delay(ssp);
-	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
+	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
 	rcu_seq_end(&ssp->srcu_gp_seq);
 	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
@@ -762,6 +762,7 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	unsigned long flags;
 	struct srcu_data *sdp;
 	unsigned long t;
+	unsigned long tlast;
 
 	/* If the local srcu_data structure has callbacks, not idle.  */
 	local_irq_save(flags);
@@ -780,9 +781,9 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 
 	/* First, see if enough time has passed since the last GP. */
 	t = ktime_get_mono_fast_ns();
+	tlast = READ_ONCE(ssp->srcu_last_gp_end);
 	if (exp_holdoff == 0 ||
-	    time_in_range_open(t, ssp->srcu_last_gp_end,
-			       ssp->srcu_last_gp_end + exp_holdoff))
+	    time_in_range_open(t, tlast, tlast + exp_holdoff))
 		return false; /* Too soon after last GP. */
 
 	/* Next, check for probable idleness. */
