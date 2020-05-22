Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F16C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2132920825
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WPC8+ucV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgEVCAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 22:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgEVCAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:00:44 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1C4C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 19:00:44 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g185so9343281qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 19:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7VXhRvEZ7AZfj1IqAb7ZWt33FE0XL8kfxx31Yf9Ecuw=;
        b=WPC8+ucVfXY+1tpUgjR07S2UMMPw8h0/8LAGLBS8Znu29ayxkCmGkQpm2rNlHp681Y
         iEFsGHCj5SpuQl0hdoK/kk1vRohCokt3UVU3OzqsF9AVFV7syE3vg5b9x7AtbqhMBOFh
         9VEPHONSG6IIavPXa3Wew7CX9MQHd+PzBOqQTKrZ2ej1Ok4DN3jqMad6rxuXVfI+tVvY
         VXONL7CzMbE6YarfqQ5be2TdAMby/zZXM2bF4ErdDFiS7uZMST40ntdFNm6UnAmd11qW
         YEWD8OXyEjMIgKs0hTUa13Sm+ogq/8Y9p1nmkbUBzUBUQr0L6zcqsHdfPakA4caM8sR5
         /AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7VXhRvEZ7AZfj1IqAb7ZWt33FE0XL8kfxx31Yf9Ecuw=;
        b=hkDa0LCNaENfRj5Jey+4Q/Amc3IW7V5uQMEajTPUqOsqJ0VXARExYOJcaIq8pJz53b
         aQmVPp9Vw2JD3DJ8riQfXNRMbZZH8obEds4PhqIGL7Xq70zkw8PPqgzeJ+cOOAEHhT8a
         SctsBSBSUqtBZftOR1tEtMo5O48mY3CFOIR85uuxfLwvFJ0qreKMFw1IxsfsBI+QLvga
         0kyyIIQ3QQpbwsw6zmR7VsBUMu3dJ7YvMbfFZ8UIoqn71Yqt04jiZDr270xSFB8lbK2Y
         Xm6xjymApAzuhvWH0yKQi37KlieEZI6MnLLVBehe5wbtTAQ70xnG7WMqtMmuHg17Aepf
         WPHw==
X-Gm-Message-State: AOAM530krcYxecwwuzOdyA2V8Ml9xun5rOrBsntRd1F2Sbd6MzEhKG9s
        bQXJo+DSOIeYyE/lOM/DoEAA1FcKuElvkw==
X-Google-Smtp-Source: ABdhPJxQxaBQ20712JGspAdfjSIEw8SaV9KRIZqgplkYJhLE0+UteD9xq8e8wbquN7K3Y9bym+aY+Q==
X-Received: by 2002:a05:620a:a53:: with SMTP id j19mr13148335qka.183.1590112843194;
        Thu, 21 May 2020 19:00:43 -0700 (PDT)
Received: from ovpn-112-192.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s201sm949467qka.8.2020.05.21.19.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 19:00:42 -0700 (PDT)
Date:   Thu, 21 May 2020 22:00:33 -0400
From:   Qian Cai <cai@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Endless soft-lockups for compiling workload since next-20200519
Message-ID: <20200522020033.GA17093@ovpn-112-192.phx2.redhat.com>
References: <CAG=TAF6jUsQrW-fjbS3vpjkMfn8=MUDsuQxjk3NMfvQa250RHA@mail.gmail.com>
 <20200520125056.GC325280@hirez.programming.kicks-ass.net>
 <20200521004035.GA15455@lenoir>
 <20200521093938.GG325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521093938.GG325280@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:39:38AM +0200, Peter Zijlstra wrote:
> On Thu, May 21, 2020 at 02:40:36AM +0200, Frederic Weisbecker wrote:
> > On Wed, May 20, 2020 at 02:50:56PM +0200, Peter Zijlstra wrote:
> > > On Tue, May 19, 2020 at 11:58:17PM -0400, Qian Cai wrote:
> > > > Just a head up. Repeatedly compiling kernels for a while would trigger
> > > > endless soft-lockups since next-20200519 on both x86_64 and powerpc.
> > > > .config are in,
> > > 
> > > Could be 90b5363acd47 ("sched: Clean up scheduler_ipi()"), although I've
> > > not seen anything like that myself. Let me go have a look.
> > > 
> > > 
> > > In as far as the logs are readable (they're a wrapped mess, please don't
> > > do that!), they contain very little useful, as is typical with IPIs :/
> > > 
> > > > [ 1167.993773][    C1] WARNING: CPU: 1 PID: 0 at kernel/smp.c:127
> > > > flush_smp_call_function_queue+0x1fa/0x2e0
> > 
> > So I've tried to think of a race that could produce that and here is
> > the only thing I could come up with. It's a bit complicated unfortunately:
> 
> This:
> 
> >         smp_call_function_single_async() {             smp_call_function_single_async() {
> >             // verified csd->flags != CSD_LOCK             // verified csd->flags != CSD_LOCK
> >             csd->flags = CSD_LOCK                          csd->flags = CSD_LOCK
> 
> concurrent smp_call_function_single_async() using the same csd is what
> I'm looking at as well. Now in the ILB case there is an easy cure:
> 
> (because there is only a single ilb target)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 01f94cf52783..b6d8a7b991f0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10033,7 +10033,7 @@ static void kick_ilb(unsigned int flags)
>  	 * is idle. And the softirq performing nohz idle load balance
>  	 * will be run before returning from the IPI.
>  	 */
> -	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
> +	smp_call_function_single_async(ilb_cpu, &this_rq()->nohz_csd);
>  }
>  
>  /*
> 
> Qian, can you give that a spin?

Running for a few hours now. It works fine.
