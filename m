Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1081C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98272064C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oTfPBjw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGFVRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFVRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:17:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C9C061755;
        Mon,  6 Jul 2020 14:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P88oZ37BuRk0q97qZsN937hiSJsTqzAUB6z4SutUkA8=; b=oTfPBjw3DSX47ZlrlHZc1dng6G
        U5jqeWkTU9UaYLnmm1nqNMzoz0qb5pa1QtoKvdDxI0pas9+6B17e8sOFvU+odUG/2TsGz5OC/39Y5
        7PtjuHGATiCyIHtNIUhLOPlyj+QkLt+KuUmpFFzLVQY9EVuxQVMvqop4XCg0hTMp2GPeaO7yO7aSc
        xvnh7QGZ2ZXliIpIU06qlKPgQ0MWmlgtlfxX+zhhwnMKaGwRCdTUTWXf+dXq9uU2ZYHBS1pIFLQli
        N74ypxFdEdz3gs0MAJd/zUyxsRV6fcOy1PzGyoWmrMokUiiZeqwSrrYQ15Upn1VKs3HvqAT1vFNaX
        0mnfikFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsYU1-00046F-0n; Mon, 06 Jul 2020 21:17:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 445F0980D7D; Mon,  6 Jul 2020 23:16:59 +0200 (CEST)
Date:   Mon, 6 Jul 2020 23:16:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 01/20] Documentation: locking: Describe seqlock design
 and usage
Message-ID: <20200706211659.GA5551@worktop.programming.kicks-ass.net>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-2-a.darwish@linutronix.de>
 <20200706210439.GD5523@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706210439.GD5523@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 11:04:39PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 30, 2020 at 07:44:33AM +0200, Ahmed S. Darwish wrote:
> > +Sequence counters (:c:type:`seqcount_t`)
> > +========================================
> 
> > +.. code-block:: c
> 
> I so hate RST, of course it's C. Also, ISTR Jon saying you can leave
> that all out without issue.

Something like the below, and then there's all that :ref: nonsense in
that's unreadable gibberish.


Index: linux-2.6/Documentation/locking/seqlock.rst
===================================================================
--- linux-2.6.orig/Documentation/locking/seqlock.rst
+++ linux-2.6/Documentation/locking/seqlock.rst
@@ -33,10 +33,8 @@ class, it can spin forever and the kerne
 This mechanism cannot be used if the protected data contains pointers,
 as the writer can invalidate a pointer that the reader is following.
 
-.. _seqcount_t:
-
-Sequence counters (:c:type:`seqcount_t`)
-========================================
+Sequence counters (`seqcount_t`)
+================================
 
 This is the the raw counting mechanism, which does not protect against
 multiple writers.  Write side critical sections must thus be serialized
@@ -56,8 +54,6 @@ requirements, use a :ref:`sequential loc
 
 Initialization:
 
-.. code-block:: c
-
 	/* dynamic */
 	seqcount_t foo_seqcount;
 	seqcount_init(&foo_seqcount);
@@ -72,9 +68,6 @@ Initialization:
 
 Write path:
 
-.. _seqcount_write_ops:
-.. code-block:: c
-
 	/* Serialized context with disabled preemption */
 
 	write_seqcount_begin(&foo_seqcount);
@@ -85,9 +78,6 @@ Write path:
 
 Read path:
 
-.. _seqcount_read_ops:
-.. code-block:: c
-
 	do {
 		seq = read_seqcount_begin(&foo_seqcount);
 
@@ -95,9 +85,7 @@ Read path:
 
 	} while (read_seqcount_retry(&foo_seqcount, seq));
 
-.. _seqcount_locktype_t:
-
-Sequence counters with associated locks (:c:type:`seqcount_LOCKTYPE_t`)
+Sequence counters with associated locks (`seqcount_LOCKTYPE_t`)
 -----------------------------------------------------------------------
 
 As :ref:`earlier discussed <seqcount_t>`, seqcount write side critical
@@ -117,11 +105,11 @@ protection is enforced in the write side
 
 The following seqcounts with associated locks are defined:
 
-  - :c:type:`seqcount_spinlock_t`
-  - :c:type:`seqcount_raw_spinlock_t`
-  - :c:type:`seqcount_rwlock_t`
-  - :c:type:`seqcount_mutex_t`
-  - :c:type:`seqcount_ww_mutex_t`
+  - `seqcount_spinlock_t`
+  - `seqcount_raw_spinlock_t`
+  - `seqcount_rwlock_t`
+  - `seqcount_mutex_t`
+  - `seqcount_ww_mutex_t`
 
 The plain seqcount read and write APIs branch out to the specific
 seqcount_LOCKTYPE_t implementation at compile-time. This avoids kernel
@@ -129,8 +117,6 @@ API explosion per each new seqcount LOCK
 
 Initialization (replace "LOCKTYPE" with one of the supported locks):
 
-.. code-block:: c
-
 	/* dynamic */
 	seqcount_LOCKTYPE_t foo_seqcount;
 	seqcount_LOCKTYPE_init(&foo_seqcount, &lock);
@@ -149,9 +135,7 @@ while running from a context with the as
 
 Read path: same as in :ref:`plain seqcount_t <seqcount_read_ops>`.
 
-.. _seqlock_t:
-
-Sequential locks (:c:type:`seqlock_t`)
+Sequential locks (`seqlock_t`)
 ======================================
 
 This contains the :ref:`sequence counting mechanism <seqcount_t>`
@@ -164,8 +148,6 @@ halves respectively.
 
 Initialization:
 
-.. code-block:: c
-
 	/* dynamic */
 	seqlock_t foo_seqlock;
 	seqlock_init(&foo_seqlock);
@@ -180,8 +162,6 @@ Initialization:
 
 Write path:
 
-.. code-block:: c
-
 	write_seqlock(&foo_seqlock);
 
 	/* ... [[write-side critical section]] ... */
@@ -194,8 +174,6 @@ Read path, three categories:
    retry if a writer is in progress by detecting change in the sequence
    number.  Writers do not wait for a sequence reader.
 
-   .. code-block:: c
-
 	do {
 		seq = read_seqbegin(&foo_seqlock);
 
@@ -208,8 +186,6 @@ Read path, three categories:
    from entering its critical section. This read lock is
    exclusive. Unlike rwlock_t, only one locking reader can acquire it.
 
-   .. code-block:: c
-
 	read_seqlock_excl(&foo_seqlock);
 
 	/* ... [[read-side critical section]] ... */
@@ -224,8 +200,6 @@ Read path, three categories:
    the next iteration marker), the lockless read is transformed to a
    full locking read and no retry loop is necessary.
 
-   .. code-block:: c
-
 	/* marker; even initialization */
 	int seq = 0;
 	do {

