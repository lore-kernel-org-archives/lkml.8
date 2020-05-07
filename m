Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3FEC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C052083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgEGObA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:31:00 -0400
Received: from foss.arm.com ([217.140.110.172]:60882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbgEGOac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:30:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3908D6E;
        Thu,  7 May 2020 07:30:30 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C5393F68F;
        Thu,  7 May 2020 07:30:29 -0700 (PDT)
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
 <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com>
 <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
 <CAJiuCcfa9ro1V4nBzfD48cCuHpEsLaNA5P0bb-tQ3hcWUCtpkA@mail.gmail.com>
 <000f26f4-3640-797f-c7f6-4b31a5e2669e@arm.com>
 <CAJiuCcfrMhu5Mi7YZTttw2k+hGui0GFAmOhPh_9fv4Te27M0+A@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <13285d84-5a5e-c695-2a8b-7ca50c976b90@arm.com>
Date:   Thu, 7 May 2020 15:30:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcfrMhu5Mi7YZTttw2k+hGui0GFAmOhPh_9fv4Te27M0+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2020 23:07, Clément Péron wrote:
> Hi Steven,
> 
> On Tue, 14 Apr 2020 at 15:10, Steven Price <steven.price@arm.com> wrote:
>>
>> Hi Clément,
>>
>> On 13/04/2020 18:28, Clément Péron wrote:
>>> Hi Steven,
>>>
> 
> <snip>
> 
>> Getting a backtrace from the two occurrences, I see one added from:
>>
>>     (debugfs_create_dir) from [<c04633f8>] (create_regulator+0xe0/0x220)
>>     (create_regulator) from [<c04681d8>] (_regulator_get+0x168/0x204)
>>     (_regulator_get) from [<c04682e0>] (regulator_bulk_get+0x64/0xf4)
>>     (regulator_bulk_get) from [<c04696f0>]
>> (devm_regulator_bulk_get+0x40/0x74)
>>     (devm_regulator_bulk_get) from [<bf00af44>]
>> (panfrost_device_init+0x1b4/0x48c [panfrost])
>>     (panfrost_device_init [panfrost]) from [<bf00a4d4>]
>> (panfrost_probe+0x94/0x184 [panfrost])
>>     (panfrost_probe [panfrost]) from [<c04ee694>]
>> (platform_drv_probe+0x48/0x94)
>>
>> And the other:
>>
>>     (debugfs_create_dir) from [<c04633f8>] (create_regulator+0xe0/0x220)
>>     (create_regulator) from [<c04681d8>] (_regulator_get+0x168/0x204)
>>     (_regulator_get) from [<c05c1280>] (dev_pm_opp_set_regulators+0x6c/0x184)
>>     (dev_pm_opp_set_regulators) from [<bf00b4ac>]
>> (panfrost_devfreq_init+0x38/0x1ac [panfrost])
>>     (panfrost_devfreq_init [panfrost]) from [<bf00a508>]
>> (panfrost_probe+0xc8/0x184 [panfrost])
>>     (panfrost_probe [panfrost]) from [<c04ee694>]
>> (platform_drv_probe+0x48/0x94)
>>
>> Both are created at /regulator/vdd_gpu
> 
> I'm preparing a new version with some clean from lima devfreq.
> My working branch :
> https://github.com/clementperon/linux/commits/panfrost_devfreq

I had a look at that branch and gave it a quick spin on my Firefly 
RK3288 and didn't notice any issues.

> Two strange things I observe:
>   - After 30sec the regulator is released by OPP ???
> [   33.757627] vdd-gpu: disabling
> Introduce the regulator support in this commit:
> https://github.com/clementperon/linux/commit/be310c37b82010e293b7f129ccdcb711a2abb2ce

I can't see anything wrong with this commit, but equally in my DTS I 
have a "regulator-always-on" for vdd_gpu. My initial thought was that 
this could be runtime PM of the GPU - but I can't see how 
panfrost_device_suspend() would end up turning off the regulator. So 
unless there's some way that the regulator itself suspends (but it 
should know it's in use) I've no clue why this would be happening.

Since you've got a reproduction - can you get a backtrace where the 
regulator is getting disabled?

>   - The Cooling map is not probe correctly :
> [    2.545756] panfrost 1800000.gpu: [drm:panfrost_devfreq_init
> [panfrost]] Failed to register cooling device
> Introduce in this commit :
> https://github.com/clementperon/linux/commit/0252c38fd55ad78366ac4b1714e285c88db34557
> 
> Do you have an hint about what I'm missing ?

Sorry, my knowledge of the cooling framework is very limited. What 
you've got looks plausible, but I'm afraid I can't really help beyond 
that! As before - can you try adding some printk()s in e.g. 
of_devfreq_cooling_register_power() and find out where it is bailing out?

Steve
