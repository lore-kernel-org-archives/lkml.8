Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3BDC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C5B2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="md3p70F7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgEFOMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:12:38 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7474 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgEFOMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:12:37 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb2c5530000>; Wed, 06 May 2020 07:10:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 06 May 2020 07:12:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 06 May 2020 07:12:37 -0700
Received: from [10.25.100.73] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 May
 2020 14:12:28 +0000
CC:     <spujar@nvidia.com>, <nicoleotsuka@gmail.com>,
        <alsa-devel@alsa-project.org>, <swarren@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <nwartikar@nvidia.com>,
        <lgirdwood@gmail.com>, <jonathanh@nvidia.com>,
        <viswanathl@nvidia.com>, <sharadg@nvidia.com>,
        <thierry.reding@gmail.com>, <atalambedu@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <digetx@gmail.com>,
        <rlokhande@nvidia.com>, <mkumard@nvidia.com>, <dramesh@nvidia.com>
Subject: Re: [RFC] DPCM for Tegra
To:     Jerome Brunet <jbrunet@baylibre.com>, <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>
References: <1588250483-10014-1-git-send-email-spujar@nvidia.com>
 <1jzhalffhh.fsf@starbuckisacylon.baylibre.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <fe842d81-22da-fbbe-b5e2-9872cefb9d8b@nvidia.com>
Date:   Wed, 6 May 2020 19:42:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1jzhalffhh.fsf@starbuckisacylon.baylibre.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588774227; bh=9Msqnz7jhEBLl+G7E7cOof/VahVpWn8exGwBX3HSCEM=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=md3p70F7J1Ms+vmsbgb4kHkoG2IhzuDsCcPR/A/kHwphH9X26oPYVGTAgcTjGlr34
         hw8FCsEGs5JUBuIJWsNqIM82GV2gLLE7W2xcuu5qtQBymIV1FmKPdMUeOYwogOcErY
         7HMvaxBbPqTXEGue7fCEinRvJg4Lm10jfuC6gQIBuhehULto46SXXYtnDgFqzLVJYM
         647TGgXNNjKJsAc0vPo/NYhOI/noJtkOpoTB5KP1eHeQs4iTUW6qxHlRymytv2oxkt
         NanypWN0O9qD0eYxB/p+3DJ08Ipt/IAj8KdDJl2B/s6lq67Ilp3UaOoORe+3ob/QcC
         GZkq0LSmlCdZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/2020 5:21 PM, Jerome Brunet wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu 30 Apr 2020 at 14:41, Sameer Pujar <spujar@nvidia.com> wrote:
>
>> At a high level Tegra Audio HW is depicted as below.
>>
>> |     Front End PCMs     |  SoC DSP   |     Back End DAIs    |
>>
>>                           *************
>> ADMAIF<0> <------------> *           * <----DAI<0>-----> I2S
>>                           *           *
>> ADMAIF<1> <------------> *           * <----DAI<1>-----> DMIC
>>                           *    XBAR   *
>> ADMAIF<2> <------------> *           * <----DAI<2>-----> DSPK
>>                           *           *
>> ADMAIF<N> <------------> *           * <----DAI<3>-----> SFC (Resampler)
>>                           *           *
>>                           *           * <----DAI<4>-----> MIXER
>>                           *           *
>>                           *           * <----DAI<N>-----> ...
>>                           *************
>>
>>
>> Follow up queries
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Based on the above experience I do have few follow up queries and reques=
t
>> for your inputs on this.
>>
>>   a) Can I use a DAPM Mux control to activate a BE path? This in turn ca=
n
>>      program required switch in XBAR.
> My 2 cents:

> DPCM should activate any BE which has:
> * a valid DAPM path from the current FE
> * a valid BE stream (ex: can handle the stream direction)

Yes, this is taken care.
>
> AFAIK, you can use any combination of DAPM elements to model your
> components, including the XBAR. Then, it is the job of the card driver to
> link the DAPM widgets of the different components together and bring the
> system to life.

XBAR currently exports all routing widgets which can be used to=20
interconnect multiple components and thus implements Mux widgets. Fixing=20
the routing paths in driver would limit anyone to try a different=20
combination as per the need, unless driver is modified. Device tree (DT)=20
can be one of the solutions here, but currently static paths can only be=20
added AFAIK. Even if this is extended to include routes with Mux=20
widgets, still it won't give the real flexibility. I cannot re-use a=20
component for a different routing path, unless DT is modified again.

Hence a Mux widget with user space control could offer required=20
flexibility.
>
> If your XBAR is widgets are not provided by a component which also
> provides a dai_link in the sound card, you'll need to add the component
> to the auxiliary device list of the card for the widget to be available
> in the card.

