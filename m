Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3FAC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D5D20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FhlWPsFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgAJXOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:14:50 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1800 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgAJXOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:14:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1905360000>; Fri, 10 Jan 2020 15:13:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Jan 2020 15:14:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Jan 2020 15:14:49 -0800
Received: from [10.2.160.1] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 23:14:48 +0000
Subject: Re: [PATCH v7 15/21] ASoC: tegra: Add fallback implementation for
 audio mclk
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <josephl@nvidia.com>, <daniel.lezcano@linaro.org>,
        <mmaddireddy@nvidia.com>, <markz@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-16-git-send-email-skomatineni@nvidia.com>
 <f3f550a2-c6e0-7a78-5c83-da3e54dab309@nvidia.com>
 <d7ac6135-73b0-1087-dafa-4df558a06ef4@nvidia.com>
 <a3c5293b-9ed4-3266-f792-38b980e54b1e@nvidia.com>
 <745b8c7b-4fe3-c9ea-284e-b89546e8ad87@nvidia.com>
 <705edf9b-d1bc-8090-017e-fa4ad445f9fb@nvidia.com>
 <135f0c0b-86d1-9b1a-af02-c14c4b5308c4@gmail.com>
 <575aa30e-1b5a-2a2d-5893-3f6832f416f1@nvidia.com>
 <9bca6c3e-bfe0-7130-b233-3f25c436f76e@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <dcfd35f3-7fdd-fdc9-1c77-bcb63bcabd5b@nvidia.com>
Date:   Fri, 10 Jan 2020 15:14:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9bca6c3e-bfe0-7130-b233-3f25c436f76e@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578698038; bh=u0UQrhfGeSXOXRblMCVznbZgOmAsjauC4YT/s6lv+3I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=FhlWPsFobB3l+M+5f6REuvNqb/Zt8Sys2EVmyPFbVa3H0Q8QoQUivYd8nbHJIFcvn
         C4CsxNXXBkrOmR7uLrDTYBf9j9+zzNcI1IK8tOVYsvPFr2bbosfBiy2ZFx1vDrrqSA
         DeE5ENz7x+6CQpZLp4pntzsrOXpb6kyWNu4SBJrRaKc+WvztS5jZyZTtx9vjaZpE3S
         tZbHwKq+/NxWLVvoGBQPFUCfgpU458fEKgxekOMnCzs5T8FtDyZgpM/lew9Sqe7T+J
         GseV6t5YT60kZ0p8ZD5DsK75HuYD5dWn3JRdpjlM5GRELniOlhm2KVuKpV9A6OLI+t
         De7DQkEWvCidw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/20 3:02 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 11.01.2020 01:13, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 1/10/20 2:05 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 10.01.2020 20:04, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> On 1/9/20 10:52 AM, Sowjanya Komatineni wrote:
