Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134D0C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C282C20773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="if+rfFwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCRNrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:47:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45961 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgCRNrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:47:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id i9so2644755wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Jgk73bst/CV0aKd8AXZSx5lKu+2oD2+raaZ8aSYRU3Y=;
        b=if+rfFwgKJlHBxHYcWGa9fyQ6RS7E/uddTEJGLpqvRqsA5k/Lm2YFZeJJges/EGbOQ
         KuRx55U+lLmy/PwaeXoaJeLgcOyw/wWAsJ/ceNk1NqlF3M85Rqn5jc7niF7jZIOtGqNy
         kBvZqV4ac73PHHuQMGXxmYyb797Qb6U3Lczbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Jgk73bst/CV0aKd8AXZSx5lKu+2oD2+raaZ8aSYRU3Y=;
        b=U9Ct9aO3BZv9df+Er4XDGflQvPeMOVBGNPzWKdvtrU72t0vf3EgAF6Z1UhnVnvSwcQ
         8XyWTRZVOCWt/K+QpwMhE36163aiRhN/ohISuA3RM9wubIA37MhgjB2bNU8Sb4hm4bC2
         3dSgF/MDatE7mzpfdjuqfKsZQSTKT+0vYTrmTherZa1ZnTh/xwNEvCd7DZkKjyBKDTnE
         sPJ+vjO/aNeyM6bxbZsDuAvAl3xZIwGN83svcaRl0OF5aoQTT1h3vihs7RrQehip4H/C
         fRkSp7aDhOVIV0bUxBRS/Qwn4RV/luTMojSOTMOahXfNJVit5OTpoRydWlS2A2scNY/k
         NFDg==
X-Gm-Message-State: ANhLgQ0iNZI5jtl3dktQU/fkZ7vjlrqkRc2Hd0mc0UxpXaezhM6aMw2o
        n97rULr5bZgRKNMNy0dqEHQ8WJUGqhTk+g6D
X-Google-Smtp-Source: ADFU+vuSiDrxguzDE4YfNXHEJi5wzEswqlT3sXLcP5L8aPhOk/LNLz00f0V/UmpjtEhK0n+G54hPaA==
X-Received: by 2002:a5d:4ac2:: with SMTP id y2mr5830973wrs.263.1584539220517;
        Wed, 18 Mar 2020 06:47:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x6sm9393174wrm.29.2020.03.18.06.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:46:59 -0700 (PDT)
Date:   Wed, 18 Mar 2020 14:46:57 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] drm/vblank: Add vblank works
Message-ID: <20200318134657.GV2363188@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20200318004159.235623-1-lyude@redhat.com>
 <20200318004159.235623-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318004159.235623-2-lyude@redhat.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 08:40:58PM -0400, Lyude Paul wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Add some kind of vblank workers. The interface is similar to regular
> delayed works, and also allows for re-scheduling.
> 
> Whatever hardware programming we do in the work must be fast
> (must at least complete during the vblank, sometimes during
> the first few scanlines of vblank), so we'll fire up a per-crtc
> high priority thread for this.
> 
> [based off patches from Ville Syrjälä <ville.syrjala@linux.intel.com>,
> change below to signoff later]
> 
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Hm not really sold on the idea that we have should reinvent our own worker
infrastructure here. Imo a vblank_work should look like a delayed work,
i.e. using struct work_struct as the base class, and wrapping the vblank
thing around it (instead of the timer). That alos would allow drivers to
schedule works on their own work queues, allowing for easier flushing and
all that stuff.

Also if we do this I think we should try to follow the delayed work abi as
closely as possible (e.g. INIT_VBLANK_WORK, queue_vblank_work,
mod_vblank_work, ...). Delayed workers (whether timer or vblank) have a
bunch of edges cases where consistently would be really great to avoid
surprises and bugs.
-Daniel

