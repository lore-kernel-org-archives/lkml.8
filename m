Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7040C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D482075F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0o2gV2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgG2TJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2TJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:09:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7A5C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:09:18 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so26234518ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3E/n7SEOLfdVqaMc+ZNZ/xbVrdyvcJQLqOe+cI8nFtw=;
        b=J0o2gV2z7hIPW5LMYE9S3Us3GOm4ob5f1F3qTFqQOiNaOuHHcLWnzv6s3l0K8frY4l
         ak3WVVsBUuj7wlzNhsKD3fyw3fTJt9+TCq55ul6ZXNbKOniZis65cj8yQbpcvaGiED2V
         tR2ZNuOFw3kZ4f5PMaVQCkLzQ/hddwh0Zbw/Q710rz+QfTC6ZjNs/Ig/Mm9/hWHhQF4P
         vyOIm2rYSNmrIoj9EM+ETwlMKJnNLDdni+sUtdPDa5E/AIsto/WAPnkYkxGpCoa35Acp
         +d602R0mOfnk/kc/wrT9DE69w3iDb+0P5VsgdRE/rL5AEiBl1OLnCSWvXXxhvoGZVJ2t
         wDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3E/n7SEOLfdVqaMc+ZNZ/xbVrdyvcJQLqOe+cI8nFtw=;
        b=Y2Jm3Ahu/ekBjzDa2BW2tHV+ee4IggF9BjTuwBAaIgnWM3hHElT7Ch02vejV3kI2SZ
         DXqhHnjyPqTLpDQiQmZgSFmFl5RDUKUUc/vmk6KwPJ/msoeTKn0b1+XDlzzHUy9PPW+o
         XFswtq1IS+1v8us8lK1x80mobci1vGBAdehYTP0w1I4UGgpOCcSGz8GLhENQhlyUsWuZ
         KhNCoavSnG4JPsSZR38pfvwpABhdYdHdYPBpPHthwldIWo9FmCsxYVvx1Ed8bOFC41ah
         cuhfRUwZtcxlIydjh0u/fk19Ww9MPyTJyj05rIZIrDsslCu1/daDEtmV2w8uZDPoqmgh
         85qQ==
X-Gm-Message-State: AOAM530NI0DtLhPUFppBVQfUImc1CSMiYYj60djVrG7jbMgRvYxLNj1r
        IicPYCIPCsRVYHgkd9iz+HMihcpHiRb6bFJUePQ=
X-Google-Smtp-Source: ABdhPJwvc3maO9expGbL+lDViIahU1LQibDFksKUNMk1j+Cp9XAg7kD1Plzax3ehzBoXfJWjCTg8ks+28MDfm7Eu/yk=
X-Received: by 2002:a2e:8858:: with SMTP id z24mr15860503ljj.425.1596049756457;
 Wed, 29 Jul 2020 12:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200722110411.ebkv6knvc6mzw5uf@smtp.gmail.com>
 <20200722120502.GK6419@phenom.ffwll.local> <20200722140604.27dfzfnzug5vb75r@smtp.gmail.com>
 <CAKMK7uHWCnJ+3YnP2FwVGH6cEDkmPnH9ALjY_1R51QVs0HPG0Q@mail.gmail.com>
 <20200725011737.GA2851@realwakka> <CAKMK7uEWPCzx+K=+nJsLT5HRBVJ+s8tqx30Ljkr4BCBDComyWQ@mail.gmail.com>
 <20200725174514.esh4gqek6oddizvh@smtp.gmail.com> <CAKMK7uEi0UFSwYTO7h6_YKN+UykOuVcmhMSG_ySy9uyo_7Pz-g@mail.gmail.com>
In-Reply-To: <CAKMK7uEi0UFSwYTO7h6_YKN+UykOuVcmhMSG_ySy9uyo_7Pz-g@mail.gmail.com>
From:   Melissa Wen <melissa.srw@gmail.com>
Date:   Wed, 29 Jul 2020 16:09:05 -0300
Message-ID: <CAJeY4oGXbNbFQtBXSi8xo_mk48G1K7TOvxPqvRKFxGQxRnY=Wg@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: add missing drm_crtc_vblank_put to the get/put
 pair on flush
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sidong Yang <realwakka@gmail.com>,
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

