Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC85C83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DB3214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="PU41HCwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD3GVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:21:41 -0400
Received: from plaes.org ([188.166.43.21]:35836 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgD3GVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:21:41 -0400
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id C8C4640275;
        Thu, 30 Apr 2020 06:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1588227698; bh=5IaA8hDKqgMnJSHF6ro9Jo9eG0qGD7sBE3O2dZ7w10w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PU41HCwMPoxYMSyP8fhrzD6juPZxEfBmdlc/PKMFtE1ZPwP2er0AY9lHYRfd5IOs3
         ww3lPC5lv8vjJLPdcnVfIoJu7rNEJRr0Lv1Buhc0bYyLzlWARFRNANnl0nlVCDQEH+
         Y7F12KOpQ9BlyxXFUabLCBAlIDMhR06t3f5crcpIZKeMscVaFpJAmB0Hd1Xtk36JV5
         Ug7TbNUf/+Ji5WbqHB4maeCLgNeA2fMie78EH0EFtcL2SQsL4EH5GY3/X/pg8QHISy
         SYRK3bC5DsGaqSbiZ5AmCmw+VLptLlpjL2rl/5gMOfj5zxvd8mZ2G8rPYanR9TdXIg
         NlKmvcIWocIiA==
Date:   Thu, 30 Apr 2020 06:21:37 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/4] clk: sunxi-ng: a10/a20: rewrite init code to a
 platform driver
Message-ID: <20200430062137.GA32281@plaes.org>
References: <20200417221730.555954-1-plaes@plaes.org>
 <20200417221730.555954-2-plaes@plaes.org>
 <20200420124935.asfbgv7envb2af55@gilmour.lan>
 <20200420203228.GA4734@plaes.org>
 <20200429143510.ksi27lok2udtmfas@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429143510.ksi27lok2udtmfas@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:35:10PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Apr 20, 2020 at 08:32:28PM +0000, Priit Laes wrote:
> > On Mon, Apr 20, 2020 at 02:49:35PM +0200, Maxime Ripard wrote:
> > > On Sat, Apr 18, 2020 at 01:17:27AM +0300, Priit Laes wrote:
> > > > In order to register regmap for sun7i CCU, there needs to be
> > > > a device structure already bound to the CCU device node.
> > > > 
> > > > Convert the sun4i/sun7i CCU setup to platform driver to use
> > > > it later as platform device.
> > > > 
> > > > Signed-off-by: Priit Laes <plaes@plaes.org>
> > > 
> > > You can't relly do that though. We have timers that need those clocks before the
> > > device model is initialized.
> > 
> > Ok, I'm somewhat lost now... are these the affected timers on sun7i following:
> > - allwinner,sun4i-a10-timer (timer@1c20c00)
> > - allwinner,sun7i-a20-hstimer (hstimer@1c60000)
> 
> Yep
> 
> > Any ideas on what approach I could actually use?
> 
> I guess you could keep the CLK_OF_DECLARE registration, and then have a
> platform_driver probe and register the regmap?
> 

Thanks this did the trick.

> > Also, similar timer dependency would affect then sun6i-a31 and sun9i-a80
> > platforms too...

I didn't check this before, but sun9i-a80 CCU is initialized currently via
platform device. Should it be converted first to clock driver (CLK_OF_DECLARE)?

I have sent out the v2 which contains sun7i/sun6i changes.

> 
> Indeed.
> 
> Maxime


