Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DE0C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40AB2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbgEKVDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732022AbgEKU7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B371FC061A0C;
        Mon, 11 May 2020 13:59:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWg-0005vi-N1; Mon, 11 May 2020 22:59:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8FCEA1C04CC;
        Mon, 11 May 2020 22:59:37 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:37 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove unused
 ->rcu_read_unlock_special.b.deferred_qs field
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077748.390.684697093024048383.tip-bot2@tip-bot2>
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

Commit-ID:     f0bdf6d473cf12a488a78422e15aafdfe77cf853
Gitweb:        https://git.kernel.org/tip/f0bdf6d473cf12a488a78422e15aafdfe77cf853
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Sat, 15 Feb 2020 14:52:32 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:50 -07:00

rcu: Remove unused ->rcu_read_unlock_special.b.deferred_qs field

The ->rcu_read_unlock_special.b.deferred_qs field is set to true in
rcu_read_unlock_special() but never set to false.  This is not
particularly useful, so this commit removes this field.

The only possible justification for this field is to ease debugging
of RCU deferred quiscent states, but the combination of the other
->rcu_read_unlock_special fields plus ->rcu_blocked_node and of course
->rcu_read_lock_nesting should cover debugging needs.  And if this last
proves incorrect, this patch can always be reverted, along with the
required setting of ->rcu_read_unlock_special.b.deferred_qs to false
in rcu_preempt_deferred_qs_irqrestore().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/sched.h    | 2 +-
 kernel/rcu/tree_plugin.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5c..a4b727f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -613,7 +613,7 @@ union rcu_special {
 		u8			blocked;
 		u8			need_qs;
 		u8			exp_hint; /* Hint for performance. */
-		u8			deferred_qs;
+		u8			pad; /* No garbage from compiler! */
 	} b; /* Bits. */
 	u32 s; /* Set of bits. */
 };
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 263c766..f31c599 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -634,7 +634,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
 		}
-		t->rcu_read_unlock_special.b.deferred_qs = true;
 		local_irq_restore(flags);
 		return;
 	}
