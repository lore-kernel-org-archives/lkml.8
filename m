Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC45C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9887C2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="vCAQfKnY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qcS2DU9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBQD5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:57:20 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:48167 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbgBQD5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:57:20 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id D796E66CF;
        Sun, 16 Feb 2020 22:57:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 16 Feb 2020 22:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=s
        Eb3W4fDy5WMXH64z7KYeDZVXMFQ3arbDkHKhfiZhKo=; b=vCAQfKnYMabbL3fR9
        acRl8pTgj/z6kV2tO+937sGOQHDebph4QmKKjuctkC8B/aQrBgHGf2lXIpCPUrqZ
        vJCUwNKcxbMqI0RJgcPY+MEv3BMiwrLxJw9MZcGLq3ydBAOFmORFwRKDXdU7dxqA
        YLWVlaB0o/O8Ed8hbsyh/b3dNlyh1kBF74DHT76psgoTuvrqFSvWwv0I1aGRsHq4
        FLJL2FFlKWzHj6ISeT9iFYUPICoCBZLB/MoPEWjZTMNHbsJYU8Lr0b7oH06qIIvC
        A0/lG3aCyhhfsZ2GOTSvYdEZiBwIsCJzQSvYuUuVF/gLU1qXuh8B+VvflGq8viP+
        eiJZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=sEb3W4fDy5WMXH64z7KYeDZVXMFQ3arbDkHKhfiZh
        Ko=; b=qcS2DU9Zp/IgNYWdaO9FP9AO+SAB4VDmwkR5FKpZtAZyKt+VznLOLKRzo
        KYy4KNj9pNwJbcDMvbQ4gip812YY2vlksaaxCCWeEMuwDXI8k1pvTc99NjbDZWk5
        gY/Z4XTw39Xg6+VIn+nh28KH2ubpBcQ3923Ng4YTdewTlQGBCzcaLJqb3eVLY9aw
        UW0dqjANKOIvybxtVlaCfFaXkAH445nZebk6B82Jp5KVuCVUjGbABr5KzjhGrrvV
        A+DksljLRWdresicG0nH2nTz7oxnRPghkXFAFNnTZOVybfqNs2T/J+sfuQ1h/a3S
        y0qD3VLqD5SXa0dRUZZFIG2xzSWiA==
X-ME-Sender: <xms:Hg9KXvQmllwMSyLuwpFxIJmebThEQMWUwqTA760mvQs7riW_ne2HAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Hg9KXq0tKyZlPG-wIGjHU9MA_d4nvYBtZZWSFWK1g5UMxLt3BoxkyA>
    <xmx:Hg9KXks8wqCEfiqLS1kch0rJl7IDKRRbL7B4oXgxdjn64PGghVN8zA>
    <xmx:Hg9KXggJbCJfQPbIwYy8Zn1xdvzYoX0LGzyxv8BXRtPjepVI45Nw-A>
    <xmx:Hg9KXsNAMBogEcqN_kTsAULr6RtILbSgHZy5OsKdHO2TLIDmZ-klzA>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D2E223060BE4;
        Sun, 16 Feb 2020 22:57:17 -0500 (EST)
Subject: Re: [PATCH 4/8] ASoC: sun50i-codec-analog: Make headphone routes
 stereo
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200217021813.53266-1-samuel@sholland.org>
 <20200217021813.53266-5-samuel@sholland.org>
 <CAGb2v677p8u8_0jhcbN07QsyVc21dKJmeK6=rxLCbde+AOqreQ@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <de0a08a8-eb02-375f-4364-2935cf4c3d7c@sholland.org>
