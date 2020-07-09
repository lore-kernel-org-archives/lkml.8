Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C040C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125032078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgGIP71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:59:27 -0400
Received: from foss.arm.com ([217.140.110.172]:38296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgGIP71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:59:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4C5131B;
        Thu,  9 Jul 2020 08:59:26 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 048743F792;
        Thu,  9 Jul 2020 08:59:24 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: fix ref count leak in
 panfrost_job_hw_submit
To:     Rob Herring <robh@kernel.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>, wu000273@umn.edu,
        kjlu@umn.edu, Stephen McCamant <smccaman@umn.edu>
References: <20200614062730.46489-1-navid.emamdoost@gmail.com>
 <CAL_JsqL=+ToP1w3m8GdK0K0o8ER2eYSiM5ffuFVxyMsZns4gqA@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <30c2031a-4975-43d0-c8ca-8664969e5df3@arm.com>
Date:   Thu, 9 Jul 2020 16:59:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL=+ToP1w3m8GdK0K0o8ER2eYSiM5ffuFVxyMsZns4gqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2020 16:44, Rob Herring wrote:
> On Sun, Jun 14, 2020 at 12:27 AM Navid Emamdoost
> <navid.emamdoost@gmail.com> wrote:
>>
>> in panfrost_job_hw_submit, pm_runtime_get_sync is called which
>> increments the counter even in case of failure, leading to incorrect
>> ref count. In case of failure, decrement the ref count before returning.
>>
>> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>> ---
>>   drivers/gpu/drm/panfrost/panfrost_job.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
>> index 7914b1570841..89ac84667eb1 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
>> @@ -147,11 +147,10 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>>
>>          ret = pm_runtime_get_sync(pfdev->dev);
>>          if (ret < 0)
>> -               return;
>> +               goto out;
> 
> If the get failed, I don't think we want to do a put.

The pm_runtime_get_sync() does actually always increment the reference 
(even when returning a failure), but actually I don't think we want it 
here anyway, as I think I explained before[1].
  [1] 
https://lore.kernel.org/dri-devel/272650ba-2c44-9084-7829-b04023eba723@arm.com
> 
>>
>>          if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
>> -               pm_runtime_put_sync_autosuspend(pfdev->dev);

This is a correct change - we don't want the put here. (Although this 
should never happen).

>> -               return;
>> +               goto out;
>>          }
>>
>>          cfg = panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
>> @@ -184,6 +183,9 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>>                                  job, js, jc_head);
>>
>>          job_write(pfdev, JS_COMMAND_NEXT(js), JS_COMMAND_START);
> 
> So we start the job here and then...
> 
>> +out:
>> +       pm_runtime_put_sync_autosuspend(pfdev->dev);
> 
> ...turn off clocks/power here. Typically, you'd be fine as autosuspend
> has a delay by default, but userspace is free to change the delay to
> 0.
> 
>> +       return;

A return at the end of the function with no argument is pointless.

Steve

>>   }
>>
>>   static void panfrost_acquire_object_fences(struct drm_gem_object **bos,
>> --
>> 2.17.1
>>

