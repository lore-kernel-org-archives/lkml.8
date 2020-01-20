Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B250C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2085520679
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iVMvQ/GH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgATEKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 23:10:35 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14260 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgATEKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 23:10:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e25282b0000>; Sun, 19 Jan 2020 20:10:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 19 Jan 2020 20:10:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 19 Jan 2020 20:10:33 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jan
 2020 04:10:27 +0000
Subject: Re: [PATCH v8 19/22] ASoC: tegra: Enable audio mclk during
 tegra_asoc_utils_init
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <josephl@nvidia.com>, <daniel.lezcano@linaro.org>,
        <mmaddireddy@nvidia.com>, <markz@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-20-git-send-email-skomatineni@nvidia.com>
 <3a8e609a-58aa-d2c1-c140-e1f0127dd53b@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <64027c16-763b-350f-9975-4f9727450ae9@nvidia.com>
Date:   Mon, 20 Jan 2020 09:40:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3a8e609a-58aa-d2c1-c140-e1f0127dd53b@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579493419; bh=LVcMB3ge8cxlkdETYViqbJ2t8Kv4AW9iqdQrzlTvyQ4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=iVMvQ/GHwoYfJZCPQ+vfHZvajRdgNH3N3AA+xRp0Br6PsCeoA7sxms8dI7wZrWU+U
         SB6t+Y6MFfa4GNTpcGvJw3/TCuxs3xGN5CkY50ZEAYZuMPeL082aJP3eaDFUH13+Yl
         P9+U4/RdMEL7APAZIcc9cATRX8Agar+eK5Re3Roj5pl9Ac/p6aMQbBJFW3keF+wIrQ
         PaD9rQfMjWYbvXalxk4wWncuLiZrNvk0WU9ZbEM25WBnAknbxOihvyELwUQQqQXYC7
         AX2WC/lqmQUkczXTax1vpGyi4wIgc0vLxtGd7YsE3hlLufIGthDCAtMEr+6Bbrp6AR
         Z93pwiOgSDXaw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/2020 8:44 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 14.01.2020 10:24, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
>> through Tegra210 and currently Tegra clock driver keeps the audio
>> mclk enabled.
>>
>> With the move of PMC clocks from clock driver into pmc driver,
>> audio mclk enable from clock driver is removed and this should be
>> taken care by the audio driver.
>>
>> tegra_asoc_utils_init calls tegra_asoc_utils_set_rate and audio mclk
>> rate configuration is not needed during init and set_rate is actually
>> done during hw_params callback.
>>
>> So, this patch removes tegra_asoc_utils_set_rate call and just leaves
>> the audio mclk enabled.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   sound/soc/tegra/tegra_asoc_utils.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_=
asoc_utils.c
>> index 1dce5ad6e665..99584970f5f4 100644
>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>> @@ -216,9 +216,16 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_d=
ata *data,
>>                data->clk_cdev1 =3D clk_out_1;
>>        }
>>
>> -     ret =3D tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
>> -     if (ret)
>> +     /*
>> +      * FIXME: There is some unknown dependency between audio mclk disa=
ble
>> +      * and suspend-resume functionality on Tegra30, although audio mcl=
k is
>> +      * only needed for audio.
>> +      */
>> +     ret =3D clk_prepare_enable(data->clk_cdev1);
>> +     if (ret) {
>> +             dev_err(data->dev, "Can't enable cdev1: %d\n", ret);
>>                return ret;
>> +     }
>>
>>        return 0;
>>   }
>>
> Shouldn't the clock be disabled on driver's removal?

I am not sure if we really need to do in this series as it does not=20
change the behavior from what was there earlier. Also there is already a=20
FIXME item here and we end up adding clock disable in remove() path of=20
multiple drivers, which is going to be removed once we address FIXME.

