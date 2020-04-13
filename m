Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E26C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A9420656
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbgDMPzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:55:15 -0400
Received: from foss.arm.com ([217.140.110.172]:42604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730923AbgDMPzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:55:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 022341FB;
        Mon, 13 Apr 2020 08:55:09 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C73EA3F68F;
        Mon, 13 Apr 2020 08:55:07 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/panfrost: add devfreq regulator support
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200411200632.4045-1-peron.clem@gmail.com>
 <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com>
 <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
 <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com>
Date:   Mon, 13 Apr 2020 16:55:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2020 15:31, Clément Péron wrote:
> Hi,
> 
> On Mon, 13 Apr 2020 at 16:18, Clément Péron <peron.clem@gmail.com> wrote:
>>
>> Hi Steven,
>>
>> On Mon, 13 Apr 2020 at 15:18, Steven Price <steven.price@arm.com> wrote:
>>>
>>> On 11/04/2020 21:06, Clément Péron wrote:
>>>> OPP table can defined both frequency and voltage.
>>>>
>>>> Register the mali regulator if it exist.
>>>>
>>>> Signed-off-by: Clément Péron <peron.clem@gmail.com>
>>>> ---
>>>>    drivers/gpu/drm/panfrost/panfrost_devfreq.c | 34 ++++++++++++++++++---
>>>>    drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
>>>>    2 files changed, 31 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>>>> index 62541f4edd81..2dc8e2355358 100644
>>>> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>>>> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>>>> @@ -78,12 +78,26 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>>>>        struct device *dev = &pfdev->pdev->dev;
>>>>        struct devfreq *devfreq;
>>>>        struct thermal_cooling_device *cooling;
>>>> +     const char *mali = "mali";
>>>> +     struct opp_table *opp_table = NULL;
>>>> +
>>>> +     /* Regulator is optional */
>>>> +     opp_table = dev_pm_opp_set_regulators(dev, &mali, 1);
>>>
>>> This looks like it applies before 3e1399bccf51 ("drm/panfrost: Add
>>> support for multiple regulators") which is currently in drm-misc-next
>>> (and linux-next). You want something more like:
>>
>> Thanks for you review, indeed I didn't see that multiple regulators
>> support has been added.
>> Will update in v2.
>>
>>>
>>>       opp_table = dev_pm_opp_set_regulators(dev,
>>>                                             pfdev->comp->supply_names,
>>>                                             pfdev->comp->num_supplies);
>>>
>>> Otherwise a platform with multiple regulators won't work correctly.
>>>
>>> Also running on my firefly (RK3288) board I get the following warning:
>>>
>>>      debugfs: Directory 'ffa30000.gpu-mali' with parent 'vdd_gpu' already
>>> present!
>>>
>>> This is due to the regulator debugfs entries getting created twice (once
>>> in panfrost_regulator_init() and once here).
>>
>> Is it a warning that should be consider as an error? Look's more an info no?
>> What should be the correct behavior if a device want to register two
>> times the same regulator?
> 
> Or we can change the name from vdd_XXX to opp_vdd_XXX ?
> https://elixir.bootlin.com/linux/latest/source/drivers/opp/debugfs.c#L45

Yes, I'm not sure that it's actually a problem in practice. And it may 
well be correct to change this in the generic code rather than try to 
work around it in Panfrost. But we shouldn't spam the user with warnings 
as that makes real issues harder to see.

Your suggestion to change the name seems reasonable to me, but I don't 
fully understand the opp code, so we'd need some review from the OPP 
maintainers. Hopefully Viresh, Nishanth or Stephen can provide some insight.

Steve
