Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E396C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010B3207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbgE1NWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:22:54 -0400
Received: from foss.arm.com ([217.140.110.172]:52562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390281AbgE1NWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:22:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F078D6E;
        Thu, 28 May 2020 06:22:45 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1028C3F52E;
        Thu, 28 May 2020 06:22:43 -0700 (PDT)
Subject: Re: [PATCH 04/15] drm/panfrost: introduce panfrost_devfreq struct
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200510165538.19720-1-peron.clem@gmail.com>
 <20200510165538.19720-5-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <1fe4ae0b-a861-d36b-db5b-755b05e44e29@arm.com>
Date:   Thu, 28 May 2020 14:22:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510165538.19720-5-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2020 17:55, Clément Péron wrote:
> Introduce a proper panfrost_devfreq to deal with devfreq variables.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 76 ++++++++++++---------
>   drivers/gpu/drm/panfrost/panfrost_devfreq.h | 20 +++++-
>   drivers/gpu/drm/panfrost/panfrost_device.h  | 11 +--
>   drivers/gpu/drm/panfrost/panfrost_job.c     |  6 +-
>   4 files changed, 66 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index df7b71da9a84..962550363391 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -10,23 +10,23 @@
>   #include "panfrost_device.h"
>   #include "panfrost_devfreq.h"
>   
> -static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev)
> +static void panfrost_devfreq_update_utilization(struct panfrost_devfreq *pfdevfreq)
>   {
>   	ktime_t now;
>   	ktime_t last;
>   
> -	if (!pfdev->devfreq.devfreq)
> +	if (!pfdevfreq->devfreq)
>   		return;
>   
>   	now = ktime_get();
> -	last = pfdev->devfreq.time_last_update;
> +	last = pfdevfreq->time_last_update;
>   
> -	if (atomic_read(&pfdev->devfreq.busy_count) > 0)
> -		pfdev->devfreq.busy_time += ktime_sub(now, last);
> +	if (atomic_read(&pfdevfreq->busy_count) > 0)
> +		pfdevfreq->busy_time += ktime_sub(now, last);
>   	else
> -		pfdev->devfreq.idle_time += ktime_sub(now, last);
> +		pfdevfreq->idle_time += ktime_sub(now, last);
>   
> -	pfdev->devfreq.time_last_update = now;
> +	pfdevfreq->time_last_update = now;
>   }
>   
>   static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
> @@ -47,30 +47,31 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
>   	return 0;
>   }
>   
> -static void panfrost_devfreq_reset(struct panfrost_device *pfdev)
> +static void panfrost_devfreq_reset(struct panfrost_devfreq *pfdevfreq)
>   {
> -	pfdev->devfreq.busy_time = 0;
> -	pfdev->devfreq.idle_time = 0;
> -	pfdev->devfreq.time_last_update = ktime_get();
> +	pfdevfreq->busy_time = 0;
> +	pfdevfreq->idle_time = 0;
> +	pfdevfreq->time_last_update = ktime_get();
>   }
>   
>   static int panfrost_devfreq_get_dev_status(struct device *dev,
>   					   struct devfreq_dev_status *status)
>   {
>   	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> +	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
>   
> -	panfrost_devfreq_update_utilization(pfdev);
> +	panfrost_devfreq_update_utilization(pfdevfreq);
>   
>   	status->current_frequency = clk_get_rate(pfdev->clock);
> -	status->total_time = ktime_to_ns(ktime_add(pfdev->devfreq.busy_time,
> -						   pfdev->devfreq.idle_time));
> +	status->total_time = ktime_to_ns(ktime_add(pfdevfreq->busy_time,
> +						   pfdevfreq->idle_time));
>   
> -	status->busy_time = ktime_to_ns(pfdev->devfreq.busy_time);
> +	status->busy_time = ktime_to_ns(pfdevfreq->busy_time);
>   
> -	panfrost_devfreq_reset(pfdev);
> +	panfrost_devfreq_reset(pfdevfreq);
>   
> -	dev_dbg(pfdev->dev, "busy %lu total %lu %lu %% freq %lu MHz\n", status->busy_time,
> -		status->total_time,
> +	dev_dbg(pfdev->dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
> +		status->busy_time, status->total_time,
>   		status->busy_time / (status->total_time / 100),
>   		status->current_frequency / 1000 / 1000);
>   
> @@ -91,6 +92,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	struct device *dev = &pfdev->pdev->dev;
>   	struct devfreq *devfreq;
>   	struct thermal_cooling_device *cooling;
> +	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
>   
>   	ret = dev_pm_opp_of_add_table(dev);
>   	if (ret == -ENODEV) /* Optional, continue without devfreq */
> @@ -98,7 +100,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	else if (ret)
>   		return ret;
>   
> -	panfrost_devfreq_reset(pfdev);
> +	panfrost_devfreq_reset(pfdevfreq);
>   
>   	cur_freq = clk_get_rate(pfdev->clock);
>   
> @@ -116,53 +118,59 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   		dev_pm_opp_of_remove_table(dev);
>   		return PTR_ERR(devfreq);
>   	}
> -	pfdev->devfreq.devfreq = devfreq;
> +	pfdevfreq->devfreq = devfreq;
>   
>   	cooling = of_devfreq_cooling_register(dev->of_node, devfreq);
>   	if (IS_ERR(cooling))
>   		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
>   	else
> -		pfdev->devfreq.cooling = cooling;
> +		pfdevfreq->cooling = cooling;
>   
>   	return 0;
>   }
>   
>   void panfrost_devfreq_fini(struct panfrost_device *pfdev)
>   {
> -	if (pfdev->devfreq.cooling)
> -		devfreq_cooling_unregister(pfdev->devfreq.cooling);
> +	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
> +
> +	if (pfdevfreq->cooling)
> +		devfreq_cooling_unregister(pfdevfreq->cooling);
>   	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
>   }
>   
>   void panfrost_devfreq_resume(struct panfrost_device *pfdev)
>   {
> -	if (!pfdev->devfreq.devfreq)
> +	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
> +
> +	if (!pfdevfreq->devfreq)
>   		return;
>   
> -	panfrost_devfreq_reset(pfdev);
> +	panfrost_devfreq_reset(pfdevfreq);
>   
> -	devfreq_resume_device(pfdev->devfreq.devfreq);
> +	devfreq_resume_device(pfdevfreq->devfreq);
>   }
>   
>   void panfrost_devfreq_suspend(struct panfrost_device *pfdev)
>   {
> -	if (!pfdev->devfreq.devfreq)
> +	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
> +
> +	if (!pfdevfreq->devfreq)
>   		return;
>   
> -	devfreq_suspend_device(pfdev->devfreq.devfreq);
> +	devfreq_suspend_device(pfdevfreq->devfreq);
>   }
>   
> -void panfrost_devfreq_record_busy(struct panfrost_device *pfdev)
> +void panfrost_devfreq_record_busy(struct panfrost_devfreq *pfdevfreq)
>   {
> -	panfrost_devfreq_update_utilization(pfdev);
> -	atomic_inc(&pfdev->devfreq.busy_count);
> +	panfrost_devfreq_update_utilization(pfdevfreq);
> +	atomic_inc(&pfdevfreq->busy_count);
>   }
>   
> -void panfrost_devfreq_record_idle(struct panfrost_device *pfdev)
> +void panfrost_devfreq_record_idle(struct panfrost_devfreq *pfdevfreq)
>   {
>   	int count;
>   
> -	panfrost_devfreq_update_utilization(pfdev);
> -	count = atomic_dec_if_positive(&pfdev->devfreq.busy_count);
> +	panfrost_devfreq_update_utilization(pfdevfreq);
> +	count = atomic_dec_if_positive(&pfdevfreq->busy_count);
>   	WARN_ON(count < 0);
>   }
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> index 0611beffc8d0..0697f8d5aa34 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> @@ -4,13 +4,29 @@
>   #ifndef __PANFROST_DEVFREQ_H__
>   #define __PANFROST_DEVFREQ_H__
>   
> +#include <linux/ktime.h>
> +
> +struct devfreq;
> +struct thermal_cooling_device;
> +
> +struct panfrost_device;
> +
> +struct panfrost_devfreq {
> +	struct devfreq *devfreq;
> +	struct thermal_cooling_device *cooling;
> +	ktime_t busy_time;
> +	ktime_t idle_time;
> +	ktime_t time_last_update;
> +	atomic_t busy_count;
> +};
> +
>   int panfrost_devfreq_init(struct panfrost_device *pfdev);
>   void panfrost_devfreq_fini(struct panfrost_device *pfdev);
>   
>   void panfrost_devfreq_resume(struct panfrost_device *pfdev);
>   void panfrost_devfreq_suspend(struct panfrost_device *pfdev);
>   
> -void panfrost_devfreq_record_busy(struct panfrost_device *pfdev);
> -void panfrost_devfreq_record_idle(struct panfrost_device *pfdev);
> +void panfrost_devfreq_record_busy(struct panfrost_devfreq *devfreq);
> +void panfrost_devfreq_record_idle(struct panfrost_devfreq *devfreq);
>   
>   #endif /* __PANFROST_DEVFREQ_H__ */
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index c30c719a8059..2efa59c9d1c5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -13,6 +13,8 @@
>   #include <drm/drm_mm.h>
>   #include <drm/gpu_scheduler.h>
>   
> +#include "panfrost_devfreq.h"
> +
>   struct panfrost_device;
>   struct panfrost_mmu;
>   struct panfrost_job_slot;
> @@ -107,14 +109,7 @@ struct panfrost_device {
>   	struct list_head shrinker_list;
>   	struct shrinker shrinker;
>   
> -	struct {
> -		struct devfreq *devfreq;
> -		struct thermal_cooling_device *cooling;
> -		ktime_t busy_time;
> -		ktime_t idle_time;
> -		ktime_t time_last_update;
> -		atomic_t busy_count;
> -	} devfreq;
> +	struct panfrost_devfreq pfdevfreq;
>   };
>   
>   struct panfrost_mmu {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 63e32a9f2749..a67f3eac6a58 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -155,7 +155,7 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>   	}
>   
>   	cfg = panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
> -	panfrost_devfreq_record_busy(pfdev);
> +	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
>   
>   	job_write(pfdev, JS_HEAD_NEXT_LO(js), jc_head & 0xFFFFFFFF);
>   	job_write(pfdev, JS_HEAD_NEXT_HI(js), jc_head >> 32);
> @@ -415,7 +415,7 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
>   	}
>   	spin_unlock_irqrestore(&pfdev->js->job_lock, flags);
>   
> -	panfrost_devfreq_record_idle(pfdev);
> +	panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
>   	panfrost_device_reset(pfdev);
>   
>   	for (i = 0; i < NUM_JOB_SLOTS; i++)
> @@ -478,7 +478,7 @@ static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
>   				pfdev->jobs[j] = NULL;
>   
>   				panfrost_mmu_as_put(pfdev, &job->file_priv->mmu);
> -				panfrost_devfreq_record_idle(pfdev);
> +				panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
>   
>   				dma_fence_signal_locked(job->done_fence);
>   				pm_runtime_put_autosuspend(pfdev->dev);
> 

