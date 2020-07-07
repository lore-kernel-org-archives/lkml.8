Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8818720702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YbqqsTv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgGGHtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGHtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:49:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C01C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qpCyLxWI8+vr0RRTomM8CK40nhOuK0K2F+B2/Nf6Os8=; b=YbqqsTv/GfrsMC95U9tokQPr5n
        +etquVO7AkoJT+OeTAPPUl+hN9Caw6UCaPupuzoGRC1liysB6zpQj8EhGX3pcL9r7A26li+subYry
        FW/4FqoLVT+QwzMUV6cELMtyvoRnS8NWcAMqoJ22csTiSpPAxuR+CuImX7tHe0FxIK+1zhsKyBqG+
        LvjvrJ4SIYNdi38lNE1WgF0fvlIz/DBhp5eBoY7cQAqptFtHiMIz96cOi0JI0mRfVQCFez/L86dxD
        QrN8rPUAqndcJka26PzVfe4/R+Oe66a0ECSnXGpw6q9fScNRwtUFxLYurP9KGzA5eEp31QidcKbqE
        PokuypKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsiLa-0001Kv-LH; Tue, 07 Jul 2020 07:48:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B3823006D0;
        Tue,  7 Jul 2020 09:48:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 71026213C65B5; Tue,  7 Jul 2020 09:48:57 +0200 (CEST)
Date:   Tue, 7 Jul 2020 09:48:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paul.gortmaker@windriver.com, valentin.schneider@arm.com
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200707074857.GJ4800@hirez.programming.kicks-ass.net>
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702213627.GF3183@techsingularity.net>
 <20200703090226.GV4800@hirez.programming.kicks-ass.net>
 <20200703104033.GK117543@hirez.programming.kicks-ass.net>
 <20200703205153.GA19901@codemonkey.org.uk>
 <20200706145952.GB597537@hirez.programming.kicks-ass.net>
 <20200706212057.GA18637@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706212057.GA18637@codemonkey.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 05:20:57PM -0400, Dave Jones wrote:
> On Mon, Jul 06, 2020 at 04:59:52PM +0200, Peter Zijlstra wrote:
>  > On Fri, Jul 03, 2020 at 04:51:53PM -0400, Dave Jones wrote:
>  > > On Fri, Jul 03, 2020 at 12:40:33PM +0200, Peter Zijlstra wrote:
>  > >  
>  > > looked promising the first few hours, but as soon as it hit four hours
>  > > of uptime, loadavg spiked and is now pinned to at least 1.00
>  > 
>  > OK, lots of cursing later, I now have the below...
>  > 
>  > The TL;DR is that while schedule() doesn't change p->state once it
>  > starts, it does read it quite a bit, and ttwu() will actually change it
>  > to TASK_WAKING. So if ttwu() changes it to WAKING before schedule()
>  > reads it to do loadavg accounting, things go sideways.
>  > 
>  > The below is extra complicated by the fact that I've had to scrounge up
>  > a bunch of load-store ordering without actually adding barriers. It adds
>  > yet another control dependency to ttwu(), so take that C standard :-)
> 
> Man this stuff is subtle. I could've read this a hundred times and not
> even come close to approaching this.
> 
> Basically me reading scheduler code:
> http://www.quickmeme.com/img/96/9642ed212bbced00885592b39880ec55218e922245e0637cf94db2e41857d558.jpg

Heh, that one made me nearly spill my tea, much funnies :-)

But yes, Dave Chinner also complained about this for the previous fix.
I've written this:

  https://lore.kernel.org/lkml/20200703133259.GE4781@hirez.programming.kicks-ass.net/

to help with that. But clearly I'll need to update that patch again
after this little adventure.

>  > I've booted it, and build a few kernels with it and checked loadavg
>  > drops to 0 after each build, so from that pov all is well, but since
>  > I'm not confident I can reproduce the issue, I can't tell this actually
>  > fixes anything, except maybe phantoms of my imagination.
> 
> Five hours in, looking good so far.  I think you nailed it.

\o/ hooray! Thanks for testing Dave!
