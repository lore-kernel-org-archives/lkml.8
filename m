Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868FFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659E12073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389166AbgEYQuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgEYQuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:50:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CFEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 09:50:51 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdGJL-0005UP-Vl; Mon, 25 May 2020 18:50:48 +0200
Date:   Mon, 25 May 2020 18:50:47 +0200
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
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 6/7] zram: Allocate struct zcomp_strm as per-CPU memory
Message-ID: <20200525165047.qkftrcv7exabilnr@linutronix.de>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-7-bigeasy@linutronix.de>
 <20200525072407.GE329373@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525072407.GE329373@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25 09:24:07 [+0200], Ingo Molnar wrote:
> Various typo/spelling fixes:
> 
> > zcomp::stream is a per-CPU pointer, pointing to struct zcomp_strm 
> > which contains two pointers. Having struct zcomp_strm allocated 
> > directly as per-CPU memory would avoid one additional memory 
> > allocation and a pointer dereference. This also simplifies the 
> > addition of a local_lock to struct zcomp_strm.

thx, updated.

> > diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> > index 1a8564a79d8dc..ae6dc137a1ed8 100644
> > --- a/drivers/block/zram/zcomp.c
> > +++ b/drivers/block/zram/zcomp.c
> > @@ -37,19 +37,17 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
> >  	if (!IS_ERR_OR_NULL(zstrm->tfm))
> >  		crypto_free_comp(zstrm->tfm);
> >  	free_pages((unsigned long)zstrm->buffer, 1);
> > -	kfree(zstrm);
> > +	zstrm->tfm = NULL;
> > +	zstrm->buffer = NULL;
> >  }
> >  
> >  /*
> >   * allocate new zcomp_strm structure with ->tfm initialized by
> >   * backend, return NULL on error
> >   */
> > -static struct zcomp_strm *zcomp_strm_alloc(struct zcomp *comp)
> > +static int zcomp_strm_alloc(struct zcomp_strm *zstrm,
> > +			    struct zcomp *comp)
> 
> There's no need to put these into two lines, in a single line it's 
> only 73 columns long. Leftover from some earlier bloat?

yup, updated.

> >  void zcomp_stream_put(struct zcomp *comp)
> > @@ -159,16 +157,14 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
> >  {
> >  	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
> >  	struct zcomp_strm *zstrm;
> > +	int ret;
> >  
> > -	if (WARN_ON(*per_cpu_ptr(comp->stream, cpu)))
> > -		return 0;
> > -
> > -	zstrm = zcomp_strm_alloc(comp);
> > -	if (IS_ERR_OR_NULL(zstrm)) {
> > +	zstrm = per_cpu_ptr(comp->stream, cpu);
> > +	ret = zcomp_strm_alloc(zstrm, comp);
> > +	if (ret) {
> >  		pr_err("Can't allocate a compression stream\n");
> >  		return -ENOMEM;
> 
> BTW., with the allocation being in a single place and us having a 
> proper 'ret', the return -ENOMEM could turn into 'return ret'?

yes.

> Thanks,
> 
> 	Ingo

Sebastian