> ---
>  drivers/gpu/drm/drm_vblank.c | 322 +++++++++++++++++++++++++++++++++++
>  include/drm/drm_vblank.h     |  34 ++++
>  2 files changed, 356 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index da7b0b0c1090..06c796b6c381 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -25,7 +25,9 @@
>   */
>  
>  #include <linux/export.h>
> +#include <linux/kthread.h>
>  #include <linux/moduleparam.h>
> +#include <uapi/linux/sched/types.h>
>  
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_drv.h>
> @@ -91,6 +93,7 @@
>  static bool
>  drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
>  			  ktime_t *tvblank, bool in_vblank_irq);
> +static int drm_vblank_get(struct drm_device *dev, unsigned int pipe);
>  
>  static unsigned int drm_timestamp_precision = 20;  /* Default to 20 usecs. */
>  
> @@ -440,6 +443,9 @@ void drm_vblank_cleanup(struct drm_device *dev)
>  			drm_core_check_feature(dev, DRIVER_MODESET));
>  
>  		del_timer_sync(&vblank->disable_timer);
> +
> +		wake_up_all(&vblank->vblank_work.work_wait);
> +		kthread_stop(vblank->vblank_work.thread);
>  	}
>  
>  	kfree(dev->vblank);
> @@ -447,6 +453,108 @@ void drm_vblank_cleanup(struct drm_device *dev)
>  	dev->num_crtcs = 0;
>  }
>  
> +static int vblank_work_thread(void *data)
> +{
> +	struct drm_vblank_crtc *vblank = data;
> +
> +	while (!kthread_should_stop()) {
> +		struct drm_vblank_work *work, *next;
> +		LIST_HEAD(list);
> +		u64 count;
> +		int ret;
> +
> +		spin_lock_irq(&vblank->dev->event_lock);
> +
> +		ret = wait_event_interruptible_lock_irq(vblank->queue,
> +							kthread_should_stop() ||
> +							!list_empty(&vblank->vblank_work.work_list),
> +							vblank->dev->event_lock);
> +
> +		WARN_ON(ret && !kthread_should_stop() &&
> +			list_empty(&vblank->vblank_work.irq_list) &&
> +			list_empty(&vblank->vblank_work.work_list));
> +
> +		list_for_each_entry_safe(work, next,
> +					 &vblank->vblank_work.work_list,
> +					 list) {
> +			list_move_tail(&work->list, &list);
> +			work->state = DRM_VBL_WORK_RUNNING;
> +		}
> +
> +		spin_unlock_irq(&vblank->dev->event_lock);
> +
> +		if (list_empty(&list))
> +			continue;
> +
> +		count = atomic64_read(&vblank->count);
> +		list_for_each_entry(work, &list, list)
> +			work->func(work, count);
> +
> +		spin_lock_irq(&vblank->dev->event_lock);
> +
> +		list_for_each_entry_safe(work, next, &list, list) {
> +			if (work->reschedule) {
> +				list_move_tail(&work->list,
> +					       &vblank->vblank_work.irq_list);
> +				drm_vblank_get(vblank->dev, vblank->pipe);
> +				work->reschedule = false;
> +				work->state = DRM_VBL_WORK_WAITING;
> +			} else {
> +				list_del_init(&work->list);
> +				work->cancel = false;
> +				work->state = DRM_VBL_WORK_IDLE;
> +			}
> +		}
> +
> +		spin_unlock_irq(&vblank->dev->event_lock);
> +
> +		wake_up_all(&vblank->vblank_work.work_wait);
> +	}
> +
> +	return 0;
> +}
> +
> +static void vblank_work_init(struct drm_vblank_crtc *vblank)
> +{
> +	struct sched_param param = {
> +		.sched_priority = MAX_RT_PRIO - 1,
> +	};
> +	int ret;
> +
> +	INIT_LIST_HEAD(&vblank->vblank_work.irq_list);
> +	INIT_LIST_HEAD(&vblank->vblank_work.work_list);
> +	init_waitqueue_head(&vblank->vblank_work.work_wait);
> +
> +	vblank->vblank_work.thread =
> +		kthread_run(vblank_work_thread, vblank, "card %d crtc %d",
> +			    vblank->dev->primary->index, vblank->pipe);
> +
> +	ret = sched_setscheduler(vblank->vblank_work.thread,
> +				 SCHED_FIFO, &param);
> +	WARN_ON(ret);
> +}
> +
> +/**
> + * drm_vblank_work_init - initialize a vblank work item
> + * @work: vblank work item
> + * @crtc: CRTC whose vblank will trigger the work execution
> + * @func: work function to be executed
> + *
> + * Initialize a vblank work item for a specific crtc.
> + */
> +void drm_vblank_work_init(struct drm_vblank_work *work, struct drm_crtc *crtc,
> +			  void (*func)(struct drm_vblank_work *work, u64 count))
> +{
> +	struct drm_device *dev = crtc->dev;
> +	struct drm_vblank_crtc *vblank = &dev->vblank[drm_crtc_index(crtc)];
> +
> +	work->vblank = vblank;
> +	work->state = DRM_VBL_WORK_IDLE;
> +	work->func = func;
> +	INIT_LIST_HEAD(&work->list);
> +}
> +EXPORT_SYMBOL(drm_vblank_work_init);
> +
>  /**
>   * drm_vblank_init - initialize vblank support
>   * @dev: DRM device
> @@ -481,6 +589,8 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
>  		init_waitqueue_head(&vblank->queue);
>  		timer_setup(&vblank->disable_timer, vblank_disable_fn, 0);
>  		seqlock_init(&vblank->seqlock);
> +
> +		vblank_work_init(vblank);
>  	}
>  
>  	DRM_INFO("Supports vblank timestamp caching Rev 2 (21.10.2013).\n");
> @@ -1825,6 +1935,22 @@ static void drm_handle_vblank_events(struct drm_device *dev, unsigned int pipe)
>  	trace_drm_vblank_event(pipe, seq, now, high_prec);
>  }
>  
> +static void drm_handle_vblank_works(struct drm_vblank_crtc *vblank)
> +{
> +	struct drm_vblank_work *work, *next;
> +	u64 count = atomic64_read(&vblank->count);
> +
> +	list_for_each_entry_safe(work, next, &vblank->vblank_work.irq_list,
> +				 list) {
> +		if (!vblank_passed(count, work->count))
> +			continue;
> +
> +		drm_vblank_put(vblank->dev, vblank->pipe);
> +		list_move_tail(&work->list, &vblank->vblank_work.work_list);
> +		work->state = DRM_VBL_WORK_SCHEDULED;
> +	}
> +}
> +
>  /**
>   * drm_handle_vblank - handle a vblank event
>   * @dev: DRM device
> @@ -1866,6 +1992,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
>  
>  	spin_unlock(&dev->vblank_time_lock);
>  
> +	drm_handle_vblank_works(vblank);
>  	wake_up(&vblank->queue);
>  
>  	/* With instant-off, we defer disabling the interrupt until after
> @@ -2076,3 +2203,198 @@ int drm_crtc_queue_sequence_ioctl(struct drm_device *dev, void *data,
>  	kfree(e);
>  	return ret;
>  }
> +
> +/**
> + * drm_vblank_work_schedule - schedule a vblank work
> + * @work: vblank work to schedule
> + * @count: target vblank count
> + * @nextonmiss: defer until the next vblank if target vblank was missed
> + *
> + * Schedule @work for execution once the crtc vblank count reaches @count.
> + *
> + * If the crtc vblank count has already reached @count and @nextonmiss is
> + * %false the work starts to execute immediately.
> + *
> + * If the crtc vblank count has already reached @count and @nextonmiss is
> + * %true the work is deferred until the next vblank (as if @count has been
> + * specified as crtc vblank count + 1).
> + *
> + * If @work is already scheduled, this function will reschedule said work
> + * using the new @count.
> + *
> + * Returns:
> + * 0 on success, error code on failure.
> + */
> +int drm_vblank_work_schedule(struct drm_vblank_work *work,
> +			     u64 count, bool nextonmiss)
> +{
> +	struct drm_vblank_crtc *vblank = work->vblank;
> +	unsigned long irqflags;
> +	u64 cur_vbl;
> +	int ret = 0;
> +	bool rescheduling = false;
> +	bool passed;
> +
> +	spin_lock_irqsave(&vblank->dev->event_lock, irqflags);
> +
> +	if (work->cancel)
> +		goto out;
> +
> +	if (work->state == DRM_VBL_WORK_RUNNING) {
> +		work->reschedule = true;
> +		work->count = count;
> +		goto out;
> +	} else if (work->state != DRM_VBL_WORK_IDLE) {
> +		if (work->count == count)
> +			goto out;
> +		rescheduling = true;
> +	}
> +
> +	if (work->state != DRM_VBL_WORK_WAITING) {
> +		ret = drm_vblank_get(vblank->dev, vblank->pipe);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	work->count = count;
> +
> +	cur_vbl = atomic64_read(&vblank->count);
> +	passed = vblank_passed(cur_vbl, count);
> +	if (passed)
> +		DRM_ERROR("crtc %d vblank %llu already passed (current %llu)\n",
> +			  vblank->pipe, count, cur_vbl);
> +
> +	if (!nextonmiss && passed) {
> +		drm_vblank_put(vblank->dev, vblank->pipe);
> +		if (rescheduling)
> +			list_move_tail(&work->list,
> +				       &vblank->vblank_work.work_list);
> +		else
> +			list_add_tail(&work->list,
> +				      &vblank->vblank_work.work_list);
> +		work->state = DRM_VBL_WORK_SCHEDULED;
> +		wake_up_all(&vblank->queue);
> +	} else {
> +		if (rescheduling)
> +			list_move_tail(&work->list,
> +				       &vblank->vblank_work.irq_list);
> +		else
> +			list_add_tail(&work->list,
> +				      &vblank->vblank_work.irq_list);
> +		work->state = DRM_VBL_WORK_WAITING;
> +	}
> +
> + out:
> +	spin_unlock_irqrestore(&vblank->dev->event_lock, irqflags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_vblank_work_schedule);
> +
> +static bool vblank_work_cancel(struct drm_vblank_work *work)
> +{
> +	struct drm_vblank_crtc *vblank = work->vblank;
> +
> +	switch (work->state) {
> +	case DRM_VBL_WORK_RUNNING:
> +		work->cancel = true;
> +		work->reschedule = false;
> +		/* fall through */
> +	default:
> +	case DRM_VBL_WORK_IDLE:
> +		return false;
> +	case DRM_VBL_WORK_WAITING:
> +		drm_vblank_put(vblank->dev, vblank->pipe);
> +		/* fall through */
> +	case DRM_VBL_WORK_SCHEDULED:
> +		list_del_init(&work->list);
> +		work->state = DRM_VBL_WORK_IDLE;
> +		return true;
> +	}
> +}
> +
> +/**
> + * drm_vblank_work_cancel - cancel a vblank work
> + * @work: vblank work to cancel
> + *
> + * Cancel an already scheduled vblank work.
> + *
> + * On return @work may still be executing, unless the return
> + * value is %true.
> + *
> + * Returns:
> + * True if the work was cancelled before it started to excute, false otherwise.
> + */
> +bool drm_vblank_work_cancel(struct drm_vblank_work *work)
> +{
> +	struct drm_vblank_crtc *vblank = work->vblank;
> +	bool cancelled;
> +
> +	spin_lock_irq(&vblank->dev->event_lock);
> +
> +	cancelled = vblank_work_cancel(work);
> +
> +	spin_unlock_irq(&vblank->dev->event_lock);
> +
> +	return cancelled;
> +}
> +EXPORT_SYMBOL(drm_vblank_work_cancel);
> +
> +/**
> + * drm_vblank_work_cancel_sync - cancel a vblank work and wait for it to finish executing
> + * @work: vblank work to cancel
> + *
> + * Cancel an already scheduled vblank work and wait for its
> + * execution to finish.
> + *
> + * On return @work is no longer guaraneed to be executing.
> + *
> + * Returns:
> + * True if the work was cancelled before it started to excute, false otherwise.
> + */
> +bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work)
> +{
> +	struct drm_vblank_crtc *vblank = work->vblank;
> +	bool cancelled;
> +	long ret;
> +
> +	spin_lock_irq(&vblank->dev->event_lock);
> +
> +	cancelled = vblank_work_cancel(work);
> +
> +	ret = wait_event_lock_irq_timeout(vblank->vblank_work.work_wait,
> +					  work->state == DRM_VBL_WORK_IDLE,
> +					  vblank->dev->event_lock,
> +					  10 * HZ);
> +
> +	spin_unlock_irq(&vblank->dev->event_lock);
> +
> +	WARN(!ret, "crtc %d vblank work timed out\n", vblank->pipe);
> +
> +	return cancelled;
> +}
> +EXPORT_SYMBOL(drm_vblank_work_cancel_sync);
> +
> +/**
> + * drm_vblank_work_flush - wait for a scheduled vblank work to finish excuting
> + * @work: vblank work to flush
> + *
> + * Wait until @work has finished executing.
> + */
> +void drm_vblank_work_flush(struct drm_vblank_work *work)
> +{
> +	struct drm_vblank_crtc *vblank = work->vblank;
> +	long ret;
> +
> +	spin_lock_irq(&vblank->dev->event_lock);
> +
> +	ret = wait_event_lock_irq_timeout(vblank->vblank_work.work_wait,
> +					  work->state == DRM_VBL_WORK_IDLE,
> +					  vblank->dev->event_lock,
> +					  10 * HZ);
> +
> +	spin_unlock_irq(&vblank->dev->event_lock);
> +
> +	WARN(!ret, "crtc %d vblank work timed out\n", vblank->pipe);
> +}
> +EXPORT_SYMBOL(drm_vblank_work_flush);
> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> index dd9f5b9e56e4..ac9130f419af 100644
> --- a/include/drm/drm_vblank.h
> +++ b/include/drm/drm_vblank.h
> @@ -203,8 +203,42 @@ struct drm_vblank_crtc {
>  	 * disabling functions multiple times.
>  	 */
>  	bool enabled;
> +
> +	struct {
> +		struct task_struct *thread;
> +		struct list_head irq_list, work_list;
> +		wait_queue_head_t work_wait;
> +	} vblank_work;
> +};
> +
> +struct drm_vblank_work {
> +	u64 count;
> +	struct drm_vblank_crtc *vblank;
> +	void (*func)(struct drm_vblank_work *work, u64 count);
> +	struct list_head list;
> +	enum {
> +		DRM_VBL_WORK_IDLE,
> +		DRM_VBL_WORK_WAITING,
> +		DRM_VBL_WORK_SCHEDULED,
> +		DRM_VBL_WORK_RUNNING,
> +	} state;
> +	bool cancel : 1;
> +	bool reschedule : 1;
>  };
>  
> +int drm_vblank_work_schedule(struct drm_vblank_work *work,
> +			     u64 count, bool nextonmiss);
> +void drm_vblank_work_init(struct drm_vblank_work *work, struct drm_crtc *crtc,
> +			  void (*func)(struct drm_vblank_work *work, u64 count));
> +bool drm_vblank_work_cancel(struct drm_vblank_work *work);
> +bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work);
> +void drm_vblank_work_flush(struct drm_vblank_work *work);
> +
> +static inline bool drm_vblank_work_pending(struct drm_vblank_work *work)
> +{
> +	return work->state != DRM_VBL_WORK_IDLE;
> +}
> +
>  int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
>  bool drm_dev_has_vblank(const struct drm_device *dev);
>  u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
> -- 
> 2.24.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
