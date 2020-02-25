Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3AFC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C7A2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t42bcYBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgBYI7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:59:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43878 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgBYI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:59:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id r11so13698509wrq.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 00:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VVbFspP9MVhJbZJcxsT+1Emp7+wrvBE436k9+CQWUiU=;
        b=t42bcYBLykmxmvpq/HsTy/hQl1YcQgAHOTrQJWtbLr0N7ZhOul5TUcv/PWCOQ2lR8F
         mmW5uFCQMLnD1t7g9O2GKS9hYKhQ/Dcu7USK14lGBmGZWwK+D+z/6kdDIHS86oK0Sl43
         HwFkMutofYYZ/rm5pE2p5paZg7ooOQOQJOw3LBmmS398spimtVcuQTKB0bmlLI93QBJd
         j0/BdVA5hGWMeXBo6l7eDr/6QZX6hfCDUTnX5/yvIcJoR79jXrSLdvQgLKTVe6+dTL4S
         eVBaVHQTGVA/LY/6iQQ1jYS/AGVL/DvdPKEZcyYnkJAFBS1+SuYozSgvI5YmFqz9OK06
         QQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VVbFspP9MVhJbZJcxsT+1Emp7+wrvBE436k9+CQWUiU=;
        b=isLgf4is3lPmGlvkvvUiMU4axdZVMa4UpyY8g1TKn7zihZJw+kbJCk20BTI20e5udO
         INdP37i1akb41En0aPEK5t8LQPI5q+/WHl4njgVm5uluGKcVv4Z4CzaFIv24rYkux48w
         dYnCQjLLAfcMm8jhGZR1qyzSl/GtGkA5rnruGvjV6FsMFwdJlVsLJbEYAXpsDsaGM+ao
         CHWjfd/pkAICWjAyt6lvvBVIiMiljSRdkOdS6QvqVcOo8H6IpGVGP1ricfdd/hotFH8h
         YisrnNORmoot7DAaJpOVuddBfekHFR02X1KSmCd81B7mma2zFap8ODcsC4nYAdvc9kme
         b3YA==
X-Gm-Message-State: APjAAAX+N67w4eupied6adM24Zc3E+qhJGcx2AySkn+9LCoMVVkfWEZi
        QhdDH7CszOe2x8RNMTnRKW7XrISJTEk=
X-Google-Smtp-Source: APXvYqx0SwEK/L7bhwBmr4FTIzN1n5jkhjJibdSjXywSJ87hSdE7Mny168jPQXOVhbOipPA149JLtw==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr68837670wro.279.1582621188553;
        Tue, 25 Feb 2020 00:59:48 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id c26sm2879657wmb.8.2020.02.25.00.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 00:59:47 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:00:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [RESEND PATCH 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Message-ID: <20200225090020.GX3494@dell>
References: <cover.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
 <c75e6e04281fd8da78cd209a888664c35a6fb8c1.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
 <20200224095654.GI3494@dell>
 <AM6PR10MB22638EDDDDFABB34D0DFC21B80EC0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200224112714.GT3494@dell>
 <AM6PR10MB226325120B64509E3372C21980EC0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR10MB226325120B64509E3372C21980EC0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020, Adam Thomson wrote:

> On 24 February 2020 11:27, Lee Jones wrote:
> 
> > On Mon, 24 Feb 2020, Adam Thomson wrote:
> > 
> > > On 24 February 2020 09:57, Lee Jones wrote:
> > >
> > > > On Fri, 24 Jan 2020, Adam Thomson wrote:
> > > >
> > > > > The current implementation performs checking in the i2c_probe()
> > > > > function of the variant_code but does this immediately after the
> > > > > containing struct has been initialised as all zero. This means the
> > > > > check for variant code will always default to using the BB tables
> > > > > and will never select AD. The variant code is subsequently set
> > > > > by device_init() and later used by the RTC so really it's a little
> > > > > fortunate this mismatch works.
> > > > >
> > > > > This update creates an initial temporary regmap instantiation to
> > > > > simply read the chip and variant/revision information (common to
> > > > > all revisions) so that it can subsequently correctly choose the
> > > > > proper regmap tables for real initialisation.
> > > >
> > > > IIUC, you have a dependency issue whereby the device type is required
> > > > before you can select the correct Regmap configuration.  Is that
> > > > correct?
> > >
> > > Yep, spot on.
> > >
> > > > If so, using Regmap for the initial register reads sounds like
> > > > over-kill.  What's stopping you simply using raw reads before the
> > > > Regmap is instantiated?
> > >
> > > Actually nothing and I did consider this at the start. Nice thing with regmap
> > > is it's all tidily contained and provides the page swapping mechanism to access
> > > higher page registers like the variant information. Given this is only once at
> > > probe time it felt like this was a reasonable solution. However if you're not
> > > keen I can update to use raw access instead.
> > 
> > It would be nice to compare the 2 solutions side by side.  I can't see
> > the raw reads of a few device-ID registers being anywhere near 170
> > lines though.
> 
> To be fair the regmap specific additions for the temporary register access, are
> maybe 50 - 60 lines. The rest is to do with handling the result which you'll
> need anyway to select the correct register map. I reckon to provide raw read and
> write access we're going to probably be similar or more as we'll need to write
> the page register then read from the relevant ID registers. Using this an
> example for the lines count:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/mfd/tps6507x.c#L37

Ah, they are I2C transactions?  Not the nice readl()s I had in mind.

> I can knock something together though just to see what it looks like.

Well, I'd appreciated that, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
