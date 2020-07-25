Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2284FC433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 15:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8314206E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 15:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Yt7HaEgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgGYP6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 11:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 11:58:10 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F18C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 08:58:09 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h1so9227757otq.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMTeRctRE65sgGGEJ5FRo/hySDzTmJpJ4TGTKDrwgxs=;
        b=Yt7HaEgSQp8Wf85TszOP8/4HCHkOH9JPDy0kYTFyuuR89vnhlG/EfPVFmUvIvJAoQV
         XnKjWG27b0mWHz8wNpSruxWbBaH/TwAi7uSfdfD49c3L/93+fqDYlMvAXXItZXh1MwPT
         dbSLkHU+vbrSl3OSmmNpb4vMDYTWI0ehB0i1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMTeRctRE65sgGGEJ5FRo/hySDzTmJpJ4TGTKDrwgxs=;
        b=KvMHl6WBvo4ayTH89wQnnoDb6AoyNyV5/fAxfQbZjI+6mR3/WhvyRUF0SIIRpNK0uB
         3GwddCGa0tvxecKnLju8guzDivV9s6duwXji1wQJxsrkP1v5AHlSo48nTIManSxydRhz
         tDKys7ar9FDy50AcdO1ulW3z3b810E6Og2ZpdX1AFKQNM90vZEWtxPhypQE2e1NEvXwB
         ki8SJ713L2Dnn4N64OOaF/YkHz0KSEj1G8xE5eljBNbhI+pr5OpGlog4MJ1Q0ieuPKx3
         EuQwysHjo25ZhLbIE1pskgi3MS5UoCs7dd7Qv3lefnOaq5UeTACGTNJdZa5zCknrFZec
         sAsQ==
X-Gm-Message-State: AOAM531xxjCSABKV5pnFlN+dpXR6hEHMkHa2JOZfJRsEZv1rUuJxh/8r
        npZPqx8KrwXMMpAj7Mdeah1ZllVJVRysQtQY2aqYyQ==
X-Google-Smtp-Source: ABdhPJyXMLpNtufgbd1Zb5G1Ld1PbT33HGQa8aXs5e3QXYJHVRvWLUGTqDR7z+3bJtE8KDVaGcRgBk/xHAIZFUV+Mh4=
X-Received: by 2002:a05:6830:1613:: with SMTP id g19mr13129583otr.303.1595692688776;
 Sat, 25 Jul 2020 08:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200722110411.ebkv6knvc6mzw5uf@smtp.gmail.com>
 <20200722120502.GK6419@phenom.ffwll.local> <20200722140604.27dfzfnzug5vb75r@smtp.gmail.com>
 <CAKMK7uHWCnJ+3YnP2FwVGH6cEDkmPnH9ALjY_1R51QVs0HPG0Q@mail.gmail.com> <20200725011737.GA2851@realwakka>
