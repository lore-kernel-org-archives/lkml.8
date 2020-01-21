Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BC0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C772A24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KOVOEaWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgAUQTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:19:50 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8827 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:19:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2724950000>; Tue, 21 Jan 2020 08:19:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 Jan 2020 08:19:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 Jan 2020 08:19:48 -0800
Received: from [10.2.160.120] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jan
 2020 16:19:48 +0000
Subject: Re: [PATCH v8 22/22] clk: tegra: Remove audio clocks configuration
 from clock driver
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-23-git-send-email-skomatineni@nvidia.com>
 <d69fe7a8-71cc-c560-a567-f89b936753ad@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <9765b723-33af-9863-72c9-8094203c8cb8@nvidia.com>
Date:   Tue, 21 Jan 2020 08:19:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d69fe7a8-71cc-c560-a567-f89b936753ad@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579623573; bh=Uvzt4B05OQmJx5YIIthOVUR2fp0v+T1943XGo2TTOM0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=KOVOEaWa6tJBw/qvDH79CnxVhoo0pTK2etj72MAparsNKIW4YF9lQJpjDrWRIShPl
         tA3Lhmht438lob3yBjTf5BcfqOYZQ4QpgBZqbppd/njbQYKfmJE+C7rC23EWqqmkZ1
         oyj3GaFWswvi/mSUaTBGh8vdMvrsVev7+km5ItUC65TwUoBRE3Q5rqaulRYEC832AM
         cM7SqLQNATAw1+EIA67N2bVaFo/IH8qib8nSkGm21OScgXncw+v79kd48ChTuOHkU7
         85bvRaAfeKr526AUSl6heUXI7lXWrRzvHOD5Kyye3iao5UjkI3lOSMij1v7OONUsOQ
         s+dfDWwbCw+KQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/20 7:04 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 14.01.2020 10:24, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>
> [snip]
>
>> diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-teg=
ra30.c
>> index 5732fdbe20db..53d1c48532ae 100644
>> --- a/drivers/clk/tegra/clk-tegra30.c
>> +++ b/drivers/clk/tegra/clk-tegra30.c
>> @@ -1221,9 +1221,8 @@ static struct tegra_clk_init_table init_table[] __=
initdata =3D {
>>        { TEGRA30_CLK_UARTC, TEGRA30_CLK_PLL_P, 408000000, 0 },
>>        { TEGRA30_CLK_UARTD, TEGRA30_CLK_PLL_P, 408000000, 0 },
>>        { TEGRA30_CLK_UARTE, TEGRA30_CLK_PLL_P, 408000000, 0 },
>> -     { TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 1 },
>> -     { TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 1 },
>> -     { TEGRA30_CLK_EXTERN1, TEGRA30_CLK_PLL_A_OUT0, 0, 1 },
>> +     { TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 0 },
>> +     { TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 0 },
>>        { TEGRA30_CLK_I2S0, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
>>        { TEGRA30_CLK_I2S1, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
>>        { TEGRA30_CLK_I2S2, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
>>
> What about to use the assigned-clock-rates in device-tree and thus to
> remove those PLL_A entries?

Yes clock rates can be used and also PLL rate is set based on sample=20
rate during hw_params. So this can be removed.

But PLLA clock rates are not related to this patch series and also=20
changing this needs audio function testing across all platforms and=20
currently we don't have audio functional tests in place for older platforms=
.

All audio clocks proper fixes and cleanup b/w clock driver and audio=20
driver will be done separately.

