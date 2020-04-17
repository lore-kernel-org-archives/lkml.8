Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF33EC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAC3206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqfQfY9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgDQUQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:16:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43371 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730573AbgDQUQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587154596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hj9MUL55uYvikUIuXy2C9yHGitkdgIH6KD52301TpIM=;
        b=RqfQfY9wG6X+t8UKcCHF/HTtj6RCPxZ/lbQMReCUJxPvHGWn7g6cHJOfkGwUWRXcDpWJ/5
        CYoJKcTAr+XcWZeb0qIf0APOkaiNIhjfysWcohjpUzTVdOpvDZTpK1X/qj/8PTxePsjltM
        esqMl6jAPTRgQOclohpqJWqGPLUK79k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-pD5QxM_QPYGt-oTqk5jk3A-1; Fri, 17 Apr 2020 16:16:31 -0400
X-MC-Unique: pD5QxM_QPYGt-oTqk5jk3A-1
Received: by mail-qv1-f69.google.com with SMTP id n4so48339qvx.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=hj9MUL55uYvikUIuXy2C9yHGitkdgIH6KD52301TpIM=;
        b=hcxH1gtJ+gxBDbxip89ScyJbHrDioSesITchINci72kFy7vDJaSY43i2+bL65HClll
         LbNvK+FzIFCc9wsIXHXPd83tmxcqO37XYm+0wlRjneM/0A9bXsXK1dzHSgQmb0fxnnqL
         zmU5j9P7uGLyYT1k/MmcxWJ5iw8UuU19kh30LXofbcGpDfAjNWP3dOCzLt9XAhl0bZzk
         Y621Ck599lvV/39jKGGIEkiecWywq46vLO7Gi+IAoGXaY+ALe8+NO38M5V6OloQ+2L6W
         d6UGGLDJpn7qtwfdy5u0G85EtA5LApah8DI8bhb+xi5OovygP/PUkEdobgF8nhS/i9M2
         19Ow==
X-Gm-Message-State: AGi0PuadYoxEbnkpvdcxH6DraNP8reT6610e3P5QFkFAM+cytVD6/HDU
        ij+4CntMbyusJzODkOVsYI6WWvlzbqvfx9Vb+MzgdSoWz3nEU8rtlxmpRBMgGP5fGUD6BmVNBo2
        KG34nB+4tHDxoucVHsTZIq7eh
X-Received: by 2002:ac8:758d:: with SMTP id s13mr4872536qtq.105.1587154591056;
        Fri, 17 Apr 2020 13:16:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypLNaTNuzOneBveIU4QRaRjIHGkPPSuy9tD4IC9wJ6Em7r7X70aSwvAphorw43N/tc9RL90OdA==
X-Received: by 2002:ac8:758d:: with SMTP id s13mr4872492qtq.105.1587154590652;
        Fri, 17 Apr 2020 13:16:30 -0700 (PDT)
Received: from Ruby.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id j9sm883780qkk.99.2020.04.17.13.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 13:16:29 -0700 (PDT)
Message-ID: <ef9da9d93022822fe4bec7e906540fcc9852ce59.camel@redhat.com>
Subject: [Poke: Tejun] Re: [RFC v3 03/11] drm/vblank: Add vblank works
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Tejun Heo <tj@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Date:   Fri, 17 Apr 2020 16:16:28 -0400
In-Reply-To: <20200417194145.36350-4-lyude@redhat.com>
References: <20200417194145.36350-1-lyude@redhat.com>
         <20200417194145.36350-4-lyude@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tejun! So I ended up rewriting the drm_vblank_work stuff so that it used
kthread_worker. Things seem to work alright now. But while we're doing just
fine with vblank workers on nouveau, we're still having trouble meeting the
time constraints needed for using vblank works for i915's needs. There still
seems to be a considerable latency between when the irq handler for the vblank
interrupts fires, and when the actual drm_vblank_work we scheduled starts:

