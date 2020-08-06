Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA0CC35277
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D68D22D05
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bb/cAxUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgHFJ1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgHFJZG (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:25:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2874FC061574
        for <Linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DKcQQBQJlA+95nyc4B/ghr/B9F2mAty2HjrbxPuzAWQ=; b=Bb/cAxUh4kHkrpPfUunGQ9HQVJ
        HOhhBKMWGbX7iLIQxhm6oGUQvY9nAbnmjinjvcIbHp5HwdDNo3wZpAJ7lGbqr1XR+YH4HVDlLF/fO
        eYZOK/+W2pldVk92Z3UdiuWqS21rAPO/NZrTvFhDXzfcAtarVja2q3oRJPjBuc6GSQLJXXAu9lGpj
        2kvcgLJ4EwgGz3dhEOf2PMPcYgRC0ABAMBUvkY11LU4W1G+8VWuEouJqX7aa27wAG/u7J7UpfbsZl
        m56eSiYs0//NC82Wz35rfmsn3RcblL/mavPtegrDVRv4Bxn0UEKUppdtj/B+4UjlMr3DOgYhHHrmN
        BtBzcK8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3c8t-0000gI-KA; Thu, 06 Aug 2020 09:24:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6FF753059DD;
        Thu,  6 Aug 2020 11:24:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E3BD23D77450; Thu,  6 Aug 2020 11:24:54 +0200 (CEST)
Date:   Thu, 6 Aug 2020 11:24:54 +0200
From:   peterz@infradead.org
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     mingo@redhat.com, oleg@redhat.com, acme@kernel.org,
        jolsa@kernel.org, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
Subject: Re: [PATCH v1 2/2] perf/core: Fake regs for leaked kernel samples
Message-ID: <20200806092454.GE35926@hirez.programming.kicks-ass.net>
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
 <20200731025617.16243-2-yao.jin@linux.intel.com>
 <20200804114900.GI2657@hirez.programming.kicks-ass.net>
 <4c958d61-11a7-9f3e-9e7d-d733270144a1@linux.intel.com>
 <20200805124454.GP2657@hirez.programming.kicks-ass.net>
 <797aa4de-c618-f340-ad7b-cef38c96b035@linux.intel.com>
 <20200806091827.GY2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806091827.GY2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 11:18:27AM +0200, peterz@infradead.org wrote:
> On Thu, Aug 06, 2020 at 10:26:29AM +0800, Jin, Yao wrote:
> 
> > > +static struct pt_regs *sanitize_sample_regs(struct perf_event *event, struct pt_regs *regs)
> > > +{
> > > +	struct pt_regs *sample_regs = regs;
> > > +
> > > +	/* user only */
> > > +	if (!event->attr.exclude_kernel || !event->attr.exclude_hv ||
> > > +	    !event->attr.exclude_host   || !event->attr.exclude_guest)
> > > +		return sample_regs;
> > > +
> > 
> > Is this condition correct?
> > 
> > Say counting user event on host, exclude_kernel = 1 and exclude_host = 0. It
> > will go "return sample_regs" path.
> 
> I'm not sure, I'm terminally confused on virt stuff.

[A]

> Suppose we have nested virt:
> 
> 	L0-hv
> 	|
> 	G0/L1-hv
> 	   |
> 	   G1
> 
> And we're running in G0, then:
> 
>  - 'exclude_hv' would exclude L0 events
>  - 'exclude_host' would ... exclude L1-hv events?
>  - 'exclude_guest' would ... exclude G1 events?

[B]

> Then the next question is, if G0 is a host, does the L1-hv run in
> G0 userspace or G0 kernel space?
> 
> I was assuming G0 userspace would not include anything L1 (kvm is a
> kernel module after all), but what do I know.
> 
> > > @@ -11609,7 +11636,8 @@ SYSCALL_DEFINE5(perf_event_open,
> > >   	if (err)
> > >   		return err;
> > > -	if (!attr.exclude_kernel) {
> > > +	if (!attr.exclude_kernel || !attr.exclude_callchain_kernel ||
> > > +	    !attr.exclude_hv || !attr.exclude_host || !attr.exclude_guest) {
> > >   		err = perf_allow_kernel(&attr);
> > >   		if (err)
> > >   			return err;
> > > 
> > 
> > I can understand the conditions "!attr.exclude_kernel || !attr.exclude_callchain_kernel".
> > 
> > But I'm not very sure about the "!attr.exclude_hv || !attr.exclude_host || !attr.exclude_guest".
> 
> Well, I'm very sure G0 userspace should never see L0 or G1 state, so
> exclude_hv and exclude_guest had better be true.
> 
> > On host, exclude_hv = 1, exclude_guest = 1 and exclude_host = 0, right?
> 
> Same as above, is G0 host state G0 userspace?
> 
> > So even exclude_kernel = 1 but exclude_host = 0, we will still go
> > perf_allow_kernel path. Please correct me if my understanding is wrong.
> 
> Yes, because with those permission checks in place it means you have
> permission to see kernel bits.

So if I understand 'exclude_host' wrong -- a distinct possibility -- can
we then pretty please have the above [A-B] corrected and put in a
comment near perf_event_attr and the exclude_* comments changed to refer
to that?
