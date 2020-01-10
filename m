Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37421C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 04:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1DA2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 04:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LKiCtw88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgAJEgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 23:36:25 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10788 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbgAJEgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 23:36:24 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e17ff350001>; Thu, 09 Jan 2020 20:36:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 09 Jan 2020 20:36:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 09 Jan 2020 20:36:23 -0800
Received: from [10.2.166.245] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 04:36:22 +0000
Subject: Re: [PATCH v7 00/21] Move PMC clocks into Tegra PMC driver
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
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
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <4e9fab30-14b5-bf1f-dc91-fd57ef614503@gmail.com>
 <61a78ba8-4cc3-f6a6-513b-36daa9be32f0@nvidia.com>
 <37a9676b-e0e5-7e80-5ee4-abfca361dcf7@nvidia.com>
 <62751d2d-2b7d-509b-e236-363d2bb29b02@nvidia.com>
Message-ID: <880b2e8a-aa55-40f3-7502-24392b88e53f@nvidia.com>
Date:   Thu, 9 Jan 2020 20:36:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <62751d2d-2b7d-509b-e236-363d2bb29b02@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578630965; bh=pFDMfq1B5n9eh51DXIzqtsvr/BTUfsiR/lTtj+CyAa4=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=LKiCtw88QrOqfhMrLfhm5+aOR0dwNi4aDcndsHAzJR1VeXsAxjeXbUgb+dpskMcjj
         GN/wqgszl8e/R6w2vmqP+2ys0KSNaq4PBFeaw5C+5LXRz9iRlh/1RankoPWVmbePQe
         ghLqooGNfCqzFxFJRZNnGd/s4EekFWrzAFtU3R+ejegZ+Zjk1mCWrklk/FzLABCz+T
         i4pQkPoY66JgKLKncbNKv8pbUkNvV8wMNIOkoUTkHNczRM2bqoKcr6jq0RKjLQVSju
         JcM1sdvate2sw3+L5/Y+6xYc0zbicwgVUozaBbO7e1Wqa1KN8KakNGq90q3SZ7Y4gO
         wfwyFAj3aVrRA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/20 7:32 PM, Sowjanya Komatineni wrote:
>
> On 1/9/20 7:24 PM, Sowjanya Komatineni wrote:
>>
>> On 1/9/20 5:39 PM, Sowjanya Komatineni wrote:
>>>
>>> On 1/9/20 11:44 AM, Dmitry Osipenko wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> 08.01.2020 07:24, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> This patch series moves Tegra PMC clocks from clock driver to pmc=20
>>>>> driver
>>>>> along with the device trees changes and audio driver which uses=20
>>>>> one of
>>>>> the pmc clock for audio mclk.
>>>>>
>>>>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls=20
>>>>> which
>>>>> are currently registered by Tegra clock driver using=20
>>>>> clk_regiser_mux and
>>>>> clk_register_gate which performs direct Tegra PMC register access.
>>>>>
>>>>> When Tegra PMC is in secure mode, any access from non-secure world=20
>>>>> will
>>>>> not go through.
>>>>>
>>>>> This patch series adds these Tegra PMC clocks and blink controls=20
>>>>> to Tegra
>>>>> PMC driver with PMC as clock provider and removes them from Tegra=20
>>>>> clock
>>>>> driver.
>>>>>
>>>>> PMC clock clk_out_1 is dedicated for audio mclk from Tegra30 thru=20
>>>>> Tegra210
>>>>> and clock driver does inital parent configuration for it and=20
>>>>> enables them.
>>>>> But this clock should be taken care by audio driver as there is no=20
>>>>> need
>>>>> to have this clock pre enabled.
>>>>>
>>>>> So, this series also includes patch that updates ASoC driver to take
>>>>> care of parent configuration for mclk if device tree don't specify
>>>>> initial parent configuration using assigned-clock-parents and=20
>>>>> controls
>>>>> audio mclk enable/disable during ASoC machine startup and shutdown.
>>>>>
>>>>> DTs are also updated to use clk_out_1 as audio mclk rather than=20
>>>>> extern1.
>>>>>
>>>>> This series also includes a patch for mclk fallback to extern1 when
>>>>> retrieving mclk fails to have this backward compatible of new DT with
>>>>> old kernels.
>>>> Suspend-resume doesn't work anymore, reverting this series helps. I
>>>> don't have any other information yet, please take a look.
>>> Thanks Dmitry. Will test suspend resume and check..
>>
>> I see if we leave audio mclk (cdev1) enabled during=20
>> tegra_asoc_utils_init, suspend resume works.
>>
>> Without audio mclk enabled during tegra_asoc_utils_init, somehow it=20
>> prevents entry to suspend on Tegra30 platform.
>>
>> Will look in detail..
>>
> audio mclk is only needed for audio and werid that having it not=20
> enabled all the time like in current clock driver prevents suspend=20
> entry on Tegra30
>
> Looks like this issue is masked earlier with having mclk enabled all=20
> the time by clock driver.
>
On linux-next without this patch series, I just disabled mclk to be=20
enabled all the time (removed set_rate from utils_init) and also=20
disabled default enable from clock driver.

So somehow disabling mclk is preventing suspend entry.

Probably debugging suspend issue on Tegra30 when audio mclk is disabled=20
can be done separately and will keep audio mclk enabled in=20
asoc_utils_init with comment mentioning this issue and fix as TBD to=20
move on with PMC clock fixes.



