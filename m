Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94FBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7390B22BEA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z+nr3IVd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9BcfJBxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgHJTbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:31:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52980 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgHJTbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:31:07 -0400
Date:   Mon, 10 Aug 2020 19:01:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597087864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6Jywy7lqllPTFMJ6o5Tm1gkuwwbnzeHH9S4UC1Euep4=;
        b=Z+nr3IVdFq/vEDkoDCbCzPI/qcTHf2tClNSLYklPib/395MnaoQGa/7fq1nkCHswYD2cB9
        sYtn1xIqLk0mgIfvFCsM03EuCDslESW+IVntEElhB04f6lZ4s4Lhpdl9GgM7Rz2Im2+Zfu
        f52Uvwriy9px1ozdoTM5DLgWYQiull6Srmc2B2smBxUn1TjRA1hqyk9YDMTOh59SgWPvuB
        Angx6TUgRgFvOOB6ru4zGXYzIOznKs21UgXNoKTH5oE7lO0MooVcWybwf6130UUMEIQ9NV
        n7GWkL/yT9oJoNNq0H3J0lS2gdYAUd02BdI1LnCvSFwsKLZddtalssGSjFjnKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597087864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6Jywy7lqllPTFMJ6o5Tm1gkuwwbnzeHH9S4UC1Euep4=;
        b=9BcfJBxONyEb7sGKihmbXN/0UYXAjhIQLTnW+5lfgMWZNQpQkPRpKbHuPs6r7UU/XzWa24
        rjfKC169qfhpP7Dw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for 5.9-rc1
Message-ID: <159708609435.2571.13948681727529247231.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-08-10

up to:  0cd39f4600ed: locking/seqlock, headers: Untangle the spaghetti monster

A set of locking fixes and updates:

  - Untangle the header spaghetti which causes build failures in various
    situations caused by the lockdep additions to seqcount to validate that
    the write side critical sections are non-preemptible.

  - The seqcount associated lock debug addons which were blocked by the
    above fallout.

    seqcount writers contrary to seqlock writers must be externally
    serialized, which usually happens via locking - except for strict per
    CPU seqcounts. As the lock is not part of the seqcount, lockdep cannot
    validate that the lock is held.

    This new debug mechanism adds the concept of associated locks.
    sequence count has now lock type variants and corresponding
    initializers which take a pointer to the associated lock used for
    writer serialization. If lockdep is enabled the pointer is stored and
    write_seqcount_begin() has a lockdep assertion to validate that the
    lock is held.

    Aside of the type and the initializer no other code changes are
    required at the seqcount usage sites. The rest of the seqcount API is
    unchanged and determines the type at compile time with the help of
    _Generic which is possible now that the minimal GCC version has been
    moved up.

    Adding this lockdep coverage unearthed a handful of seqcount bugs which
    have been addressed already independent of this.

    While generaly useful this comes with a Trojan Horse twist: On RT
    kernels the write side critical section can become preemtible if the
    writers are serialized by an associated lock, which leads to the well
    known reader preempts writer livelock. RT prevents this by storing the
    associated lock pointer independent of lockdep in the seqcount and
    changing the reader side to block on the lock when a reader detects
    that a writer is in the write side critical section.

 - Conversion of seqcount usage sites to associated types and initializers.

Thanks,

	tglx

------------------>
Ahmed S. Darwish (16):
      seqlock: Extend seqcount API with associated locks
      seqlock: Align multi-line macros newline escapes at 72 columns
      dma-buf: Remove custom seqcount lockdep class key
      dma-buf: Use sequence counter with associated wound/wait mutex
      sched: tasks: Use sequence counter with associated spinlock
      netfilter: conntrack: Use sequence counter with associated spinlock
      netfilter: nft_set_rbtree: Use sequence counter with associated rwlock
      xfrm: policy: Use sequence counters with associated lock
      timekeeping: Use sequence counter with associated raw spinlock
      vfs: Use sequence counter with associated spinlock
      raid5: Use sequence counter with associated spinlock
      iocost: Use sequence counter with associated spinlock
      NFSv4: Use sequence counter with associated spinlock
      userfaultfd: Use sequence counter with associated spinlock
      kvm/eventfd: Use sequence counter with associated spinlock
      hrtimer: Use sequence counter with associated raw spinlock

Chris Wilson (1):
      locking/lockdep: Fix overflow in presentation of average lock-time

Ingo Molnar (1):
      x86/headers: Remove APIC headers from <asm/smp.h>

Peter Zijlstra (7):
      seqlock: s/__SEQ_LOCKDEP/__SEQ_LOCK/g
      seqlock: Fold seqcount_LOCKNAME_t definition
      seqlock: Fold seqcount_LOCKNAME_init() definition
      seqcount: Compress SEQCNT_LOCKNAME_ZERO()
      seqcount: More consistent seqprop names
      locking, arch/ia64: Reduce <asm/smp.h> header dependencies by moving XTP bits into the new <asm/xtp.h> header
      locking/seqlock, headers: Untangle the spaghetti monster