>>>>> On 1/7/20 10:28 PM, Sameer Pujar wrote:
>>>>>> On 1/8/2020 11:18 AM, Sowjanya Komatineni wrote:
>>>>>>> On 1/7/20 9:34 PM, Sameer Pujar wrote:
>>>>>>>> On 1/8/2020 9:55 AM, Sowjanya Komatineni wrote:
>>>>>>>>> mclk is from clk_out_1 which is part of Tegra PMC block and pmc
>>>>>>>>> clocks
>>>>>>>>> are moved to Tegra PMC driver with pmc as clock provider and usin=
g
>>>>>>>>> pmc
>>>>>>>>> clock ids.
>>>>>>>>>
>>>>>>>>> New device tree uses clk_out_1 from pmc clock provider.
>>>>>>>>>
>>>>>>>>> So, this patch adds implementation for mclk fallback to extern1
>>>>>>>>> when
>>>>>>>>> retrieving mclk returns -ENOENT to be backward compatible of new
>>>>>>>>> device
>>>>>>>>> tree with older kernels.
>>>>>>>>>
>>>>>>>>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>>>>> ---
>>>>>>>>>     sound/soc/tegra/tegra_asoc_utils.c | 11 ++++++++++-
>>>>>>>>>     1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>>> index 9cfebef74870..9a5f81039491 100644
>>>>>>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>>> @@ -183,7 +183,16 @@ int tegra_asoc_utils_init(struct
>>>>>>>>> tegra_asoc_utils_data *data,
>>>>>>>>>         data->clk_cdev1 =3D devm_clk_get(dev, "mclk");
>>>>>>>>>         if (IS_ERR(data->clk_cdev1)) {
>>>>>>>>>             dev_err(data->dev, "Can't retrieve clk cdev1\n");
>>>>>>>> This error print can be moved inside below if, when this actually
>>>>>>>> meant to be an error condition.
>>>>>>>>
>>>>>>> Want to show error even if mclk retrieval returns ENOENT to clearly
>>>>>>> indicate mclk does not exist along with message of falling back to
>>>>>>> extern1.
>>>>>> Yes, but falling back essentially means 'mclk' is not available and
>>>>>> fallback print is not an error.
>>>>>> Not a major issue though, you can consider updating. Otherwise LGTM.
>>>>>>
>>>>> Will update
>>>>>>>>> -        return PTR_ERR(data->clk_cdev1);
>>>>>>>>> +        if (PTR_ERR(data->clk_cdev1) !=3D -ENOENT)
>>>>>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>>>>>> +        /* Fall back to extern1 */
>>>>>>>>> +        data->clk_cdev1 =3D devm_clk_get(dev, "extern1");
>>>>>>>>> +        if (IS_ERR(data->clk_cdev1)) {
>>>>>>>>> +            dev_err(data->dev, "Can't retrieve clk extern1\n");
>>>>>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        dev_err(data->dev, "Falling back to extern1\n");
>>>>>>>> This can be a info print?
>>>>> Will use dev_info
>>>>>>>>>         }
>>>>>>>>>           /*
>>>>> Dmitry/Rob, there was discussion in v3 regarding backporting mclk
>>>>> fallback.
>>>>>
>>>>> Dmitry wanted Rob to confirm on this
>>>>>
>>>>> I think openSUSE Leap could be one of those distros that use LTS kern=
el
>>>>> with newer device-trees, but that's not 100%. Maybe Rob could help
>>>>> clarifying that.
>>>>>
>>>>> Dmitry/Rob, Can you please confirm if mclk fallback patch need
>>>>> backport to have new device tree work with old kernels?
>>>>>
>>>> Dmitry,
>>>>
>>>> Can you please confirm if we need to backport this mclk fallback patch=
?
>>>>
>>> Seems only T210 was making use of the CaR's TEGRA*_CLK_CLK_OUT_*, thus
>>> the backporting isn't needed.
>> Thanks Dmitry
>>> Also, please use 'git rebase --exec make ...' to make sure that all
>>> patches are compiling without problems. The removal of the legacy clock
>>> IDs should be done after the device-trees changes, otherwise it looks
>>> like DTBs compilation will fail. It's possible that the order of the
>>> patches could be changed if Thierry will chose to split this series int=
o
>>> several pull requests, nevertheless all patches should compile and work
>>> in the original order.
>> OK, Will move patches of device tree updates to use new DT ID prior to
>> removal of old ID.
> Oh, wait. But then the newer device-trees won't work with the stable
> kernels, so it actually won't hurt to backport this change.
ok will add Fixes tag to have this mclk fallback patch backported.
>
> Secondly, please move the "Use device managed resource APIs to get the
> clock" after the ASoC patches with the stable tags, such that the stable
> patches could be applied cleanly.
OK
>
> Lastly, please separate the assigned-clocks change from the the audio
> mclk enable/disable into a standalone patch. These changes are not
> interdependent, unless I'm missing something.

But parent configuration when assigned-clock-parents are not in DT are=20
needed along with mclk enable

as we are removing audio clocks parent configuration and enabling them=20
together from clock driver.

So doesn't both parent configuration and enabling mclk together need to=20
be in same patch to match what we are removing from clock driver?

