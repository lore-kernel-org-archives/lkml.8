Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88457C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BBC207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P8x86hz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgHTNIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbgHTNIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:08:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358D1C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E3zojqPhdk7VSZAujguQkn+IVWrkry8akdjcjCF1GMY=; b=P8x86hz0Jfe9ms3orxSszObeD+
        ypy4aFu7xOCkhBcWo5N9X2PZAeROH+GK/+MdXh9NR9rGxoFBETN4/d8RZcVBZ8rOLd3OAV2zQKdtT
        uCCbZ16bpdOJFjYq6dww6ynDe4tzVX7z/2AzDqiVFLbHE3GPTVoey/faxfrBQp36uHmg6DQ3BXhwL
        uY9LAxIoSB0ptToc+Csmgh/E6ZbzvrhXNlUvY6WTR1c97mJRvfTC3tv6FtOq+SH8fqT6HGwbkeYsG
        doMHDJ/5oVxwRtE3wu8YFlb2QE8ooVWcmtPo+L60Ge96U+LMDExnyPHKIkgOc47SX6JuuKoVFUegK
        zx01TIRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8kIi-0000zQ-Pp; Thu, 20 Aug 2020 13:08:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D75B305E21;
        Thu, 20 Aug 2020 15:08:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 417CD28B7E840; Thu, 20 Aug 2020 15:08:12 +0200 (CEST)
Date:   Thu, 20 Aug 2020 15:08:12 +0200
From:   peterz@infradead.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC][PATCH v2 08/10] smp,irq_work: Use the new irq_work API
Message-ID: <20200820130812.GU2674@hirez.programming.kicks-ass.net>
References: <20200818105102.926463950@infradead.org>
 <20200818112418.460474861@infradead.org>
 <20200818162542.GB27196@lst.de>
 <20200819072209.GU2674@hirez.programming.kicks-ass.net>
 <CAHk-=wgMATDQQxLSsgmxCoCqApVXVeRnGOf6iWjnYdTJY_R3aw@mail.gmail.com>
 <20200819194116.GJ2674@hirez.programming.kicks-ass.net>
 <CAHk-=wh2_pAFxa8FN95KoOseqMYPD0iX-d6ORbXxX22ixVZwBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh2_pAFxa8FN95KoOseqMYPD0iX-d6ORbXxX22ixVZwBQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 03:04:56PM -0700, Linus Torvalds wrote:
> On Wed, Aug 19, 2020 at 12:41 PM <peterz@infradead.org> wrote:
> >
> > I'm not sure I get the "expensive irq_work queues" argument, I fully
> > agree with you that adding the atomic op is fairly crap.
> 
> There's an atomic op on the actual runing side too, because of the
> whole IRQ_WORK_PENDING thing.
> 
> So you get that double hit.
> 
> Maybe it doesn't matter. I just remember us being very careful to
> avoid any unnecessary atomics in the smp_call_function area, but
> admittedly I haven't worked on that code for a few years, so ..

Patch #3 trades that atomic for a full barrier. Not a massive win on
x86, but still.

