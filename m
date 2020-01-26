Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE3BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 21:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E897C20716
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 21:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgAZV23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 16:28:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60801 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgAZV22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 16:28:28 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ivpSD-0004z0-Kq; Sun, 26 Jan 2020 22:28:25 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ivpSB-0003RP-Ky; Sun, 26 Jan 2020 22:28:23 +0100
Date:   Sun, 26 Jan 2020 22:28:23 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 177/639] rtc: ds1307: rx8130: Fix alarm handling
Message-ID: <20200126212823.63nnwytrwup5uim6@pengutronix.de>
References: <20200124093047.008739095@linuxfoundation.org>
 <20200124093109.349854130@linuxfoundation.org>
 <20200125133036.GD14064@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200125133036.GD14064@duo.ucw.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 02:30:36PM +0100, Pavel Machek wrote:
> Hi!
> 
> > When the EXTENSION.WADA bit is set, register 0x19 contains a bitmap of
> > week days, not a day of month. As Linux only handles a single alarm
> > without repetition using day of month is more flexible, so clear this
> > bit. (Otherwise a value depending on time.tm_wday would have to be
> > written to register 0x19.)
> 
> So the comment explains why WADA bit needs to be clear.
> 
> > @@ -749,8 +749,8 @@ static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	ctl[0] &= ~RX8130_REG_EXTENSION_WADA;
> > +	ctl[0] &= RX8130_REG_EXTENSION_WADA;
> 
> But then code is changed to preserve WADA bit while it was clearing it
> before.

This looks broken indeed. The new code clears all flags but WADA. Will
take a look tomorrow.
 
Best regards
Uwe



-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
