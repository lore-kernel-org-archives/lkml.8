Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB01C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217392070E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4wQYgf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgGYDMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 23:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYDMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:12:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30170C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 20:12:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u5so6278769pfn.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 20:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Sv+mpmEc9cecqKsmATo9ohfdalYjthMVIOv9E7m6Io=;
        b=d4wQYgf1IFR5UmOFS+vrgWLPi42iQgFG+veVH4SJ0TYVaxDC6HKWZWugkdoyv7W5Rx
         TaSIDuh/tq8zKW34oSDYh9SWZ86m+80Lx0HKmz2Z4omtnTv9cOk9qSq2PpC2FWWuqNyk
         /ZVPLKBstqFfb3AgHA9V7QoQ/R3DtE1GQxzaRxFijN3qURBqzidSEssNZHgRsxk5zWhd
         pO+e/yHZ1WhN9n0cvIyLCVEi5uF4/GUZS0MfBoNp2vRoYkcczz/NY5DVpEn+PKCY4Ltj
         mXFU9i9RwYjdQKRH7QklCQKfFU3PgxxKnbrfVMWE0REo/OAjduOg19W3dREWyx11EvYA
         Eq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Sv+mpmEc9cecqKsmATo9ohfdalYjthMVIOv9E7m6Io=;
        b=UEmVooVPvUffY+CaU0ecp/EWC3UBwLGj2iN5bPggaLdM1GEbZN2Z5kcPrG+bbRA5b/
         brp4HKq5rTmT5guIw8+40Csyf3QSuWHQ000S8FcA3LkA46Wm8h5ph5aNkjv1fRuuzINZ
         HJMJqqkjXcVgozmMbSU0eou1DqIQdVbzy8IMYcV2XvlBQqrh48aTWzRhDxhsNg/jZ/Zd
         gWYKsfUYp795bVdSioIbC46poJf4y0uRlIoVOrn1U/jK1srNXbeIdVCleQXurx6N7IvB
         qfjzJUCLFVrDNGFfwl83AsAshkXmoO63tjR5b1ksv5zDWXRDVK6xXOO4QK39v/S/VuGu
         TDng==
X-Gm-Message-State: AOAM532S1RAyI/5BLUD1fVwXLtfQRnIBdmsjsVGuS2fCxh0QyWPtDYJ3
        xDUe1sOM3OveFcYuDAx8jSw=
X-Google-Smtp-Source: ABdhPJxshuzT3nHNdT/e6Wx0P+I8jNX6uQWiYIdptXTIkrKI0CMtYr088XEw9xwISS7rmPMx7Jl8wQ==
X-Received: by 2002:aa7:9419:: with SMTP id x25mr11790741pfo.67.1595646771675;
        Fri, 24 Jul 2020 20:12:51 -0700 (PDT)
Received: from realwakka ([168.126.185.84])
        by smtp.gmail.com with ESMTPSA id y7sm6817411pjp.47.2020.07.24.20.12.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 20:12:50 -0700 (PDT)
Date:   Sat, 25 Jul 2020 01:17:37 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Melissa Wen <melissa.srw@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH] drm/vkms: add missing drm_crtc_vblank_put to the get/put
 pair on flush
Message-ID: <20200725011737.GA2851@realwakka>
References: <20200722110411.ebkv6knvc6mzw5uf@smtp.gmail.com>
 <20200722120502.GK6419@phenom.ffwll.local>
 <20200722140604.27dfzfnzug5vb75r@smtp.gmail.com>
 <CAKMK7uHWCnJ+3YnP2FwVGH6cEDkmPnH9ALjY_1R51QVs0HPG0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHWCnJ+3YnP2FwVGH6cEDkmPnH9ALjY_1R51QVs0HPG0Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 05:17:05PM +0200, Daniel Vetter wrote:
