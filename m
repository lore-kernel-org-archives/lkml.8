Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75D9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61722177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgHDP4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:56:46 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:47795 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgHDP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:56:45 -0400
Received: from localhost (lfbn-lyo-1-23-225.w86-202.abo.wanadoo.fr [86.202.118.225])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id AE1C610000A;
        Tue,  4 Aug 2020 15:56:36 +0000 (UTC)
Date:   Tue, 4 Aug 2020 17:56:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        wenyou.yang@atmel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ARM: at91: pm: add per soc validation of pm modes
Message-ID: <20200804155636.GC10725@piout.net>
References: <1596539258-20719-1-git-send-email-claudiu.beznea@microchip.com>
 <1596539258-20719-3-git-send-email-claudiu.beznea@microchip.com>
 <20200804114223.GC7836@piout.net>
 <f9e1d923-225e-7a18-ed48-c8c7e7d4d8cf@microchip.com>
 <20200804150841.GA10725@piout.net>
 <5c00c0f9-dc73-fb8d-aef8-88f4bc923295@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c00c0f9-dc73-fb8d-aef8-88f4bc923295@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2020 15:45:40+0000, Claudiu.Beznea@microchip.com wrote:
> 
> 
> On 04.08.2020 18:08, Alexandre Belloni wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 04/08/2020 15:00:38+0000, Claudiu.Beznea@microchip.com wrote:
> >>
> >>
> >> On 04.08.2020 14:42, Alexandre Belloni wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> Hello,
> >>>
> >>> On 04/08/2020 14:07:37+0300, Claudiu Beznea wrote:
> >>>>  void __init at91rm9200_pm_init(void)
> >>>>  {
> >>>> +     static const int modes[] __initconst = {
> >>>
> >>> You don't need that to be static as it is now local to the function.
> >>>
> >>>> +             AT91_PM_STANDBY, AT91_PM_ULP0
> >>>> +     };
> >>>> +
> >>>>       if (!IS_ENABLED(CONFIG_SOC_AT91RM9200))
> >>>>               return;
> >>>>
> >>>> +     at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
> >>>
> >>> For rm9200 and at91sam9, I would not allow changing the pm_modes and
> >>> simply enforce standby_mode = AT91_PM_STANDBY and suspend_mode =
> >>> AT91_PM_ULP0.I don't think you have any user that ever changed that
> >>> behaviour also that avoids increasing the boot time for those slow SoCs.
> >>
> >> OK, but bootargs is parsed at a moment when there is no information about
> >> the machine that is running the code. And enforcing this in *_pm_init()
> >> functions for rm9200 and at91sam9 may change suspend and standby mode that
> >> user selected. If there is no user up to this moment there is still the
> >> possibility of being one in the future.
> >>
> > 
> > So let's prevent users from doing that. Unused arguments are silently
> > ignored which is exactly what we want to do.
> 
> Can you share what are you thinking about? You want to not parse
> atmel.pm_modes for this machines?
> 

Well, as you said, when parsing we don't know on which machine we are
running so let's keep parsing it anyway.

> > You won't make me believe
> > there is actually a use case for swapping the standby and suspend
> > meanings.
> What i want to say is this:
> bootargs contains atmel.pm_modes=ulp0,standby
> 
> this leads to
> standby_mode=ulp0
> suspend_mode=standby
> 
> But you want in code to force
> standby_mode=standby
> suspend_mode=ulp0
> 
> The question is: is this what you are thinking this should be done?
> 

Yes, I think we need to enforce standby_mode=standby and
suspend_mode=ulp0 for rm9200 and at91sam9. This is how it always have
been.

You have two ways of doing that:

Etiher you enforce the values after parsing, in at91rm9200_pm_init and
at91sam9_pm_init. Or, when parsing your store the values in a different
location than soc_pm.data and update soc_pm.data only in sama5_pm_init,
sama5d2_pm_init and sam9x60_pm_init. I feel like the first solution is
easier.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
