Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496C1C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC1020709
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RdwJnl4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgAJDcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 22:32:11 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16554 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbgAJDcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 22:32:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e17f0060000>; Thu, 09 Jan 2020 19:31:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Jan 2020 19:32:09 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Jan 2020 19:32:09 -0800
Received: from [10.2.166.245] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 03:32:07 +0000
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
Message-ID: <62751d2d-2b7d-509b-e236-363d2bb29b02@nvidia.com>
Date:   Thu, 9 Jan 2020 19:32:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <37a9676b-e0e5-7e80-5ee4-abfca361dcf7@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578627079; bh=h+UK0T0ZVoq0xlRJgSEmpib8ESf+rXQ95WyAK46QTis=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=RdwJnl4St7LW5RgLOTnTJzx7marVTEg5gBkDL5je4bCIpErjkEECgt74tcuUIV7xj
         AMquKzInk/UBSYXTInphlHW3tm3N6CDNDLOYBNeHnH7CG02uMU2ZQOPq0NvdbLjSmp
         PTIXdFLTCx0vtXfKDRKJcaIpyLZhVsargsilGQS8/ASADPwMK6ZtfvIhKXowHiLzBS
         b6R11TGDsHjqjD6e8KR47qe1D/1uwMnH1MsREsrfAeeM3/BKcrt0mSPDXiBlxpm6hH
         8yHwU0e5sepSvC8LRGKxJsF22wM7R4tUGq1PLHDrj/JHdpeJte6/3X6KP2R9aXkTlZ
         O0qZR+YvJKVHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/20 7:24 PM, Sowjanya Komatineni wrote:
>
> On 1/9/20 5:39 PM, Sowjanya Komatineni wrote:
>>
>> On 1/9/20 11:44 AM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 08.01.2020 07:24, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> This patch series moves Tegra PMC clocks from clock driver to pmc=20
>>>> driver
>>>> along with the device trees changes and audio driver which uses one of
>>>> the pmc clock for audio mclk.
>>>>
>>>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
>>>> are currently registered by Tegra clock driver using=20
>>>> clk_regiser_mux and
>>>> clk_register_gate which performs direct Tegra PMC register access.
>>>>
>>>> When Tegra PMC is in secure mode, any access from non-secure world=20
>>>> will
>>>> not go through.
>>>>
>>>> This patch series adds these Tegra PMC clocks and blink controls to=20
>>>> Tegra
>>>> PMC driver with PMC as clock provider and removes them from Tegra=20
>>>> clock
>>>> driver.
>>>>
>>>> PMC clock clk_out_1 is dedicated for audio mclk from Tegra30 thru=20
>>>> Tegra210
>>>> and clock driver does inital parent configuration for it and=20
>>>> enables them.
>>>> But this clock should be taken care by audio driver as there is no=20
>>>> need
>>>> to have this clock pre enabled.
>>>>
>>>> So, this series also includes patch that updates ASoC driver to take
>>>> care of parent configuration for mclk if device tree don't specify
>>>> initial parent configuration using assigned-clock-parents and controls
>>>> audio mclk enable/disable during ASoC machine startup and shutdown.
>>>>
>>>> DTs are also updated to use clk_out_1 as audio mclk rather than=20
>>>> extern1.
>>>>
>>>> This series also includes a patch for mclk fallback to extern1 when
>>>> retrieving mclk fails to have this backward compatible of new DT with
>>>> old kernels.
>>> Suspend-resume doesn't work anymore, reverting this series helps. I
>>> don't have any other information yet, please take a look.
>> Thanks Dmitry. Will test suspend resume and check..
>
> I see if we leave audio mclk (cdev1) enabled during=20
> tegra_asoc_utils_init, suspend resume works.
>
> Without audio mclk enabled during tegra_asoc_utils_init, somehow it=20
> prevents entry to suspend on Tegra30 platform.
>
> Will look in detail..
>
audio mclk is only needed for audio and werid that having it not enabled=20
all the time like in current clock driver prevents suspend entry on Tegra30

Looks like this issue is masked earlier with having mclk enabled all the=20
time by clock driver.

