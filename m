Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C67C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE522076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="uad/q7X5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ur6lTTEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJFor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:44:47 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:41431 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbgGJFom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:44:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 08A7EDD6;
        Fri, 10 Jul 2020 01:44:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 10 Jul 2020 01:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:subject:to:cc:references:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=T
        Y2tPFdx7fey0wUOp1pvyVk5MN3ejOr1EHuMUz2E4uw=; b=uad/q7X5nHnT4xj1W
        i2l77nLmfCp6jQOTGMJbWYTpfABM7ixr34xCNBx9La+vAOYsJ2jF7iqgOeUiqPrG
        Ud1aa0FrLMABYP8G8Xxp24qDSpYog/MhIV7Qhx48Kl3n5FXvICCL5fsFeXin+lAn
        xnvL3Qw1dIEeZFJieWOteqBKwUpIT8PeGFgmXtnkyb+lEU6R00I5iTbz74xGwUkU
        Jw/40fGNhBK/pWojqHdyfmLfh4qaFeM16pBWx2Q1VpwFXUcfUmB405bVZXRGA9QS
        b3oFgn3rWYmUyBjTJJTnCeU1hBU1I8uIBM3Qjy1IU13+SqH89muOpWJO/7mZ5+Ug
        /oglg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=TY2tPFdx7fey0wUOp1pvyVk5MN3ejOr1EHuMUz2E4
        uw=; b=Ur6lTTEWnuNnAfC5iF7QiKaGjy8kpSy83jKu+RkG/QJ3/0p+r9iqvRzlh
        FgYGadoxl1U5xsJROSCazI8MmIwfRmbBLzLmVVA0JasxYjzQM1YjhSZyLt+4v94a
        EhccUr6iyxB+UxkezLcJWL84PGYPwfIQrw9ZYH82VVUEMCSuYrN6i3eTLTiC9pVL
        UvpbbFZ3Rv/3DC20gpcN6+AvKhxnfxRAxavFl/Imes30Jxzio+0TWmpWKjAPGqBT
        VCRViwimPrXxm+bJZ4Dh4qVedNHSU+zv8POLDifTtbQCDfq/oI0VQH0fQQ47HuXu
        h0gmsJsfMqqpuKhNMSBoDy6AMVbCg==
X-ME-Sender: <xms:RwAIX1Mdssdja-kjIY6gmqeRvzNXo5OCPqUUh3IRZQ3KRxcoxeRIEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrvddtgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhuffvfhfkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeevvdffgedtieehfeeltdekleejvedtvdefueehueeihfdvjefgkeef
    udegjeejtdenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:RwAIX38qqVdKFz3jtZqbg4iqXexfxRYJSEch7FLyc42AjswekGSl1w>
    <xmx:RwAIX0SKqZWRqFd5KnZ7q92SD6RVpQ2uPnNfl3zvTS6zuXlcxSqkHQ>
    <xmx:RwAIXxtj_L7X7Rw_7uRU0mKFV3lUjgJBlpyOuPj7hEnfHllHRIFRuA>
    <xmx:RwAIX71oTe-9aYbTNFcnbIAiU0R-6u9uKuGMcAB-ABD8LBdnPRwaOxAvub0>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 75E5B3280059;
        Fri, 10 Jul 2020 01:44:38 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [linux-sunxi] [PATCH 02/16] ASoC: sun4i-i2s: Adjust LRCLK width
To:     peron.clem@gmail.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Maxime Ripard <maxime@cerno.tech>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-3-peron.clem@gmail.com>
Message-ID: <72fa00f8-85b4-4653-f27e-57791271a068@sholland.org>
Date:   Fri, 10 Jul 2020 00:44:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200704113902.336911-3-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/20 6:38 AM, Clément Péron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Some codecs such as i2s based HDMI audio and the Pine64 DAC require
> a different amount of bit clocks per frame than what is calculated
> by the sample width. Use the values obtained by the tdm slot bindings
> to adjust the LRCLK width accordingly.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Acked-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 9690389cb68e..8bae97efea30 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -470,6 +470,9 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>  		return -EINVAL;
>  	}
>  
> +	if (i2s->slot_width)
> +		lrck_period = i2s->slot_width;
> +
>  	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
>  			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
>  			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
> 

It looks like the existing code would have the same problem, that this should be
lrck_period - 1 according to the manual (I checked H3).

Regards,
Samuel
