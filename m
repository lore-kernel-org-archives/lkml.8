Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB716C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EF520714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o1zl9slY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgCWPwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:52:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCWPwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ysalBJzhuJVJmOkBVr4y/sPJxWq5OuY+ZimbIwAKEcs=; b=o1zl9slYsnK310chqMTVz6ctmY
        OmCkgh5gHMdklsfTfA87pKDo2SKUnVIOD5HFTActx8i8muWVBEZUm5tt4F9yMCmlvW6MWxrUIHxxu
        TgMIOBdWU+dYL2MfGcFNrD1enc7ZEeBwz9gwNd/yS2DhvXjgpQklInlQryQSbaUAsKnortVI1rv26
        RFYR/smtJTc/k5Ynszyk7WGe9Sbg0hDFJ38n16/fyxLayaDpq+xjXd73+CwbtJud9v5SNlqdpBBNf
        tP6SOj+KUdn49GI5IN6GYfVq/vLiPquI864gqc2PYB8W6liP8uXHoqDN+b+6B4MiE6+PMA/l+qWxT
        SBJDPhOw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGPNV-0000U6-4c; Mon, 23 Mar 2020 15:52:37 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Docs: locktypes: minor fixes
Message-ID: <27884858-6468-bbc4-0e3e-f36c3b2241c0@infradead.org>
Date:   Mon, 23 Mar 2020 08:52:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Copy editor fixes:
- add some hyphens to multi-word adjectives
- end some sentences with a period ('.') for consistency
- minor wordsmithing
- use semi-colon instead of comma in a sentence


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Applies to your PATCH V3 13/20] of 2020-03-21.

 Documentation/locking/locktypes.rst |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- linux-next-20200323.orig/Documentation/locking/locktypes.rst
+++ linux-next-20200323/Documentation/locking/locktypes.rst
@@ -73,7 +73,7 @@ rtmutex
 
 RT-mutexes are mutexes with support for priority inheritance (PI).
 
-PI has limitations on non PREEMPT_RT enabled kernels due to preemption and
+PI has limitations on non-PREEMPT_RT-enabled kernels due to preemption and
 interrupt disabled sections.
 
 PI clearly cannot preempt preemption-disabled or interrupt-disabled
@@ -90,11 +90,11 @@ raw_spinlock_t
 --------------
 
 raw_spinlock_t is a strict spinning lock implementation regardless of the
-kernel configuration including PREEMPT_RT enabled kernels.
+kernel configuration including PREEMPT_RT-enabled kernels.
 
 raw_spinlock_t is a strict spinning lock implementation in all kernels,
 including PREEMPT_RT kernels.  Use raw_spinlock_t only in real critical
-core code, low level interrupt handling and places where disabling
+core code, low-level interrupt handling and places where disabling
 preemption or interrupts is required, for example, to safely access
 hardware state.  raw_spinlock_t can sometimes also be used when the
 critical section is tiny, thus avoiding RT-mutex overhead.
@@ -104,20 +104,20 @@ spinlock_t
 
 The semantics of spinlock_t change with the state of CONFIG_PREEMPT_RT.
 
-On a non PREEMPT_RT enabled kernel spinlock_t is mapped to raw_spinlock_t
+On a non-PREEMPT_RT-enabled kernel spinlock_t is mapped to raw_spinlock_t
 and has exactly the same semantics.
 
 spinlock_t and PREEMPT_RT
 -------------------------
 
-On a PREEMPT_RT enabled kernel spinlock_t is mapped to a separate
+On a PREEMPT_RT-enabled kernel spinlock_t is mapped to a separate
 implementation based on rt_mutex which changes the semantics:
 
- - Preemption is not disabled
+ - Preemption is not disabled.
 
  - The hard interrupt related suffixes for spin_lock / spin_unlock
    operations (_irq, _irqsave / _irqrestore) do not affect the CPUs
-   interrupt disabled state
+   interrupt disabled state.
 
  - The soft interrupt related suffix (_bh()) still disables softirq
    handlers.
@@ -194,8 +194,8 @@ and is fully equivalent to::
 
 Same applies to rwlock_t and the _irqsave() suffix variants.
 
-On PREEMPT_RT kernel this code sequence breaks because RT-mutex requires a
-fully preemptible context.  Instead, use spin_lock_irq() or
+On a PREEMPT_RT kernel this code sequence breaks because RT-mutex requires
+a fully preemptible context.  Instead, use spin_lock_irq() or
 spin_lock_irqsave() and their unlock counterparts.  In cases where the
 interrupt disabling and locking must remain separate, PREEMPT_RT offers a
 local_lock mechanism.  Acquiring the local_lock pins the task to a CPU,
@@ -257,7 +257,7 @@ The most basic rules are:
 These rules apply in general independent of CONFIG_PREEMPT_RT.
 
 As PREEMPT_RT changes the lock category of spinlock_t and rwlock_t from
-spinning to sleeping this has obviously restrictions how they can nest with
+spinning to sleeping this has obvious restrictions on how they can nest with
 raw_spinlock_t.
 
 This results in the following nest ordering:
@@ -286,7 +286,7 @@ often used for both serialization and wa
 discouraged and should be replaced by separate serialization and wait
 mechanisms, such as mutexes and completions.
 
-rwsems have grown interfaces which allow non owner release for special
+rwsems have grown interfaces which allow non-owner release for special
 purposes. This usage is problematic on PREEMPT_RT because PREEMPT_RT
 substitutes all locking primitives except semaphores with RT-mutex based
 implementations to provide priority inheritance for all lock types except
@@ -295,5 +295,5 @@ obviously impossible.
 
 For now the rwsem non-owner release excludes code which utilizes it from
 being used on PREEMPT_RT enabled kernels. In same cases this can be
-mitigated by disabling portions of the code, in other cases the complete
+mitigated by disabling portions of the code; in other cases the complete
 functionality has to be disabled until a workable solution has been found.


