Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3D7C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0971B21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aYxYuk19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgBMILx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:11:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMILw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=847pzyVrtZCzsbfhxF1vEmTe4aPfobgj5eCqvQBGp1U=; b=aYxYuk196tbYMdLPy9bjNRTwcP
        nCSDuoH8YbkxeDpHGjXvXJ0xxOtxrIxcX78c+6QyCxkKnRW/a1mxGDKeYnR1fq/5thnLHaUcExAaE
        upamVGG7siLMkjiJZt80mvWnYa+cZpYFK2N2JD0dqmN6VHoOSyw1b7+QfrLl0NcVKSDjbwMSxTG+8
        vrdkxgO0PMTQlkOc/2k7XebrDpQyZkRZqh8T77V9FE7KSbuOPsyCRKtHGbfjR+jFYV9jWVslE343p
        G5mwRFBT/l94iXto3Wy8WEIHz5VIeMaDr49s0UoCsRi+ZtuC8/rWEOYNM9HPuC3DtiUjWXCOEoOb0
        PEhR3bhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j29b3-0006Wv-Hk; Thu, 13 Feb 2020 08:11:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0EC2300446;
        Thu, 13 Feb 2020 09:09:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4497E20206D6B; Thu, 13 Feb 2020 09:11:39 +0100 (CET)
Date:   Thu, 13 Feb 2020 09:11:39 +0100
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
Message-ID: <20200213081139.GG14897@hirez.programming.kicks-ass.net>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <20200212160852.GC14973@hirez.programming.kicks-ass.net>
 <8dc57ea5-0868-0707-25a7-4cd6d8a43add@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dc57ea5-0868-0707-25a7-4cd6d8a43add@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 08:49:40AM +0100, Michal Simek wrote:
> On 12. 02. 20 17:08, Peter Zijlstra wrote:
> > On Wed, Feb 12, 2020 at 04:42:22PM +0100, Michal Simek wrote:
> > 
> >> Microblaze has 32bit exclusive load/store instructions which should be used
> >> instead of irq enable/disable. For more information take a look at
> >> https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug984-vivado-microblaze-ref.pdf
> >> starting from page 25.
> > 
> >>  arch/microblaze/include/asm/Kbuild           |   1 -
> >>  arch/microblaze/include/asm/atomic.h         | 265 ++++++++++++++++++-
> >>  arch/microblaze/include/asm/bitops.h         | 189 +++++++++++++
> >>  arch/microblaze/include/asm/cmpxchg.h        |  87 ++++++
> >>  arch/microblaze/include/asm/cpuinfo.h        |   2 +-
> >>  arch/microblaze/include/asm/pgtable.h        |  19 +-
> >>  arch/microblaze/include/asm/spinlock.h       | 240 +++++++++++++++++
> >>  arch/microblaze/include/asm/spinlock_types.h |  25 ++
> >>  arch/microblaze/kernel/cpu/cache.c           | 154 ++++++-----
> >>  arch/microblaze/kernel/cpu/cpuinfo.c         |  38 ++-
> >>  arch/microblaze/kernel/cpu/mb.c              | 207 ++++++++-------
> >>  arch/microblaze/kernel/timer.c               |   2 +-
> >>  arch/microblaze/mm/consistent.c              |   8 +-
> >>  13 files changed, 1040 insertions(+), 197 deletions(-)
> >>  create mode 100644 arch/microblaze/include/asm/bitops.h
> >>  create mode 100644 arch/microblaze/include/asm/spinlock.h
> >>  create mode 100644 arch/microblaze/include/asm/spinlock_types.h
> > 
> > I'm missing asm/barrier.h
> 
> This has been sent in previous patchset. Link was in this email.

lkml.org link, please don't use them. The kernel.org links (example
below) have the Message-Id in them, which allows me to search for them
in my local storage without having to use a web browser.

You mean this one, right?

  https://lkml.kernel.org/r/be707feb95d65b44435a0d9de946192f1fef30c6.1581497860.git.michal.simek@xilinx.com

So the PDF says this is a completion barrier, needed for DMA. This is a
very expensive option for smp_mb(), but if it is all you have and is
required, then yes, that should do.
