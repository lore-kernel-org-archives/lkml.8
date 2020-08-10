Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B503EC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87EC120656
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FcjtyaDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHJUMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgHJUMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:12:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEE6C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZSAg39q96p74JTIalb6bZ2racT8O7omo7ECLmgOnpzM=; b=FcjtyaDGP4xSBMlJql8RmVa7WJ
        Mz0CAV34kHkHfK1Qp2SZZP24tQs5lPRj/9WI0csq36V3QfwTb/kfC8HaAe/Y6UKz7niDgcnSvPtyN
        rGWF/wScV92z4VFv/dkvvhyybFtbtnlGtdCzcQfiSR1TAK2mSlcfYn24wIVcVFUcFljg6u/XcGUXF
        WyHDieNQdQoY1GYmq+WXpex9xjBZoi+pQ4mQqWtmOPjCiMT//ViUh5qTIFkfHGTHmIrNqyKOazGnd
        Su3sIf6RZZuefbJar2ICfOCvCt5YphzJNTRDbBYKbu6jNtgWQU7Lsdl/k3O8F7MaUkldnk8a1nwuv
        nXdtuBMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5E9m-0007b6-FG; Mon, 10 Aug 2020 20:12:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0378D980D39; Mon, 10 Aug 2020 22:12:27 +0200 (CEST)
Date:   Mon, 10 Aug 2020 22:12:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] kernel: update callers of task_work_add() to use
 TWA_RESUME
Message-ID: <20200810201227.GC3982@worktop.programming.kicks-ass.net>
References: <10debfb3-25f2-20ed-d4f3-1d95ba4c2129@kernel.dk>
 <20200810114407.GT2674@hirez.programming.kicks-ass.net>
 <21d27dfe-91f8-ebc3-6390-a0345603ac28@kernel.dk>
 <2aeafd33-7e26-cdfc-9a4c-98965faeccfb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aeafd33-7e26-cdfc-9a4c-98965faeccfb@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:50:33AM -0600, Jens Axboe wrote:
> On 8/10/20 8:37 AM, Jens Axboe wrote:
> > On 8/10/20 5:44 AM, peterz@infradead.org wrote:
> >> On Sat, Aug 08, 2020 at 03:43:50PM -0600, Jens Axboe wrote:
> >>> Any pre-existing caller of this function uses 'true' to signal to use
> >>> notifications or not, but we now also have signaled notifications.
> >>> Update existing callers that specify 'true' for notify to use the
> >>> updated TWA_RESUME instead.
> >>>
> >>> This was noted in the original commit as well:
> >>>
> >>> e91b48162332 ("task_work: teach task_work_add() to do signal_wake_up()")
> >>>
> >>> Cc: Oleg Nesterov <oleg@redhat.com>
> >>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>>
> >>
> >> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>
> >> How do you want to route this?
> > 
> > I don't really care, as I have no dependencies on it. Feel free to queue
> > it up! It's just sitting at the top of my io_uring branch right now,
> > but that's because I had to stuff it somewhere. Easy to pop off the top.
> 
> FWIW, I dropped this from my branch, so would be great if you or Oleg
> could push this one upstream.

Will do, thanks!
