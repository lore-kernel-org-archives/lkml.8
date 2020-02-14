Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EF6C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3682187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgBNOqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:46:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:38516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgBNOqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:46:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19CCDB028;
        Fri, 14 Feb 2020 14:46:02 +0000 (UTC)
Message-ID: <e3d851477d569ccb66294b2292495778a3a24c09.camel@suse.de>
Subject: Re: [PATCH] clocksource: owl: Improve owl_timer_init fail messages
From:   Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Matheus Castello <matheus@castello.eng.br>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 14 Feb 2020 15:46:05 +0100
In-Reply-To: <20200214141714.GA30872@Mani-XPS-13-9360>
References: <20200214064923.190035-1-matheus@castello.eng.br>
         <20200214141714.GA30872@Mani-XPS-13-9360>
Organization: SUSE Linux GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Freitag, den 14.02.2020, 19:47 +0530 schrieb Manivannan Sadhasivam:
> On Fri, Feb 14, 2020 at 03:49:23AM -0300, Matheus Castello wrote:
> > Adding error messages, in case of not having a defined clock
> > property
> > and in case of an error in clocksource_mmio_init, which may not be
> > fatal, so just adding a pr_err to notify that it failed.
> > 
> > Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> > ---
> > 
> > Tested on my Caninos Labrador s500 based board. If the clock
> > property is not
> > set this message would help debug:
> > 
> > ...
> > [    0.000000] Failed to get OF clock for clocksource
> > [    0.000000] Failed to initialize '/soc/timer@b0168000': -2
> > [    0.000000] timer_probe: no matching timers found
> > ...
> > 
> >  drivers/clocksource/timer-owl.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/clocksource/timer-owl.c
> > b/drivers/clocksource/timer-owl.c
> > index 900fe736145d..f53596f9e86c 100644
> > --- a/drivers/clocksource/timer-owl.c
> > +++ b/drivers/clocksource/timer-owl.c
> > @@ -135,8 +135,10 @@ static int __init owl_timer_init(struct
> > device_node *node)
> >  	}
> > 
> >  	clk = of_clk_get(node, 0);
> > -	if (IS_ERR(clk))
> > +	if (IS_ERR(clk)) {
> > +		pr_err("Failed to get OF clock for clocksource\n");
> 
> No need to mention OF here. Just, "Failed to get clock for
> clocksource"
> is good enough.

We should be consistent then and output PTR_ERR(clk), too.

i.e., "Failed to get clock for clocksource (%d)\n"

> 
> >  		return PTR_ERR(clk);
> > +	}
> > 
> >  	rate = clk_get_rate(clk);
> > 
> > @@ -144,8 +146,11 @@ static int __init owl_timer_init(struct
> > device_node *node)
> >  	owl_timer_set_enabled(owl_clksrc_base, true);
> > 
> >  	sched_clock_register(owl_timer_sched_read, 32, rate);
> > -	clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
> > -			      rate, 200, 32,
> > clocksource_mmio_readl_up);
> > +	ret = clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node-
> > >name,
> > +				    rate, 200, 32,
> > clocksource_mmio_readl_up);
> > +
> > +	if (ret)
> > +		pr_err("Failed to register clocksource %d\n", ret);

It's not a numeric clocksource, so for humans please use "... (%d)\n".

> > 
> 
> Do you want to continue if it fails? I'd bail out.

Agreed, but I'd suggest to check under which circumstances this can
actually fail and how other drivers handle it, given that it was not
checked before. Was this missed during original review, or is the
return value new?

Cheers,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)

