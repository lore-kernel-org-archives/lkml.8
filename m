Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42494C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFDF2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L32Q6EwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgFROiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbgFROiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:38:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33C0C06174E;
        Thu, 18 Jun 2020 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QkS9Mtt0QDYYe9qdb3TQ9/JElZki5rRNgo5h249RJlY=; b=L32Q6EwUocb1McN+U2WqgDbYx1
        4GkclM9Db9mAuFZXMPwXX23Mt2Q4oVOzO84QHQ6BBXfeCVr6gf4ZAOwBZaqc2yhhEgjG540/H/sIH
        ePMWCIwSXxNmlgILMXr/q1zXMeXnniSlpR3cMaKca8GTWtBM23md02Wt1LXdJXPJaC6PibEhwst6c
        ModKdOyeLTrE6BM0xiuQj/UCB/QKTszsTxl/1b25tfCB0lqf+2+uHY3slTWqn8huQQNgXqgfZi5P8
        fvwzGm+j9zVGpgax3VqNyq2RL21lJXMhXGv2rNnWk7df6kVlVABP5JWOha8rStyxvYrFcIvWQcGNo
        0qaAvbeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlvfe-0000C3-Ki; Thu, 18 Jun 2020 14:37:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF9CF30604B;
        Thu, 18 Jun 2020 16:37:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4A0E21AB372C; Thu, 18 Jun 2020 16:37:35 +0200 (CEST)
Date:   Thu, 18 Jun 2020 16:37:35 +0200
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
Subject: Re: [v3 PATCH 1/2] lockdep: Split header file into lockdep and
 lockdep_types
Message-ID: <20200618143735.GJ576905@hirez.programming.kicks-ass.net>
References: <20200617071524.GA3055@gondor.apana.org.au>
 <E1jlSJz-0003hE-8g@fornost.hmeau.com>
 <20200617082459.GC2531@hirez.programming.kicks-ass.net>
 <20200617122449.GX31238@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617122449.GX31238@alley>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 02:24:50PM +0200, Petr Mladek wrote:
> On Wed 2020-06-17 10:24:59, Peter Zijlstra wrote:
> > On Wed, Jun 17, 2020 at 05:17:19PM +1000, Herbert Xu wrote:
> > > There is a header file inclusion loop between asm-generic/bug.h
> > > and linux/kernel.h.  This causes potential compile failurs depending
> > > on the which file is included first.  One way of breaking this loop
> > > is to stop spinlock_types.h from including lockdep.h.  This patch
> > > splits lockdep.h into two files for this purpose.
> > > 
> > > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > Acked-by: Petr Mladek <pmladek@suse.com>
> > > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > Looks good.
> > 
> > Petr, how about I stick this in tip/locking/header for us both to share?
> 
> Sure. Sounds good to me.

OK, done. tip/locking/header should contain just this patch, and that
branch also got merged into tip/locking/core.
