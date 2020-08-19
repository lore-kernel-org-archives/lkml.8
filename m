Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1AAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BD8207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F0wxTivB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgHSHWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgHSHWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:22:30 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A9EC061389
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IFVPeoABVAWlX5Ye9pKQLfoaggiRVPrbiYCxG/HWnfs=; b=F0wxTivBlyaQRq9IiyUescXXr3
        o0voBsC22GH9KulcIsMhWH2ao2h9gf1d5jAR1ITbh+9g15uK0y/iDSios+j4zWyeC6qJDA+xLnZxQ
        Zt7QRCaTPj585HJrt5XSBjdWP6qNvfGZ+wdEErBuosJ5Ct6b+rbVBG9UgNmT9XBrgXzD3/ggwal21
        PIWy8p0b3Y+FEv1Sdwb4cL7WmvlzdLEGAUOvrF1+CHN80x7FUTl42/k6A5ojyC24tgYT+ldp2a5VO
        qyoxI5K/5KYLZsNAeh+AZj5AaVxiNVyampXY+cG9QJ2xf194ZCn3ia7fB03YaL26VWxPHoE/gEW5S
        XoHIfkzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8IQI-0008VQ-4g; Wed, 19 Aug 2020 07:22:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D78573059C6;
        Wed, 19 Aug 2020 09:22:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E5372BDDD466; Wed, 19 Aug 2020 09:22:09 +0200 (CEST)
Date:   Wed, 19 Aug 2020 09:22:09 +0200
From:   peterz@infradead.org
To:     Christoph Hellwig <hch@lst.de>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        axboe@kernel.dk, chris@chris-wilson.co.uk, davem@davemloft.net,
        kuba@kernel.org, fweisbec@gmail.com, oleg@redhat.com,
        vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v2 08/10] smp,irq_work: Use the new irq_work API
Message-ID: <20200819072209.GU2674@hirez.programming.kicks-ass.net>
References: <20200818105102.926463950@infradead.org>
 <20200818112418.460474861@infradead.org>
 <20200818162542.GB27196@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818162542.GB27196@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 06:25:42PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 12:51:10PM +0200, Peter Zijlstra wrote:
> > Convert the performance sensitive users of
> > smp_call_single_function_async() over to the new
> > irq_work_queue_remote_static().
> > 
> > The new API is marginally less crap but taking these users away allows
> > fixing up smp_call_single_function_async() without risk of performance
> > regressions.
> 
> You probably want a conversion patch per subsystem so that it sticks
> out.  What is so crap about this API?  How could we as subsystem
> maintainers help to make it less crappy?

The problem with both the current smp_call_function_single_async() and
the proposed irq_work_queue_remote_static() is that they require
external serialization and lifetime management.

That is, the external serialization comes from the non-atomic
test-and-set they both have. This works nicely when there is external
state that already serializes things, but totally comes apart (and
causes trivial list corruption) when you get it wrong.

The life-time thing is because you can't tell when the IPI is done.


The newly introduced irq_work_queue_remote() suffers neither of these
problems, and patch 9 fixes the first for
smp_call_function_single_async(). The whole smp_call_function*() class
suffers the second issue for .wait=0, typically they get combined with a
completion or some other state when/where it matters.

Patch 9 also shows why I introduced irq_work_queue_remote_static(), the
additional atomic op on enqueue is of course not cheap, and I can
imagine a bunch of users that don't really need it not wanting to pay
that price.


From a user pov (I'm one too), I'm not sure what we can do about this,
other than possibly accept the extra overhead :/

I do have a TODO item to see if I can come up with extra debugging
checks to catch abuse of these fragile things. One possible thing is to
have csd_unlock() also set csd->next = NULL, and have the llist_add()
users verify csd->next == NULL before doing the add.



