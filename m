Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FE1C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B892084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="dXreldKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBZQN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:13:57 -0500
Received: from mx1.tq-group.com ([62.157.118.193]:23277 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbgBZQN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:13:56 -0500
IronPort-SDR: 6Qx8ssSbOkI6D56CLdH9L6PF/ODFcG48Qz0MQmTFzF32TqgxOrNIuzP7spCIEYySK4GgYkPaIF
 9jxz9dwcwvhQH+4S6kqz3KmqzSVaeDQESV1h02KzM2u5lnwGIyoW5OHgrEVEX0MHru93ELGTw0
 yJ7M+c+3GnjWdNXdktjB9NCrZbK0TAfOb+c7OKa1kp7zsWq6lWou9k6RvtMsvwUYq5M+EmXJIg
 RPlmRzfojTcSjAXCKGNcJm7zgiv11lbMISp9e2d3Jjg1KaN50zVg2/Kn97jYHwpj11j9uk17SD
 i3I=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11123578"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Feb 2020 17:13:54 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Feb 2020 17:13:54 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Feb 2020 17:13:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1582733634; x=1614269634;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CfLkn3IyCRPRrMr7mK9ri9UAMdYkHqcrntX3zjaFVMI=;
  b=dXreldKcntrpmpqizkyI8NSX9RS/eOWQk9H5Uk/kuYLbwBcS01uH6Ep+
   DwqXfrC6HgExXB7XFh/6v5VOJK+wzKJj/WZJFbEaKEc8W4qt2Ju6xa790
   qUIwS6sXWVDIFuUpoCP0u81S25L9/1Cxf9omtCj/09UV8c/HnGHYxC2sI
   GKbhDIqxOeNdeGhZWxSL+sKZW1VqZOcy16jC2KIiNv0qI/v9P3bU9AYOt
   nGgs//Rdn9ua+AWIQoDF6Iks6ZysgNf7lQ6VcGssbLb0KhXYYoxzdtekN
   VO8NchDqbfkrcj5L9EE+WlGWB59YJocHsUVaeidxxPCAN4CCO+RQY6Xsi
   g==;
IronPort-SDR: baiqaEEcSblsfjxqPshcVv84p+dKRSeTWCyaQUpDPqo59BUfy0ze4UrWsnWHcqvGcNBcMR6Zb/
 GGhcxaGsQ0dyPvpNaJxXJwAs4/We/VuwRgJawa1w4AzoB/t5yasOJm1+URumj8wq7z2dui9hqY
 dyzBgqcPdXAWmkNT7l0qAlFTo5bSH1hdBxj+8DOqkUhFsDUOleLUYAg5JHx/otYfyp1Wx8FR3p
 20bTJshKQ56hAqMhkn/j9tWtTCwjCN5l/Da98c3sz5wQGbvBcTnvTqklADb7vIfdDaBm6L9AZj
 icM=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11123577"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Feb 2020 17:13:54 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id B4DCD280065;
        Wed, 26 Feb 2020 17:14:00 +0100 (CET)
Message-ID: <74522773dd3e820ab6f38cd83e52c83f1288c04a.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH 3/4] pwm: pca9685: initialize all LED
 registers during probe
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 26 Feb 2020 17:13:51 +0100
In-Reply-To: <20200226150051.sbopz7uzbdhtccba@pengutronix.de>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
         <20200226135229.24929-3-matthias.schiffer@ew.tq-group.com>
         <20200226150051.sbopz7uzbdhtccba@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-26 at 16:00 +0100, Uwe Kleine-König wrote:
> On Wed, Feb 26, 2020 at 02:52:28PM +0100, Matthias Schiffer wrote:
> > Initialize all ON delays to 0 during probe, rather than doing it in
> > pca9685_pwm_enable.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > >
> > ---
> >  drivers/pwm/pwm-pca9685.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 393ab92aa945..370691b21107 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -289,13 +289,6 @@ static int pca9685_pwm_enable(struct pwm_chip
> > *chip, struct pwm_device *pwm)
> >  {
> >  	struct pca9685 *pca = to_pca(chip);
> >  
> > -	/*
> > -	 * The PWM subsystem does not support a pre-delay.
> > -	 * So, set the ON-timeout to 0
> > -	 */
> > -	regmap_write(pca->regmap, LED_N_ON_L(pwm->hwpwm), 0);
> > -	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), 0);
> > -
> >  	/*
> >  	 * Clear the full-off bit.
> >  	 * It has precedence over the others and must be off.
> > @@ -388,6 +381,13 @@ static int pca9685_pwm_probe(struct i2c_client
> > *client,
> >  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
> >  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
> >  
> > +	/*
> > +	 * The PWM subsystem does not support a pre-delay.
> > +	 * So, set the ON-timeout to 0
> > +	 */
> > +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
> > +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> > +
> 
> What is a pre-delay: Something like:
>           _________                   ______
>     _____/         \_________________/
>     ^                           ^
> 
> Where ^ marks the period start and then the time between period start
> and the rising signal is the pre-delay?
> 
> If so, the IMHO more right approach is to keep the pre-delay until a
> new
> setting is applied and in .get_state ignore the pre-delay. This way
> you
> don't modify the output in .probe() which sounds right.
> 

My approach was to get the hardware into a known state by resetting
most registers (which is what the driver attempted to do so far). If
getting the hardware state via get_state is preferable, I can implement
that instead.

Matthias


> Best regards
> Uwe
> 

