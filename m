Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B94C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1843F2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCWIid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:38:33 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57353 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgCWIid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:38:33 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M4b5s-1jHwlF0VEc-001eWd for <linux-kernel@vger.kernel.org>; Mon, 23 Mar
 2020 09:38:31 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id E54D06503CA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Lx99sRFqOfUl for <linux-kernel@vger.kernel.org>;
        Mon, 23 Mar 2020 09:38:30 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 9157664F7DC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:38:30 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.4) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Mar 2020 09:38:30 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id C3AA1804FB; Mon, 23 Mar 2020 09:36:10 +0100 (CET)
Date:   Mon, 23 Mar 2020 09:36:10 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <devel@driverdev.osuosl.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3 05/11] media: adv748x: add support for HDMI audio
Message-ID: <20200323083610.GB4298@pflmari>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>
References: <cover.1584720678.git.alexander.riesen@cetitec.com>
 <82828e89ccf4173de4e5e52dcecacc4d5168315c.1584720678.git.alexander.riesen@cetitec.com>
 <158475297119.125146.8177273856843293558@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <158475297119.125146.8177273856843293558@swboyd.mtv.corp.google.com>
X-Originating-IP: [10.8.5.4]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7066
X-Provags-ID: V03:K1:BwxtMQF9rpOdaMb3JcuN8YntpFbArXE7zzyBV8RNS2LLENTQVdj
 3+wzh3wnsKZoorJ3NnYRkUVuBinR4/I87rSA9zdOIN6/ts1rUwdsobymqjnIFkHcpVBsHFq
 MhXy74PwiA57WsQ1IAhUJmepZam4gcdg7hvbPgaMFHaeAEW7BHfd0Q73CeuBMNVqg4jnLPL
 tdHJXlDAIt5+t8uedMFnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/7id41zEggA=:FuBW8JFTE/hwlnblfBQmcs
 WiYu5NhwlzTTBvvrfDMH+S05dxByHdV2s3g3O17eXt7NQ8sI7cRzdPcqGHX39a4C4YK/U6C+k
 m9RztBseOXICzMVcIY4Xq2kAUJTudaGV3eh0VsOTPEdG+FWXoV+ySNzlhhGzDOH0nnbSNDLnn
 0fvb9bCWPL7fwy0P3taSG/LaT+hBfFzPhEqjBGv+BzFwudshpDw6XROMkJXt2YmM1eRARYE08
 gvOHWoh3ra/w+IXo9Fn4woBNdjg4tHAHNMrRPg11HCHLctc33SZEL0y3HWj6pW5JpAOG+lf1Y
 OxM5FCm6/GiOmtnDU+PH1ratX8zsLwKwM7lKJPw0OctbacXA5agBSxsNOAzRfE/xN5RF7ZGZM
 px0KN8LfDjCnQceQXy72Q/Uyuo98+kafFztcXEDcS0bxHlGyX3aZE2S4KIe9cw39ZF3tiGWF0
 aMYVtOyuNJN4b2VCOmKqZ8s8sWgvqkenxutlSH+FxnYgqY03ZnPJA6b8eEU03XP06vT3dGKVb
 5dN1eo2cLdQAjtrlQubHIX/22C2nSIJL7bSFuUZoDAVHYiGcTgNk/VQY+IwAYulFhtUqYO4d2
 q97QqLt07I4OiLmYUEnv6vGQdEOH1X+tsvD6c2x1eB4KPeKGZapJQUq7U+HdelyHcYmsAxoyT
 ZD3PuiKPWSKSByFIHnuTzOlKpTbgcfp1TCbPlnnEARlWjgUDXfcMPprdGwnua7GI+TmDoltS9
 r7vVd12tyPtVBB/D2tjZi3RdiSI29r7Lu77jw0R9DqyREqmMhxhDikt8ojgMwS5JQsh4TTh6T
 6omb95JvXFtyY9Q+PqbZaPBCuKpgHIqtfecHz+/28X0lCoE/mnMsrmDUm58dTd2xtFByZv5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Boyd, Sat, Mar 21, 2020 02:09:31 +0100:
> Quoting Alex Riesen (2020-03-20 09:12:00)
> > diff --git a/drivers/media/i2c/adv748x/adv748x-dai.c b/drivers/media/i2c/adv748x/adv748x-dai.c
> > new file mode 100644
> > index 000000000000..6fce7d000423
> > --- /dev/null
> > +++ b/drivers/media/i2c/adv748x/adv748x-dai.c
> > @@ -0,0 +1,265 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Driver for Analog Devices ADV748X HDMI receiver with AFE
> > + * The implementation of DAI.
> > + */
> > +
> > +#include "adv748x.h"
> > +
> > +#include <linux/clk.h>
> 
> Is this include used? Please try to make a clk provider or a clk
> consumer and not both unless necessary.

Yes, they're both used: I use clk_get_rate to get the frequency of the clock to validate
the master clock frequency configuration.

> > +int adv748x_dai_init(struct adv748x_dai *dai)
> > +{
> > +       int ret;
> > +       struct adv748x_state *state = adv748x_dai_to_state(dai);
> > +
> > +       dai->mclk_name = kasprintf(GFP_KERNEL, "%s.%s-i2s-mclk",
> > +                                  state->dev->driver->name,
> > +                                  dev_name(state->dev));
> > +       if (!dai->mclk_name) {
> > +               ret = -ENOMEM;
> > +               adv_err(state, "No memory for MCLK\n");
> > +               goto fail;
> > +       }
> > +       dai->mclk = clk_register_fixed_rate(state->dev,
> 
> Please register with clk_hw_register_fixed_rate() instead.

Ok, I see the clk_register_fixed_rate isn't even commented...
I shall change it to used clk_hw_register_fixed_rate.

But could you please point me at some documentation, example, or just add a
few words to explain the preference?

BTW, the clock which the driver attempts to provide can actually be switched
on and off (it output pad can be even tristated). As the device is connected
by I2C to the how, I seems to be unable to use the existing gated clock
implementation because of the mmio register it requires. Or am I wrong?

> > +                                           dai->mclk_name,
> > +                                           NULL /* parent_name */,
> > +                                           0 /* flags */,
> > +                                           12288000 /* rate */);
> 
> Not sure these comments are useful.

You're right. Removed.

> > +       dai->drv.name = ADV748X_DAI_NAME;
> > +       dai->drv.ops = &adv748x_dai_ops;
> > +       dai->drv.capture = (struct snd_soc_pcm_stream){
> 
> Can this be const?

It can. Fixed.

> Please drop extra newline at end of file.

Done.

Thanks a lot for the review and commentary!

Regards,
Alex
