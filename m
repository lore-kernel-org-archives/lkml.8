Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D5EC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8201D208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502621AbgDNNJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:09:23 -0400
Received: from foss.arm.com ([217.140.110.172]:55112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502606AbgDNNJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:09:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30E0130E;
        Tue, 14 Apr 2020 06:09:07 -0700 (PDT)
Received: from [10.57.33.145] (unknown [10.57.33.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B89573F73D;
        Tue, 14 Apr 2020 06:09:05 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/panfrost: add devfreq regulator support
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Steven Price <steven.price@arm.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20200411200632.4045-1-peron.clem@gmail.com>
 <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com>
 <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <729d73c5-2d2d-a2b6-7715-7293744f8f95@arm.com>
Date:   Tue, 14 Apr 2020 14:09:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-13 3:18 pm, Clément Péron wrote:
> Hi Steven,
> 
> On Mon, 13 Apr 2020 at 15:18, Steven Price <steven.price@arm.com> wrote:
>>
>> On 11/04/2020 21:06, Clément Péron wrote:
>>> OPP table can defined both frequency and voltage.
>>>
>>> Register the mali regulator if it exist.
>>>
>>> Signed-off-by: Clément Péron <peron.clem@gmail.com>
>>> ---
>>>    drivers/gpu/drm/panfrost/panfrost_devfreq.c | 34 ++++++++++++++++++---
>>>    drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
>>>    2 files changed, 31 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>>> index 62541f4edd81..2dc8e2355358 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>>> @@ -78,12 +78,26 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>>>        struct device *dev = &pfdev->pdev->dev;
>>>        struct devfreq *devfreq;
>>>        struct thermal_cooling_device *cooling;
>>> +     const char *mali = "mali";
>>> +     struct opp_table *opp_table = NULL;
>>> +
>>> +     /* Regulator is optional */
>>> +     opp_table = dev_pm_opp_set_regulators(dev, &mali, 1);
>>
>> This looks like it applies before 3e1399bccf51 ("drm/panfrost: Add
>> support for multiple regulators") which is currently in drm-misc-next
>> (and linux-next). You want something more like:
> 
> Thanks for you review, indeed I didn't see that multiple regulators
> support has been added.
> Will update in v2.

Although note that we probably also want a version that can be 
backported to stable without that dependency, since this behaviour is 
arguably a regression since 221bc77914cb ("drm/panfrost: Use generic 
code for devfreq"), and does appear to have been causing subtle problems 
for users.

Robin.
