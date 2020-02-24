Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372FEC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D44E20732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wS5Zaxo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgBXL0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:26:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40053 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXL0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:26:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so9930036wru.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GUE9byY6wO2HgQFL4TnoFmWzAyXcnBL0bArnNpj/mBw=;
        b=wS5Zaxo+nWR1GIp0j6jyiBBn/jxkuur3d4IGGxWXvtegP8SDaVOwF1zhwjYYul/Wfu
         9Bs4t61XPW8X3KQSCCCz6/YNHdGRyykMKcWAJlsVVfljk4PqAlknXbskmUQ3WfzuB81L
         +Fx0+Q1q7HQJzsFIycPrYoRGaH5ZQhhkA7qiJFwuhry86y05RqBm1ZhAgazm7GVoOTvO
         KgOyfYPJ5C1quGdDHJOpWVmAxK9iFcyVl+Xcqp2OQqa0WrTVOebhWY9Z+pnYLnRCMBMj
         lKroLSvO0apH+A9zWLmjL8oxvCZDEorB9wo/Xj6LBMMkw5ujyIq0NVyIrZ6iudnqXGw5
         D7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GUE9byY6wO2HgQFL4TnoFmWzAyXcnBL0bArnNpj/mBw=;
        b=ufCjPpmGOhT5efgrA82SsU2gy/YSR9/oNDKY1qZWiKbvTKoz1kzSw9AbbvM7BzJr7n
         4BanfiDgK4nw20ODHaUHOdmiZldV3uHO5ZJdVsRVOk7G0hgaGDWq8K2xSu5+wk6Eskzu
         /9Pj3aZIis/w931ABsppeNb3eojQXsXG6KrKc1AEXUaXBngp2KzlvJ26XcRWGn7yCJXB
         bxSvizauj9dK0cw0bP36wjCgUOPwpxPvAs4GXeFTRgrRP21B9unpwefdwAsjDdMVrQ9Y
         ZMCb2vy25aYf5/sWeP1dH+0VgH7PcXmbzK27CL/TYIf9C0s7UtBJGToqsyEmTjbQ1SXf
         NSoQ==
X-Gm-Message-State: APjAAAVmKUUk+Fvw0BrgMQXdRU9bRThzVFUV1NyC3pfSmMxm/EO1aFpm
        rHwfoT3uzY1WVI+5ictpeu/dXoHPuWo=
X-Google-Smtp-Source: APXvYqyD5pojVdnr7qCDdLlH4uSYAx1ztRSVqoExjb64P+4ifvjIy62TE1uNS2oJ+L06NmvfhcycKw==
X-Received: by 2002:a5d:498f:: with SMTP id r15mr64823983wrq.284.1582543603795;
        Mon, 24 Feb 2020 03:26:43 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id i2sm17347531wmb.28.2020.02.24.03.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 03:26:43 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:27:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [RESEND PATCH 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Message-ID: <20200224112714.GT3494@dell>
References: <cover.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
 <c75e6e04281fd8da78cd209a888664c35a6fb8c1.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
 <20200224095654.GI3494@dell>
 <AM6PR10MB22638EDDDDFABB34D0DFC21B80EC0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR10MB22638EDDDDFABB34D0DFC21B80EC0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020, Adam Thomson wrote:

> On 24 February 2020 09:57, Lee Jones wrote:
> 
> > On Fri, 24 Jan 2020, Adam Thomson wrote:
> > 
> > > The current implementation performs checking in the i2c_probe()
> > > function of the variant_code but does this immediately after the
> > > containing struct has been initialised as all zero. This means the
> > > check for variant code will always default to using the BB tables
> > > and will never select AD. The variant code is subsequently set
> > > by device_init() and later used by the RTC so really it's a little
> > > fortunate this mismatch works.
> > >
> > > This update creates an initial temporary regmap instantiation to
> > > simply read the chip and variant/revision information (common to
> > > all revisions) so that it can subsequently correctly choose the
> > > proper regmap tables for real initialisation.
> > 
> > IIUC, you have a dependency issue whereby the device type is required
> > before you can select the correct Regmap configuration.  Is that
> > correct?
> 
> Yep, spot on.
> 
> > If so, using Regmap for the initial register reads sounds like
> > over-kill.  What's stopping you simply using raw reads before the
> > Regmap is instantiated?
> 
> Actually nothing and I did consider this at the start. Nice thing with regmap
> is it's all tidily contained and provides the page swapping mechanism to access
> higher page registers like the variant information. Given this is only once at
> probe time it felt like this was a reasonable solution. However if you're not
> keen I can update to use raw access instead.

It would be nice to compare the 2 solutions side by side.  I can't see
the raw reads of a few device-ID registers being anywhere near 170
lines though.

> > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > ---
> > >  drivers/mfd/da9063-core.c            |  31 -------
> > >  drivers/mfd/da9063-i2c.c             | 167 +++++++++++++++++++++++++++++++-
> > ---
> > >  include/linux/mfd/da9063/registers.h |  15 ++--
> > >  3 files changed, 160 insertions(+), 53 deletions(-)
> > 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
