Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B6FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFFB820801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LKj+wOy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFLQxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgFLQxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:53:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985DAC03E96F;
        Fri, 12 Jun 2020 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P/jNQXjNSM/A6oN+60RJrl9Lv/d/a/2jIE6Q5ifN8/s=; b=LKj+wOy3l57klhVmnW+yujCrgG
        K7vkYi8Xm/4X3STZKa3XkUVc5AWgi7GO+GsOh+Bf1JE7dJHBKvlapqkZV0d9gYyCrh2J2Z4/kPTY9
        eelN7KE71KCqEPJLY22K0lXk1Ybhak4ch2hFNUsnJOnAq0JnQ/5vGXDnAmn/SHUfGAH/r3rjIEoH+
        GaaphLBJxhYFqpz+IeuImATeDu4sovDgngfnxkVC8r35iNWt+5x3sr+LWGuKxIjjCP9Qog63+PLHF
        jIphBiN6QCX8C98YlF0kJECi8dCAaccSYeNUekLCIHGQG7AgjrszTRsgowpiiHyc8cPivjxu43f3L
        XtfHf8Cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjmvG-0006Qb-09; Fri, 12 Jun 2020 16:52:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB7CB3003E4;
        Fri, 12 Jun 2020 18:52:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9937E213DCC6A; Fri, 12 Jun 2020 18:52:51 +0200 (CEST)
Date:   Fri, 12 Jun 2020 18:52:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [v2 PATCH] printk: Make linux/printk.h self-contained
Message-ID: <20200612165251.GG2497@hirez.programming.kicks-ass.net>
References: <20200611125144.GA2506@gondor.apana.org.au>
 <20200612043634.GA30181@gondor.apana.org.au>
 <20200612131405.GI4311@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612131405.GI4311@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 03:14:05PM +0200, Petr Mladek wrote:
> On Fri 2020-06-12 14:36:35, Herbert Xu wrote:
> > As it stands if you include printk.h by itself it will fail to
> > compile because it requires definitions from ratelimit.h.  However,
> > simply including ratelimit.h from printk.h does not work due to
> > inclusion loops involving sched.h and kernel.h.
> > 
> > This patch solves this by moving bits from ratelimit.h into a new
> > header file which can then be included by printk.h without any
> > worries about header loops.
> > 
> > The build bot then revealed some intriguing failures arising out
> > of this patch.  On s390 there is an inclusion loop with asm/bug.h
> > and linux/kernel.h that triggers a compile failure, because kernel.h
> > will cause asm-generic/bug.h to be included before s390's own
> > asm/bug.h has finished processing.  This has been fixed by not
> > including kernel.h in arch/s390/include/asm/bug.h.
> > 
> > A related failure was seen on powerpc where asm/bug.h leads to
> > the inclusion of linux/kernel.h via asm-generic/bug.h which then
> > prematurely tries to use the very macros defined in asm/bug.h.
> > The particular inclusion path which led to this involves lockdep.h.
> > I have fixed this moving the type definitions lockdep.h into the
> > new lockdep_types.h.
> > 
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> I am fine with the changes as long as the kernel test robot
> does not complain ;-)
> 
> Acked-by: Petr Mladek <pmladek@suse.com>
> 
> Well, I wonder if PeterZ is fine with the lockdep part. It might make
> sense to split it into separate patch as a prerequisite.

They look fine, but yes, I think it makes sense to split that out.
