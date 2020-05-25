Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5427C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D1C2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbgEYQvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgEYQvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:51:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F3C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 09:51:42 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdGKC-0005Vg-Nn; Mon, 25 May 2020 18:51:40 +0200
Date:   Mon, 25 May 2020 18:51:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 7/7] zram: Use local lock to protect per-CPU data
Message-ID: <20200525165140.r2gkn6avembdaonh@linutronix.de>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-8-bigeasy@linutronix.de>
 <20200525072648.GF329373@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525072648.GF329373@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25 09:26:48 [+0200], Ingo Molnar wrote:
> 
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > --- a/drivers/block/zram/zcomp.h
> > +++ b/drivers/block/zram/zcomp.h
> > @@ -5,11 +5,13 @@
> >  
> >  #ifndef _ZCOMP_H_
> >  #define _ZCOMP_H_
> > +#include <linux/locallock.h>
> >  
> >  struct zcomp_strm {
> >  	/* compression/decompression buffer */
> >  	void *buffer;
> >  	struct crypto_comp *tfm;
> > +	struct local_lock lock;
> >  };
> 
> I believe the general pattern is to put the lock in front of the 
> fields it protects.
> 
> I'd also add a comment documenting that both fields ->buffer and ->tfm 
> are protected by the lock.

I moved the member, and added a comment.

> Thanks,
> 
> 	Ingo

Sebastian
