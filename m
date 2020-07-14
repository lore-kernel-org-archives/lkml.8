Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99241C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7166D221FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="agPnpXFU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SO9e64r7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGNHIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgGNHIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:08:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467C1C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:08:22 -0700 (PDT)
Date:   Tue, 14 Jul 2020 09:08:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594710500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jPRRFki10EiKd1lhNuS/YJXha59CcEIMe6vwOhimWWM=;
        b=agPnpXFUrnQRVkS/UHW2Ri+kLt1+TXg2coqyXzHiJh6ez1+2izW5ch9kTbN6sDhSmcAv0Q
        xW6SybTM06IcugrE7LQc6Y9fqcXD1n5dzKApwDwv94nDaPMnNalPAyPQluIeXU9mnwoHRi
        +vBfsPVQwd5yXhFRg7F8OegfWFhjZ0qncXCHx2/70yIdqEJdnp3tQlMdwbpWLBQVBNfTSS
        aS9pmoNd+E513An4urR4P5fVI+35/W6vcHC4YoX6Xn2rS69mHqBtanLleFWJEQZb/jzwkq
        yI0985rFANY8zCd4hBIGHTpsp8mQ1iVcojTJCU/SGna7QfRIXEUZEDLHQhA4XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594710500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jPRRFki10EiKd1lhNuS/YJXha59CcEIMe6vwOhimWWM=;
        b=SO9e64r7iyJZGDcire0q/B7Iq/vHZCokDD3nW6yL7fxR/IHz5Wb97m0US0xyVvHqXLyHA3
        UkoMeD0LFxTSOJCw==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] timers: Use only bucket expiry for base->next_expiry
 value
In-Reply-To: <20200710214458.GA31351@lenoir>
Message-ID: <alpine.DEB.2.21.2007140853310.17878@somnus>
References: <20200710154622.14989-1-anna-maria@linutronix.de> <20200710214458.GA31351@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On Fri, 10 Jul 2020, Frederic Weisbecker wrote:

> Hi Anna-Maria,
> 
> Nice change, it indeed makes more sense that way.
> Just a few details below:
> 
> On Fri, Jul 10, 2020 at 05:46:22PM +0200, Anna-Maria Behnsen wrote:
> > Use the expiry value of the bucket into which the timer is queued to
> > do the new first timer check. This fixes the base->clk going backward
> > problem and also prevents unnecessary softirq invocations when the
> > timer->expiry is not equal to the bucket expiry time in case of a new
> > first timer which is queued in a secondary wheel level.
> 
> I think there shouldn't be such unecessary softirq invocations. Either they
> fire at the bucket expiry time or the timer expiry time, it doesn't make
> much difference.

It will make a difference but only with your queue (I had the changes of
your queue already in mind, when writing the commit message)... I will
remove this.

> More important below:
> 
> > -static int calc_wheel_index(unsigned long expires, unsigned long clk)
> > +static int calc_wheel_index(unsigned long expires, unsigned long clk,
> > +			    unsigned long *bucket_expiry)
> >  {
> >  	unsigned long delta = expires - clk;
> >  	unsigned int idx;
> >  
> >  	if (delta < LVL_START(1)) {
> > -		idx = calc_index(expires, 0);
> > +		idx = calc_index(expires, 0, bucket_expiry);
> >  	} else if (delta < LVL_START(2)) {
> > -		idx = calc_index(expires, 1);
> > +		idx = calc_index(expires, 1, bucket_expiry);
> >  	} else if (delta < LVL_START(3)) {
> > -		idx = calc_index(expires, 2);
> > +		idx = calc_index(expires, 2, bucket_expiry);
> >  	} else if (delta < LVL_START(4)) {
> > -		idx = calc_index(expires, 3);
> > +		idx = calc_index(expires, 3, bucket_expiry);
> >  	} else if (delta < LVL_START(5)) {
> > -		idx = calc_index(expires, 4);
> > +		idx = calc_index(expires, 4, bucket_expiry);
> >  	} else if (delta < LVL_START(6)) {
> > -		idx = calc_index(expires, 5);
> > +		idx = calc_index(expires, 5, bucket_expiry);
> >  	} else if (delta < LVL_START(7)) {
> > -		idx = calc_index(expires, 6);
> > +		idx = calc_index(expires, 6, bucket_expiry);
> >  	} else if (LVL_DEPTH > 8 && delta < LVL_START(8)) {
> > -		idx = calc_index(expires, 7);
> > +		idx = calc_index(expires, 7, bucket_expiry);
> >  	} else if ((long) delta < 0) {
> >  		idx = clk & LVL_MASK;
> 
> You also need to handle that part. That's in fact the critical one  :)
> 

damn... too many idx here...

Thanks,

	Anna-Maria

