Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE36BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FC12087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408472AbgDPGuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408163AbgDPGu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:50:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE8FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:50:25 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOyLo-0003uP-OB; Thu, 16 Apr 2020 08:50:16 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOyLm-0002Kn-V4; Thu, 16 Apr 2020 08:50:14 +0200
Date:   Thu, 16 Apr 2020 08:50:14 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     wsa@the-dreams.de, o.rempel@pengutronix.de, ardb@kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: drivers: Avoid unnecessary check inefm32_i2c_probe()
Message-ID: <20200416065014.7umocf2aohz6q2nn@pengutronix.de>
References: <20200415140640.19948-1-tangbin@cmss.chinamobile.com>
 <20200415143133.qwbes5whbqx5jf2j@pengutronix.de>
 <20cc01b8-2661-7b3e-3dbc-38f7e282679b@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20cc01b8-2661-7b3e-3dbc-38f7e282679b@cmss.chinamobile.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:30:22AM +0800, Tang Bin wrote:
> Hi Uwe:
> 
> On 2020/4/15 22:31, Uwe Kleine-König wrote:
> > Same things apply as in the previous patch. (space after punctuation,
> > Sob of sender should be last)
> I will notice this problem next time, thanks.
> > > ---
> > >   drivers/i2c/busses/i2c-efm32.c | 3 ---
> > >   1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
> > > index 4de31fae7..4786ef6b2 100644
> > > --- a/drivers/i2c/busses/i2c-efm32.c
> > > +++ b/drivers/i2c/busses/i2c-efm32.c
> > > @@ -312,9 +312,6 @@ static int efm32_i2c_probe(struct platform_device *pdev)
> > >   	int ret;
> > >   	u32 clkdiv;
> > > -	if (!np)
> > > -		return -EINVAL;
> > > -
> > I don't care much about this change. While the statement that this
> > driver is only instantiated on dt platforms is probably right,
> > explicitly checking for it might still prevent surprises later, serves
> > as explicit statement for the driver reader that non-dt isn't supposed
> > to work and given that the check is cheap I tend slightly to just keep
> > it.
> > 
> In this driver, the function efm32_i2c_probe() can be triggered only if the
> platform_device and platform_driver matches,  and the matching condition is
> DTS. It's my opinion.

I admit I didn't recheck, but I think the driver will also be matched on
non-dt platforms that provide an "efm32-i2c" device.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
