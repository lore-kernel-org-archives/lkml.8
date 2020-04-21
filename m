Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53419C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A312071C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="euQ3cJaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgDUMfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbgDUMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:35:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA66C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:35:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x18so16307390wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rcuv9zZok45/Wj3VEtEchXA85grG3e+F+EQYK2BGvVs=;
        b=euQ3cJaN/vqjYl7t9h0rr8+Iv7xSNP83vHImGwVTuWXwXhw1NQoMOd4CIFDB7Etgd9
         hbIYF/4LTVaRBCXWeSTMn46IM9QWjvh9FRR4gWO/v4UBDom86HRMEF73VY7WZfGYgCJF
         NeZb+o5z5ESbSAQkbzr2gnKvLEQCe33ljVORo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Rcuv9zZok45/Wj3VEtEchXA85grG3e+F+EQYK2BGvVs=;
        b=rrQELlkkzrpaWQtUMnteZCbiSETWavb7Nx3QgGFHtFCA7Tm1K3RK2A+QJvT++8bjQG
         SWwm1UNs2Ck7nD2ff+Ol5LXJkPv87lYMszFvmiw8oP64TG+rlrGUrTz0gjtuHV0ebmHb
         j8jwVBm/lL+19Hgh486Ue9h4wgrwK8zcYVLggcNsLXeJ7eeFcJwCtgInnk+QZ/1pqV6E
         E9I0Sl7kXIviN04ZeEvL9flmJZKFKaBLNRTf+fq+773Kdv2D7FyTShm4qc0/x0TXGClU
         91qHbexdHfbD5KUA+qDyD9Wlo9qREofLp+1N9llBiPaVJqs5swI2T3Bbh0pMfl+XShvJ
         b4Cw==
X-Gm-Message-State: AGi0PubhBq1bk5lbHrwUw5MwUX8Wvzij3vL6FmRIiKs7+nr54S90IrMh
        jZZrKng3mZvpRdkof3neSezHcQ==
X-Google-Smtp-Source: APiQypLr8+PKlIrlKHW0Pay4sEh++wGhVyagS1g4lWtu15F4/Bjb2HbItpKHrCGA/Bcd8Lt3Xh9xpg==
X-Received: by 2002:a5d:6148:: with SMTP id y8mr23363738wrt.236.1587472502397;
        Tue, 21 Apr 2020 05:35:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x23sm3161978wmj.6.2020.04.21.05.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 05:35:01 -0700 (PDT)
Date:   Tue, 21 Apr 2020 14:34:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [Poke: Tejun] Re: [RFC v3 03/11] drm/vblank: Add vblank works
Message-ID: <20200421123459.GY3456981@phenom.ffwll.local>
Mail-Followup-To: Tejun Heo <tj@kernel.org>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20200417194145.36350-1-lyude@redhat.com>
 <20200417194145.36350-4-lyude@redhat.com>
 <ef9da9d93022822fe4bec7e906540fcc9852ce59.camel@redhat.com>
 <20200417210356.GD43469@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417210356.GD43469@mtj.thefacebook.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 05:03:56PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Fri, Apr 17, 2020 at 04:16:28PM -0400, Lyude Paul wrote:
> > Hey Tejun! So I ended up rewriting the drm_vblank_work stuff so that it used
> > kthread_worker. Things seem to work alright now. But while we're doing just
> > fine with vblank workers on nouveau, we're still having trouble meeting the
> > time constraints needed for using vblank works for i915's needs. There still
> > seems to be a considerable latency between when the irq handler for the vblank
> > interrupts fires, and when the actual drm_vblank_work we scheduled starts:
> ...
> > Tejun, do you have any idea if we might be able to further reduce the latency
> > from the scheduler here? I believe we're already using pm_qos to at least
> > reduce the latency between when the vblank interrupt fires and the interrupt
> > handler starts, but that still isn't enough to fix the other latency issues
> > apparently. We're also already setting the priority of kthread_worker->task to
> > RT_FIFO as well.
> 
> I don't think the kernel can do much better than what you're seeing. I don't
> know the time scale that you need - is it some tens of microseconds range? I'm
> definitely not an expert on the subject but on generic kernels I don't think
> you can achieve anything sub millisec with any kind of reliability.
> 
> If the timing is that tight and it's not a hot path, the right solution may be
> polling for it rather than yielding the cpu and hoping to get scheduled in
> time.

What we've discussed on irc is that the hand-rolled version is apparently
a bit better (but not perfect, since indeed this isn't possible without
-rt). I think we need to look more into whether that difference is real,
and why exactly it happens. From a quick look our hand-rolled worker and
kthread_worker have identical code ...

> > Also, of course, let me know if yu're not happy with the
> > __kthread_queue_work() changes/kthread_worker usage in drm_vblank_work as well
> 
> Just glanced over it and I still wonder whether it needs to be that tightly
> integrated, but we can look into that once we settle on whether this is the
> right direction.

I don't think we absolutely have to do this, simply means some nested
irq-safe spinlock. One in vblank_work, other in kthread_worker. Since the
delayed work doesn't do that I think it'd be nice if the drm_vblank
(instead of timer) delayed work could use the same pattern.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
