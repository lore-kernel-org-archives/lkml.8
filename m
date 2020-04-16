Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EF4C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808F020786
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392918AbgDPOD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:03:58 -0400
Received: from foss.arm.com ([217.140.110.172]:32874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgDPNmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:42:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6F8C1FB;
        Thu, 16 Apr 2020 06:42:17 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68A253F68F;
        Thu, 16 Apr 2020 06:42:15 -0700 (PDT)
Subject: Re: Multiple regulators for one device [was drm/panfrost: add devfreq
 regulator support]
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
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
 <CAJiuCccF3tmbmMWNh0nC5WRJ1_iPdj6f1oH1zYMSue_pFrXsPQ@mail.gmail.com>
 <20200414185523.GO5412@sirena.org.uk>
 <CAJiuCce5ekAed6RF8+x_ehruCXW3900wkFNKRXN_Xo_62MPXew@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <5e15e7ac-1d9c-d614-8fd9-27525c88cafb@arm.com>
Date:   Thu, 16 Apr 2020 14:42:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCce5ekAed6RF8+x_ehruCXW3900wkFNKRXN_Xo_62MPXew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2020 20:16, Clément Péron wrote:
> Hi Mark,
> 
> On Tue, 14 Apr 2020 at 20:55, Mark Brown <broonie@kernel.org> wrote:
>>
>> On Tue, Apr 14, 2020 at 08:20:23PM +0200, Clément Péron wrote:
>>> Hi Liam and Mark,
>>
>> You might want to flag stuff like this in the subject line, I very
>> nearly deleted this without opening it since most of the email I get
>> about panfrost appears to be coming from me having sent patches rather
>> than being relevant.
> 
> Ok will do next time,
> 
>>
>>> We are having an issue with Panfrost driver registering two times the
>>> same regulator and giving an error when trying to create the debugfs
>>> folder.
>>
>>> Could you clarify if it is allowed for a device to register two times
>>> the same regulator?
>>
>>> I check Documentation/power/regulator/regulator.rst but this point is
>>> not specified.
>>
>> We don't actively prevent it and I can't think what other than debugfs
>> might run into problems (and that's just a warning) but it does seem
>> like a weird thing to want to do and like it's pointing to some
>> confusion in your code with two different parts of the device
>> controlling the same supply independently.  What's the use case here?
> 
> Panfrost first probe clock, reset and regulator in device_init:
> https://elixir.bootlin.com/linux/v5.7-rc1/source/drivers/gpu/drm/panfrost/panfrost_drv.c#L602
> Then it probe for optional devfreq, devfreq will get opp tables and
> also get regulator again.
> https://elixir.bootlin.com/linux/v5.7-rc1/source/drivers/gpu/drm/panfrost/panfrost_drv.c#L609
> 
> That's can be reworked and Panfrost can only probe regulator if there
> is no opp-table.

This is what I was thinking about looking at. But it may make sense 
instead to extend the regulator API to allow multiple regualtor_get() 
calls for a single device. I haven't had time to dig into how difficult 
this would be.

> But if multiple regulator is not an issue and as each request is logic.
> The first in device_init assure to enable the regulator and the second
> in OPP assure the voltage level.
> 
> Maybe we can just fix this warning?

 From what I can see in the code, just silencing the warning would lead 
to 'odd' behaviour with debugfs. The first struct regulator Panfrost 
acquires is the one that is used purely for turning the GPU on (no 
voltage scaling). The second struct regulator is the one which is 
obtained by the OPP framework. However the debugfs entries point into 
the actual struct regulator, so it would be far more logical/useful if 
those were pointing into the second struct regulator.

Ideally calling regulator_get a second time for the same device would 
simply return the same struct regulator object (with a reference count 
increment).

Perhaps a better approach would be for Panfrost to hand over the struct 
regulator objects it has already got to the OPP framework. I.e. open 
code dev_pm_opp_set_regulators(), but instead of calling 
regulator_get_optional() simply populate the regulators we already have?

The other benefit of that is it would provide a clear hand-over of 
responsibility between Panfrost handling it's own regulators and the OPP 
framework picking up the work. The disadvantage is that Panfrost would 
have to track whether the regulators have been handed over or not.

Steve
