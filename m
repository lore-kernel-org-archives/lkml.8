Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672F4C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F7520656
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rN7z2enz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgDQMWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727877AbgDQMWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:22:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05B2C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SLoUm+BzJe/VKqHJ2ONW40lm1UdZG6XkpJnj2k6pZhc=; b=rN7z2enzlzxrutdF0NtmuQYPMY
        FkSfXw/WcKyzu0QT0EMWZTbjBbJZcT37xLdgwwBW3cTGQvr1MjV7ivrplxL0DTFefuvf7jCB5aKI4
        Rss3b3QP3pu0n6cmPEvRXIzW9lb2cQrJC3XRfT4E6KnCj3Ndd/axunrxs1TNfxk8wXC+SmlZcV9WO
        ju7AiL6ppeFYp6fyjhYR2IvaayU0pV4gnV3nJAQjKjfM7SVOR8hv+3PPV2ra6slIWRthniferaoqK
        QCFRDRT9z6CxEP0GMYaYAEyZxd7TPh78WiRB0TCd/NCuMVMo/fg90Q/zaLYdLqRw5QDyfhLxYgve+
        17TCG+MQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPQ0E-0002iW-SY; Fri, 17 Apr 2020 12:21:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F05B307005;
        Fri, 17 Apr 2020 14:21:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 208812B121525; Fri, 17 Apr 2020 14:21:48 +0200 (CEST)
Date:   Fri, 17 Apr 2020 14:21:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     SeongJae Park <sjpark@amazon.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: Re: Re: [RFC] autonuma: Support to scan page table asynchronously
Message-ID: <20200417122148.GC20730@hirez.programming.kicks-ass.net>
References: <20200417100417.GT20730@hirez.programming.kicks-ass.net>
 <20200417102129.23399-1-sjpark@amazon.com>
 <20200417121629.GA3758@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417121629.GA3758@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 01:16:29PM +0100, Mel Gorman wrote:
> On Fri, Apr 17, 2020 at 12:21:29PM +0200, SeongJae Park wrote:
> > On Fri, 17 Apr 2020 12:04:17 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Fri, Apr 17, 2020 at 09:05:08AM +0200, SeongJae Park wrote:
> > > > I think the main idea of DAMON[1] might be able to applied here.  Have you
> > > > considered it?
> > > > 
> > > > [1] https://lore.kernel.org/linux-mm/20200406130938.14066-1-sjpark@amazon.com/
> > > 
> > > I've ignored that entire thing after you said the information it
> > > provides was already available through the PMU.
> > 
> > Sorry if my answer made you confused.  What I wanted to say was that the
> > fundamental access checking mechanism that DAMON depends on is PTE Accessed bit
> > for now, but it could be modified to use PMU or other features instead. 
> 
> I would not be inclined to lean towards either approach for NUMA
> balancing. Fiddling with the accessed bit can have consequences for page
> aging and residency -- fine for debugging a problem, not to fine for
> normal usage. I would expect the PMU approach would have high overhead
> as well as taking over a PMU counter that userspace debugging may expect
> to be available.

Oh, quite agreed; I was just saying I never saw the use of that whole
DAMON thing. AFAICT it's not actually solving a problem, just making
more.
