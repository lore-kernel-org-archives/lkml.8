Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE01C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B0C20801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="TBjUAvH2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="emEn5VRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgBRBfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 20:35:14 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60427 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbgBRBfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 20:35:14 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2C406713D;
        Mon, 17 Feb 2020 20:35:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 20:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=3
        /frFdDog4FFMXYLrMEqlb9W6/lavkPu4eDG9CYrLUs=; b=TBjUAvH2+r4py/WeH
        dYAXfAV4xxtqVJJvqORkLcT/xfwC5knGW4m8noq+FusysuQMjxp9A9H9lNss2gnE
        ymgEbL6i0MGS6OF8k1usR5lR+Cg9edB4Rv9Ib/c3SSX2UApy0Xa0c00d3U3ox/o9
        4Q5K9XHW/gNfqp/j/Q0WXTD/9Qke/BMjRGiRYkbaheZ+HU2Jld0d6KfqMuxhuvr/
        OFqZyDIAvhvNiue09cak608wjlJRg9VirPCiEYtWK50FUC6uOZzuW/f2ekpg6F+M
        XIm0oTZZVUAWHUScEwFvVdjHnkB6zB5DnF6H0dAARSAY8Et9XLfz0qBp6j+TO5f/
        gZcfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=3/frFdDog4FFMXYLrMEqlb9W6/lavkPu4eDG9CYrL
        Us=; b=emEn5VRVxNTBoJPTmLWomfIy5R32M8Md760VVUhJ8eGdlPLXN/bBDeAhn
        +GcRJWZ+ZcfYF+TjHHHmpxUG2qZH9XzsdXTHFcnislY/u2Fx3s+0ze1T0G/q/Nr9
        pV0YUiWSfpM1yX7Qc08gt5hHW5RUaRe0kEN7x6p4rTO0uwbJYi5mzghsgYonmo5h
        UgrwwrrjA8pjcj8qu3DprW0R2++v1uvMz4mGtCPNJ5nt4KL8Ius1gwBwa8qRoyOd
        6SvpNR9WOVvc26Rp8jw00FcSlVDTCEUoYaNwABsoBbqg4v/t6Gctsh1lsY6TtMHY
        fD5VzybJD8UZnTSBy9Lg6S1ohvpbw==
X-ME-Sender: <xms:TT9LXgMZLVK3eoy7lHkwIhGNH59zEU_eNFtjj4jAdQj4T8gzQPs2xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeejgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:TT9LXo2V3EfTC9_V2ZPSxdf994TQft8hgcC1iX8yeLmBq9K211zslw>
    <xmx:TT9LXr3xwclyYDuE7X_abSeevmEbdYeyRHoI4C0PUBnTzHN2mAuSkg>
    <xmx:TT9LXmW8Slb9DKdlRHeHD8iOTo1pmbW9sKShTs1y-AM3XGHDPHyf9A>
    <xmx:UT9LXsmgCGu_GY9u1ruN_VtYA7ZhFghMMyHEI-o8EdG6-txapHEZVQ>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 88DCB3060BD1;
        Mon, 17 Feb 2020 20:35:08 -0500 (EST)
Subject: Re: [RFC PATCH 05/34] ASoC: sun8i-codec: Remove incorrect
 SND_SOC_DAIFMT_DSP_B
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?Q?Myl=c3=a8ne_Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-6-samuel@sholland.org>
 <20200217150208.GG9304@sirena.org.uk>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <1cdcbc0d-39c7-25f2-68eb-a44e815fb9b8@sholland.org>
Date:   Mon, 17 Feb 2020 19:35:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200217150208.GG9304@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/20 9:02 AM, Mark Brown wrote:
> On Mon, Feb 17, 2020 at 12:42:21AM -0600, Samuel Holland wrote:
>> DSP_A and DSP_B are not interchangeable. The timing used by the codec in
>> DSP mode is consistent with DSP_A. This is verified with an EG25-G modem
>> connected to AIF2, as well as by comparing with the BSP driver.
>>
>> Remove the DSP_B option, as it is not supported by the hardware.
>>
>> Cc: stable@kernel.org
>> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> 
> This can only break things for existing systems using stable, if they
> haven't noticed a problem with DSP B they'll certainly notice failing to
> set up the DAI at all without it.

Are you suggesting that I drop this patch entirely, or only that I remove the CC
to stable (and/or Fixes: tag)? Is this something that can't be removed once it's
there, or is the concern about making user-visible changes on stable?

Thanks,
Samuel
