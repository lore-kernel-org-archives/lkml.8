Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F146CC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4186206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nzIrN17S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgBLQiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:38:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLQiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PM+7PJ6Z7kS+rPQtWGRINgob1poar/Cfo5GEs5f/tg0=; b=nzIrN17SVPRIuHkkfn8v2yCVY1
        XSIFGa89nuFKxhpDtW2pDOEAkiBFTxxjqUH0mi+jYzLpgEA604cWCXwqsxLVm+ErTB6m6NIXVhYDS
        kc9nbfVGz+pUb8XMXh+NRluBL2FW9TeKlhQp/cWGgQpT8rnwldCFSqVceQQq8kqf4hqBA/b+KnRBR
        MVTwVWQMVQjJ+r1MTreZkToSdC9pHKboXKX/NT7+2MSxw48a1HloDBf+zbLN//3J/c39dFxRLBPLC
        8CrWwCfKwwzRNBivpmbzq9CElNV8tXnRsqFi4lIMq+fMzFOREkl31Mjv8VKFhp8L2UkL0tENtUOCb
        WBO/4o3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1v1X-0003Re-Gn; Wed, 12 Feb 2020 16:38:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 549E6300235;
        Wed, 12 Feb 2020 17:36:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86BD92038B228; Wed, 12 Feb 2020 17:38:00 +0100 (CET)
Date:   Wed, 12 Feb 2020 17:38:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de, Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/7] microblaze: Define SMP safe operations
Message-ID: <20200212163800.GY14946@hirez.programming.kicks-ass.net>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <20200212160852.GC14973@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212160852.GC14973@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 05:08:52PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 04:42:22PM +0100, Michal Simek wrote:
> 
> > Microblaze has 32bit exclusive load/store instructions which should be used
> > instead of irq enable/disable. For more information take a look at
> > https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug984-vivado-microblaze-ref.pdf
> > starting from page 25.
> 
> >  arch/microblaze/include/asm/Kbuild           |   1 -
> >  arch/microblaze/include/asm/atomic.h         | 265 ++++++++++++++++++-
> >  arch/microblaze/include/asm/bitops.h         | 189 +++++++++++++
> >  arch/microblaze/include/asm/cmpxchg.h        |  87 ++++++
> >  arch/microblaze/include/asm/cpuinfo.h        |   2 +-
> >  arch/microblaze/include/asm/pgtable.h        |  19 +-
> >  arch/microblaze/include/asm/spinlock.h       | 240 +++++++++++++++++
> >  arch/microblaze/include/asm/spinlock_types.h |  25 ++
> >  arch/microblaze/kernel/cpu/cache.c           | 154 ++++++-----
> >  arch/microblaze/kernel/cpu/cpuinfo.c         |  38 ++-
> >  arch/microblaze/kernel/cpu/mb.c              | 207 ++++++++-------
> >  arch/microblaze/kernel/timer.c               |   2 +-
> >  arch/microblaze/mm/consistent.c              |   8 +-
> >  13 files changed, 1040 insertions(+), 197 deletions(-)
> >  create mode 100644 arch/microblaze/include/asm/bitops.h
> >  create mode 100644 arch/microblaze/include/asm/spinlock.h
> >  create mode 100644 arch/microblaze/include/asm/spinlock_types.h
> 
> I'm missing asm/barrier.h
> 
> Also that PDF (thanks for that!), seems light on memory ordering
> details.
> 
> Your comment:
> 
> +/*
> + * clear_bit doesn't imply a memory barrier
> + */
> 
> worries me, because that would imply your ll/sc does not impose order,
> but then you also don't have any explicit barriers in your locking
> primitives or atomics where required.
> 
> In the PDF I only find MBAR; is that what smp_mb() ends up being?

Bah, I'm sure I did patches at some point that made
asm-generic/barrier.h #error if you didn't define at least one memory
barrier on CONFIG_SMP, but it seems that all got lost somewhere.