Melissa Wen

On Sat, Jul 25, 2020 at 3:12 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Sat, Jul 25, 2020 at 7:45 PM Melissa Wen <melissa.srw@gmail.com> wrote:
> >
> > On 07/25, Daniel Vetter wrote:
> > > On Sat, Jul 25, 2020 at 5:12 AM Sidong Yang <realwakka@gmail.com> wrote:
> > > >
> > > > On Wed, Jul 22, 2020 at 05:17:05PM +0200, Daniel Vetter wrote:
> > > > > On Wed, Jul 22, 2020 at 4:06 PM Melissa Wen <melissa.srw@gmail.com> wrote:
> > > > > >
> > > > > > On 07/22, daniel@ffwll.ch wrote:
> > > > > > > On Wed, Jul 22, 2020 at 08:04:11AM -0300, Melissa Wen wrote:
> > > > > > > > This patch adds a missing drm_crtc_vblank_put op to the pair
> > > > > > > > drm_crtc_vblank_get/put (inc/decrement counter to guarantee vblanks).
> > > > > > > >
> > > > > > > > It clears the execution of the following kms_cursor_crc subtests:
> > > > > > > > 1. pipe-A-cursor-[size,alpha-opaque, NxN-(on-screen, off-screen, sliding,
> > > > > > > >    random, fast-moving])] - successful when running individually.
> > > > > > > > 2. pipe-A-cursor-dpms passes again
> > > > > > > > 3. pipe-A-cursor-suspend also passes
> > > > > > > >
> > > > > > > > The issue was initially tracked in the sequential execution of IGT
> > > > > > > > kms_cursor_crc subtest: when running the test sequence or one of its
> > > > > > > > subtests twice, the odd execs complete and the pairs get stuck in an
> > > > > > > > endless wait. In the IGT code, calling a wait_for_vblank before the start
> > > > > > > > of CRC capture prevented the busy-wait. But the problem persisted in the
> > > > > > > > pipe-A-cursor-dpms and -suspend subtests.
> > > > > > > >
> > > > > > > > Checking the history, the pipe-A-cursor-dpms subtest was successful when,
> > > > > > > > in vkms_atomic_commit_tail, instead of using the flip_done op, it used
> > > > > > > > wait_for_vblanks. Another way to prevent blocking was wait_one_vblank when
> > > > > > > > enabling crtc. However, in both cases, pipe-A-cursor-suspend persisted
> > > > > > > > blocking in the 2nd start of CRC capture, which may indicate that
> > > > > > > > something got stuck in the step of CRC setup. Indeed, wait_one_vblank in
> > > > > > > > the crc setup was able to sync things and free all kms_cursor_crc
> > > > > > > > subtests.
> > > > > > > >
> > > > > > > > Tracing and comparing a clean run with a blocked one:
> > > > > > > > - in a clean one, vkms_crtc_atomic_flush enables vblanks;
> > > > > > > > - when blocked, only in next op, vkms_crtc_atomic_enable, the vblanks
> > > > > > > > started. Moreover, a series of vkms_vblank_simulate flow out until
> > > > > > > > disabling vblanks.
> > > > > > > > Also watching the steps of vkms_crtc_atomic_flush, when the very first
> > > > > > > > drm_crtc_vblank_get returned an error, the subtest crashed. On the other
> > > > > > > > hand, when vblank_get succeeded, the subtest completed. Finally, checking
> > > > > > > > the flush steps: it increases counter to hold a vblank reference (get),
> > > > > > > > but there isn't a op to decreased it and release vblanks (put).
> > > > > > > >
> > > > > > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > > > > > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > > > > > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > > > > > > > Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/vkms/vkms_crtc.c | 1 +
> > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > > > > index ac85e17428f8..a99d6b4a92dd 100644
> > > > > > > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > > > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > > > > @@ -246,6 +246,7 @@ static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
> > > > > > > >
> > > > > > > >             spin_unlock(&crtc->dev->event_lock);
> > > > > > > >
> > > > > > > > +           drm_crtc_vblank_put(crtc);
> > > > > > >
> > > > > > > Uh so I reviewed this a bit more carefully now, and I dont think this is
> > > > > > > the correct bugfix. From the kerneldoc of drm_crtc_arm_vblank_event():
> > > > > > >
> > > > > > >  * Caller must hold a vblank reference for the event @e acquired by a
> > > > > > >  * drm_crtc_vblank_get(), which will be dropped when the next vblank arrives.
> > > > > > >
> > > > > > > So when we call drm_crtc_arm_vblank_event then the vblank_put gets called
> > > > > > > for us. And that's the only case where we successfully acquired a vblank
> > > > > > > interrupt reference since on failure of drm_crtc_vblank_get (0 indicates
> > > > > > > success for that function, failure negative error number) we directly send
> > > > > > > out the event.
> > > > > > >
> > > > > > > So something else fishy is going on, and now I'm totally confused why this
> > > > > > > even happens.
> > > > > > >
> > > > > > > We also have a pile of WARN_ON checks in drm_crtc_vblank_put to make sure
> > > > > > > we don't underflow the refcount, so it's also not that I think (except if
> > > > > > > this patch creates more WARNING backtraces).
> > > > > > >
> > > > > > > But clearly it changes behaviour somehow ... can you try to figure out
> > > > > > > what changes? Maybe print out the vblank->refcount at various points in
> > > > > > > the driver, and maybe also trace when exactly the fake vkms vblank hrtimer
> > > > > > > is enabled/disabled ...
> > > > > >
> > > > > > :(
> > > > > >
> > > > > > I can check these, but I also have other suspicions. When I place the
> > > > > > drm_crct_vblank_put out of the if (at the end of flush), it not only solve
> > > > > > the issue of blocking on kms_cursor_crc, but also the WARN_ON on kms_flip
> > > > > > doesn't appear anymore (a total cleanup). Just after:
> > > > > >
> > > > > > vkms_output->composer_state = to_vkms_crtc_state(crtc->state);
> > > > > >
> > > > > > looks like there is something stuck around here.
> > > > >
> > > > > Hm do you have the full WARNING for this? Maybe this gives me an idea
> > > > > what's going wrong.
> > > > >
> > > > > > Besides, there is a lock at atomic_begin:
> > > > > >
> > > > > >   /* This lock is held across the atomic commit to block vblank timer
> > > > > >    * from scheduling vkms_composer_worker until the composer is updated
> > > > > >    */
> > > > > >   spin_lock_irq(&vkms_output->lock);
> > > > > >
> > > > > > that seems to be released on atomic_flush and make me suspect something
> > > > > > missing on the composer update.
> > > > >
> > > > > atomic_begin/atomic_flush are symmetric functions an always called
> > > > > around all the plane updates. So having the spin_lock in _begin and
> > > > > the spin_unlock in _flush should be symmetric and correct.
> > > > >
> > > > > If you want to make sure, recompile with CONFIG_PROVE_LOCKING, which
> > > > > should immmediately give you a huge splat in dmesg if there's anything
> > > > > unbalanced with locking.
> > > > >
> > > > > > I'll check all these things and come back with news (hope) :)
> > > > >
> > > > > Have fun chasing stuff :-)
> > > > >
> > > > > Cheers, Daniel
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > Melissa
> > > > > > >
> > > > > > > I'm totally confused about what's going on here now.
> > > > > > > -Daniel
> > > >
> > > > Hi Daniel, Melissa.
> > > > I found something about this problem.
> > > > I traced vblank->refcount that it's important in the problem.
> > > > In normal case, first test run calls commit_tail() and enable vblank in
> > > > atomic_flush(). in drm_vblank_get(), it enable vblank when refcount was zero.
> > > >
> > > > in first test run, it disable crtc for cleanup test. drm_crtc_vblank_off() was
> > > > called by atomic_disable. in this function vblank's refcount was increased for
> > > > prevent subsequent drm_vblank_get() from re-enabling the vblank interrupt.
> > > > and refcount goes one not zero for next test run.
> > > >
> > > > and next test run, drm_vblank_get() was called but it didn't enable vblank
> > > > because refcount was already one. drm_crtc_vblank_on() was called in next. but
> > > > it didn't enable vblank but just increase refcount only.
> > > >
> > > > I think this is why this problem happen. don't know how to fix this correctly.
> > > > should we force to enable vblank after enabling crtc?
> > >
> > > Hm, between drm_crtc_vblank_off and drm_crtc_vblank_on
> > > drm_crtc_vblank_get should fail (and leave the refcount unchanged).
> > > It's convoluted logic, but the check for vblank->enabled should catch
> > > that and return -EINVAL for this case. Does that not happen?
> > >
> > > It would indeed explain the bug (I think, I've been wrong way too many
> > > times with this).
> > > -Daniel
> > >
> > Hi Daniel and Sidong,
> >
> > I don't know if it will be confusing, but I will try to explain in a
> > little more detail (and newbie way) what I saw in this behavior of the
> > refcount (similar to what Sidong evaluated).
> >
> > 1. Starting with the loading of vkms is:
> > In vkms_init:
> > After drm_vblank_init (refcount=0), it calls:
> > vkms_modeset_init
> > --> vkms_output_init
> > ----> drm_mode_config_reset
> > -------> vkms_atomic_crtc_reset
> > (even more inside)--> drm_crtc_vblank_reset that bumps the refcount to
> > prevent vblank_get to enable vblank (refcount=1)
> >
> > 2. So, when we start a subtest, vblank is still disabled and in
> > commit_tail, commit_planes triggers a atomic_begin/flush->vblank_get that
> > return -EINVAL because !vblank->enabled (refcount ends 1) and send_vblank;
> > however the test fails before atomic_enable decrements refcount to 0 and
> > reset timestamp.
> > ** This warning also appears in this very first running:
> > WARNING: CPU: 0 PID: 708 at drivers/gpu/drm/vkms/vkms_crtc.c:91 vkms_get_vblank_timestamp+0x41/0x50 [vkms]
>
> Hm yeah I guess that's something we should paper over a bit, but maybe
> the bugfix will take care of that.
>
> > In the end, this sequence modeset_disable -> atomic_begin ->
> > atomic_flush: refcount going from 0 to 1 and than drm_vblank_enable
> > prepares to everything going well in the next subtest (because
> > atomic_disable is not called).
> >
> > 3. It could be nice, but in the next subtest (with success), as refcount +
> > vblank_enabled ok, after doind its job, it calls
> > atomic_disable->vblank_off and here refcount ends 1 and vblank disabled
> > (the problem returns).
> > So, we have a kind of good turn and bad turn.
> >
> > I tried different things, but the only relatively stable result was
> > putting the sequence modeset_disable + modeset_enables + commit_planes in
> > the commit_tail. That didn't convince me and then I keep trying things.
>
> This actually sounds like a good idea, I had the same one. Doing it
> this way should also resolve the WARNING you've pointed out I think?

Hi Daniel,

My uncertainty in this idea was related to a subtest, the cursor-suspend.
Although the reordering solves most of the blocking in kms-cursor-crc, the
suspend subtest fails because when vkms suspends, it disables vblank,
and when it resumes, vblank is not enabled in time. In this subtest, there is
a pipe-crc-start and adding a igt_wait_for_vblank solves... but again,
I know it is not the real fix.

Would be the case to develop a specific feature of suspend/resume in vkms?
I mean, something to enable vblank when resume. I am trying to figure out how
to develop it, but still without success.

Melissa
>
> But I'm still wondering why after step 3 we don't get -EINVAL from
> vblank_get() - after vblank_off() vblank->enabled should be false
> again, getting us back to the same state as after 1. Is that not
> happening?
> -Daniel
>
> >
> > > >
> > > > Thanks
> > > > -Sidong
> > > >
> > > > > > >
> > > > > > > >             crtc->state->event = NULL;
> > > > > > > >     }
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.27.0
> > > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Daniel Vetter
> > > > > > > Software Engineer, Intel Corporation
> > > > > > > http://blog.ffwll.ch
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Daniel Vetter
> > > > > Software Engineer, Intel Corporation
> > > > > http://blog.ffwll.ch
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> > >
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
