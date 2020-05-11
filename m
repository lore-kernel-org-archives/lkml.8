Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9BDC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EA92078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbgEKVC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732068AbgEKVAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:00:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE38C061A0E;
        Mon, 11 May 2020 14:00:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWp-00060s-Iy; Mon, 11 May 2020 22:59:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2E2991C07F8;
        Mon, 11 May 2020 22:59:43 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:43 -0000
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Get rid of some doc warnings in update.c
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923078309.390.2071709326416344298.tip-bot2@tip-bot2>
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

Commit-ID:     c28d5c09d09f86374a00b70a57d3cb75e3fc7fa9
Gitweb:        https://git.kernel.org/tip/c28d5c09d09f86374a00b70a57d3cb75e3fc7fa9
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Tue, 17 Mar 2020 15:54:18 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:01:16 -07:00

rcu: Get rid of some doc warnings in update.c

This commit escapes *ret, because otherwise the documentation system
thinks that this is an incomplete emphasis block:

	./kernel/rcu/update.c:65: WARNING: Inline emphasis start-string without end-string.
	./kernel/rcu/update.c:65: WARNING: Inline emphasis start-string without end-string.
	./kernel/rcu/update.c:70: WARNING: Inline emphasis start-string without end-string.
	./kernel/rcu/update.c:82: WARNING: Inline emphasis start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 28a8bdc..72461dd 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -63,12 +63,12 @@ module_param(rcu_normal_after_boot, int, 0);
  * rcu_read_lock_held_common() - might we be in RCU-sched read-side critical section?
  * @ret:	Best guess answer if lockdep cannot be relied on
  *
- * Returns true if lockdep must be ignored, in which case *ret contains
+ * Returns true if lockdep must be ignored, in which case ``*ret`` contains
  * the best guess described below.  Otherwise returns false, in which
- * case *ret tells the caller nothing and the caller should instead
+ * case ``*ret`` tells the caller nothing and the caller should instead
  * consult lockdep.
  *
- * If CONFIG_DEBUG_LOCK_ALLOC is selected, set *ret to nonzero iff in an
+ * If CONFIG_DEBUG_LOCK_ALLOC is selected, set ``*ret`` to nonzero iff in an
  * RCU-sched read-side critical section.  In absence of
  * CONFIG_DEBUG_LOCK_ALLOC, this assumes we are in an RCU-sched read-side
  * critical section unless it can prove otherwise.  Note that disabling
@@ -82,7 +82,7 @@ module_param(rcu_normal_after_boot, int, 0);
  *
  * Note that if the CPU is in the idle loop from an RCU point of view (ie:
  * that we are in the section between rcu_idle_enter() and rcu_idle_exit())
- * then rcu_read_lock_held() sets *ret to false even if the CPU did an
+ * then rcu_read_lock_held() sets ``*ret`` to false even if the CPU did an
  * rcu_read_lock().  The reason for this is that RCU ignores CPUs that are
  * in such a section, considering these as in extended quiescent state,
  * so such a CPU is effectively never in an RCU read-side critical section
