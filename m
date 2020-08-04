Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3CFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AEE2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgHDPIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:08:51 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52741 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgHDPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:08:46 -0400
X-Originating-IP: 86.202.118.225
Received: from localhost (lfbn-lyo-1-23-225.w86-202.abo.wanadoo.fr [86.202.118.225])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D16071C0006;
        Tue,  4 Aug 2020 15:08:41 +0000 (UTC)
Date:   Tue, 4 Aug 2020 17:08:41 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        wenyou.yang@atmel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ARM: at91: pm: add per soc validation of pm modes
Message-ID: <20200804150841.GA10725@piout.net>
References: <1596539258-20719-1-git-send-email-claudiu.beznea@microchip.com>
 <1596539258-20719-3-git-send-email-claudiu.beznea@microchip.com>
 <20200804114223.GC7836@piout.net>
 <f9e1d923-225e-7a18-ed48-c8c7e7d4d8cf@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e1d923-225e-7a18-ed48-c8c7e7d4d8cf@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2020 15:00:38+0000, Claudiu.Beznea@microchip.com wrote:
> 
> 
> On 04.08.2020 14:42, Alexandre Belloni wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hello,
> > 
> > On 04/08/2020 14:07:37+0300, Claudiu Beznea wrote:
> >>  void __init at91rm9200_pm_init(void)
> >>  {
> >> +     static const int modes[] __initconst = {
> > 
> > You don't need that to be static as it is now local to the function.
> > 
> >> +             AT91_PM_STANDBY, AT91_PM_ULP0
> >> +     };
> >> +
> >>       if (!IS_ENABLED(CONFIG_SOC_AT91RM9200))
> >>               return;
> >>
> >> +     at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
> > 
> > For rm9200 and at91sam9, I would not allow changing the pm_modes and
> > simply enforce standby_mode = AT91_PM_STANDBY and suspend_mode =
> > AT91_PM_ULP0.I don't think you have any user that ever changed that
> > behaviour also that avoids increasing the boot time for those slow SoCs.
> 
> OK, but bootargs is parsed at a moment when there is no information about
> the machine that is running the code. And enforcing this in *_pm_init()
> functions for rm9200 and at91sam9 may change suspend and standby mode that
> user selected. If there is no user up to this moment there is still the
> possibility of being one in the future.
> 

So let's prevent users from doing that. Unused arguments are silently
ignored which is exactly what we want to do. You won't make me believe
there is actually a use case for swapping the standby and suspend
meanings.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
