Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E197FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A8F20722
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sg+mW7y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgHDGau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgHDGau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:30:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06975C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 23:30:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a79so3863239pfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BS92Sq6q7n94/aHq6JQ3yd1cYmx3gIjRwBJOL6Tqt7s=;
        b=Sg+mW7y8iDCWNlMIqjCofkFAn8mmYpoI5p05fB1k9dPbzPV3dP967l+i1WPVmM9iJj
         L4HItDLcwRP7gn3rhzhNEfUeZAFCKCJg0tyMOKEUOeceu0BBKs/7ZalGZOFe7FuNeHeo
         DLN6Epa2z6pXgYW/HyLtUOpKfLxC1w6PdQ453O7Z70PAkSqKGlxIAjb+b7Bj0Wbuy71k
         yV5X1a6KGtx2qtB0Og0sbYmbDVFaJVJI+07q7OPCelzrT4OmKwo3TKCdLhJO9EjadUB2
         mPmBWTbyLkkuGPlzOhVFNfvDRo6ofK4soaj0bjHN5KFcdPDG4L6Rd2dF/9P3hlWb7kga
         hr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BS92Sq6q7n94/aHq6JQ3yd1cYmx3gIjRwBJOL6Tqt7s=;
        b=bbL5br2ZWAyKTeb1OfixBHAsV4/WqIodiRRz553+9m+y9OLu4WSDAnQGl07kVrEioZ
         tr/8M5on0j774QFaFL1zKSh/QAt1dGht/xeVCfTBAphFYJ7IZyKce3uU3FZfDYuSDBOE
         bRd6FYmV5MiPso9Y+ADj+JF/raN7uwx41FyqbhdjHUIlmhLIetkuODPPFHy9407oTu0/
         Iu9BWTAJoZW9kPvcVKXBZ9kWiw/naorL1WNubIG6anemsbg9WvPkVzehi3yV7/LHn/kn
         Fb39UhUXVylnj1UqJCBOBC02wkv9YUBlkOC9iWkWCSGIUhu2iD3VhdVb5RMk6iXYCIo9
         8LzQ==
X-Gm-Message-State: AOAM5335Q9E4lnUFxbPDk1i+gyOHzH/gw8kU++B+eGF4r5CRSyhT/kaX
        84Nq0ZBtT96DHjUthw5i4cBTZs5IRus=
X-Google-Smtp-Source: ABdhPJyGa9ah22zuDQgf0Ditcuq0XQOapNoNRHgrXa/42Bm+te+ZwAEHhvV26wUUZTLHQtWR54mL+Q==
X-Received: by 2002:a62:647:: with SMTP id 68mr20097776pfg.45.1596522649293;
        Mon, 03 Aug 2020 23:30:49 -0700 (PDT)
Received: from localhost ([122.162.244.227])
        by smtp.gmail.com with ESMTPSA id k21sm17731086pgl.0.2020.08.03.23.30.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 23:30:48 -0700 (PDT)
Date:   Tue, 4 Aug 2020 12:00:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] arch_topology: disable frequency invariance for
 CONFIG_BL_SWITCHER
Message-ID: <20200804063046.a2hw5cxwiewhb3aw@vireshk-mac-ubuntu>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-4-ionela.voinescu@arm.com>
 <20200730042423.4j22udejluis7blw@vireshk-mac-ubuntu>
 <1db4317a-0018-1590-f0ae-ed5e235b174f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db4317a-0018-1590-f0ae-ed5e235b174f@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-07-20, 12:29, Dietmar Eggemann wrote:
> On 30/07/2020 06:24, Viresh Kumar wrote:
> > On 22-07-20, 10:37, Ionela Voinescu wrote:
> >> +++ b/drivers/base/arch_topology.c
> >> @@ -27,6 +27,7 @@ __weak bool arch_freq_counters_available(struct cpumask *cpus)
> >>  }
> >>  DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
> >>  
> >> +#ifndef CONFIG_BL_SWITCHER
> >>  void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> >>  			 unsigned long max_freq)
> >>  {
> >> @@ -46,6 +47,7 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> >>  	for_each_cpu(i, cpus)
> >>  		per_cpu(freq_scale, i) = scale;
> >>  }
> >> +#endif
> > 
> > I don't really like this change, the ifdef hackery is disgusting and
> > then we are putting that in a completely different part of the kernel.
> > 
> > There are at least these two ways of solving this, maybe more:
> > 
> > - Fix the bl switcher driver and add the complexity in it (which you
> >   tried to do earlier).
> > 
> > - Add a cpufreq flag to skip arch-set-freq-scale call.
> 
> I agree it's not nice but IMHO the cpufreq flag is worse since we would
> introduce new infrastructure only for a deprecated feature. I'm assuming
> that BL SWITCHER is the only feature needing this CPUfreq flag extension.
> 
> #ifdef CONFIG_BL_SWITCHER is already in drivers/irqchip/irq-gic.c so
> it's ugly already.
> 
> Runtime detecting (via bL_switching_enabled) of BL SWITCHER is right now
> also only handled inside vexpress-spc-cpufreq.c via a
> bL_switcher_notifier. A mechanism which also sits behind a #ifdef
> CONFIG_BL_SWITCHER.

Vexpress one is a driver and so ugliness could be ignored here :)

So here is option number 3 (in continuation of the earlier two
options):
- Don't do anything for bL switcher, just add a TODO/NOTE in the
  driver that FIE is broken for switcher. And I don't think anyone
  will care about FIE for the switcher anyway :)

-- 
viresh
