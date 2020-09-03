Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06330C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8EC320773
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="UzcvB9eY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kCjx+/FX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgICCWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:22:40 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56015 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgICCWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:22:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CBCB058012E;
        Wed,  2 Sep 2020 22:22:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 02 Sep 2020 22:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=Z
        HA9Ys3BbFE/uK3mH/P+4binR9tHt/5auQFE5N/VEm0=; b=UzcvB9eY6ycvjTjhV
        WwTnXWT54TlevB6RLGw7acGaDmeskyXA5dcl+AXs2KFel9Xu8ZW91OO5gokvoQEb
        zivH2O4QcO1GkP3YGZTyxpG6U5va3Vd/QfQ2vRlcJhRkfa/UJsu3NeklgonwOB6A
        Mv+ysNCLiF0DAk2o5Llzz+6iGuR+/qpNXEhKqhmHkFOPRRg71+fqc3TQ5ZFbjA8s
        R6gXI4JesAytjW0D5W9eodwEuGBN0i3A8BCrtow9yervRe7hP7zHKAHiFWzRjVt+
        +8fx0Lu0+4DpBoU3Si7QDdtAwwcjWBtGv6nTvZR6FBDHfJa1NxFAbsXarwUQ7uMR
        mvhCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=ZHA9Ys3BbFE/uK3mH/P+4binR9tHt/5auQFE5N/VE
        m0=; b=kCjx+/FXNJqGJx61GurAtrQrD3mCorm0S1vRvhGowKWZNZfJ7aM/9TGkT
        tGAO9nEWiB/TxAGpQ3Xo03Bvd+lVerHFT+R6+uFFTWMEfmC5OVKloqKZb21A8T/4
        F/HfDXUDHliLuqZzaXZwghjFKkA20r/cQguj4pqadm8GAalR1X8u5JibrwT5aXsx
        DmvS2ck7cuiqgLpBUv+8nXe6nQU2mdVvMP6yB32a9oE6NoOKmwF8kIqiPJgnOC+t
        fml/J4PmjFJBrtq8Mt0EcYdCiVc8r4Iw5vPnZXLMNykFaz4GMwgUA0HgMrexJgh5
        08GmtrMeQg3wQnSa4YvMnjFCS2scg==
X-ME-Sender: <xms:alNQX4wEEHX0uGS-GN4SuW7TSVpTqmQSPXm53bSeHX4yaehzFhm0uA>
    <xme:alNQX8TT7RxT0akP6ndzYeo7vZvO-kw2j3xYRrIvzAC6o5H7VThq1l7Dw9jNbcX1x
    1ODqZHKJHju5mbvCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfelkeduveejtdejhfeiledvhfeggeeiieeklefhfeefffffffeg
    udetteelieejnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:a1NQX6WalSV9vioGk7RoQzkRnPFRdEOgieAyO3oEhNNE_4b5eHnd5w>
    <xmx:a1NQX2iColSFeiEwRrHtOTOBO8Iw7GBm0RTF6TTyCNHSPrfP7ITo8w>
    <xmx:a1NQX6C6fq6_ADG_NFR_ab4Y4vDN90X2fntsA_xaBmK6qdkpbkLT0g>
    <xmx:bFNQX268XgzMR4ag7dujTr-he2aEqYSBqQzmE3SimjNteIkDOVhC8Q>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A1043280063;
        Wed,  2 Sep 2020 22:22:34 -0400 (EDT)
Subject: Re: [linux-sunxi] [PATCH 05/16] ASoc: sun4i-i2s: Add 20 and 24 bit
 support
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        peron.clem@gmail.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-6-peron.clem@gmail.com>
 <1e320dfd-9388-54b2-dba9-7def0bf4bbad@sholland.org>
 <9148679.oVN3Z7rve9@kista>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <fd714cb6-3650-1eb9-616d-33c00f1442eb@sholland.org>
