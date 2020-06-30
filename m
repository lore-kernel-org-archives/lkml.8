Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C50C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFCA20829
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593538704;
	bh=bP3p7dVexcSkteyD/dA+wmwP54RNKmjexoS8VX/yL5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ubfpwztRNlj4YwTPf2Jp25PoiyL0407MfEG+V68hkyZYEfOa6DyD/hohr87luaATQ
	 ZXJHXxEsWkh4C7WWa7q/1bfCT6dqiQBepou4O4w+J4ZLgDPqJgf0jWJoMjFRyj5SyP
	 000g48lLPRlZfRWG6GaGcgP/aH4Q3ltr1iuRVx8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390402AbgF3RiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390353AbgF3RiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:38:22 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1162083E;
        Tue, 30 Jun 2020 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593538701;
        bh=bP3p7dVexcSkteyD/dA+wmwP54RNKmjexoS8VX/yL5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QdbuWMrkMfSwq4uJ0dE+MaBUXfWAXh4mUItpEYk3m3ySP5Ykil0SoWaDHGKe4AiaC
         la5/K0HaSktEtvbrsQE4tBkfI7p4ADAZX8LRUg7jiqX69JQDIH670SxaFC6z+ZnYgr
         GkiwruxZBoqBoqCmBhyJFi/VqHNWjElPMsoOSr/g=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: [PATCH 09/18] Documentation/barriers: Remove references to [smp_]read_barrier_depends()
Date:   Tue, 30 Jun 2020 18:37:25 +0100
Message-Id: <20200630173734.14057-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The [smp_]read_barrier_depends() barrier macros no longer exist as
part of the Linux memory model, so remove all references to them from
the Documentation/ directory.

Although this is fairly mechanical on the whole, we drop the "CACHE
COHERENCY" section entirely from 'memory-barriers.txt' as it doesn't
make any sense now that the dependency barriers have been removed.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst  |   2 +-
 Documentation/memory-barriers.txt             | 156 +-----------------
 2 files changed, 9 insertions(+), 149 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 75b8ca007a11..50d5c43c48b0 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -463,7 +463,7 @@ again without disrupting RCU readers.
 This guarantee was only partially premeditated. DYNIX/ptx used an
 explicit memory barrier for publication, but had nothing resembling
 ``rcu_dereference()`` for subscription, nor did it have anything
-resembling the ``smp_read_barrier_depends()`` that was later subsumed
+resembling the dependency-ordering barrier that was later subsumed
 into ``rcu_dereference()`` and later still into ``READ_ONCE()``. The
 need for these operations made itself known quite suddenly at a
 late-1990s meeting with the DEC Alpha architects, back in the days when
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index eaabc3134294..4e55aba3eb4a 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -553,12 +553,12 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 DATA DEPENDENCY BARRIERS (HISTORICAL)
 -------------------------------------
 
-As of v4.15 of the Linux kernel, an smp_read_barrier_depends() was
-added to READ_ONCE(), which means that about the only people who
-need to pay attention to this section are those working on DEC Alpha
-architecture-specific code and those working on READ_ONCE() itself.
-For those who need it, and for those who are interested in the history,
-here is the story of data-dependency barriers.
+As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
+DEC Alpha, which means that about the only people who need to pay attention
+to this section are those working on DEC Alpha architecture-specific code
+and those working on READ_ONCE() itself.  For those who need it, and for
+those who are interested in the history, here is the story of
+data-dependency barriers.
 
 The usage requirements of data dependency barriers are a little subtle, and
 it's not always obvious that they're needed.  To illustrate, consider the
@@ -2708,144 +2708,6 @@ the properties of the memory window through which devices are accessed and/or
 the use of any special device communication instructions the CPU may have.
 
 
