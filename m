Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDA1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA75F206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgIBSGX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:06:23 -0400
Received: from mailoutvs22.siol.net ([185.57.226.213]:34409 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726567AbgIBSGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id DC7AB526A96;
        Wed,  2 Sep 2020 20:06:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JLXQv0_kZthx; Wed,  2 Sep 2020 20:06:13 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 5A4CB526A97;
        Wed,  2 Sep 2020 20:06:13 +0200 (CEST)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 8177A526A92;
        Wed,  2 Sep 2020 20:06:12 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     peron.clem@gmail.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH 05/16] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Wed, 02 Sep 2020 20:10:47 +0200
Message-ID: <9148679.oVN3Z7rve9@kista>
In-Reply-To: <1e320dfd-9388-54b2-dba9-7def0bf4bbad@sholland.org>
References: <20200704113902.336911-1-peron.clem@gmail.com> <20200704113902.336911-6-peron.clem@gmail.com> <1e320dfd-9388-54b2-dba9-7def0bf4bbad@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel!

Dne petek, 10. julij 2020 ob 07:44:51 CEST je Samuel Holland napisal(a):
> On 7/4/20 6:38 AM, Clément Péron wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> > 
> > Extend the functionality of the driver to include support of 20 and
> > 24 bits per sample.
> > 
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > ---
> > 
> >  sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index f78167e152ce..bc7f9343bc7a 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -577,6 +577,9 @@ static int sun4i_i2s_hw_params(struct
> > snd_pcm_substream *substream,> 
> >  	case 16:
> >  		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> >  		break;
> > 
> > +	case 32:
> > +		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +		break;
> 
> This breaks the sun4i variants, because sun4i_i2s_get_wss returns 4 for a 32
> bit width, but it needs to return 3.

I'm not sure what has WSS with physical width and DMA?

> 
> As a side note, I wonder why we use the physical width (the spacing between
> samples in RAM) to drive the slot width. S24_LE takes up 4 bytes per sample
> in RAM, which we need for DMA. But I don't see why we would want to
> transmit the padding over the wire. I would expect it to be transmitted the
> same as S24_3LE (which has no padding). It did not matter before, because
> the only supported format had no padding.

Allwinner DMA engines support only 1, 2, 4 and sometimes 8 bytes for bus 
width, so if sample is 24 bits in size, we have no other way but to transmit 
padding too.

Best regards,
Jernej

> 
> Regards,
> Samuel
> 
> >  	default:
> >  		dev_err(dai->dev, "Unsupported physical sample width: 
%d\n",
> >  		
> >  			params_physical_width(params));
> > 
> > @@ -1063,6 +1066,10 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai
> > *dai)> 
> >  	return 0;
> >  
> >  }
> > 
> > +#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
> > +			 SNDRV_PCM_FMTBIT_S20_LE | \
> > +			 SNDRV_PCM_FMTBIT_S24_LE)
> > +
> > 
> >  static struct snd_soc_dai_driver sun4i_i2s_dai = {
> >  
> >  	.probe = sun4i_i2s_dai_probe,
> >  	.capture = {
> > 
> > @@ -1070,14 +1077,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
> > 
> >  		.channels_min = 1,
> >  		.channels_max = 8,
> >  		.rates = SNDRV_PCM_RATE_8000_192000,
> > 
> > -		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +		.formats = SUN4I_FORMATS,
> > 
> >  	},
> >  	.playback = {
> >  	
> >  		.stream_name = "Playback",
> >  		.channels_min = 1,
> >  		.channels_max = 8,
> >  		.rates = SNDRV_PCM_RATE_8000_192000,
> > 
> > -		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +		.formats = SUN4I_FORMATS,
> > 
> >  	},
> >  	.ops = &sun4i_i2s_dai_ops,
> >  	.symmetric_rates = 1,




