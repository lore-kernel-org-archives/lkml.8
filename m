Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96235C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F0220899
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404954AbgFXQYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:24:52 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:55946 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404855AbgFXQYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:24:51 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E18FD806BA;
        Wed, 24 Jun 2020 18:24:47 +0200 (CEST)
Date:   Wed, 24 Jun 2020 18:24:46 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/8] Fix a bunch of W=1 warnings in Backlight
Message-ID: <20200624162446.GA1815586@ravnborg.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624153216.GA1814806@ravnborg.org>
 <20200624154321.GH954398@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624154321.GH954398@dell>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=G88y7es5 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=7gkXJVJtAAAA:8 a=KKAkSRfTAAAA:8
        a=9V60zPr9lzPatE790UIA:9 a=QEXdDO2ut3YA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=cvBusfyB2V15izCimMoJ:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee.

On Wed, Jun 24, 2020 at 04:43:21PM +0100, Lee Jones wrote:
> On Wed, 24 Jun 2020, Sam Ravnborg wrote:
> 
> > Hi Lee.
> > 
> > On Wed, Jun 24, 2020 at 03:57:13PM +0100, Lee Jones wrote:
> > > Attempting to clean-up W=1 kernel builds, which are currently
> > > overwhelmingly riddled with niggly little warnings.
> > > 
> > > Lee Jones (8):
> > >   backlight: lms501kf03: Remove unused const variables
> > >   backlight: lcd: Add missing kerneldoc entry for 'struct device parent'
> > 
> > 
> > >   backlight: ili922x: Add missing kerneldoc descriptions for
> > >     CHECK_FREQ_REG() args
> > >   backlight: ili922x: Remove invalid use of kerneldoc syntax
> > >   backlight: ili922x: Add missing kerneldoc description for
> > >     ili922x_reg_dump()'s arg
> > I wonder why these warnings show up as nothing pulls in this .c file.
> > Anyway I would suggest to drop using kerneldoc syntax for single drivers
> > like this - and the benefit here is low.
> > Now they are typed, otherwise this ahd been fine in a single patch.
> 
> What do you mean by 'nothing pulls it in'?
There are no .rst files that includes any:
.. kernel-doc:: drivers/video/backlight/ili922x.c

so I do not see how the kernel-doc comments will be used by any
of the generated kernel-docs.

	Sam

> 
> > >   backlight: backlight: Supply description for function args in existing
> > >     Kerneldocs
> > >   backlight: lm3630a_bl: Remove invalid checks for unsigned int < 0
> > >   backlight: qcom-wled: Remove unused configs for LED3 and LED4
> > 
> > The other fixes looks good.
> > They are all:
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Thanks (although this should be Reviewed-by).
> 
> > >  drivers/video/backlight/backlight.c  | 2 ++
> > >  drivers/video/backlight/ili922x.c    | 8 ++++++--
> > >  drivers/video/backlight/lcd.c        | 1 +
> > >  drivers/video/backlight/lm3630a_bl.c | 4 ++--
> > >  drivers/video/backlight/lms501kf03.c | 8 --------
> > >  drivers/video/backlight/qcom-wled.c  | 8 --------
> > >  6 files changed, 11 insertions(+), 20 deletions(-)
> > > 
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
