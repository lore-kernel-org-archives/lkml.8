Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DD7C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF2520748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579247838;
	bh=IjBrACMENfRnrwziX1OEE1eyJl5/3tzabzgvyUShm1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LmV76kSOn01hOtbTB5WBqLy4PEIw6BmftzC+l/HH3BqzsbmIDP7md0zj3PzN7dJ80
	 RQ846bDPFdVEUSHpyXnLpVXXslTtIjgSDF4JE6GQACPnITSWAZspHdtOQQjV1xbeQI
	 lwCXXSepDuDDmeksuTgiRj5ASBpC1oBqDscG+TFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgAQH5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:57:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgAQH5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:57:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB06F2073A;
        Fri, 17 Jan 2020 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579247837;
        bh=IjBrACMENfRnrwziX1OEE1eyJl5/3tzabzgvyUShm1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpCzoCI0TIWJEgVLCtHfO8Hp+0Dvw3u2nPSEiGBGbErrdSRrwaBCqnKeHZjW1kl/c
         Jyy7rGb1AMTPQeeePJwKy8lEMO1Im5H5jW5jGrSStB9WkiRZbvf50bwLbsPRN9zZ/L
         cy2hKbOSj+7ZOLd7cxvwSDhZ3JQ/I8Pq+ly8OU+I=
Date:   Fri, 17 Jan 2020 08:57:14 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] mfd: bd70528: Fix hour register mask
Message-ID: <20200117075714.GA1822218@kroah.com>
References: <20200115082933.GA29117@localhost.localdomain>
 <83e8e1ecc40a58e2e6d1960bbb41c8dcfe730ce1.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e8e1ecc40a58e2e6d1960bbb41c8dcfe730ce1.camel@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 07:44:07AM +0000, Vaittinen, Matti wrote:
> Hello Lee, Alexandre, Greg & Sasha
> 
> On Wed, 2020-01-15 at 10:29 +0200, Matti Vaittinen wrote:
> > When RTC is used in 24H mode (and it is by this driver) the maximum
> > hour value is 24 in BCD. This occupies bits [5:0] - which means
> > correct mask for HOUR register is 0x3f not 0x1f. Fix the mask
> > 
> > Fixes: 32a4a4ebf768 ("rtc: bd70528: Initial support for ROHM bd70528
> > RTC")
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> > 
> > I just noticed this was never applied. I'd like to get this in as
> > we currently have bd70528 RTC not working in few exiting releases.
> > (Or it works as long as time is not set at the evening :/)
> > 
> > I think this once was in RTC tree but was dropped as Lee mentioned
> > this
> > belongs to MFD. Thus I dared to add the Alexandre's acked-by - please
> > let me know if this is not Ok.
> > 
> > Lee, can you please pull this in so that we get the fix
> > in-tree? I guess the fixes tag helps this to be included in some
> > existing branches.
> 
> Actually - I don't know if applying this in MFD is good idea. The
> BD71828 support series
> 
> (
> https://lore.kernel.org/lkml/cover.1579078681.git.matti.vaittinen@fi.rohmeurope.com/
> )
> 
> will fix this when applied (and conflict with this if both are
> applied). I would like to get this fix in 5.4 though - but I don't
> think the BD71828 series should be in 5.4.
> 
> Is it possible to get this in 5.4 stable - while leaving this out of
> current MFD tree and applying the BD71828 series to MFD?

We only take patches that are in Linus's tree for the stable tree,
unless there are very big reasons not to do so (i.e. it is totally
rewritten in a different way there.)

Once the change/fix is in Linus's tree, then you can backport it to
stable in a different way if you want, but you need to give lots of
reasons why it is done that way.

thanks,

greg k-h
