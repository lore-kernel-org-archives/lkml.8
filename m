Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F364C2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EC020774
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgC1LwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:52:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55714 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgC1LwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:52:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIA0S-0004Rc-Gw; Sat, 28 Mar 2020 12:52:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E63E71C03A9;
        Sat, 28 Mar 2020 12:52:03 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:52:03 -0000
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] Documentation/locking/locktypes: Minor copy editor fixes
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <ac615f36-0b44-408d-aeab-d76e4241add4@infradead.org>
References: <ac615f36-0b44-408d-aeab-d76e4241add4@infradead.org>
MIME-Version: 1.0
Message-ID: <158539632348.28353.11072082042183429562.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     51e69e6551a8c6fffe0185ba305bb4e2d7223616
Gitweb:        https://git.kernel.org/tip/51e69e6551a8c6fffe0185ba305bb4e2d7223616
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Wed, 25 Mar 2020 09:58:14 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 28 Mar 2020 12:47:34 +01:00

Documentation/locking/locktypes: Minor copy editor fixes

Minor editorial fixes:
- remove 'enabled' from PREEMPT_RT enabled kernels for consistency
- add some periods for consistency
- add "'" for possessive CPU's
- spell out interrupts

[ tglx: Picked up Paul's suggestions ]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/ac615f36-0b44-408d-aeab-d76e4241add4@infradead.org

---
 Documentation/locking/locktypes.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
index 1c18bb8..09f45ce 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -84,7 +84,7 @@ rtmutex
 
 RT-mutexes are mutexes with support for priority inheritance (PI).
 
-PI has limitations on non PREEMPT_RT enabled kernels due to preemption and
+PI has limitations on non-PREEMPT_RT kernels due to preemption and
 interrupt disabled sections.
 
 PI clearly cannot preempt preemption-disabled or interrupt-disabled
@@ -150,7 +150,7 @@ kernel configuration including PREEMPT_RT enabled kernels.
 
 raw_spinlock_t is a strict spinning lock implementation in all kernels,
 including PREEMPT_RT kernels.  Use raw_spinlock_t only in real critical
-core code, low level interrupt handling and places where disabling
+core code, low-level interrupt handling and places where disabling
 preemption or interrupts is required, for example, to safely access
 hardware state.  raw_spinlock_t can sometimes also be used when the
 critical section is tiny, thus avoiding RT-mutex overhead.
@@ -160,20 +160,20 @@ spinlock_t
 
 The semantics of spinlock_t change with the state of PREEMPT_RT.
 
-On a non PREEMPT_RT enabled kernel spinlock_t is mapped to raw_spinlock_t
-and has exactly the same semantics.
+On a non-PREEMPT_RT kernel spinlock_t is mapped to raw_spinlock_t and has
+exactly the same semantics.
 
 spinlock_t and PREEMPT_RT
 -------------------------
 
-On a PREEMPT_RT enabled kernel spinlock_t is mapped to a separate
-implementation based on rt_mutex which changes the semantics:
+On a PREEMPT_RT kernel spinlock_t is mapped to a separate implementation
+based on rt_mutex which changes the semantics:
 
- - Preemption is not disabled
+ - Preemption is not disabled.
 
  - The hard interrupt related suffixes for spin_lock / spin_unlock
-   operations (_irq, _irqsave / _irqrestore) do not affect the CPUs
-   interrupt disabled state
+   operations (_irq, _irqsave / _irqrestore) do not affect the CPU's
+   interrupt disabled state.
 
  - The soft interrupt related suffix (_bh()) still disables softirq
    handlers.
@@ -279,8 +279,8 @@ fully preemptible context.  Instead, use spin_lock_irq() or
 spin_lock_irqsave() and their unlock counterparts.  In cases where the
 interrupt disabling and locking must remain separate, PREEMPT_RT offers a
 local_lock mechanism.  Acquiring the local_lock pins the task to a CPU,
-allowing things like per-CPU irq-disabled locks to be acquired.  However,
-this approach should be used only where absolutely necessary.
+allowing things like per-CPU interrupt disabled locks to be acquired.
+However, this approach should be used only where absolutely necessary.
 
 
 raw_spinlock_t
