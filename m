Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128BAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0613207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589793497;
	bh=vspP1UlkLkB/JOB38JTRPvKN/7nlnibhBIT98ITQ3lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GmVE+URo7greRb8dfXdtGCkNxckCI3sUOOwtHHmf/UfFY8Vnvlr/BxC5DlE4rTpze
	 1tay8UCUOr4iyoNBJF3WlhDRmEGdTJWiwElPVqNXPeanNa4tGOihI0tTIm/cHKAGwm
	 uI1OS0mZKHiAw6U0YGhaBUwxSlPQJ3OEyy8MLARs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgERJSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgERJSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:18:16 -0400
Received: from kernel.org (unknown [87.71.47.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7589B20643;
        Mon, 18 May 2020 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589793495;
        bh=vspP1UlkLkB/JOB38JTRPvKN/7nlnibhBIT98ITQ3lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vfdf64MjvNL9DCh3shYDOVNCelvO9k5qgFnbkaxnR8CSLafylND93fl4SPC090Ssx
         lXfNFdN1PlH2g/dyjYg825Qq/jLIopm9sZB3QX0TXj9AkpwseV+4rnot/t4CrE2YEL
         jKieBIbULKqfz91L4Op8g2B/VKTZ+vlYF/sTSX3c=
Date:   Mon, 18 May 2020 12:18:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
Message-ID: <20200518091807.GB1118872@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net>
 <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518083715.GA31383@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 09:37:15AM +0100, Will Deacon wrote:
> On Sat, May 16, 2020 at 05:07:50PM -0700, Guenter Roeck wrote:
> > On Sat, May 16, 2020 at 05:00:50PM -0700, Guenter Roeck wrote:
> > > On Mon, May 11, 2020 at 09:41:36PM +0100, Will Deacon wrote:
> > > > Now that the page table allocator can free page table allocations
> > > > smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
> > > > to avoid needlessly wasting memory.
> > > > 
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > 
> > > Something in the sparc32 patches in linux-next causes all my sparc32 emulations
> > > to crash. bisect points to this patch, but reverting it doesn't help, and neither
> > > does reverting the rest of the series.
> > > 
> > Actually, turns out I see the same pattern (lots of scheduling while atomic
> > followed by 'killing interrupt handler' in cryptomgr_test) with several
> > powerpc boot tests.  I am currently bisecting those crashes. I'll report
> > the results here as well as soon as I have it.
> 
> FWIW, I retested my sparc32 patches with PREEMPT=y and I don't see any
> issues. However, linux-next is a different story, where I don't get very far
> at all:
> 
> BUG: Bad page state in process swapper  pfn:005b4
> 
> If you're seeing this on powerpc too, I wonder if it's related to:
> 
> https://lore.kernel.org/r/20200514170327.31389-1-rppt@kernel.org
> 
> since I think it just hit -next and the diffstat is all over the place. I've
> added Mike to CC just in case.

Thanks, Will, I'll take a look.

> Will

-- 
Sincerely yours,
Mike.