> On Wed, Jul 22, 2020 at 4:06 PM Melissa Wen <melissa.srw@gmail.com> wrote:
> >
> > On 07/22, daniel@ffwll.ch wrote:
> > > On Wed, Jul 22, 2020 at 08:04:11AM -0300, Melissa Wen wrote:
> > > > This patch adds a missing drm_crtc_vblank_put op to the pair
> > > > drm_crtc_vblank_get/put (inc/decrement counter to guarantee vblanks).
> > > >
> > > > It clears the execution of the following kms_cursor_crc subtests:
> > > > 1. pipe-A-cursor-[size,alpha-opaque, NxN-(on-screen, off-screen, sliding,
> > > >    random, fast-moving])] - successful when running individually.
> > > > 2. pipe-A-cursor-dpms passes again
> > > > 3. pipe-A-cursor-suspend also passes
> > > >
> > > > The issue was initially tracked in the sequential execution of IGT
> > > > kms_cursor_crc subtest: when running the test sequence or one of its
> > > > subtests twice, the odd execs complete and the pairs get stuck in an
> > > > endless wait. In the IGT code, calling a wait_for_vblank before the start
> > > > of CRC capture prevented the busy-wait. But the problem persisted in the
> > > > pipe-A-cursor-dpms and -suspend subtests.
> > > >
> > > > Checking the history, the pipe-A-cursor-dpms subtest was successful when,
> > > > in vkms_atomic_commit_tail, instead of using the flip_done op, it used
> > > > wait_for_vblanks. Another way to prevent blocking was wait_one_vblank when
> > > > enabling crtc. However, in both cases, pipe-A-cursor-suspend persisted
> > > > blocking in the 2nd start of CRC capture, which may indicate that
> > > > something got stuck in the step of CRC setup. Indeed, wait_one_vblank in
> > > > the crc setup was able to sync things and free all kms_cursor_crc
> > > > subtests.
> > > >
> > > > Tracing and comparing a clean run with a blocked one:
> > > > - in a clean one, vkms_crtc_atomic_flush enables vblanks;
> > > > - when blocked, only in next op, vkms_crtc_atomic_enable, the vblanks
> > > > started. Moreover, a series of vkms_vblank_simulate flow out until
> > > > disabling vblanks.
> > > > Also watching the steps of vkms_crtc_atomic_flush, when the very first
> > > > drm_crtc_vblank_get returned an error, the subtest crashed. On the other
> > > > hand, when vblank_get succeeded, the subtest completed. Finally, checking
> > > > the flush steps: it increases counter to hold a vblank reference (get),
> > > > but there isn't a op to decreased it and release vblanks (put).
> > > >
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > > > Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/vkms/vkms_crtc.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > index ac85e17428f8..a99d6b4a92dd 100644
> > > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > @@ -246,6 +246,7 @@ static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
> > > >
> > > >             spin_unlock(&crtc->dev->event_lock);
> > > >
> > > > +           drm_crtc_vblank_put(crtc);
> > >
> > > Uh so I reviewed this a bit more carefully now, and I dont think this is
> > > the correct bugfix. From the kerneldoc of drm_crtc_arm_vblank_event():
> > >
> > >  * Caller must hold a vblank reference for the event @e acquired by a
> > >  * drm_crtc_vblank_get(), which will be dropped when the next vblank arrives.
> > >
> > > So when we call drm_crtc_arm_vblank_event then the vblank_put gets called
> > > for us. And that's the only case where we successfully acquired a vblank
> > > interrupt reference since on failure of drm_crtc_vblank_get (0 indicates
> > > success for that function, failure negative error number) we directly send
> > > out the event.
> > >
> > > So something else fishy is going on, and now I'm totally confused why this
> > > even happens.
> > >
> > > We also have a pile of WARN_ON checks in drm_crtc_vblank_put to make sure
> > > we don't underflow the refcount, so it's also not that I think (except if
> > > this patch creates more WARNING backtraces).
> > >
> > > But clearly it changes behaviour somehow ... can you try to figure out
> > > what changes? Maybe print out the vblank->refcount at various points in
> > > the driver, and maybe also trace when exactly the fake vkms vblank hrtimer
> > > is enabled/disabled ...
> >
> > :(
> >
> > I can check these, but I also have other suspicions. When I place the
> > drm_crct_vblank_put out of the if (at the end of flush), it not only solve
> > the issue of blocking on kms_cursor_crc, but also the WARN_ON on kms_flip
> > doesn't appear anymore (a total cleanup). Just after:
> >
> > vkms_output->composer_state = to_vkms_crtc_state(crtc->state);
> >
> > looks like there is something stuck around here.
> 
> Hm do you have the full WARNING for this? Maybe this gives me an idea
> what's going wrong.
> 
> > Besides, there is a lock at atomic_begin:
> >
> >   /* This lock is held across the atomic commit to block vblank timer
> >    * from scheduling vkms_composer_worker until the composer is updated
> >    */
> >   spin_lock_irq(&vkms_output->lock);
> >
> > that seems to be released on atomic_flush and make me suspect something
> > missing on the composer update.
> 
> atomic_begin/atomic_flush are symmetric functions an always called
> around all the plane updates. So having the spin_lock in _begin and
> the spin_unlock in _flush should be symmetric and correct.
> 
> If you want to make sure, recompile with CONFIG_PROVE_LOCKING, which
> should immmediately give you a huge splat in dmesg if there's anything
> unbalanced with locking.
> 
> > I'll check all these things and come back with news (hope) :)
> 
> Have fun chasing stuff :-)
> 
> Cheers, Daniel
> 
> 
> >
> > Thanks,
> >
> > Melissa
> > >
> > > I'm totally confused about what's going on here now.
> > > -Daniel

Hi Daniel, Melissa.
I found something about this problem.
I traced vblank->refcount that it's important in the problem.
In normal case, first test run calls commit_tail() and enable vblank in 
atomic_flush(). in drm_vblank_get(), it enable vblank when refcount was zero.

in first test run, it disable crtc for cleanup test. drm_crtc_vblank_off() was
called by atomic_disable. in this function vblank's refcount was increased for
prevent subsequent drm_vblank_get() from re-enabling the vblank interrupt.
and refcount goes one not zero for next test run.

and next test run, drm_vblank_get() was called but it didn't enable vblank
because refcount was already one. drm_crtc_vblank_on() was called in next. but
it didn't enable vblank but just increase refcount only.

I think this is why this problem happen. don't know how to fix this correctly.
should we force to enable vblank after enabling crtc?

Thanks
-Sidong

> > >
> > > >             crtc->state->event = NULL;
> > > >     }
> > > >
> > > > --
> > > > 2.27.0
> > > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
