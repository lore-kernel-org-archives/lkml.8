Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34600C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197D820C56
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgE0UL2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgE0UL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:11:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA294C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:11:27 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1je2OZ-0005ku-Mm; Wed, 27 May 2020 22:11:24 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 0/7] Introduce local_lock()
Date:   Wed, 27 May 2020 22:11:12 +0200
Message-Id: <20200527201119.1692513-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v3 of the local_lock() series. The v2 can be found at 

   https://lore.kernel.org/lkml/20200524215739.551568-1-bigeasy@linutronix.de/

v2…v3:
  - Use `local_lock_t' instead of `struct local_lock' because it is
    tiny data structure in general (similar to spinlock_t). Use also
    consistent file names `local_lock.h'.

  - Export the data structure in radix-tree so that the `lock' member
    can be accessed externally. The common case of 'local_unlock()' (no
    lockdep, no preemption) will then be optimized away. Otherwise
    `idr_preload_end()' will be a function containing only a return
    opcode.

  - Reorganize the struct member names in mm/swap and connector/cn_proc.

  - Make the `lock' member comes before the member that it aims to
    protect.

  - Two hunks from patch #6 appeared under mysteries circumstances in
    patch #7. They have been moved back to patch #6.
    Also applied comments to patch #7 as suggested by Ingo.

v1…v2:
  - Remove static initializer so a local_lock is not used a single
    per-CPU variable but a as a member of an existing structure, that is
    used per-CPU.

  - Use LD_WAIT_CONFIG as wait-type in the dep_map.

  - Expect a pointer like value as argument (same as this_cpu_ptr()).

  - Drop the SRCU patch. A different sollution is worked on.

  - Drop the zswap patch. That code part will be reworked.


preempt_disable() and local_irq_disable/save() are in principle per CPU big
kernel locks. This has several downsides:

  - The protection scope is unknown

  - Violation of protection rules is hard to detect by instrumentation

  - For PREEMPT_RT such sections, unless in low level critical code, can
    violate the preemptability constraints.

To address this PREEMPT_RT introduced the concept of local_locks which are
strictly per CPU.

The lock operations map to preempt_disable(), local_irq_disable/save() and
the enabling counterparts on non RT enabled kernels.

If lockdep is enabled local locks gain a lock map which tracks the usage
context. This will catch cases where an area is protected by
preempt_disable() but the access also happens from interrupt context. local
locks have identified quite a few such issues over the years, the most
recent example is:

  b7d5dc21072cd ("random: add a spinlock_t to struct batched_entropy")

Aside of the lockdep coverage this also improves code readability as it
precisely annotates the protection scope.

PREEMPT_RT substitutes these local locks with 'sleeping' spinlocks to
protect such sections while maintaining preemtability and CPU locality.

The followin series introduces the infrastructure including
documentation and provides a couple of examples how they are used to
adjust code to be RT ready.

Sebastian

