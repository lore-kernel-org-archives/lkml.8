Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982C7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6061A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KI8CqX4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbgDMUTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:19:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46233 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388255AbgDMUTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586809148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfkq5NTqVCQXust1Yr13C2rG0RvQN996NmPeVGAc7Cw=;
        b=KI8CqX4YXWCG1BGTyx9C2N3F+xHqKGngtcMrjh0oKJveHDeQlqaU2nmY1T14d0CTfK3Mf1
        mhFFS2bm/h2dn51/o1k0CmkiqbRxu+CdKqNMBxGfiuHm28/LJ4zLQJEfXILT648Mohagn4
        kiC9LuQo9MtOeMtrwTlYL6I1oBKi40Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-gNzI8z_eMM66Y3ga7C6BQA-1; Mon, 13 Apr 2020 16:19:01 -0400
X-MC-Unique: gNzI8z_eMM66Y3ga7C6BQA-1
Received: by mail-qt1-f198.google.com with SMTP id w2so4418657qtn.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=jfkq5NTqVCQXust1Yr13C2rG0RvQN996NmPeVGAc7Cw=;
        b=NAZ5Qjyy6q5bVxnCCrmu64r4ufx54YyAgG/PmoE8PYhOey1hNukfwJIRF5/geAYfGd
         CF5BdY/brlZoEm5wFFLQ7Gn9OIL6zuzvc2DXVd/qjseyVA9oB1+b8kYiOT/SIu+KcAM9
         uyke6uwaEQAMEZ9rV1GSxdL82EkPDKO/Wa3wZn34sQeuvEEIEdK2mO3zkI3TduQ99pxG
         l877CyZQEjg5ewsBFDug9XIKbGCWaJ56X5Ijk+brToXjetaTz6sjmk3ZFlDGQwGlFjYU
         0YmsY+fUxLl3ul4FzJn+48UdGz/8l+u164dln5f+XJzksHIYWbEUqBdnasAVUYrcYuXl
         xsaQ==
X-Gm-Message-State: AGi0Pubehzrwbg9QWDkJUV6mWeMKLS5RFmpDT2TZWAGP6RApc5fjd0u2
        hjp98xJqsD7W9VHbnuwazoZzLB7/1t0VaFq6k8+1VyhqLR9ogk82FfojPVWdWShvqAgdlLnCLiS
        lFqWGMmXajBhOVdsm34MwMpg9
X-Received: by 2002:a0c:e105:: with SMTP id w5mr2519189qvk.118.1586809140286;
        Mon, 13 Apr 2020 13:19:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ6qg9gyNOyGlB3cll2JNBMVTKM4bpDypxB8r1apwQcYA9vdee8fEMq1uja2ZvG1G1cLFGmQw==
X-Received: by 2002:a0c:e105:: with SMTP id w5mr2519158qvk.118.1586809139700;
        Mon, 13 Apr 2020 13:18:59 -0700 (PDT)
Received: from Ruby.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id 39sm3860636qtg.94.2020.04.13.13.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 13:18:58 -0700 (PDT)
Message-ID: <96cb912809f99d04cd5cdd46c77b66b8c1163380.camel@redhat.com>
Subject: Re: [PATCH 1/9] drm/vblank: Add vblank works
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Tejun Heo <tj@kernel.org>
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Date:   Mon, 13 Apr 2020 16:18:57 -0400
In-Reply-To: <faf63d8a9ed23c16af69762f59d0dca6b2bf085f.camel@redhat.com>
References: <20200318004159.235623-1-lyude@redhat.com>
         <20200318004159.235623-2-lyude@redhat.com>
         <20200318134657.GV2363188@phenom.ffwll.local>
         <e4fb0c39ec024d60587e5e1e70b171b99eb537f4.camel@redhat.com>
         <faf63d8a9ed23c16af69762f59d0dca6b2bf085f.camel@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun! Sorry to bother you, but have you had a chance to look at any of
this yet? Would like to continue moving this forward

