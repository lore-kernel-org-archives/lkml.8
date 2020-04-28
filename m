Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7F9C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8455120730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgD1RLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:11:32 -0400
Received: from foss.arm.com ([217.140.110.172]:55814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgD1RLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:11:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FC6430E;
        Tue, 28 Apr 2020 10:11:30 -0700 (PDT)
Received: from [10.57.33.170] (unknown [10.57.33.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0ADD3F305;
        Tue, 28 Apr 2020 10:11:27 -0700 (PDT)
Subject: Re: Audio sound card name [was [PATCH 4/7] arm64: dts: allwinner:
 a64: Add HDMI audio]
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Marcus Cooper <codekipper@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20200426120442.11560-1-peron.clem@gmail.com>
 <20200426120442.11560-5-peron.clem@gmail.com>
 <20200428080020.35qcuylwq2ylmubu@gilmour.lan>
 <CAJiuCcc2LQ4L36KSfO8iLVFBUO6k+zsZFX+_Ovm_10PoWO4AsA@mail.gmail.com>
 <20200428160417.6q5oab2guaumhhwi@gilmour.lan>
 <CAJiuCccFFUJJzXwygLQbDK4fGJ61p72Hv7vj3WVP-=z=J1Yj0Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <031ee5d3-8a30-82ee-76db-c0e8a1073046@arm.com>
Date:   Tue, 28 Apr 2020 18:11:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCccFFUJJzXwygLQbDK4fGJ61p72Hv7vj3WVP-=z=J1Yj0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-28 5:49 pm, Clément Péron wrote:
> Hi Mark, Rob,
> 
> On Tue, 28 Apr 2020 at 18:04, Maxime Ripard <maxime@cerno.tech> wrote:
>>
>> On Tue, Apr 28, 2020 at 10:54:00AM +0200, Clément Péron wrote:
>>> Hi Maxime,
>>>
>>> On Tue, 28 Apr 2020 at 10:00, Maxime Ripard <maxime@cerno.tech> wrote:
>>>>
>>>> On Sun, Apr 26, 2020 at 02:04:39PM +0200, Clément Péron wrote:
>>>>> From: Marcus Cooper <codekipper@gmail.com>
>>>>>
>>>>> Add a simple-soundcard to link audio between HDMI and I2S.
>>>>>
>>>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>>>>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>>>>> Signed-off-by: Clément Péron <peron.clem@gmail.com>
>>>>> ---
>>>>>   arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++
>>>>>   1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>>>> index e56e1e3d4b73..08ab6b5e72a5 100644
>>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>>>> @@ -102,6 +102,25 @@
>>>>>                status = "disabled";
>>>>>        };
>>>>>
>>>>> +     hdmi_sound: hdmi-sound {
>>>>> +             compatible = "simple-audio-card";
>>>>> +             simple-audio-card,format = "i2s";
>>>>> +             simple-audio-card,name = "allwinner,hdmi";
>>>>
>>>> I'm not sure what the usual card name should be like though. I would assume that
>>>> this should be something specific enough so that you're able to differentiate
>>>> between boards / SoC so that the userspace can choose a different configuration
>>>> based on it?
>>>
>>> I really don't know what we should use here,
>>> I just have a look at other SoC:
>>> rk3328: "HDMI"
>>> rk3399: "hdmi-sound"
>>> r8a774c0-cat874: "CAT874 HDMI sound"
>>>
>>> But maybe it's time to introduce proper name:
>>> What about :
>>> pat
>>> sun50i-h6-hdmi
>>
>> It's pretty much what we've been using for the other sound cards we have, so it
>> makes sense to me.
> 
> I have a question regarding the simple-audio-card,name.
> In this patch, I would like to introduce a simple-audio-card for the
> Allwinner A64 HDMI.
> 
> What should be the preferred name for this sound card?
> "sun50i-a64-hdmi" ? "allwinner, sun50i-a64-hdmi" ?

I can at least speak for RK3328, and the reasoning there was that as the 
user looking at what `aplay -l` says, I don't give a hoot about what the 
SoC may be called, I see two cards and I want to know, with the least 
amount of uncertainty, which one will make the sound come out of the 
port that's labelled "HDMI" on the box ;)

Robin.
