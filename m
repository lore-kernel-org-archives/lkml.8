Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B49C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09CB2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="beoqdleF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391727AbgEZWBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:01:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50520 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389799AbgEZWBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ic9korQKPModNIisuiJMxCn+f02tNtVOzvQqeZQE5kU=; b=beoqdleFIBmKIcGYnN27TTlPSy
        zWSwbh20ovaLnM1XaPd+X91ds1or2HRE7q1dsXHm7bipBAwmSic1R3rUpuwnpjVYYiOTJT/Z6JnF3
        kXuGswWcXQmBQ8G8+gSb1G9ommatXdVW7dO+c+kHDq/dnLGag2gU5pPB/ZeKJtqU9xM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jdhdX-003KKA-Kg; Wed, 27 May 2020 00:01:27 +0200
Date:   Wed, 27 May 2020 00:01:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
        thomas.petazzoni@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 4/4] net: phy: mscc-miim: read poll when high
 resolution timers are disabled
Message-ID: <20200526220127.GS768009@lunn.ch>
References: <20200526162256.466885-1-antoine.tenart@bootlin.com>
 <20200526162256.466885-5-antoine.tenart@bootlin.com>
 <e95bbdb6-a6db-be02-660e-7318b9bb5f01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e95bbdb6-a6db-be02-660e-7318b9bb5f01@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/* When high resolution timers aren't built-in: we can't use usleep_range() as
> > + * we would sleep way too long. Use udelay() instead.
> > + */
> > +#define mscc_readl_poll_timeout(addr, val, cond, delay_us, timeout_us)	\
> > +({									\
> > +	if (!IS_ENABLED(CONFIG_HIGH_RES_TIMERS))			\
> > +		readl_poll_timeout_atomic(addr, val, cond, delay_us,	\
> > +					  timeout_us);			\
> > +	readl_poll_timeout(addr, val, cond, delay_us, timeout_us);	\
> > +})
> > +
> 
> I would make this a regular function which would not harm the compiler's
> ability to optimize it, but would give you type checking. With that fixed:

Hi Florian

cond makes that difficult, since it is not a parameter in the usual
sense, but an expression to evaluate if the polling should terminate.

readl_poll_timeout() and readl_poll_timeout_atomic() themselves are
#define's, and there are more levels of macros under them.

	   Andrew
