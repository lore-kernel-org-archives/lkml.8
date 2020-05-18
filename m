Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AE6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3DDD20787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589791042;
	bh=GfXmtofJRfQqgkk4PPH1+7PyZDSRmTw8B2hV1RDSVGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U7Xg1MK5OhqHVAYmflkARjrtbxGWFaXI/x0YWldPQ3W/OEcAoUk/aRBAr71h0NLQE
	 JkbJWfGgL1dFGfY0uao37i03PeTFd5PU6jn5DDQcfDEUXuD0Vyhn2Z5EnYCKkJG0j/
	 G3v+x3qN7gjGirOPQeQezJIiJJkWcfhXPMRLUbGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgERIhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgERIhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:37:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E9420657;
        Mon, 18 May 2020 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589791040;
        bh=GfXmtofJRfQqgkk4PPH1+7PyZDSRmTw8B2hV1RDSVGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vnucEISVMAu27LDa3Z3ZP43l+qLnKsbUyeDD4giG5LhaX1hT2GQtLcG0CY3Vmscu7
         bPTh6sWoUFyKZmuqsW6basXTJM9HrTrFMuHi6u4h8EAHPmA05vAEUOLn3KIHImAbg+
         SYMhCfKSc/yx7xVejS5L4lnRF2aKAMWNJPd+LwjQ=
Date:   Mon, 18 May 2020 09:37:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>, rppt@kernel.org
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
Message-ID: <20200518083715.GA31383@willie-the-truck>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net>
 <20200517000750.GA157503@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517000750.GA157503@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 05:07:50PM -0700, Guenter Roeck wrote:
> On Sat, May 16, 2020 at 05:00:50PM -0700, Guenter Roeck wrote:
> > On Mon, May 11, 2020 at 09:41:36PM +0100, Will Deacon wrote:
> > > Now that the page table allocator can free page table allocations
> > > smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
> > > to avoid needlessly wasting memory.
> > > 
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > 
> > Something in the sparc32 patches in linux-next causes all my sparc32 emulations
> > to crash. bisect points to this patch, but reverting it doesn't help, and neither
> > does reverting the rest of the series.
> > 
> Actually, turns out I see the same pattern (lots of scheduling while atomic
> followed by 'killing interrupt handler' in cryptomgr_test) with several
> powerpc boot tests.  I am currently bisecting those crashes. I'll report
> the results here as well as soon as I have it.

FWIW, I retested my sparc32 patches with PREEMPT=y and I don't see any
issues. However, linux-next is a different story, where I don't get very far
at all:

BUG: Bad page state in process swapper  pfn:005b4

If you're seeing this on powerpc too, I wonder if it's related to:

https://lore.kernel.org/r/20200514170327.31389-1-rppt@kernel.org

since I think it just hit -next and the diffstat is all over the place. I've
added Mike to CC just in case.

Will