On Fri, 2020-03-27 at 16:38 -0400, Lyude Paul wrote:
> Oops, completely forgot to link to the work_struct version of this patch:
> 
> [1] 
> https://gitlab.freedesktop.org/lyudess/linux/-/commit/f57886aebbd9631f1ee6e61b516bf73afbfe74f4
> 
> On Fri, 2020-03-27 at 16:29 -0400, Lyude Paul wrote:
> > Adding Tejun to this thread per-Daniel's suggestion on IRC.
> > 
> > Hi Tejun! So, I don't know what your experience with modesetting related
> > stuff
> > is so I'll quickly explain some important concepts here regarding
> > scanlines,
> > vblanks, etc. If you already understand this, feel free to skip this next
> > paragraph.
> > 
> > From the perspective of a computer, every time a computer monitor displays
> > a
> > new frame it's done by "scanning out" the display image from top to
> > bottom,
> > one row of pixels at a time. which row of pixels we're on is referred to
> > as
> > the scanline. Additionally, there's usually a couple of extra scanlines
> > which
> > we scan out, but aren't actually displayed on the screen (these sometimes
> > get
> > used by HDMI audio and friends, but that's another story). The period
> > where
> > we're on these scanlines is referred to as the vblank, this is important.
> > 
> > On a lot of display hardware, programming needs to take effect during the
> > vertical blanking period so that settings like gamma, what frame we're
> > scanning out, etc. can be safely changed without showing visual tearing on
> > the
> > screen. In some unforgiving hardware, some of this programming has to both
> > start and end in the same vblank. This is apparently the case on the
> > majority
> > of Intel GPUs in the wild right now, most notably with gamma updates which
> > involve mashing over 2KiB of registers during the vblank. Other drivers
> > have
> > very similar needs to this (nouveau in particular is why I'm here, we need
> > it
> > for CRC related stuff) so we figured it'd be a good idea to add a set of
> > helpers for performing realtime hardware programming that's synchronized
> > to
> > vblank intervals. In particular, this is aimed at hardware programming
> > that
> > would be a bit too awkward to try to pull off entirely in interrupt
> > context.
> > We call these vblank workers.
> > 
> > We first tried doing this using plain old kthreads, as you can see in the
> > patch below, since we could schedule them as realtime. Additionally, the
> > plan
> > was to use this in i915 combined with pm_qos to get rid of cstate latency
> > when
> > handling the original vblank interrupt. Note, our time constraints are a
> > bit
> > more forgiving in nouveau so you won't see any pm_qos mentions in this
> > series.
> > 
> > In an effort to try to avoid reinventing parts of the kernel's worker
> > infrastructure though, we tried to see if we could implement these with
> > simple
> > work_structs and workqueues with HIGH_PRI | UNBOUNDED,[1]. But, it would
> > seem
> > that this work_struct approach is quite unreliable and we still usually
> > fail
> > to start the register programming in time for Intel's vblank worker
> > usecase.
> > 
> > So, so far using plain old RT kthreads seems to make things about as
> > reliable
> > as I think we're going to get. Note - even using kthreads we _still_
> > sometimes
> > miss the vblank period and end up tearing a bit on screen, but it happens
> > significantly less often then with work_structs and is basically going to
> > be
> > as fast as we can get (in the future, Intel wants to try fixing this by
> > doing
> > this hardware programming outside of the CPU, but for now we're stuck with
> > this).
> > 
> > With all of this being said - we'd still like to avoid having to reinvent
> > workers if possible, so we were wondering if there was any kind of
> > realtime
> > worker that could be used for this instead? I haven't been able to find
> > any
> > way of scheduling workers to be realtime, and I'm not sure if implementing
> > this in Linux's workqueues would be realistic either. It'd be nice to
> > avoid
> > having to use plain old kthreads if possible :). What do you think Tejun?
> > 
> > On Wed, 2020-03-18 at 14:46 +0100, Daniel Vetter wrote:
> > > On Tue, Mar 17, 2020 at 08:40:58PM -0400, Lyude Paul wrote:
> > > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > 
> > > > Add some kind of vblank workers. The interface is similar to regular
> > > > delayed works, and also allows for re-scheduling.
> > > > 
> > > > Whatever hardware programming we do in the work must be fast
> > > > (must at least complete during the vblank, sometimes during
> > > > the first few scanlines of vblank), so we'll fire up a per-crtc
> > > > high priority thread for this.
> > > > 
> > > > [based off patches from Ville Syrjälä <ville.syrjala@linux.intel.com>,
> > > > change below to signoff later]
> > > > 
> > > > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > 
> > > Hm not really sold on the idea that we have should reinvent our own
> > > worker
> > > infrastructure here. Imo a vblank_work should look like a delayed work,
> > > i.e. using struct work_struct as the base class, and wrapping the vblank
> > > thing around it (instead of the timer). That alos would allow drivers to
> > > schedule works on their own work queues, allowing for easier flushing
> > > and
> > > all that stuff.
> > > 
> > > Also if we do this I think we should try to follow the delayed work abi
> > > as
> > > closely as possible (e.g. INIT_VBLANK_WORK, queue_vblank_work,
> > > mod_vblank_work, ...). Delayed workers (whether timer or vblank) have a
> > > bunch of edges cases where consistently would be really great to avoid
> > > surprises and bugs.
> > > -Daniel
> > > 
> > > > ---
> > > >  drivers/gpu/drm/drm_vblank.c | 322
> > > > +++++++++++++++++++++++++++++++++++
> > > >  include/drm/drm_vblank.h     |  34 ++++
> > > >  2 files changed, 356 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_vblank.c
> > > > b/drivers/gpu/drm/drm_vblank.c
> > > > index da7b0b0c1090..06c796b6c381 100644
> > > > --- a/drivers/gpu/drm/drm_vblank.c
> > > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > > @@ -25,7 +25,9 @@
> > > >   */
> > > >  
> > > >  #include <linux/export.h>
> > > > +#include <linux/kthread.h>
> > > >  #include <linux/moduleparam.h>
> > > > +#include <uapi/linux/sched/types.h>
> > > >  
> > > >  #include <drm/drm_crtc.h>
> > > >  #include <drm/drm_drv.h>
> > > > @@ -91,6 +93,7 @@
> > > >  static bool
> > > >  drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
> > > >  			  ktime_t *tvblank, bool in_vblank_irq);
> > > > +static int drm_vblank_get(struct drm_device *dev, unsigned int pipe);
> > > >  
> > > >  static unsigned int drm_timestamp_precision = 20;  /* Default to 20
> > > > usecs. */
> > > >  
> > > > @@ -440,6 +443,9 @@ void drm_vblank_cleanup(struct drm_device *dev)
> > > >  			drm_core_check_feature(dev, DRIVER_MODESET));
> > > >  
> > > >  		del_timer_sync(&vblank->disable_timer);
> > > > +
> > > > +		wake_up_all(&vblank->vblank_work.work_wait);
> > > > +		kthread_stop(vblank->vblank_work.thread);
> > > >  	}
> > > >  
> > > >  	kfree(dev->vblank);
> > > > @@ -447,6 +453,108 @@ void drm_vblank_cleanup(struct drm_device *dev)
> > > >  	dev->num_crtcs = 0;
> > > >  }
> > > >  
> > > > +static int vblank_work_thread(void *data)
> > > > +{
> > > > +	struct drm_vblank_crtc *vblank = data;
> > > > +
> > > > +	while (!kthread_should_stop()) {
> > > > +		struct drm_vblank_work *work, *next;
> > > > +		LIST_HEAD(list);
> > > > +		u64 count;
> > > > +		int ret;
> > > > +
> > > > +		spin_lock_irq(&vblank->dev->event_lock);
> > > > +
> > > > +		ret = wait_event_interruptible_lock_irq(vblank->queue,
> > > > +							kthread_should
> > > > _stop()
> > > > +							!list_empty(&v
> > > > blank-
> > > > > vblank_work.work_list),
> > > > +							vblank->dev-
> > > > > event_lock);
> > > > +
> > > > +		WARN_ON(ret && !kthread_should_stop() &&
> > > > +			list_empty(&vblank->vblank_work.irq_list) &&
> > > > +			list_empty(&vblank->vblank_work.work_list));
> > > > +
> > > > +		list_for_each_entry_safe(work, next,
> > > > +					 &vblank-
> > > > >vblank_work.work_list,
> > > > +					 list) {
> > > > +			list_move_tail(&work->list, &list);
> > > > +			work->state = DRM_VBL_WORK_RUNNING;
> > > > +		}
> > > > +
> > > > +		spin_unlock_irq(&vblank->dev->event_lock);
> > > > +
> > > > +		if (list_empty(&list))
> > > > +			continue;
> > > > +
> > > > +		count = atomic64_read(&vblank->count);
> > > > +		list_for_each_entry(work, &list, list)
> > > > +			work->func(work, count);
> > > > +
> > > > +		spin_lock_irq(&vblank->dev->event_lock);
> > > > +
> > > > +		list_for_each_entry_safe(work, next, &list, list) {
> > > > +			if (work->reschedule) {
> > > > +				list_move_tail(&work->list,
> > > > +					       &vblank-
> > > > >vblank_work.irq_list);
> > > > +				drm_vblank_get(vblank->dev, vblank-
> > > > >pipe);
> > > > +				work->reschedule = false;
> > > > +				work->state = DRM_VBL_WORK_WAITING;
> > > > +			} else {
> > > > +				list_del_init(&work->list);
> > > > +				work->cancel = false;
> > > > +				work->state = DRM_VBL_WORK_IDLE;
> > > > +			}
> > > > +		}
> > > > +
> > > > +		spin_unlock_irq(&vblank->dev->event_lock);
> > > > +
> > > > +		wake_up_all(&vblank->vblank_work.work_wait);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void vblank_work_init(struct drm_vblank_crtc *vblank)
> > > > +{
> > > > +	struct sched_param param = {
> > > > +		.sched_priority = MAX_RT_PRIO - 1,
> > > > +	};
> > > > +	int ret;
> > > > +
> > > > +	INIT_LIST_HEAD(&vblank->vblank_work.irq_list);
> > > > +	INIT_LIST_HEAD(&vblank->vblank_work.work_list);
> > > > +	init_waitqueue_head(&vblank->vblank_work.work_wait);
> > > > +
> > > > +	vblank->vblank_work.thread =
> > > > +		kthread_run(vblank_work_thread, vblank, "card %d crtc
> > > > %d",
> > > > +			    vblank->dev->primary->index, vblank-
> > > > >pipe);
> > > > +
> > > > +	ret = sched_setscheduler(vblank->vblank_work.thread,
> > > > +				 SCHED_FIFO, &param);
> > > > +	WARN_ON(ret);
> > > > +}
> > > > +
> > > > +/**
> > > > + * drm_vblank_work_init - initialize a vblank work item
> > > > + * @work: vblank work item
> > > > + * @crtc: CRTC whose vblank will trigger the work execution
> > > > + * @func: work function to be executed
> > > > + *
> > > > + * Initialize a vblank work item for a specific crtc.
> > > > + */
> > > > +void drm_vblank_work_init(struct drm_vblank_work *work, struct
> > > > drm_crtc
> > > > *crtc,
> > > > +			  void (*func)(struct drm_vblank_work *work,
> > > > u64
> > > > count))
> > > > +{
> > > > +	struct drm_device *dev = crtc->dev;
> > > > +	struct drm_vblank_crtc *vblank = &dev-
> > > > >vblank[drm_crtc_index(crtc)];
> > > > +
> > > > +	work->vblank = vblank;
> > > > +	work->state = DRM_VBL_WORK_IDLE;
> > > > +	work->func = func;
> > > > +	INIT_LIST_HEAD(&work->list);
> > > > +}
> > > > +EXPORT_SYMBOL(drm_vblank_work_init);
> > > > +
> > > >  /**
> > > >   * drm_vblank_init - initialize vblank support
> > > >   * @dev: DRM device
> > > > @@ -481,6 +589,8 @@ int drm_vblank_init(struct drm_device *dev,
> > > > unsigned
> > > > int num_crtcs)
> > > >  		init_waitqueue_head(&vblank->queue);
> > > >  		timer_setup(&vblank->disable_timer, vblank_disable_fn,
> > > > 0);
> > > >  		seqlock_init(&vblank->seqlock);
> > > > +
> > > > +		vblank_work_init(vblank);
> > > >  	}
> > > >  
> > > >  	DRM_INFO("Supports vblank timestamp caching Rev 2
> > > > (21.10.2013).\n");
> > > > @@ -1825,6 +1935,22 @@ static void drm_handle_vblank_events(struct
> > > > drm_device *dev, unsigned int pipe)
> > > >  	trace_drm_vblank_event(pipe, seq, now, high_prec);
> > > >  }
> > > >  
> > > > +static void drm_handle_vblank_works(struct drm_vblank_crtc *vblank)
> > > > +{
> > > > +	struct drm_vblank_work *work, *next;
> > > > +	u64 count = atomic64_read(&vblank->count);
> > > > +
> > > > +	list_for_each_entry_safe(work, next, &vblank-
> > > > >vblank_work.irq_list,
> > > > +				 list) {
> > > > +		if (!vblank_passed(count, work->count))
> > > > +			continue;
> > > > +
> > > > +		drm_vblank_put(vblank->dev, vblank->pipe);
> > > > +		list_move_tail(&work->list, &vblank-
> > > > >vblank_work.work_list);
> > > > +		work->state = DRM_VBL_WORK_SCHEDULED;
> > > > +	}
> > > > +}
> > > > +
> > > >  /**
> > > >   * drm_handle_vblank - handle a vblank event
> > > >   * @dev: DRM device
> > > > @@ -1866,6 +1992,7 @@ bool drm_handle_vblank(struct drm_device *dev,
> > > > unsigned int pipe)
> > > >  
> > > >  	spin_unlock(&dev->vblank_time_lock);
> > > >  
> > > > +	drm_handle_vblank_works(vblank);
> > > >  	wake_up(&vblank->queue);
> > > >  
> > > >  	/* With instant-off, we defer disabling the interrupt until
> > > > after
> > > > @@ -2076,3 +2203,198 @@ int drm_crtc_queue_sequence_ioctl(struct
> > > > drm_device *dev, void *data,
> > > >  	kfree(e);
> > > >  	return ret;
> > > >  }
> > > > +
> > > > +/**
> > > > + * drm_vblank_work_schedule - schedule a vblank work
> > > > + * @work: vblank work to schedule
> > > > + * @count: target vblank count
> > > > + * @nextonmiss: defer until the next vblank if target vblank was
> > > > missed
> > > > + *
> > > > + * Schedule @work for execution once the crtc vblank count reaches
> > > > @count.
> > > > + *
> > > > + * If the crtc vblank count has already reached @count and
> > > > @nextonmiss
> > > > is
> > > > + * %false the work starts to execute immediately.
> > > > + *
> > > > + * If the crtc vblank count has already reached @count and
> > > > @nextonmiss
> > > > is
> > > > + * %true the work is deferred until the next vblank (as if @count has
> > > > been
> > > > + * specified as crtc vblank count + 1).
> > > > + *
> > > > + * If @work is already scheduled, this function will reschedule said
> > > > work
> > > > + * using the new @count.
> > > > + *
> > > > + * Returns:
> > > > + * 0 on success, error code on failure.
> > > > + */
> > > > +int drm_vblank_work_schedule(struct drm_vblank_work *work,
> > > > +			     u64 count, bool nextonmiss)
> > > > +{
> > > > +	struct drm_vblank_crtc *vblank = work->vblank;
> > > > +	unsigned long irqflags;
> > > > +	u64 cur_vbl;
> > > > +	int ret = 0;
> > > > +	bool rescheduling = false;
> > > > +	bool passed;
> > > > +
> > > > +	spin_lock_irqsave(&vblank->dev->event_lock, irqflags);
> > > > +
> > > > +	if (work->cancel)
> > > > +		goto out;
> > > > +
> > > > +	if (work->state == DRM_VBL_WORK_RUNNING) {
> > > > +		work->reschedule = true;
> > > > +		work->count = count;
> > > > +		goto out;
> > > > +	} else if (work->state != DRM_VBL_WORK_IDLE) {
> > > > +		if (work->count == count)
> > > > +			goto out;
> > > > +		rescheduling = true;
> > > > +	}
> > > > +
> > > > +	if (work->state != DRM_VBL_WORK_WAITING) {
> > > > +		ret = drm_vblank_get(vblank->dev, vblank->pipe);
> > > > +		if (ret)
> > > > +			goto out;
> > > > +	}
> > > > +
> > > > +	work->count = count;
> > > > +
> > > > +	cur_vbl = atomic64_read(&vblank->count);
> > > > +	passed = vblank_passed(cur_vbl, count);
> > > > +	if (passed)
> > > > +		DRM_ERROR("crtc %d vblank %llu already passed (current
> > > > %llu)\n",
> > > > +			  vblank->pipe, count, cur_vbl);
> > > > +
> > > > +	if (!nextonmiss && passed) {
> > > > +		drm_vblank_put(vblank->dev, vblank->pipe);
> > > > +		if (rescheduling)
> > > > +			list_move_tail(&work->list,
> > > > +				       &vblank-
> > > > >vblank_work.work_list);
> > > > +		else
> > > > +			list_add_tail(&work->list,
> > > > +				      &vblank->vblank_work.work_list);
> > > > +		work->state = DRM_VBL_WORK_SCHEDULED;
> > > > +		wake_up_all(&vblank->queue);
> > > > +	} else {
> > > > +		if (rescheduling)
> > > > +			list_move_tail(&work->list,
> > > > +				       &vblank->vblank_work.irq_list);
> > > > +		else
> > > > +			list_add_tail(&work->list,
> > > > +				      &vblank->vblank_work.irq_list);
> > > > +		work->state = DRM_VBL_WORK_WAITING;
> > > > +	}
> > > > +
> > > > + out:
> > > > +	spin_unlock_irqrestore(&vblank->dev->event_lock, irqflags);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +EXPORT_SYMBOL(drm_vblank_work_schedule);
> > > > +
> > > > +static bool vblank_work_cancel(struct drm_vblank_work *work)
> > > > +{
> > > > +	struct drm_vblank_crtc *vblank = work->vblank;
> > > > +
> > > > +	switch (work->state) {
> > > > +	case DRM_VBL_WORK_RUNNING:
> > > > +		work->cancel = true;
> > > > +		work->reschedule = false;
> > > > +		/* fall through */
> > > > +	default:
> > > > +	case DRM_VBL_WORK_IDLE:
> > > > +		return false;
> > > > +	case DRM_VBL_WORK_WAITING:
> > > > +		drm_vblank_put(vblank->dev, vblank->pipe);
> > > > +		/* fall through */
> > > > +	case DRM_VBL_WORK_SCHEDULED:
> > > > +		list_del_init(&work->list);
> > > > +		work->state = DRM_VBL_WORK_IDLE;
> > > > +		return true;
> > > > +	}
> > > > +}
> > > > +
> > > > +/**
> > > > + * drm_vblank_work_cancel - cancel a vblank work
> > > > + * @work: vblank work to cancel
> > > > + *
> > > > + * Cancel an already scheduled vblank work.
> > > > + *
> > > > + * On return @work may still be executing, unless the return
> > > > + * value is %true.
> > > > + *
> > > > + * Returns:
> > > > + * True if the work was cancelled before it started to excute, false
> > > > otherwise.
> > > > + */
> > > > +bool drm_vblank_work_cancel(struct drm_vblank_work *work)
> > > > +{
> > > > +	struct drm_vblank_crtc *vblank = work->vblank;
> > > > +	bool cancelled;
> > > > +
> > > > +	spin_lock_irq(&vblank->dev->event_lock);
> > > > +
> > > > +	cancelled = vblank_work_cancel(work);
> > > > +
> > > > +	spin_unlock_irq(&vblank->dev->event_lock);
> > > > +
> > > > +	return cancelled;
> > > > +}
> > > > +EXPORT_SYMBOL(drm_vblank_work_cancel);
> > > > +
> > > > +/**
> > > > + * drm_vblank_work_cancel_sync - cancel a vblank work and wait for it
> > > > to
> > > > finish executing
> > > > + * @work: vblank work to cancel
> > > > + *
> > > > + * Cancel an already scheduled vblank work and wait for its
> > > > + * execution to finish.
> > > > + *
> > > > + * On return @work is no longer guaraneed to be executing.
> > > > + *
> > > > + * Returns:
> > > > + * True if the work was cancelled before it started to excute, false
> > > > otherwise.
> > > > + */
> > > > +bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work)
> > > > +{
> > > > +	struct drm_vblank_crtc *vblank = work->vblank;
> > > > +	bool cancelled;
> > > > +	long ret;
> > > > +
> > > > +	spin_lock_irq(&vblank->dev->event_lock);
> > > > +
> > > > +	cancelled = vblank_work_cancel(work);
> > > > +
> > > > +	ret = wait_event_lock_irq_timeout(vblank-
> > > > >vblank_work.work_wait,
> > > > +					  work->state ==
> > > > DRM_VBL_WORK_IDLE,
> > > > +					  vblank->dev->event_lock,
> > > > +					  10 * HZ);
> > > > +
> > > > +	spin_unlock_irq(&vblank->dev->event_lock);
> > > > +
> > > > +	WARN(!ret, "crtc %d vblank work timed out\n", vblank->pipe);
> > > > +
> > > > +	return cancelled;
> > > > +}
> > > > +EXPORT_SYMBOL(drm_vblank_work_cancel_sync);
> > > > +
> > > > +/**
> > > > + * drm_vblank_work_flush - wait for a scheduled vblank work to finish
> > > > excuting
> > > > + * @work: vblank work to flush
> > > > + *
> > > > + * Wait until @work has finished executing.
> > > > + */
> > > > +void drm_vblank_work_flush(struct drm_vblank_work *work)
> > > > +{
> > > > +	struct drm_vblank_crtc *vblank = work->vblank;
> > > > +	long ret;
> > > > +
> > > > +	spin_lock_irq(&vblank->dev->event_lock);
> > > > +
> > > > +	ret = wait_event_lock_irq_timeout(vblank-
> > > > >vblank_work.work_wait,
> > > > +					  work->state ==
> > > > DRM_VBL_WORK_IDLE,
> > > > +					  vblank->dev->event_lock,
> > > > +					  10 * HZ);
> > > > +
> > > > +	spin_unlock_irq(&vblank->dev->event_lock);
> > > > +
> > > > +	WARN(!ret, "crtc %d vblank work timed out\n", vblank->pipe);
> > > > +}
> > > > +EXPORT_SYMBOL(drm_vblank_work_flush);
> > > > diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> > > > index dd9f5b9e56e4..ac9130f419af 100644
> > > > --- a/include/drm/drm_vblank.h
> > > > +++ b/include/drm/drm_vblank.h
> > > > @@ -203,8 +203,42 @@ struct drm_vblank_crtc {
> > > >  	 * disabling functions multiple times.
> > > >  	 */
> > > >  	bool enabled;
> > > > +
> > > > +	struct {
> > > > +		struct task_struct *thread;
> > > > +		struct list_head irq_list, work_list;
> > > > +		wait_queue_head_t work_wait;
> > > > +	} vblank_work;
> > > > +};
> > > > +
> > > > +struct drm_vblank_work {
> > > > +	u64 count;
> > > > +	struct drm_vblank_crtc *vblank;
> > > > +	void (*func)(struct drm_vblank_work *work, u64 count);
> > > > +	struct list_head list;
> > > > +	enum {
> > > > +		DRM_VBL_WORK_IDLE,
> > > > +		DRM_VBL_WORK_WAITING,
> > > > +		DRM_VBL_WORK_SCHEDULED,
> > > > +		DRM_VBL_WORK_RUNNING,
> > > > +	} state;
> > > > +	bool cancel : 1;
> > > > +	bool reschedule : 1;
> > > >  };
> > > >  
> > > > +int drm_vblank_work_schedule(struct drm_vblank_work *work,
> > > > +			     u64 count, bool nextonmiss);
> > > > +void drm_vblank_work_init(struct drm_vblank_work *work, struct
> > > > drm_crtc
> > > > *crtc,
> > > > +			  void (*func)(struct drm_vblank_work *work,
> > > > u64
> > > > count));
> > > > +bool drm_vblank_work_cancel(struct drm_vblank_work *work);
> > > > +bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work);
> > > > +void drm_vblank_work_flush(struct drm_vblank_work *work);
> > > > +
> > > > +static inline bool drm_vblank_work_pending(struct drm_vblank_work
> > > > *work)
> > > > +{
> > > > +	return work->state != DRM_VBL_WORK_IDLE;
> > > > +}
> > > > +
> > > >  int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
> > > >  bool drm_dev_has_vblank(const struct drm_device *dev);
> > > >  u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
> > > > -- 
> > > > 2.24.1
> > > > 
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat

