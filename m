Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09352C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAFD62177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G8jjpap+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EGu7Yilw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgH0Lxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 07:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbgH0Lk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:40:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405EFC06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:40:26 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598528424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VrRM45vL6L0gNPdfds/GsuaBAjPLpyd+E3qz8ezBnpQ=;
        b=G8jjpap+o80AIiLZN5+/94QkGZCqPg6Ug0Mh3EgjITFTgbe0DNcSmLxFlmtmicosbFbAPd
        mVDlYUn8MW/7I3HdTn3gzKioN35HOt0QA5ItQofzbTHnVBuROjPvzUlkKxBmlf1nAaSnc9
        ZDbgk8PqR9dUmr5mgOrmjB0ty8KBkpnhUA6VbBvJZ9cDP0p12C1VrfBbk33f/nwaLStyrf
        4FDkj/23K7LVgqXkvBN+9miin5ZNnStFd165PSDu14QLPVEWWEj15bvDRg5mw38f6Elklr
        LhRcvTYI95p+uxLSB+AGyk2VdY8ksFexCeL9yxzVyumY5JwZqEVBWMCtqVaU1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598528424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VrRM45vL6L0gNPdfds/GsuaBAjPLpyd+E3qz8ezBnpQ=;
        b=EGu7Yilw784/dRq6Y+vuP9+tv6uvOyMqetIBeGAR10BcKGwYNPr0z3OxL2Ecbr8rZTd4/r
        /ukwrjBSh0UHNLBw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v1 0/8] seqlock: Introduce seqcount_latch_t
Date:   Thu, 27 Aug 2020 13:40:36 +0200
Message-Id: <20200827114044.11173-1-a.darwish@linutronix.de>
In-Reply-To: <20200519214547.352050-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latch sequence counters are a multiversion concurrency control mechanism
where the embedded seqcount_t counter even/odd value is used to switch
between two copies of protected data. This allows the sequence counter
read side to be invoked from NMIs and safely interrupt its own write
side critical section.

Initially, latch sequence counters were implemented as a single write
function above plain seqcount_t, raw_write_seqcount_latch(). The read
path was expected to use plain seqcount_t raw_read_seqcount().

A specialized latch read function, raw_read_seqcount_latch(), was later
added. It became the standardized way for latch read paths.  Due to the
dependent load, it has one read memory barrier less than the more
generic raw_read_seqcount() API.

Only raw_write_seqcount_latch() and raw_read_seqcount_latch() should be
used with latch sequence counters. Having unique read and write path
APIs means that latch sequence counters are actually a data type of
their own -- just inappropriately overloading plain seqcount_t.

Introduce seqcount_latch_t. This adds type-safety and ensures that only
the correct latch-safe APIs are to be used.

Not to break bisection, let the latch APIs also accept plain seqcount_t
or seqcount_raw_spinlock_t. After converting all call sites to
seqcount_latch_t, (patches #4 => #7), only allow seqcount_latch_t.

Thanks,

8<--------------

Ahmed S. Darwish (8):
  time/sched_clock: Use raw_read_seqcount_latch() during suspend
  mm/swap: Do not abuse the seqcount_t latching API
  seqlock: Introduce seqcount_latch_t
  time/sched_clock: Use seqcount_latch_t
  timekeeping: Use seqcount_latch_t
  x86/tsc: Use seqcount_latch_t
  rbtree_latch: Use seqcount_latch_t
  seqlock: seqcount latch APIs: Only allow seqcount_latch_t

 Documentation/locking/seqlock.rst | 18 ++++++
 arch/x86/kernel/tsc.c             | 12 ++--
 include/linux/rbtree_latch.h      |  6 +-
 include/linux/seqlock.h           | 96 +++++++++++++++++++++----------
 kernel/time/sched_clock.c         |  6 +-
 kernel/time/timekeeping.c         | 10 ++--
 mm/swap.c                         | 65 +++++++++++++++++----
 7 files changed, 156 insertions(+), 57 deletions(-)

base-commit: d012a7190fc1fd72ed48911e77ca97ba4521bccd
--
2.28.0
