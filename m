Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5DEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0860E20772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TnJbmMtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgGCLgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCLgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:36:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EBDC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 04:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BRmHDFS/bl7K2f11+G87TQqmBoQlHFzbNhHFpvrEgZE=; b=TnJbmMtlYIRn5TgsQ6FuWoTaOx
        aaOLzsXKlb5lXbmd5aaVvLelDE2t/OYdSMqK+QsEpVNowiwAZBa7Req9LrSYABCP6cfYkMBcWzpjg
        OfynZIv63p4j6ZdJCquqHVBi8Dqlg/5U+SUmu6A/oOHlaASRX1yOXkAe4F50ueu0vR8YTCcH2YoPp
        GqUooo0/bcxlBNY1/ES2yURT/TaYCFBlkKG4/ZLPyVGnqpxnXsB6T5zPmzNQYKej92GqSqOohEFFW
        YOT7zBLWrwv4/ofBlr/Mr9burN3+VpcKckgjfwaBJgwTWNpQvRYsPpX2T/BX0g8b0RXWRAndzb+7L
        s62TEPiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrJzA-0008Vx-79; Fri, 03 Jul 2020 11:36:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74C6B301124;
        Fri,  3 Jul 2020 13:36:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40AFA21476E77; Fri,  3 Jul 2020 13:36:03 +0200 (CEST)
Date:   Fri, 3 Jul 2020 13:36:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, mgorman@suse.de,
        Oleg Nesterov <oleg@redhat.com>, david@fromorbit.com
Subject: Re: [RFC][PATCH] sched: Better document ttwu()
Message-ID: <20200703113603.GL117543@hirez.programming.kicks-ass.net>
References: <20200702125211.GQ4800@hirez.programming.kicks-ass.net>
 <jhjd05d92y3.mognet@arm.com>
 <20200703083012.GU4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703083012.GU4800@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 10:30:12AM +0200, Peter Zijlstra wrote:
> On Thu, Jul 02, 2020 at 07:39:16PM +0100, Valentin Schneider wrote:
> > > @@ -3134,8 +3274,12 @@ static inline void prepare_task(struct task_struct *next)
> > >       /*
> > >        * Claim the task as running, we do this before switching to it
> > >        * such that any running task will have this set.
> > > +	 *
> > > +	 * __schedule()'s rq->lock and smp_mb__after_spin_lock() orders this
> > > +	 * store against prior state change of @next, also see
> > > +	 * try_to_wake_up(), specifically smp_load_acquire(&p->on_cpu).
> > 
> > smp_*cond*_load_acquire(&p->on_cpu, <blah>)
> 
> Both, but yeah.. arguably the cond one is the more important one.

Ah no, this one really want to match the WF_ON_CPU case. I'll clarify
non-the-less.
