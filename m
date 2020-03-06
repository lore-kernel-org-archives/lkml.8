Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560A6C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334452072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCFJwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:52:06 -0500
Received: from foss.arm.com ([217.140.110.172]:58704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbgCFJwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:52:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FAB331B;
        Fri,  6 Mar 2020 01:52:05 -0800 (PST)
Received: from [192.168.1.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 693DB3F6C4;
        Fri,  6 Mar 2020 01:52:03 -0800 (PST)
Subject: Re: [PATCH] drm: komeda: Make rt_pm_ops dependent on CONFIG_PM
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20200304145412.33936-1-vincenzo.frascino@arm.com>
 <20200305184255.GH364558@e110455-lin.cambridge.arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <be7a17bf-86f8-a086-9783-3f4a211cf9e3@arm.com>
Date:   Fri, 6 Mar 2020 09:52:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200305184255.GH364558@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liviu,

On 3/5/20 6:42 PM, Liviu Dudau wrote:
> On Wed, Mar 04, 2020 at 02:54:12PM +0000, Vincenzo Frascino wrote:
>> komeda_rt_pm_suspend() and komeda_rt_pm_resume() are compiled only when
>> CONFIG_PM is enabled. Having it disabled triggers the following warning
>> at compile time:
>>
>> linux/drivers/gpu/drm/arm/display/komeda/komeda_drv.c:156:12:
>> warning: ‘komeda_rt_pm_resume’ defined but not used [-Wunused-function]
>>  static int komeda_rt_pm_resume(struct device *dev)
>>             ^~~~~~~~~~~~~~~~~~~
>> linux/drivers/gpu/drm/arm/display/komeda/komeda_drv.c:149:12:
>> warning: ‘komeda_rt_pm_suspend’ defined but not used [-Wunused-function]
>>  static int komeda_rt_pm_suspend(struct device *dev)
>>
>> Make komeda_rt_pm_suspend() and komeda_rt_pm_resume() dependent on
>> CONFIG_PM to address the issue.
>>
>> Cc: "James (Qian) Wang" <james.qian.wang@arm.com>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Mihail Atanassov <mihail.atanassov@arm.com>
>> Cc: Brian Starkey <brian.starkey@arm.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Thanks for the patch, I will push it into drm-misc-fixes tomorrow.
> 

Thank you!

> Best regards,
> Liviu
> 
>> ---
>>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
>> index ea5cd1e17304..dd3ae3d88687 100644
>> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
>> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
>> @@ -146,6 +146,7 @@ static const struct of_device_id komeda_of_match[] = {
>>  
>>  MODULE_DEVICE_TABLE(of, komeda_of_match);
>>  
>> +#ifdef CONFIG_PM
>>  static int komeda_rt_pm_suspend(struct device *dev)
>>  {
>>  	struct komeda_drv *mdrv = dev_get_drvdata(dev);
>> @@ -159,6 +160,7 @@ static int komeda_rt_pm_resume(struct device *dev)
>>  
>>  	return komeda_dev_resume(mdrv->mdev);
>>  }
>> +#endif /* CONFIG_PM */
>>  
>>  static int __maybe_unused komeda_pm_suspend(struct device *dev)
>>  {
>> -- 
>> 2.25.1
>>
> 

-- 
Regards,
Vincenzo
