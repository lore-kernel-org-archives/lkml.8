Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9F7C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F1C20678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="r98heYA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgAJWNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:13:45 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10305 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgAJWNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:13:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e18f7050000>; Fri, 10 Jan 2020 14:13:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Jan 2020 14:13:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Jan 2020 14:13:44 -0800
Received: from [10.2.160.1] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 22:13:43 +0000
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
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <575aa30e-1b5a-2a2d-5893-3f6832f416f1@nvidia.com>
Date:   Fri, 10 Jan 2020 14:13:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <135f0c0b-86d1-9b1a-af02-c14c4b5308c4@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578694406; bh=2gkT3tMLxYwyOI9Jl1S9GbWxm3s4X8H8VJ7ik1MXyoA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=r98heYA0mgWJMM7cxOmYtXFUe/SUO8nBYkvD8RFzN75yxHfwCro5N/26m0Q4Kthbo
         taSjL+fkp5qmsLhaeib7B1DgpcQPdPulDvkawBOxVb4f6pVMOreJvS5U8dlskzP0Yb
         3OaVvsPSHsO+1VMVPImCytt6SVTCMUm2ZLbxpl41V/dgSi4vxwZ+2MWcyi/zyB/MIs
         d/ZxdT0RIeVWQTsUYAi+YO1fEmCA/Bic8duqn9egyfmACnOPqWlIHZ6QLDVxRzoUlM
         xedxgQ/GDRfpkmtOyfQhRtjzkN8ofhV75Fajgejd9tLh7IPJouR+plxhE/66feLx8f
         ZXR4WaiaklikQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/20 2:05 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 10.01.2020 20:04, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 1/9/20 10:52 AM, Sowjanya Komatineni wrote:
>>>
>>> On 1/7/20 10:28 PM, Sameer Pujar wrote:
>>>> On 1/8/2020 11:18 AM, Sowjanya Komatineni wrote:
>>>>> On 1/7/20 9:34 PM, Sameer Pujar wrote:
>>>>>> On 1/8/2020 9:55 AM, Sowjanya Komatineni wrote:
>>>>>>> mclk is from clk_out_1 which is part of Tegra PMC block and pmc
>>>>>>> clocks
>>>>>>> are moved to Tegra PMC driver with pmc as clock provider and using
>>>>>>> pmc
>>>>>>> clock ids.
>>>>>>>
>>>>>>> New device tree uses clk_out_1 from pmc clock provider.
>>>>>>>
>>>>>>> So, this patch adds implementation for mclk fallback to extern1 whe=
n
>>>>>>> retrieving mclk returns -ENOENT to be backward compatible of new
>>>>>>> device
>>>>>>> tree with older kernels.
>>>>>>>
>>>>>>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>>> ---
>>>>>>>    sound/soc/tegra/tegra_asoc_utils.c | 11 ++++++++++-
>>>>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>> index 9cfebef74870..9a5f81039491 100644
>>>>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>> @@ -183,7 +183,16 @@ int tegra_asoc_utils_init(struct
>>>>>>> tegra_asoc_utils_data *data,
>>>>>>>        data->clk_cdev1 =3D devm_clk_get(dev, "mclk");
>>>>>>>        if (IS_ERR(data->clk_cdev1)) {
>>>>>>>            dev_err(data->dev, "Can't retrieve clk cdev1\n");
>>>>>> This error print can be moved inside below if, when this actually
>>>>>> meant to be an error condition.
>>>>>>
>>>>> Want to show error even if mclk retrieval returns ENOENT to clearly
>>>>> indicate mclk does not exist along with message of falling back to
>>>>> extern1.
>>>> Yes, but falling back essentially means 'mclk' is not available and
>>>> fallback print is not an error.
>>>> Not a major issue though, you can consider updating. Otherwise LGTM.
>>>>
>>> Will update
>>>>>>> -        return PTR_ERR(data->clk_cdev1);
>>>>>>> +        if (PTR_ERR(data->clk_cdev1) !=3D -ENOENT)
>>>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>>>> +        /* Fall back to extern1 */
>>>>>>> +        data->clk_cdev1 =3D devm_clk_get(dev, "extern1");
>>>>>>> +        if (IS_ERR(data->clk_cdev1)) {
>>>>>>> +            dev_err(data->dev, "Can't retrieve clk extern1\n");
>>>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        dev_err(data->dev, "Falling back to extern1\n");
>>>>>> This can be a info print?
>>> Will use dev_info
>>>>>>>        }
>>>>>>>          /*
>>> Dmitry/Rob, there was discussion in v3 regarding backporting mclk
>>> fallback.
>>>
>>> Dmitry wanted Rob to confirm on this
>>>
>>> I think openSUSE Leap could be one of those distros that use LTS kernel
>>> with newer device-trees, but that's not 100%. Maybe Rob could help
>>> clarifying that.
>>>
>>> Dmitry/Rob, Can you please confirm if mclk fallback patch need
>>> backport to have new device tree work with old kernels?
>>>
>> Dmitry,
>>
>> Can you please confirm if we need to backport this mclk fallback patch?
>>
> Seems only T210 was making use of the CaR's TEGRA*_CLK_CLK_OUT_*, thus
> the backporting isn't needed.
Thanks Dmitry
>
> Also, please use 'git rebase --exec make ...' to make sure that all
> patches are compiling without problems. The removal of the legacy clock
> IDs should be done after the device-trees changes, otherwise it looks
> like DTBs compilation will fail. It's possible that the order of the
> patches could be changed if Thierry will chose to split this series into
> several pull requests, nevertheless all patches should compile and work
> in the original order.
OK, Will move patches of device tree updates to use new DT ID prior to=20
removal of old ID.
