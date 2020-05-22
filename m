Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEA920727
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgEVRN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:13:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50660 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730536AbgEVRN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:13:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 42B4F2A3A73
Date:   Fri, 22 May 2020 13:13:19 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Fix inbalance of devfreq record_busy/idle()
Message-ID: <20200522171319.GA1836@kevin>
References: <20200522153653.40754-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522153653.40754-1-steven.price@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A-b

On Fri, May 22, 2020 at 04:36:53PM +0100, Steven Price wrote:
> The calls to panfrost_devfreq_record_busy() and
> panfrost_devfreq_record_idle() must be balanced to ensure that the
> devfreq utilisation is correctly reported. But there are two cases where
> this doesn't work correctly.
> 
> In panfrost_job_hw_submit() if pm_runtime_get_sync() fails or the
> WARN_ON() fires then no call to panfrost_devfreq_record_busy() is made,
> but when the job times out the corresponding _record_idle() call is
> still made in panfrost_job_timedout(). Move the call up to ensure that
> it always happens.
> 
> Secondly panfrost_job_timedout() only makes a single call to
> panfrost_devfreq_record_idle() even if it is cleaning up multiple jobs.
> Move the call inside the loop to ensure that the number of
> _record_idle() calls matches the number of _record_busy() calls.
> 
> Fixes: 9e62b885f715 ("drm/panfrost: Simplify devfreq utilisation tracking")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index b2f09c038d35..ac87ef675e8a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -145,6 +145,8 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  	u64 jc_head = job->jc;
>  	int ret;
>  
> +	panfrost_devfreq_record_busy(pfdev);
> +
>  	ret = pm_runtime_get_sync(pfdev->dev);
>  	if (ret < 0)
>  		return;
> @@ -155,7 +157,6 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  	}
>  
>  	cfg = panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
> -	panfrost_devfreq_record_busy(pfdev);
>  
>  	job_write(pfdev, JS_HEAD_NEXT_LO(js), jc_head & 0xFFFFFFFF);
>  	job_write(pfdev, JS_HEAD_NEXT_HI(js), jc_head >> 32);
> @@ -410,12 +411,12 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
>  	for (i = 0; i < NUM_JOB_SLOTS; i++) {
>  		if (pfdev->jobs[i]) {
>  			pm_runtime_put_noidle(pfdev->dev);
> +			panfrost_devfreq_record_idle(pfdev);
>  			pfdev->jobs[i] = NULL;
>  		}
>  	}
>  	spin_unlock_irqrestore(&pfdev->js->job_lock, flags);
>  
> -	panfrost_devfreq_record_idle(pfdev);
>  	panfrost_device_reset(pfdev);
>  
>  	for (i = 0; i < NUM_JOB_SLOTS; i++)
> -- 
> 2.20.1
> 