In-Reply-To: <20200725011737.GA2851@realwakka>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sat, 25 Jul 2020 17:57:57 +0200
Message-ID: <CAKMK7uEWPCzx+K=+nJsLT5HRBVJ+s8tqx30Ljkr4BCBDComyWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: add missing drm_crtc_vblank_put to the get/put
 pair on flush
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 5:12 AM Sidong Yang <realwakka@gmail.com> wrote:
>
> On Wed, Jul 22, 2020 at 05:17:05PM +0200, Daniel Vetter wrote:
> > On Wed, Jul 22, 2020 at 4:06 PM Melissa Wen <melissa.srw@gmail.com> wrote:
> > >
> > > On 07/22, daniel@ffwll.ch wrote:
> > > > On Wed, Jul 22, 2020 at 08:04:11AM -0300, Melissa Wen wrote:
> > > > > This patch adds a missing drm_crtc_vblank_put op to the pair
> > > > > drm_crtc_vblank_get/put (inc/decrement counter to guarantee vblanks).
> > > > >
> > > > > It clears the execution of the following kms_cursor_crc subtests:
> > > > > 1. pipe-A-cursor-[size,alpha-opaque, NxN-(on-screen, off-screen, sliding,
> > > > >    random, fast-moving])] - successful when running individually.
> > > > > 2. pipe-A-cursor-dpms passes again
> > > > > 3. pipe-A-cursor-suspend also passes
> > > > >
> > > > > The issue was initially tracked in the sequential execution of IGT
> > > > > kms_cursor_crc subtest: when running the test sequence or one of its
> > > > > subtests twice, the odd execs complete and the pairs get stuck in an
> > > > > endless wait. In the IGT code, calling a wait_for_vblank before the start
> > > > > of CRC capture prevented the busy-wait. But the problem persisted in the
> > > > > pipe-A-cursor-dpms and -suspend subtests.
> > > > >
> > > > > Checking the history, the pipe-A-cursor-dpms subtest was successful when,
> > > > > in vkms_atomic_commit_tail, instead of using the flip_done op, it used
> > > > > wait_for_vblanks. Another way to prevent blocking was wait_one_vblank when
> > > > > enabling crtc. However, in both cases, pipe-A-cursor-suspend persisted
> > > > > blocking in the 2nd start of CRC capture, which may indicate that
> > > > > something got stuck in the step of CRC setup. Indeed, wait_one_vblank in
> > > > > the crc setup was able to sync things and free all kms_cursor_crc
> > > > > subtests.
> > > > >
> > > > > Tracing and comparing a clean run with a blocked one:
> > > > > - in a clean one, vkms_crtc_atomic_flush enables vblanks;
> > > > > - when blocked, only in next op, vkms_crtc_atomic_enable, the vblanks
> > > > > started. Moreover, a series of vkms_vblank_simulate flow out until
> > > > > disabling vblanks.
> > > > > Also watching the steps of vkms_crtc_atomic_flush, when the very first
> > > > > drm_crtc_vblank_get returned an error, the subtest crashed. On the other
> > > > > hand, when vblank_get succeeded, the subtest completed. Finally, checking
> > > > > the flush steps: it increases counter to hold a vblank reference (get),
> > > > > but there isn't a op to decreased it and release vblanks (put).
> > > > >
> > > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > > > > Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> > > > > ---
> > > > >  drivers/gpu/drm/vkms/vkms_crtc.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > index ac85e17428f8..a99d6b4a92dd 100644
> > > > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > @@ -246,6 +246,7 @@ static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
> > > > >
> > > > >             spin_unlock(&crtc->dev->event_lock);
> > > > >
> > > > > +           drm_crtc_vblank_put(crtc);
> > > >
> > > > Uh so I reviewed this a bit more carefully now, and I dont think this is
> > > > the correct bugfix. From the kerneldoc of drm_crtc_arm_vblank_event():
> > > >
> > > >  * Caller must hold a vblank reference for the event @e acquired by a
> > > >  * drm_crtc_vblank_get(), which will be dropped when the next vblank arrives.
> > > >
> > > > So when we call drm_crtc_arm_vblank_event then the vblank_put gets called
> > > > for us. And that's the only case where we successfully acquired a vblank
> > > > interrupt reference since on failure of drm_crtc_vblank_get (0 indicates
> > > > success for that function, failure negative error number) we directly send
> > > > out the event.
> > > >
> > > > So something else fishy is going on, and now I'm totally confused why this
> > > > even happens.
> > > >
> > > > We also have a pile of WARN_ON checks in drm_crtc_vblank_put to make sure
> > > > we don't underflow the refcount, so it's also not that I think (except if
> > > > this patch creates more WARNING backtraces).
> > > >
> > > > But clearly it changes behaviour somehow ... can you try to figure out
> > > > what changes? Maybe print out the vblank->refcount at various points in
> > > > the driver, and maybe also trace when exactly the fake vkms vblank hrtimer
> > > > is enabled/disabled ...
> > >
> > > :(
> > >
> > > I can check these, but I also have other suspicions. When I place the
> > > drm_crct_vblank_put out of the if (at the end of flush), it not only solve
> > > the issue of blocking on kms_cursor_crc, but also the WARN_ON on kms_flip
> > > doesn't appear anymore (a total cleanup). Just after:
> > >
> > > vkms_output->composer_state = to_vkms_crtc_state(crtc->state);
> > >
> > > looks like there is something stuck around here.
> >
> > Hm do you have the full WARNING for this? Maybe this gives me an idea
> > what's going wrong.
> >
> > > Besides, there is a lock at atomic_begin:
> > >
> > >   /* This lock is held across the atomic commit to block vblank timer
> > >    * from scheduling vkms_composer_worker until the composer is updated
> > >    */
> > >   spin_lock_irq(&vkms_output->lock);
> > >
> > > that seems to be released on atomic_flush and make me suspect something
> > > missing on the composer update.
> >
> > atomic_begin/atomic_flush are symmetric functions an always called
> > around all the plane updates. So having the spin_lock in _begin and
> > the spin_unlock in _flush should be symmetric and correct.
> >
> > If you want to make sure, recompile with CONFIG_PROVE_LOCKING, which
> > should immmediately give you a huge splat in dmesg if there's anything
> > unbalanced with locking.
> >
> > > I'll check all these things and come back with news (hope) :)
> >
> > Have fun chasing stuff :-)
> >
> > Cheers, Daniel
> >
> >
> > >
> > > Thanks,
> > >
> > > Melissa
> > > >
> > > > I'm totally confused about what's going on here now.
> > > > -Daniel
>
> Hi Daniel, Melissa.
> I found something about this problem.
> I traced vblank->refcount that it's important in the problem.
> In normal case, first test run calls commit_tail() and enable vblank in
> atomic_flush(). in drm_vblank_get(), it enable vblank when refcount was zero.
>
> in first test run, it disable crtc for cleanup test. drm_crtc_vblank_off() was
> called by atomic_disable. in this function vblank's refcount was increased for
> prevent subsequent drm_vblank_get() from re-enabling the vblank interrupt.
> and refcount goes one not zero for next test run.
>
> and next test run, drm_vblank_get() was called but it didn't enable vblank
> because refcount was already one. drm_crtc_vblank_on() was called in next. but
> it didn't enable vblank but just increase refcount only.
>
> I think this is why this problem happen. don't know how to fix this correctly.
> should we force to enable vblank after enabling crtc?

Hm, between drm_crtc_vblank_off and drm_crtc_vblank_on
drm_crtc_vblank_get should fail (and leave the refcount unchanged).
It's convoluted logic, but the check for vblank->enabled should catch
that and return -EINVAL for this case. Does that not happen?

It would indeed explain the bug (I think, I've been wrong way too many
times with this).
-Daniel

>
> Thanks
> -Sidong
>
> > > >
> > > > >             crtc->state->event = NULL;
> > > > >     }
> > > > >
> > > > > --
> > > > > 2.27.0
> > > > >
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
