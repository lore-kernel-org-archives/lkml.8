Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA2C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4C12078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbgEKVEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731871AbgEKU7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5800C061A0C;
        Mon, 11 May 2020 13:59:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWL-0005iz-CH; Mon, 11 May 2020 22:59:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 52CCF1C0494;
        Mon, 11 May 2020 22:59:21 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:21 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Use data_race() for RCU expedited CPU
 stall-warning prints
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076125.390.1656849191203394981.tip-bot2@tip-bot2>
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

Commit-ID:     654db05cee8186cf9438d94ef32a4f9ffe964e57
Gitweb:        https://git.kernel.org/tip/654db05cee8186cf9438d94ef32a4f9ffe964e57
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 09 Feb 2020 02:35:22 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:04:37 -07:00

rcu: Use data_race() for RCU expedited CPU stall-warning prints

Although the accesses used to determine whether or not an expedited
stall should be printed are an integral part of the concurrency algorithm
governing use of the corresponding variables, the values that are simply
printed are ancillary.  As such, it is best to use data_race() for these
accesses in order to provide the greatest latitude in the use of KCSAN
for the other accesses that are an integral part of the algorithm.  This
commit therefore changes the relevant uses of READ_ONCE() to data_race().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 1a617b9..e1a7986 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -542,8 +542,8 @@ static void synchronize_rcu_expedited_wait(void)
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
 			jiffies - jiffies_start, rcu_state.expedited_sequence,
-			READ_ONCE(rnp_root->expmask),
-			".T"[!!rnp_root->exp_tasks]);
+			data_race(rnp_root->expmask),
+			".T"[!!data_race(rnp_root->exp_tasks)]);
 		if (ndetected) {
 			pr_err("blocking rcu_node structures:");
 			rcu_for_each_node_breadth_first(rnp) {
@@ -553,8 +553,8 @@ static void synchronize_rcu_expedited_wait(void)
 					continue;
 				pr_cont(" l=%u:%d-%d:%#lx/%c",
 					rnp->level, rnp->grplo, rnp->grphi,
-					READ_ONCE(rnp->expmask),
-					".T"[!!rnp->exp_tasks]);
+					data_race(rnp->expmask),
+					".T"[!!data_race(rnp->exp_tasks)]);
 			}
 			pr_cont("\n");
 		}