[note: intel_load_luts_start() is the vblank work we've scheduled)

<idle>-0          [003] d.h1  1822.559503: intel_pipe_vblank: pipe A, scanline 1081
card0-crtc0-236   [002] ....  1822.560176: intel_load_luts_start: pipe A, frame 4340, scanline 14
card0-crtc0-236   [002] ....  1822.560225: intel_load_luts_end: pipe A, frame 4340, scanline 17

https://gitlab.freedesktop.org/lyudess/linux/-/commits/wip/vbl-workers-vlv-kthread

Tejun, do you have any idea if we might be able to further reduce the latency
from the scheduler here? I believe we're already using pm_qos to at least
reduce the latency between when the vblank interrupt fires and the interrupt
handler starts, but that still isn't enough to fix the other latency issues
apparently. We're also already setting the priority of kthread_worker->task to
RT_FIFO as well.

Also, of course, let me know if you're not happy with the
__kthread_queue_work() changes/kthread_worker usage in drm_vblank_work as well

On Fri, 2020-04-17 at 15:40 -0400, Lyude Paul wrote:
> Add some kind of vblank workers. The interface is similar to regular
> delayed works, and is mostly based off kthread_work. It allows for
> scheduling delayed works that execute once a particular vblank sequence
> has passed. It also allows for accurate flushing of scheduled vblank
> works - in that flushing waits for both the vblank sequence and job
> execution to complete, or for the work to get cancelled - whichever
> comes first.
> 
> Whatever hardware programming we do in the work must be fast (must at
> least complete during the vblank or scanout period, sometimes during the
> first few scanlines of the vblank). As such we use a high-priority
> per-CRTC thread to accomplish this.
> 
> [based off patches from Ville Syrjälä <ville.syrjala@linux.intel.com>,
> change below to signoff later]
> 
> Changes since v2:
> * Use kthread_workers instead of reinventing the wheel.
> 
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 296 ++++++++++++++++++++++++++++++++++-
>  include/drm/drm_vblank.h     |  31 ++++
>  2 files changed, 326 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index bf8de10c131f..ed0ae3d78b69 100644
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
> @@ -155,6 +157,7 @@
>  static bool
>  drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
>  			  ktime_t *tvblank, bool in_vblank_irq);
> +static int drm_vblank_get(struct drm_device *dev, unsigned int pipe);
>  
>  static unsigned int drm_timestamp_precision = 20;  /* Default to 20 usecs.
> */
>  
> @@ -496,9 +499,49 @@ static void drm_vblank_init_release(struct drm_device
> *dev, void *ptr)
>  	WARN_ON(READ_ONCE(vblank->enabled) &&
>  		drm_core_check_feature(dev, DRIVER_MODESET));
>  
> +	kthread_destroy_worker(vblank->worker);
>  	del_timer_sync(&vblank->disable_timer);
>  }
>  
> +/**
> + * drm_vblank_work_init - initialize a vblank work item
> + * @work: vblank work item
> + * @crtc: CRTC whose vblank will trigger the work execution
> + * @func: work function to be executed
> + *
> + * Initialize a vblank work item for a specific crtc.
> + */
> +void drm_vblank_work_init(struct drm_vblank_work *work, struct drm_crtc
> *crtc,
> +			  void (*func)(struct kthread_work *work))
> +{
> +	kthread_init_work(&work->base, func);
> +	INIT_LIST_HEAD(&work->flushers);
> +	INIT_LIST_HEAD(&work->pending);
> +	work->vblank = &crtc->dev->vblank[drm_crtc_index(crtc)];
> +}
> +EXPORT_SYMBOL(drm_vblank_work_init);
> +
> +static int vblank_worker_init(struct drm_vblank_crtc *vblank)
> +{
> +	struct sched_param param = {
> +		.sched_priority = MAX_RT_PRIO - 1,
> +	};
> +	int ret;
> +
> +	INIT_LIST_HEAD(&vblank->pending_work);
> +	vblank->worker = kthread_create_worker(0, "card%d-crtc%d",
> +					       vblank->dev->primary->index,
> +					       vblank->pipe);
> +	if (IS_ERR(vblank->worker))
> +		return PTR_ERR(vblank->worker);
> +
> +	ret = sched_setscheduler(vblank->worker->task, SCHED_FIFO, &param);
> +	if (ret < 0)
> +		kthread_destroy_worker(vblank->worker);
> +
> +	return ret;
> +}
> +
>  /**
>   * drm_vblank_init - initialize vblank support
>   * @dev: DRM device
> @@ -534,11 +577,17 @@ int drm_vblank_init(struct drm_device *dev, unsigned
> int num_crtcs)
>  		timer_setup(&vblank->disable_timer, vblank_disable_fn, 0);
>  		seqlock_init(&vblank->seqlock);
>  
> -		ret = drmm_add_action(dev, drm_vblank_init_release, vblank);
> +		ret = vblank_worker_init(vblank);
>  		if (ret) {
>  			del_timer_sync(&vblank->disable_timer);
>  			return ret;
>  		}
> +
> +		ret = drmm_add_action(dev, drm_vblank_init_release, vblank);
> +		if (ret) {
> +			drm_vblank_init_release(dev, vblank);
> +			return ret;
> +		}
>  	}
>  
>  	DRM_INFO("Supports vblank timestamp caching Rev 2 (21.10.2013).\n");
> @@ -1879,6 +1928,48 @@ static void drm_handle_vblank_events(struct
> drm_device *dev, unsigned int pipe)
>  	trace_drm_vblank_event(pipe, seq, now, high_prec);
>  }
>  
> +struct drm_vblank_flush_work {
> +	struct kthread_work base;
> +	struct completion done;
> +};
> +
> +/* Add a vblank work along with any pending flushes to the kthread_worker
> */
> +static void queue_vblank_work(struct drm_vblank_crtc *vblank,
> +			      struct drm_vblank_work *work)
> +{
> +	struct drm_vblank_flush_work *pos, *tmp;
> +
> +	__kthread_queue_work(vblank->worker, &work->base,
> +			     &vblank->worker->work_list);
> +
> +	list_for_each_entry_safe(pos, tmp, &work->flushers, base.node) {
> +		list_del_init(&work->base.node);
> +		__kthread_queue_work(vblank->worker, &pos->base,
> +				     work->base.node.next);
> +	}
> +}
> +
> +static inline void drm_handle_vblank_works(struct drm_vblank_crtc *vblank)
> +{
> +	struct drm_vblank_work *work, *next;
> +	u64 count = atomic64_read(&vblank->count);
> +	int put_count = 0, i;
> +
> +	raw_spin_lock(&vblank->worker->lock);
> +	list_for_each_entry_safe(work, next, &vblank->pending_work, pending) {
> +		if (!vblank_passed(count, work->count))
> +			continue;
> +
> +		put_count++;
> +		list_del_init(&work->pending);
> +		queue_vblank_work(vblank, work);
> +	}
> +	raw_spin_unlock(&vblank->worker->lock);
> +
> +	for (i = 0; i < put_count; i++)
> +		drm_vblank_put(vblank->dev, vblank->pipe);
> +}
> +
>  /**
>   * drm_handle_vblank - handle a vblank event
>   * @dev: DRM device
> @@ -1920,6 +2011,7 @@ bool drm_handle_vblank(struct drm_device *dev,
> unsigned int pipe)
>  
>  	spin_unlock(&dev->vblank_time_lock);
>  
> +	drm_handle_vblank_works(vblank);
>  	wake_up(&vblank->queue);
>  
>  	/* With instant-off, we defer disabling the interrupt until after
> @@ -2130,3 +2222,205 @@ int drm_crtc_queue_sequence_ioctl(struct drm_device
> *dev, void *data,
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
> +	struct drm_device *dev = vblank->dev;
> +	u64 cur_vbl;
> +	unsigned long irqflags;
> +	bool passed, rescheduling = false;
> +	int ret = 0;
> +
> +	/* Grab our vblank ref early, since that grabs spinlocks */
> +	ret = drm_vblank_get(dev, vblank->pipe);
> +	if (ret < 0)
> +		return ret;
> +
> +	raw_spin_lock_irqsave(&vblank->worker->lock, irqflags);
> +
> +	if (work->base.canceling)
> +		goto out;
> +
> +	if (list_empty(&work->pending))
> +		atomic_inc(&vblank->refcount);
> +	else if (work->count == count) /* Already scheduled w/ same vbl count
> */
> +		goto out;
> +	else
> +		rescheduling = true;
> +
> +	work->count = count;
> +	cur_vbl = atomic64_read(&vblank->count);
> +	passed = vblank_passed(cur_vbl, count);
> +	if (passed)
> +		DRM_ERROR("crtc %d vblank %llu already passed (current
> %llu)\n",
> +			  vblank->pipe, count, cur_vbl);
> +
> +	if (!nextonmiss && passed) {
> +		atomic_dec(&vblank->refcount);
> +		if (rescheduling)
> +			list_del_init(&work->pending);
> +		queue_vblank_work(vblank, work);
> +	} else {
> +		if (rescheduling)
> +			list_move_tail(&work->pending, &vblank->pending_work);
> +		else
> +			list_add_tail(&work->pending, &vblank->pending_work);
> +	}
> +
> + out:
> +	raw_spin_unlock_irqrestore(&vblank->worker->lock, irqflags);
> +	drm_vblank_put(dev, vblank->pipe);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_vblank_work_schedule);
> +
> +static bool vblank_work_cancel(struct drm_vblank_work *work)
> +{
> +	struct drm_vblank_flush_work *pos, *tmp;
> +
> +	if (list_empty(&work->pending))
> +		return false;
> +
> +	list_del_init(&work->pending);
> +
> +	list_for_each_entry_safe(pos, tmp, &work->flushers, base.node) {
> +		list_del(&pos->base.node);
> +		complete(&pos->done);
> +	}
> +
> +	return true;
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
> + * True if the work was cancelled before it started to excute, false
> otherwise.
> + */
> +bool drm_vblank_work_cancel(struct drm_vblank_work *work)
> +{
> +	struct drm_vblank_crtc *vblank = work->vblank;
> +	bool cancelled;
> +
> +	raw_spin_lock_irq(&vblank->worker->lock);
> +	cancelled = vblank_work_cancel(work);
> +	raw_spin_unlock_irq(&vblank->worker->lock);
> +	if (cancelled)
> +		drm_vblank_put(vblank->dev, vblank->pipe);
> +
> +	return cancelled;
> +}
> +EXPORT_SYMBOL(drm_vblank_work_cancel);
> +
> +/**
> + * drm_vblank_work_cancel_sync - cancel a vblank work and wait for it to
> + * finish executing
> + * @work: vblank work to cancel
> + *
> + * Cancel an already scheduled vblank work and wait for its
> + * execution to finish.
> + *
> + * On return @work is no longer guaraneed to be executing.
> + *
> + * Returns:
> + * True if the work was cancelled before it started to excute, false
> + * otherwise.
> + */
> +bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work)
> +{
> +	struct drm_vblank_crtc *vblank = work->vblank;
> +	bool queued, cancelled;
> +
> +	raw_spin_lock_irq(&vblank->worker->lock);
> +	cancelled = vblank_work_cancel(work);
> +	queued = !!work->base.worker;
> +	if (queued)
> +		work->base.canceling++;
> +	raw_spin_unlock_irq(&vblank->worker->lock);
> +
> +	if (cancelled)
> +		drm_vblank_put(vblank->dev, vblank->pipe);
> +
> +	if (queued) {
> +		cancelled = kthread_cancel_work_sync(&work->base);
> +		raw_spin_lock_irq(&vblank->worker->lock);
> +		work->base.canceling--;
> +		raw_spin_unlock_irq(&vblank->worker->lock);
> +	}
> +
> +	return cancelled;
> +}
> +EXPORT_SYMBOL(drm_vblank_work_cancel_sync);
> +
> +static void drm_flush_vblank_work_fn(struct kthread_work *work)
> +{
> +	struct drm_vblank_flush_work *fwork =
> +		container_of(work, struct drm_vblank_flush_work, base);
> +
> +	complete(&fwork->done);
> +}
> +
> +/**
> + * drm_vblank_work_flush - wait for a scheduled vblank work to finish
> + * executing
> + * @work: vblank work to flush
> + *
> + * Wait until @work has finished executing once.
> + */
> +void drm_vblank_work_flush(struct drm_vblank_work *work)
> +{
> +	struct drm_vblank_crtc *vblank = work->vblank;
> +	struct drm_vblank_flush_work fwork = {
> +		KTHREAD_WORK_INIT(fwork.base, drm_flush_vblank_work_fn),
> +		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> +	};
> +
> +	raw_spin_lock_irq(&vblank->worker->lock);
> +
> +	if (!list_empty(&work->pending)) {
> +		list_add_tail(&fwork.base.node, &work->flushers);
> +	} else if (!list_empty(&work->base.node)) {
> +		__kthread_queue_work(vblank->worker, &fwork.base,
> +				     work->base.node.next);
> +	} else if (vblank->worker->current_work == &work->base) {
> +		__kthread_queue_work(vblank->worker, &fwork.base,
> +				     vblank->worker->work_list.next);
> +	} else {
> +		raw_spin_unlock_irq(&vblank->worker->lock);
> +		return;
> +	}
> +
> +	raw_spin_unlock_irq(&vblank->worker->lock);
> +	wait_for_completion(&fwork.done);
> +}
> +EXPORT_SYMBOL(drm_vblank_work_flush);
> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> index dd9f5b9e56e4..03fc96a533bb 100644
> --- a/include/drm/drm_vblank.h
> +++ b/include/drm/drm_vblank.h
> @@ -27,6 +27,7 @@
>  #include <linux/seqlock.h>
>  #include <linux/idr.h>
>  #include <linux/poll.h>
> +#include <linux/kthread.h>
>  
>  #include <drm/drm_file.h>
>  #include <drm/drm_modes.h>
> @@ -203,8 +204,38 @@ struct drm_vblank_crtc {
>  	 * disabling functions multiple times.
>  	 */
>  	bool enabled;
> +
> +	/**
> +	 * @worker: The &kthread_worker used for executing vblank works.
> +	 */
> +	struct kthread_worker *worker;
> +	/**
> +	 * @pending_work: A list of scheduled &drm_vblank_work that are
> +	 * waiting for a future vblank.
> +	 */
> +	struct list_head pending_work;
>  };
>  
> +struct drm_vblank_work {
> +	struct kthread_work base;
> +	struct drm_vblank_crtc *vblank;
> +	u64 count;
> +
> +	struct list_head pending;
> +	struct list_head flushers;
> +};
> +
> +#define to_drm_vblank_work(_work) \
> +	container_of((_work), struct drm_vblank_work, base)
> +
> +int drm_vblank_work_schedule(struct drm_vblank_work *work,
> +			     u64 count, bool nextonmiss);
> +void drm_vblank_work_init(struct drm_vblank_work *work, struct drm_crtc
> *crtc,
> +			  void (*func)(struct kthread_work *work));
> +bool drm_vblank_work_cancel(struct drm_vblank_work *work);
> +bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work);
> +void drm_vblank_work_flush(struct drm_vblank_work *work);
> +
>  int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
>  bool drm_dev_has_vblank(const struct drm_device *dev);
>  u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat

