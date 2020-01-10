Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D888DC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8AA2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jZ7LmOgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbgAJBjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:39:16 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3544 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbgAJBjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 20:39:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e17d5b00000>; Thu, 09 Jan 2020 17:38:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Jan 2020 17:39:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Jan 2020 17:39:14 -0800
Received: from [10.110.103.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 01:39:14 +0000
Subject: Re: [PATCH v7 00/21] Move PMC clocks into Tegra PMC driver
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
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <61a78ba8-4cc3-f6a6-513b-36daa9be32f0@nvidia.com>
Date:   Thu, 9 Jan 2020 17:39:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4e9fab30-14b5-bf1f-dc91-fd57ef614503@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578620336; bh=TEyph305SGFKLXuFDQSfRRNPpBb2Qcw+rzGH7+g9RCM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=jZ7LmOgJ3X9CqsuPrT4gbvHXep3nztWX+cwqZ29zspMGe6q3dn9fx4ZQUzcrOzAXI
         G1zboO/l/IhLIq0oWM8juJqyZp30lJ1T6O7Ma0OfP/2C4bxwtIYgm7tu31Zb7mgEbL
         DwTrUY3xLhSvopL3m4Sl+kurq00qd8lrzKCEry4ce5lte+kN+pqasukdT/vmM/I6Iy
         GXTmEKyfKuCcYAxDjw8mj13McuN25q+ZYsLYPlPRkW8bwcQbk1RFUSQolIX54VjPId
         ZzVGCX1DP/+jtgwzdDO8MWKMx9TMR80iJ2swRXP3bHFqjI8zz0Rr1Vb1NdI7q/y/IS
         dFn/Yc9tZcGrA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/20 11:44 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 08.01.2020 07:24, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> This patch series moves Tegra PMC clocks from clock driver to pmc driver
>> along with the device trees changes and audio driver which uses one of
>> the pmc clock for audio mclk.
>>
>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
>> are currently registered by Tegra clock driver using clk_regiser_mux and
>> clk_register_gate which performs direct Tegra PMC register access.
>>
>> When Tegra PMC is in secure mode, any access from non-secure world will
>> not go through.
>>
>> This patch series adds these Tegra PMC clocks and blink controls to Tegr=
a
>> PMC driver with PMC as clock provider and removes them from Tegra clock
>> driver.
>>
>> PMC clock clk_out_1 is dedicated for audio mclk from Tegra30 thru Tegra2=
10
>> and clock driver does inital parent configuration for it and enables the=
m.
>> But this clock should be taken care by audio driver as there is no need
>> to have this clock pre enabled.
>>
>> So, this series also includes patch that updates ASoC driver to take
>> care of parent configuration for mclk if device tree don't specify
>> initial parent configuration using assigned-clock-parents and controls
>> audio mclk enable/disable during ASoC machine startup and shutdown.
>>
>> DTs are also updated to use clk_out_1 as audio mclk rather than extern1.
>>
>> This series also includes a patch for mclk fallback to extern1 when
>> retrieving mclk fails to have this backward compatible of new DT with
>> old kernels.
> Suspend-resume doesn't work anymore, reverting this series helps. I
> don't have any other information yet, please take a look.
Thanks Dmitry. Will test suspend resume and check..
