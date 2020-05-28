Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63661C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1532084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbgE1NW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:22:58 -0400
Received: from foss.arm.com ([217.140.110.172]:52582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390288AbgE1NWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:22:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36548D6E;
        Thu, 28 May 2020 06:22:48 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFDF83F52E;
        Thu, 28 May 2020 06:22:46 -0700 (PDT)
Subject: Re: [PATCH 05/15] drm/panfrost: use spinlock instead of atomic
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
 <20200510165538.19720-6-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <20155d49-fa2b-722e-9e9e-789838c07b61@arm.com>
Date:   Thu, 28 May 2020 14:22:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510165538.19720-6-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2020 17:55, Clément Péron wrote:
> Convert busy_count to a simple int protected by spinlock.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Looks like a fairly mechanical cleanup.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 43 +++++++++++++++------
>   drivers/gpu/drm/panfrost/panfrost_devfreq.h | 10 ++++-
>   2 files changed, 41 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 962550363391..78753cfb59fb 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -12,16 +12,12 @@
>   
>   static void panfrost_devfreq_update_utilization(struct panfrost_devfreq *pfdevfreq)
>   {
> -	ktime_t now;
> -	ktime_t last;
> -
> -	if (!pfdevfreq->devfreq)
> -		return;
> +	ktime_t now, last;
>   
>   	now = ktime_get();
>   	last = pfdevfreq->time_last_update;
>   
> -	if (atomic_read(&pfdevfreq->busy_count) > 0)
> +	if (pfdevfreq->busy_count > 0)
>   		pfdevfreq->busy_time += ktime_sub(now, last);
>   	else
>   		pfdevfreq->idle_time += ktime_sub(now, last);
> @@ -59,10 +55,14 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
>   {
>   	struct panfrost_device *pfdev = dev_get_drvdata(dev);
>   	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
> +	unsigned long irqflags;
> +
> +	status->current_frequency = clk_get_rate(pfdev->clock);
> +
> +	spin_lock_irqsave(&pfdevfreq->lock, irqflags);
>   
>   	panfrost_devfreq_update_utilization(pfdevfreq);
>   
> -	status->current_frequency = clk_get_rate(pfdev->clock);
>   	status->total_time = ktime_to_ns(ktime_add(pfdevfreq->busy_time,
>   						   pfdevfreq->idle_time));
>   
> @@ -70,6 +70,8 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
>   
>   	panfrost_devfreq_reset(pfdevfreq);
>   
> +	spin_unlock_irqrestore(&pfdevfreq->lock, irqflags);
> +
>   	dev_dbg(pfdev->dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
>   		status->busy_time, status->total_time,
>   		status->busy_time / (status->total_time / 100),
> @@ -100,6 +102,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	else if (ret)
>   		return ret;
>   
> +	spin_lock_init(&pfdevfreq->lock);
> +
>   	panfrost_devfreq_reset(pfdevfreq);
>   
>   	cur_freq = clk_get_rate(pfdev->clock);
> @@ -162,15 +166,32 @@ void panfrost_devfreq_suspend(struct panfrost_device *pfdev)
>   
>   void panfrost_devfreq_record_busy(struct panfrost_devfreq *pfdevfreq)
>   {
> +	unsigned long irqflags;
> +
> +	if (!pfdevfreq->devfreq)
> +		return;
> +
> +	spin_lock_irqsave(&pfdevfreq->lock, irqflags);
> +
>   	panfrost_devfreq_update_utilization(pfdevfreq);
> -	atomic_inc(&pfdevfreq->busy_count);
> +
> +	pfdevfreq->busy_count++;
> +
> +	spin_unlock_irqrestore(&pfdevfreq->lock, irqflags);
>   }
>   
>   void panfrost_devfreq_record_idle(struct panfrost_devfreq *pfdevfreq)
>   {
> -	int count;
> +	unsigned long irqflags;
> +
> +	if (!pfdevfreq->devfreq)
> +		return;
> +
> +	spin_lock_irqsave(&pfdevfreq->lock, irqflags);
>   
>   	panfrost_devfreq_update_utilization(pfdevfreq);
> -	count = atomic_dec_if_positive(&pfdevfreq->busy_count);
> -	WARN_ON(count < 0);
> +
> +	WARN_ON(--pfdevfreq->busy_count < 0);
> +
> +	spin_unlock_irqrestore(&pfdevfreq->lock, irqflags);
>   }
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> index 0697f8d5aa34..e6629900a618 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> @@ -4,6 +4,7 @@
>   #ifndef __PANFROST_DEVFREQ_H__
>   #define __PANFROST_DEVFREQ_H__
>   
> +#include <linux/spinlock.h>
>   #include <linux/ktime.h>
>   
>   struct devfreq;
> @@ -14,10 +15,17 @@ struct panfrost_device;
>   struct panfrost_devfreq {
>   	struct devfreq *devfreq;
>   	struct thermal_cooling_device *cooling;
> +
>   	ktime_t busy_time;
>   	ktime_t idle_time;
>   	ktime_t time_last_update;
> -	atomic_t busy_count;
> +	int busy_count;
> +	/*
> +	 * Protect busy_time, idle_time, time_last_update and busy_count
> +	 * because these can be updated concurrently, for example by the GP
> +	 * and PP interrupts.
> +	 */
> +	spinlock_t lock;
>   };
>   
>   int panfrost_devfreq_init(struct panfrost_device *pfdev);
> 