I registered XBAR device as a component having a dummy DAI just to allow=20
routing paths to be available for the given sound card. Are you=20
suggesting I can register XBAR as an auxiliary device so that all the=20
routing paths are available?
>
>>      This is needed for following reasons:
>>
>>      - For an open platform like Jetson, we want to give maximum flexibi=
lity
>>        for a user to customize their audio paths. Number of connected
>>        components and order of these can vary depending on a use case.
>>
>>      - Allow re-use of audio components across multiple use cases.
>>        For example, number of SFC instances are lesser than PCM playback=
 or
>>        capture devices.
>>
>>   b) I have modelled SFC and MIXER as backends. Is this allowed?
>>
>>      This was done to include SFC or MIXER HW components as part of the
>>      sound card and use like below in one of the audio use cases.
>>
>>      ADMAIF1(FE) --> SFC(BE1) --> I2S(BE2) ... OR
>>      ADMAIF2(FE) --> SFC(BE1) --> I2S(BE2) ...

> What your are trying to achieve here is DAI chaining. From the DAPM
> perspective, it is alright. Unfortunately this kind of chaining are
> not supported (not yet, at least) from the dai_link perspective, even
> with DPCM.

In the current design we achieve this by using codec-to-codec links and=20
attempt here is if we can use DPCM to simplify few things.
>
>
>  From the DPCM perspective, I think your patch does the following:
>
> ADMAIF1(FE) ---> SFC(BE1)
>              |--> I2S(BE2)
> ADMAIF2(FE) ---> SFC(BE1)
>              |--> I2S(BE2)
>
> Your DAIs are not chained, but put in parallel. Maybe all your DAI
> callbacks are called in a way that is convinient enough for your
> use cases, but it is not what you intended.

Yes this seems to be the case. All of my BE DAIs are added to the list=20
and callbacks happen for all. DPCM is viewing these as parallel paths.
>
> For the example, the rate passed to 'I2S(BE2)' in hw_params() will
> be the one provided by the 'ADMAIF', not the output rate of the 'SFC'.

I was earlier thinking if dpcm_be_dai_hw_params() can be enhanced to=20
propagate PCM parameters (sample rate, channels, sample size) from BE to=20
BE. This is a rough idea, I have not tried this. But because of above it=20
will be a problem unless real parallel paths are not differentiated.
For example:
ADMAIF1(FE) ---> SFC1 ---> I2S1 (operated at 48 kHz)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |--> SF=
C2 ---> I2S2 (operated at 16 kHz)

If I understand correctly, this problem will be there if I want to drive=20
multiple paths with the "same FE". I am not sure how often we have such=20
requirements.
For example below would work fine (though it is functionally not same as=20
above example):
ADMAIF1(FE) ---> SFC1 ---> I2S1 (operated at 48 kHz)
ADMAIF2(FE) ---> SFC2 ---> I2S2 (operated at 16 kHz)
>
>>      I used following workaround to connect multiple BE components.
>>      With this I can see PCM callbacks happen for all BE DAIs along the =
DAPM
>>      path. The obective was to connect multiple components together and =
(a)
>>      was used to connect one component to another. Each "-->" here conne=
cts
>>      two components and it is a switch in XBAR.
>>
>>      ---
>>        sound/soc/soc-pcm.c | 2 +-
>>        1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>        diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
>>        index e256d43..ee7af55 100644
>>        --- a/sound/soc/soc-pcm.c
>>        +++ b/sound/soc/soc-pcm.c
>>        @@ -1494,7 +1494,7 @@ int dpcm_path_get(struct snd_soc_pcm_runtim=
e *fe,
>>
>>          /* get number of valid DAI paths and their widgets */
>>          paths =3D snd_soc_dapm_dai_get_connected_widgets(cpu_dai, strea=
m, list,
>>        -                       dpcm_end_walk_at_be);
>>        +                       NULL);
>>
>>        dev_dbg(fe->dev, "ASoC: found %d audio %s paths\n", paths,
>>                        stream ? "capture" : "playback");
>>      --
. . .
>> References
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [0] http://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D15966=
4&archive=3Dboth&state=3D*
>> [1] http://patchwork.ozlabs.org/project/linux-tegra/patch/1582180492-252=
97-6-git-send-email-spujar@nvidia.com/
>> [2] http://patchwork.ozlabs.org/project/linux-tegra/patch/1582180492-252=
97-4-git-send-email-spujar@nvidia.com/
>> [3] https://www.kernel.org/doc/html/v5.6/sound/soc/dpcm.html

