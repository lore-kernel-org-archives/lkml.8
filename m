Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5B0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA8320823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390434AbgFXIV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:21:58 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48412 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388916AbgFXIV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:21:58 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jo0f3-0005oy-3q; Wed, 24 Jun 2020 18:21:38 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 24 Jun 2020 18:21:37 +1000
Date:   Wed, 24 Jun 2020 18:21:37 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: build failure after merge of the printk tree
Message-ID: <20200624082137.GA14282@gondor.apana.org.au>
References: <20200621131554.5a662afe@canb.auug.org.au>
 <20200623102655.6d16e610@canb.auug.org.au>
 <20200623121637.GA8444@alley>
 <20200623121937.GA9671@gondor.apana.org.au>
 <20200623142858.GB8444@alley>
 <20200624002057.GA12716@gondor.apana.org.au>
 <20200624081929.GD8444@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624081929.GD8444@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:19:29AM +0200, Petr Mladek wrote:
> On Wed 2020-06-24 10:20:58, Herbert Xu wrote:
> > On Tue, Jun 23, 2020 at 04:28:58PM +0200, Petr Mladek wrote:
> > >
> > > It is similar cycle:
> > > 
> > > spinlock_types.h -> lockdep.h -> printk.h -> ratelimit.h -> spinlock_types.h
> > > 
> > > But this time it happens via list.h -> kernel.h ->printk.h.
> > > Where list.h needs READ_ONCE() stuff from compiler.h.
> > 
> > But this is exactly the loop that's fixed by the lockdep_types
> > patch.
> 
> I think that this problem is similar to the one on s390 that was
> solved by compiler.h in arch/s390/include/asm/bug.h
> 
> It is related to
> https://lore.kernel.org/r/20200613142901.65xieioomt6bbqa6@ltop.local
> 
> It seems that we need the same change also in list.h.

Oh I see.  I misunderstood what you said in the first email.
 
> Do you mean to repost the 2nd patch with the change in
> include/linux/list.h?

OK let me test this and repost.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