Date:   Wed, 2 Sep 2020 21:22:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9148679.oVN3Z7rve9@kista>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 1:10 PM, Jernej Škrabec wrote:
> Hi Samuel!
> 
> Dne petek, 10. julij 2020 ob 07:44:51 CEST je Samuel Holland napisal(a):
>> On 7/4/20 6:38 AM, Clément Péron wrote:
>>> From: Marcus Cooper <codekipper@gmail.com>
>>>
>>> Extend the functionality of the driver to include support of 20 and
>>> 24 bits per sample.
>>>
>>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>>> Signed-off-by: Clément Péron <peron.clem@gmail.com>
>>> ---
>>>
>>>  sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++--
>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>>> index f78167e152ce..bc7f9343bc7a 100644
>>> --- a/sound/soc/sunxi/sun4i-i2s.c
>>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>>> @@ -577,6 +577,9 @@ static int sun4i_i2s_hw_params(struct
>>> snd_pcm_substream *substream,> 
>>>  	case 16:
>>>  		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>>>  		break;
>>>
>>> +	case 32:
>>> +		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>>> +		break;
>>
>> This breaks the sun4i variants, because sun4i_i2s_get_wss returns 4 for a 32
>> bit width, but it needs to return 3.
> 
> I'm not sure what has WSS with physical width and DMA?

This is the change where creating a S24_LE stream no longer fails with -EINVAL.
So this is the change where userspace stops downsampling 24-bit audio sources.
So this is the change where playback of 24-bit audio sources breaks, because WSS
is programmed wrong.

>> As a side note, I wonder why we use the physical width (the spacing between
>> samples in RAM) to drive the slot width. S24_LE takes up 4 bytes per sample
>> in RAM, which we need for DMA. But I don't see why we would want to
>> transmit the padding over the wire. I would expect it to be transmitted the
>> same as S24_3LE (which has no padding). It did not matter before, because
>> the only supported format had no padding.
> 
> Allwinner DMA engines support only 1, 2, 4 and sometimes 8 bytes for bus 
> width, so if sample is 24 bits in size, we have no other way but to transmit 
> padding too.

I understand why we do 4 byte DMA from RAM <=> I2S FIFO; that was not my
question. I'm referring to the actual wire format (FIFO <=> PCM_DIN/DOUT). The
sample is already truncated from 32 bits to 24 bits in the FIFO -- that's what
TXIM and RXOM in FIFO_CTRL control.

If a sample is 24 bits wide, why would we send 32 BCLKs for every LRCK? I would
expect the slot width to match the sample resolution by default. But yet we have
this code in the driver:

    unsigned int word_size = params_width(params);
    unsigned int slot_width = params_physical_width(params);

I think slot_width should be the same as word_size, and I suggest changing it
before adding 20/24-bit support.

> Best regards,
> Jernej

Regards,
Samuel

>>>  	default:
>>>  		dev_err(dai->dev, "Unsupported physical sample width: 
> %d\n",
>>>  		
>>>  			params_physical_width(params));
>>>
>>> @@ -1063,6 +1066,10 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai
>>> *dai)> 
>>>  	return 0;
>>>  
>>>  }
>>>
>>> +#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
>>> +			 SNDRV_PCM_FMTBIT_S20_LE | \
>>> +			 SNDRV_PCM_FMTBIT_S24_LE)
>>> +
>>>
>>>  static struct snd_soc_dai_driver sun4i_i2s_dai = {
>>>  
>>>  	.probe = sun4i_i2s_dai_probe,
>>>  	.capture = {
>>>
>>> @@ -1070,14 +1077,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
>>>
>>>  		.channels_min = 1,
>>>  		.channels_max = 8,
>>>  		.rates = SNDRV_PCM_RATE_8000_192000,
>>>
>>> -		.formats = SNDRV_PCM_FMTBIT_S16_LE,
>>> +		.formats = SUN4I_FORMATS,
>>>
>>>  	},
>>>  	.playback = {
>>>  	
>>>  		.stream_name = "Playback",
>>>  		.channels_min = 1,
>>>  		.channels_max = 8,
>>>  		.rates = SNDRV_PCM_RATE_8000_192000,
>>>
>>> -		.formats = SNDRV_PCM_FMTBIT_S16_LE,
>>> +		.formats = SUN4I_FORMATS,
>>>
>>>  	},
>>>  	.ops = &sun4i_i2s_dai_ops,
>>>  	.symmetric_rates = 1,
> 
> 
> 
> 

