Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAFDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17FC208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCahDElm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgFRQiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgFRQiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:38:19 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A59FC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 09:38:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l17so5816190wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=A8w5ExslFUBbm0A4m0OlIbsuB7v5tD1zTg63c5JdKhI=;
        b=WCahDElmtPTsHMfEwYZTN3QYiJulMw7aSpfjoqwqPymc/lNbsmlFwcB7pIfCBlE1PZ
         Tz/l7bkm8hT0Z9G6AoEtAd0/1w488Rt2NH6u+EVv24J+Vva9J4Lafw05wsM08BWll+2N
         K5smykK28vfirtYGTSmru6aHKTcEnqV/rxbM8jMDUid2yrd8JNHNQpx2VJah3L10G0Wy
         MRdDMivAarC7RSbnjLMYhEMRCyR9bpF4fJRdJTvUF/E+zfzHNUKun04wQiWY6kPFiwmK
         3EAdyTsgIL2zDFoZPp5CsGxJJw9iZne+DUnt9bb7CJu9PHYmaxJoveGS/fdkdGYrMPx5
         rbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A8w5ExslFUBbm0A4m0OlIbsuB7v5tD1zTg63c5JdKhI=;
        b=iw81htHFc/oz/iiOmRJToSURvuj1PUZ3nHoyV1hQN0AmKAsfQv8PRRGOXbHUy3rSWl
         SKwLmu5kQIphIuj3wC1ml8qOVRYvph21a4+HxthDAUgkViw4Z2NAj1yv40FwHNrs6l4L
         vjmFxUG6h+rPfWCRjHZNAUtaFGq0yak/mY3wonhft/cylPbt/169hgeYv1VAwwVTy76s
         3FhvFOPpE/N7U35NGDmZTh/kty/Ek0lgAfGe1nw5MRKmVYv4nMf8pBNRw56+UyepZf3V
         grihsC0lz66E1lr0aeL6dMNoaJjF0/O8xAU+O4hkvmkq/1u1cPVicXpYePrbBXuYYhyP
         Gx2A==
X-Gm-Message-State: AOAM5306I01Wr0XFKizYkVEunKZz0GWCo/ooEyhIFWLlJDy5h8Xwsc13
        qTLUI1dcPI+E4mXhkXmASec08g==
X-Google-Smtp-Source: ABdhPJyjphnYl0cV048SR20AH4SPmx65BgLcTf/iCuKojCwffumkfz1ktYlySb/O4dXgYNkpoT1hrg==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr4667980wmi.7.1592498297040;
        Thu, 18 Jun 2020 09:38:17 -0700 (PDT)
Received: from dell ([95.149.164.118])
        by smtp.gmail.com with ESMTPSA id l204sm4183753wmf.19.2020.06.18.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 09:38:16 -0700 (PDT)
Date:   Thu, 18 Jun 2020 17:38:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH v3 1/2] mfd: da9063: Fix revision handling to correctly
 select reg tables
Message-ID: <20200618163814.GI954398@dell>
References: <cover.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
 <a019b698f0c643455e07e7a94dcf0478b1b1f4d4.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
 <20200618101511.GE954398@dell>
 <AM6PR10MB226325A1203A99CE49C364EC809B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200618111526.GG954398@dell>
 <AM6PR10MB22631681F86F61E323055922809B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR10MB22631681F86F61E323055922809B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020, Adam Thomson wrote:

> On 18 June 2020 12:15, Lee Jones wrote:
> 
> > > > > The current implementation performs checking in the i2c_probe()
> > > > > function of the variant_code but does this immediately after the
> > > > > containing struct has been initialised as all zero. This means the
> > > > > check for variant code will always default to using the BB tables
> > > > > and will never select AD. The variant code is subsequently set
> > > > > by device_init() and later used by the RTC so really it's a little
> > > > > fortunate this mismatch works.
> > > > >
> > > > > This update adds raw I2C read access functionality to read the chip
> > > > > and variant/revision information (common to all revisions) so that
> > > > > it can subsequently correctly choose the proper regmap tables for
> > > > > real initialisation.
> > > > >
> > > > > Signed-off-by: Adam Thomson
> > <Adam.Thomson.Opensource@diasemi.com>
> > > > > ---
> > > > >  drivers/mfd/da9063-core.c            |  31 ------
> > > > >  drivers/mfd/da9063-i2c.c             | 184
> > +++++++++++++++++++++++++++++++-
> > > > ---
> > > > >  include/linux/mfd/da9063/registers.h |  15 ++-
> > > > >  3 files changed, 177 insertions(+), 53 deletions(-)

[...]

> > > > Rather than open coding this, does it make sense to register a small
> > > > (temporary?) Device ID Regmap to read from?
> > >
> > > The original patch submission did exactly that but you indicated you weren't
> > > keen due to overheads, hence the implementation above. Actually what we
> > have
> > > here is a bit smaller than the regmap approach and I really I'd rather not
> > > have to respin again just to revert to something that was dismissed in the first
> > > place over 6 months ago.
> > 
> > Actually the conversation went like:
> > 
> > Lee:
> >   IIUC, you have a dependency issue whereby the device type is required
> >   before you can select the correct Regmap configuration.  Is that
> >   correct?
> > 
> >   If so, using Regmap for the initial register reads sounds like
> >   over-kill.  What's stopping you simply using raw reads before the
> >   Regmap is instantiated?
> > 
> > Adam:
> >   Actually nothing and I did consider this at the start. Nice thing with regmap
> >   is it's all tidily contained and provides the page swapping mechanism to access
> >   higher page registers like the variant information. Given this is only once at
> >   probe time it felt like this was a reasonable solution. However if you're not
> >   keen I can update to use raw access instead.
> > 
> > Lee:
> >   It would be nice to compare the 2 solutions side by side.  I can't see
> >   the raw reads of a few device-ID registers being anywhere near 170
> >   lines though.
> > 
> >   Ah, they are I2C transactions?  Not the nice readl()s I had in mind.
> > 
> > Adam:
> >   I can knock something together though just to see what it looks like.
> > 
> > Lee:
> >   Well, I'd appreciated that, thanks.
> > 
> > So now we can see them side-by-side we can take them on their own
> > merits.  When I initially requested raw reads, I had readl()s in mind,
> > rather than the extensive code required to read the required registers
> > via I2C.
> 
> To be fair those changes were in V2 of the patch set, which is why I was a quite
> surprised by your suggestion today as you hadn't made this comment against that
> version, given the previous discussion.

It would be very difficult to remember complete revision history for
every patch received.  Especially with the lack of a provided
patch-level changelog.  So I have to take each submission on its own
merits.  This is particularly true for patch-sets ranging over 6
months or more.

The Regmap vs raw accesses decision could easily have gone either way,
so it's not surprising the other was considered during the review of
each submission.  Both times were phrased as an "I wonder if" enquiry,
rather than a demand.

> > However, it looks like there is very little difference between them,
> > thus I do not see a benefit to reverting it back.  The current version
> > seems fine.
> > 
> > I'll conduct a full review shortly, when I have a little more spare
> > time (looking at my current TODO list, this will probably be Monday
> > now).  Although everything does look fine at first glance.
> 
> Thanks. That would be appreciated.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
