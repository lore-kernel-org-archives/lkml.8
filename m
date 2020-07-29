Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F0AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EC320838
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgG2ICY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2ICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:02:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1596C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:02:22 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k0h2X-00086y-8P; Wed, 29 Jul 2020 10:02:17 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k0h2W-0001cy-D3; Wed, 29 Jul 2020 10:02:16 +0200
Message-ID: <d259a74ca9e425f9b39ebbf47b0decb6be0beed5.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] reset-controller: ti: adjust the reset assert and
 deassert interface
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Crystal Guo <crystal.guo@mediatek.com>, robh+dt@kernel.org
Cc:     srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, seiya.wang@mediatek.com
Date:   Wed, 29 Jul 2020 10:02:16 +0200
In-Reply-To: <ba0d1e29-3ba3-5379-d03e-1ccec21c2ffa@gmail.com>
References: <1596008357-11213-1-git-send-email-crystal.guo@mediatek.com>
         <1596008357-11213-2-git-send-email-crystal.guo@mediatek.com>
         <ba0d1e29-3ba3-5379-d03e-1ccec21c2ffa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Crystal, Matthias,

On Wed, 2020-07-29 at 09:48 +0200, Matthias Brugger wrote:
> 
> On 29/07/2020 09:39, Crystal Guo wrote:
> > Add ti_syscon_reset() to integrate assert and deassert together,
> > and change return value of the reset assert and deassert interface
> > from regmap_update_bits to regmap_write_bits.
> > 
> > when clear bit is already 1, regmap_update_bits can not write 1 to it again.
> > Some IC has the feature that, when set bit is 1, the clear bit change
> > to 1 together. It will truly clear bit to 0 by write 1 to the clear bit
> > 
> > Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> > ---
> >   drivers/reset/reset-ti-syscon.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
> > index a2635c2..5a8ec8f 100644
> > --- a/drivers/reset/reset-ti-syscon.c
> > +++ b/drivers/reset/reset-ti-syscon.c
> > @@ -89,7 +89,7 @@ static int ti_syscon_reset_assert(struct reset_controller_dev *rcdev,
> >   	mask = BIT(control->assert_bit);
> >   	value = (control->flags & ASSERT_SET) ? mask : 0x0;
> >   
> > -	return regmap_update_bits(data->regmap, control->assert_offset, mask, value);
> > +	return regmap_write_bits(data->regmap, control->assert_offset, mask, value);
> 
> Nack, this will break the driver for the other devices.

I don't think this will break the driver for existing hardware.
regmap_write_bits() is the same as regmap_update_bits(), it just forces
the write in case the read already happens to return the correct value.
Of course it would be good to check that this actually works.

> The kernel has to work not just for your SoC but for all devices of all 
> architectures. You can't just hack something up, that will work on your specific 
> SoC.
> 
> Regards,
> Matthias
> 
> >   }
> >   
> >   /**
> > @@ -120,7 +120,7 @@ static int ti_syscon_reset_deassert(struct reset_controller_dev *rcdev,
> >   	mask = BIT(control->deassert_bit);
> >   	value = (control->flags & DEASSERT_SET) ? mask : 0x0;
> >   
> > -	return regmap_update_bits(data->regmap, control->deassert_offset, mask, value);
> > +	return regmap_write_bits(data->regmap, control->deassert_offset, mask, value);
> >   }
> >   
> >   /**
> > @@ -158,10 +158,19 @@ static int ti_syscon_reset_status(struct reset_controller_dev *rcdev,
> >   		!(control->flags & STATUS_SET);
> >   }
> >   
> > +static int ti_syscon_reset(struct reset_controller_dev *rcdev,
> > +			   unsigned long id)
> > +{
> > +	ti_syscon_reset_assert(rcdev, id);
> > +
> > +	return ti_syscon_reset_deassert(rcdev, id);
> > +}
> > +

I'm unsure about this one, though. This is an incompatible change. At
the very least this would have to be optional depending on compatible.

regards
Philipp