-CACHE COHERENCY
----------------
-
-Life isn't quite as simple as it may appear above, however: for while the
-caches are expected to be coherent, there's no guarantee that that coherency
-will be ordered.  This means that while changes made on one CPU will
-eventually become visible on all CPUs, there's no guarantee that they will
-become apparent in the same order on those other CPUs.
-
-
-Consider dealing with a system that has a pair of CPUs (1 & 2), each of which
-has a pair of parallel data caches (CPU 1 has A/B, and CPU 2 has C/D):
-
-	            :
-	            :                          +--------+
-	            :      +---------+         |        |
-	+--------+  : +--->| Cache A |<------->|        |
-	|        |  : |    +---------+         |        |
-	|  CPU 1 |<---+                        |        |
-	|        |  : |    +---------+         |        |
-	+--------+  : +--->| Cache B |<------->|        |
-	            :      +---------+         |        |
-	            :                          | Memory |
-	            :      +---------+         | System |
-	+--------+  : +--->| Cache C |<------->|        |
-	|        |  : |    +---------+         |        |
-	|  CPU 2 |<---+                        |        |
-	|        |  : |    +---------+         |        |
-	+--------+  : +--->| Cache D |<------->|        |
-	            :      +---------+         |        |
-	            :                          +--------+
-	            :
-
-Imagine the system has the following properties:
-
- (*) an odd-numbered cache line may be in cache A, cache C or it may still be
-     resident in memory;
-
- (*) an even-numbered cache line may be in cache B, cache D or it may still be
-     resident in memory;
-
- (*) while the CPU core is interrogating one cache, the other cache may be
-     making use of the bus to access the rest of the system - perhaps to
-     displace a dirty cacheline or to do a speculative load;
-
- (*) each cache has a queue of operations that need to be applied to that cache
-     to maintain coherency with the rest of the system;
-
- (*) the coherency queue is not flushed by normal loads to lines already
-     present in the cache, even though the contents of the queue may
-     potentially affect those loads.
-
-Imagine, then, that two writes are made on the first CPU, with a write barrier
-between them to guarantee that they will appear to reach that CPU's caches in
-the requisite order:
-
-	CPU 1		CPU 2		COMMENT
-	===============	===============	=======================================
-					u == 0, v == 1 and p == &u, q == &u
-	v = 2;
-	smp_wmb();			Make sure change to v is visible before
-					 change to p
-	<A:modify v=2>			v is now in cache A exclusively
-	p = &v;
-	<B:modify p=&v>			p is now in cache B exclusively
-
-The write memory barrier forces the other CPUs in the system to perceive that
-the local CPU's caches have apparently been updated in the correct order.  But
-now imagine that the second CPU wants to read those values:
-
-	CPU 1		CPU 2		COMMENT
-	===============	===============	=======================================
-	...
-			q = p;
-			x = *q;
-
-The above pair of reads may then fail to happen in the expected order, as the
-cacheline holding p may get updated in one of the second CPU's caches while
-the update to the cacheline holding v is delayed in the other of the second
-CPU's caches by some other cache event:
-
-	CPU 1		CPU 2		COMMENT
-	===============	===============	=======================================
-					u == 0, v == 1 and p == &u, q == &u
-	v = 2;
-	smp_wmb();
-	<A:modify v=2>	<C:busy>
-			<C:queue v=2>
-	p = &v;		q = p;
-			<D:request p>
-	<B:modify p=&v>	<D:commit p=&v>
-			<D:read p>
-			x = *q;
-			<C:read *q>	Reads from v before v updated in cache
-			<C:unbusy>
-			<C:commit v=2>
-
-Basically, while both cachelines will be updated on CPU 2 eventually, there's
-no guarantee that, without intervention, the order of update will be the same
-as that committed on CPU 1.
-
-
-To intervene, we need to interpolate a data dependency barrier or a read
-barrier between the loads (which as of v4.15 is supplied unconditionally
-by the READ_ONCE() macro).  This will force the cache to commit its
-coherency queue before processing any further requests:
-
-	CPU 1		CPU 2		COMMENT
-	===============	===============	=======================================
-					u == 0, v == 1 and p == &u, q == &u
-	v = 2;
-	smp_wmb();
-	<A:modify v=2>	<C:busy>
-			<C:queue v=2>
-	p = &v;		q = p;
-			<D:request p>
-	<B:modify p=&v>	<D:commit p=&v>
-			<D:read p>
-			smp_read_barrier_depends()
-			<C:unbusy>
-			<C:commit v=2>
-			x = *q;
-			<C:read *q>	Reads from v after v updated in cache
-
-
-This sort of problem can be encountered on DEC Alpha processors as they have a
-split cache that improves performance by making better use of the data bus.
-While most CPUs do imply a data dependency barrier on the read when a memory
-access depends on a read, not all do, so it may not be relied on.
-
-Other CPUs may also have split caches, but must coordinate between the various
-cachelets for normal memory accesses.  The semantics of the Alpha removes the
-need for hardware coordination in the absence of memory barriers, which
-permitted Alpha to sport higher CPU clock rates back in the day.  However,
-please note that (again, as of v4.15) smp_read_barrier_depends() should not
-be used except in Alpha arch-specific code and within the READ_ONCE() macro.
-
-
 CACHE COHERENCY VS DMA
 ----------------------
 
@@ -3009,10 +2871,8 @@ caches with the memory coherence system, thus making it seem like pointer
 changes vs new data occur in the right order.
 
 The Alpha defines the Linux kernel's memory model, although as of v4.15
-the Linux kernel's addition of smp_read_barrier_depends() to READ_ONCE()
-greatly reduced Alpha's impact on the memory model.
-
-See the subsection on "Cache Coherency" above.
+the Linux kernel's addition of smp_mb() to READ_ONCE() on Alpha greatly
+reduced its impact on the memory model.
 
 
 VIRTUAL MACHINE GUESTS
-- 
2.27.0.212.ge8ba1cc988-goog

