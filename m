Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F3CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B924020897
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aXoNO5iH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgFRGvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgFRGvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:51:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9312C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 23:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6FGRqWtgXD15Eh22+O8zWbquO7KKkqTc+lfdYmXTOtc=; b=aXoNO5iH7w+O2Ud+POcHyxjJJv
        dZVED8sEXW6C6VUJA7gBX1MEh/uBmcHhgt/GsBoyIxenBaNTfVxgiXmD8I0JMVFiR0cjGUPGhNOdc
        07UCtPoH4uv0BfxLpmAjblCRUfqefEVw8JgsXfoHY5AXLauaPpQv/ROZ1HydNmdKXLj6zg2TnsrAM
        +RZ6UlYFJADK0l99TtjGWeV0tyjS4mIn/uFcvxKM4GK1ePzIuiYvugoJc2VhUuDTwAdy1rAhNDIRQ
        yQiByWNU3po9QvECdfZfbajoS0a7H8uONOewkAlLkqQ4M93M90dPiHB3otgzbutzPJICHfnC/upBg
        ptJniOSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jloOC-0006Rf-0S; Thu, 18 Jun 2020 06:51:08 +0000
Date:   Wed, 17 Jun 2020 23:51:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, frederic@kernel.org,
        tsbogend@alpha.franken.de, axboe@kernel.dk, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, dchickles@marvell.com,
        davem@davemloft.net, kuba@kernel.org, daniel.thompson@linaro.org,
        gerald.schaefer@de.ibm.com
Subject: Re: [PATCH 6/6] smp: Cleanup smp_call_function*()
Message-ID: <20200618065107.GA4406@infradead.org>
References: <20200615125654.678940605@infradead.org>
 <20200615131143.434079683@infradead.org>
 <20200617082349.GA19894@infradead.org>
 <20200617110401.GG2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617110401.GG2531@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:04:01PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 17, 2020 at 01:23:49AM -0700, Christoph Hellwig wrote:
> 
> > > @@ -178,9 +178,7 @@ static void zpci_handle_fallback_irq(voi
> > >  		if (atomic_inc_return(&cpu_data->scheduled) > 1)
> > >  			continue;
> > >  
> > > -		cpu_data->csd.func = zpci_handle_remote_irq;
> > > -		cpu_data->csd.info = &cpu_data->scheduled;
> > > -		cpu_data->csd.flags = 0;
> > > +		cpu_data->csd = CSD_INIT(zpci_handle_remote_irq, &cpu_data->scheduled);
> > 
> > This looks weird.  I'd much rather see an initialization ala INIT_WORK:
> > 
> > 		INIT_CSD(&cpu_data->csd, zpci_handle_remote_irq,
> > 			 &cpu_data->scheduled);
> 
> 
> like so then?

Much better.  Although if we touch all the callers we might as well
pass the csd as the argument to the callback, as with that we can
pretty trivially remove the private data field later.

Btw, it seems the callers that don't have the CSD embedded into the
containing structure seems to be of these two kinds:

 - reimplementing on_each_cpumask (mostly because they can be called
   from irq context)
 - reimplenenting smp_call_function_single because they want
   to sleep instead of busy wait

I wonder if those would be useful primitives for smp.c..
