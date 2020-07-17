Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7762DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5696B2065D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgGQOK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:10:27 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:6599 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQOK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:10:26 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 93190240013;
        Fri, 17 Jul 2020 14:10:23 +0000 (UTC)
Date:   Fri, 17 Jul 2020 16:10:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 16/25] arch: arm: mach-at91: pm: Move prototypes to
 mutually included header
Message-ID: <20200717141023.GS3428@piout.net>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
 <20200713144930.1034632-17-lee.jones@linaro.org>
 <20200713200244.GA23553@piout.net>
 <20200716134231.GP3165313@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716134231.GP3165313@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2020 14:42:31+0100, Lee Jones wrote:
> > > diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> > > index 9c52130876597..37997e5ab0538 100644
> > > --- a/drivers/pinctrl/pinctrl-at91.c
> > > +++ b/drivers/pinctrl/pinctrl-at91.c
> > > @@ -22,6 +22,7 @@
> > >  #include <linux/pinctrl/pinmux.h>
> > >  /* Since we request GPIOs from ourself */
> > >  #include <linux/pinctrl/consumer.h>
> > > +#include <linux/platform_data/atmel.h>
> > >  
> > >  #include "pinctrl-at91.h"
> > >  #include "core.h"
> > > diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
> > > index 99e6069c5fd89..666ef482ea8c0 100644
> > > --- a/include/linux/platform_data/atmel.h
> > > +++ b/include/linux/platform_data/atmel.h
> > 
> > The plan is to get rid of that file so you should probably find a better
> > location.
> 
> Suggestions welcome.
> 

Something like include/soc/at91/pm.h so we can also move
at91_suspend_entering_slow_clock there and then kill
platform_data/atmel.h.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