Date:   Sun, 16 Feb 2020 21:57:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAGb2v677p8u8_0jhcbN07QsyVc21dKJmeK6=rxLCbde+AOqreQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2/16/20 9:48 PM, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, Feb 17, 2020 at 10:18 AM Samuel Holland <samuel@sholland.org> wrote:
>>
>> This matches the hardware more accurately, and is necessary for
>> including the (stereo) headphone mute switch in the DAPM graph.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  sound/soc/sunxi/sun50i-codec-analog.c | 28 +++++++++++++++++++--------
>>  1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
>> index 17165f1ddb63..f98851067f97 100644
>> --- a/sound/soc/sunxi/sun50i-codec-analog.c
>> +++ b/sound/soc/sunxi/sun50i-codec-analog.c
>> @@ -311,9 +311,15 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
>>          */
>>
>>         SND_SOC_DAPM_REGULATOR_SUPPLY("cpvdd", 0, 0),
>> -       SND_SOC_DAPM_MUX("Headphone Source Playback Route",
>> +       SND_SOC_DAPM_MUX("Left Headphone Source",
>>                          SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
>> -       SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN50I_ADDA_HP_CTRL,
>> +       SND_SOC_DAPM_MUX("Right Headphone Source",
> 
> Please don't remove the widget suffix. The suffix was chosen to work with
> alsa-lib's control parsing code. The term "Playback Route" is appropriate
> because it is playback only, and it is a routing switch, not a source or
> sink.

Removing the suffix here doesn't affect the control name as seen by userspace,
because the control is shared between multiple widgets (Left and Right).

> Also, what's wrong with just having a single "stereo" widget instead of
> two "mono" widgets? I added stereo (2-channel) support to DAPM quite
> some time ago. You just have to have two routes in and out.

If you have any completed path through a widget, the widget is turned on. A
stereo mute switch is logically two separate paths. So if I break one path by
muting one channel, that lets me turn off everything before and after in the
path (e.g. turning off the right side of the DAC lets DAPM turn off the right
mixer, the right side of the output amp, even the right side of the AIF or the
ADC if that was the only input. That only works if there are separate Left/Right
widgets.

> ChenYu

Samuel

>> +                        SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
>> +       SND_SOC_DAPM_OUT_DRV("Left Headphone Amp",
>> +                            SND_SOC_NOPM, 0, 0, NULL, 0),
>> +       SND_SOC_DAPM_OUT_DRV("Right Headphone Amp",
>> +                            SND_SOC_NOPM, 0, 0, NULL, 0),
>> +       SND_SOC_DAPM_SUPPLY("Headphone Amp", SUN50I_ADDA_HP_CTRL,
>>                              SUN50I_ADDA_HP_CTRL_HPPA_EN, 0, NULL, 0),
>>         SND_SOC_DAPM_OUTPUT("HP"),
>>
>> @@ -405,13 +411,19 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
>>         { "Right ADC", NULL, "Right ADC Mixer" },
>>
>>         /* Headphone Routes */
>> -       { "Headphone Source Playback Route", "DAC", "Left DAC" },
>> -       { "Headphone Source Playback Route", "DAC", "Right DAC" },
>> -       { "Headphone Source Playback Route", "Mixer", "Left Mixer" },
>> -       { "Headphone Source Playback Route", "Mixer", "Right Mixer" },
>> -       { "Headphone Amp", NULL, "Headphone Source Playback Route" },
>> +       { "Left Headphone Source", "DAC", "Left DAC" },
>> +       { "Left Headphone Source", "Mixer", "Left Mixer" },
>> +       { "Left Headphone Amp", NULL, "Left Headphone Source" },
>> +       { "Left Headphone Amp", NULL, "Headphone Amp" },
>> +       { "HP", NULL, "Left Headphone Amp" },
>> +
>> +       { "Right Headphone Source", "DAC", "Right DAC" },
>> +       { "Right Headphone Source", "Mixer", "Right Mixer" },
>> +       { "Right Headphone Amp", NULL, "Right Headphone Source" },
>> +       { "Right Headphone Amp", NULL, "Headphone Amp" },
>> +       { "HP", NULL, "Right Headphone Amp" },
>> +
>>         { "Headphone Amp", NULL, "cpvdd" },
>> -       { "HP", NULL, "Headphone Amp" },
>>
>>         /* Microphone Routes */
>>         { "Mic1 Amplifier", NULL, "MIC1"},
>> --
>> 2.24.1
>>

