Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F2C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623FB20809
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Rt2kMTj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgG1JJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgG1JJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:09:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA75DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:09:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so15102491wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u55INkZWirsK6NQAZxkEs5ZVazhhRGpWntp9Ofr7sR8=;
        b=Rt2kMTj88D08Uugt49awJBzJvdwWdVWsAt4NmFFzNu38ZtkQw7GlCk8JwEpxhkClxX
         PbqyEcMFX/Q08dWO85av6MGjwRRO9SsgcFXJojwaQ2lVSP3JqDVPckL4yhm4aNCIFR6s
         iaHJQR3Rk8i6yQMYYXTT5AMMuCxzN+Qch4eF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=u55INkZWirsK6NQAZxkEs5ZVazhhRGpWntp9Ofr7sR8=;
        b=SqXsi9Pi4vc1Fdn4B8duptoa9WiA6UUe82O42rkqr5oqlXK7PzwEXRA/QOwm42AK1X
         V0+8H7XrGAFSgsLbFKzamRYiToR/SKd/R2qu0EMd9mcra3nVRJUEtb9XpZFiNKvJblOX
         4wG/ldgHYMLY99lvQSKtSF5I9ncfoRZqsA1aSVonZ6fLbZ5TcwNvFWAKrnHbbHIWrwKQ
         cGSSlSPc/Z9bgCPq/hAiFt8HRSvYZeRlYvjjdmuqQvyXXC9LORW1kdmJlfreTLxJqzIJ
         EHBTV8KxZZ/XBDSjof4N0q46cXFEccCzcUDDggweCBpUm4t18+pmcNzTpktmCIygOqQw
         0I4g==
X-Gm-Message-State: AOAM533pJZeckO/HxBGCOb1IM4m+Neg7GhZVjHPFrdlsa7T/zgVHycB5
        h0Q2KwTtMbIRDrR0zTdLh8mmuA==
X-Google-Smtp-Source: ABdhPJxrZc03v97sNH4i4UTTHjPVDu2m03vOCqlNBmz6FfdNbT9H2NGkD+XQtKd1H5B/3CaZfYdTRw==
X-Received: by 2002:a1c:9e06:: with SMTP id h6mr2898411wme.45.1595927340195;
        Tue, 28 Jul 2020 02:09:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t189sm3281581wmf.47.2020.07.28.02.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 02:08:57 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:08:55 +0200
From:   daniel@ffwll.ch
Cc:     Daniel Vetter <daniel@ffwll.ch>, Mazin Rezk <mnrzk@protonmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "anthony.ruhier@gmail.com" <anthony.ruhier@gmail.com>,
        Duncan <1i5t5.duncan@cox.net>, Kees Cook <keescook@chromium.org>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "mphantomx@yahoo.com.br" <mphantomx@yahoo.com.br>
Subject: Re: [PATCH] drm/amd/display: Clear dm_state for fast updates
Message-ID: <20200728090855.GZ6419@phenom.ffwll.local>
Mail-Followup-To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Mazin Rezk <mnrzk@protonmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "anthony.ruhier@gmail.com" <anthony.ruhier@gmail.com>,
        Duncan <1i5t5.duncan@cox.net>, Kees Cook <keescook@chromium.org>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "mphantomx@yahoo.com.br" <mphantomx@yahoo.com.br>
References: <M0lxN5AUlPvzBKULfIBe5BZRwfQGXeMQCdWItYcQ-9P79y32WzExYK2Y0DwyNVtyGelqbvV07_lFk1oeT4cApbT-P_oH0bnxQbMmFsJv_xg=@protonmail.com>
 <ba078fb0-0dbc-df06-cfe9-f9537883f82a@amd.com>
 <e2f55480-c24f-6c85-08d3-21131a22d0bf@amd.com>
 <3b7e3e50-2ff7-eff3-2ffc-abaa4b36ce7f@amd.com>
 <CAKMK7uHCu02P4tvhF4LQbtYeNciU61ONC9EZRmQ-0wEGFPzZgg@mail.gmail.com>
 <Fnx2lsAReNccvQbyMYBgghvef4ekiQ_ZWL0m5BwF-2h48gvnNLghI4zkIWhQwy-H6CiytTXaxEtZ83dYRlzAXeKHujBRLc_tffmcJVWjwuo=@protonmail.com>
 <CAKMK7uFAnedLTp6LJYum6gYj3xaWkuuXJr70UJ48Pxxr-4dA7w@mail.gmail.com>
 <dcc84e05-54ef-4314-a32b-3c596fccb327@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcc84e05-54ef-4314-a32b-3c596fccb327@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:49:48PM -0400, Kazlauskas, Nicholas wrote:
> On 2020-07-27 5:32 p.m., Daniel Vetter wrote:
> > On Mon, Jul 27, 2020 at 11:11 PM Mazin Rezk <mnrzk@protonmail.com> wrote:
> > > 
> > > On Monday, July 27, 2020 4:29 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > 
> > > > On Mon, Jul 27, 2020 at 9:28 PM Christian König
> > > > <christian.koenig@amd.com> wrote:
> > > > > 
> > > > > Am 27.07.20 um 16:05 schrieb Kazlauskas, Nicholas:
> > > > > > On 2020-07-27 9:39 a.m., Christian König wrote:
> > > > > > > Am 27.07.20 um 07:40 schrieb Mazin Rezk:
> > > > > > > > This patch fixes a race condition that causes a use-after-free during
> > > > > > > > amdgpu_dm_atomic_commit_tail. This can occur when 2 non-blocking
> > > > > > > > commits
> > > > > > > > are requested and the second one finishes before the first.
> > > > > > > > Essentially,
> > > > > > > > this bug occurs when the following sequence of events happens:
> > > > > > > > 
> > > > > > > > 1. Non-blocking commit #1 is requested w/ a new dm_state #1 and is
> > > > > > > > deferred to the workqueue.
> > > > > > > > 
> > > > > > > > 2. Non-blocking commit #2 is requested w/ a new dm_state #2 and is
> > > > > > > > deferred to the workqueue.
> > > > > > > > 
> > > > > > > > 3. Commit #2 starts before commit #1, dm_state #1 is used in the
> > > > > > > > commit_tail and commit #2 completes, freeing dm_state #1.
> > > > > > > > 
> > > > > > > > 4. Commit #1 starts after commit #2 completes, uses the freed dm_state
> > > > > > > > 1 and dereferences a freelist pointer while setting the context.
> > > > > > > 
> > > > > > > Well I only have a one mile high view on this, but why don't you let
> > > > > > > the work items execute in order?
> > > > > > > 
> > > > > > > That would be better anyway cause this way we don't trigger a cache
> > > > > > > line ping pong between CPUs.
> > > > > > > 
> > > > > > > Christian.
> > > > > > 
> > > > > > We use the DRM helpers for managing drm_atomic_commit_state and those
> > > > > > helpers internally push non-blocking commit work into the system
> > > > > > unbound work queue.
> > > > > 
> > > > > Mhm, well if you send those helper atomic commits in the order A,B and
> > > > > they execute it in the order B,A I would call that a bug :)
> > > > 
> > > > The way it works is it pushes all commits into unbound work queue, but
> > > > then forces serialization as needed. We do _not_ want e.g. updates on
> > > > different CRTC to be serialized, that would result in lots of judder.
> > > > And hw is funny enough that there's all kinds of dependencies.
> > > > 
> > > > The way you force synchronization is by adding other CRTC state
> > > > objects. So if DC is busted and can only handle a single update per
> > > > work item, then I guess you always need all CRTC states and everything
> > > > will be run in order. But that also totally kills modern multi-screen
> > > > compositors. Xorg isn't modern, just in case that's not clear :-)
> > > > 
> > > > Lucking at the code it seems like you indeed have only a single dm
> > > > state, so yeah global sync is what you'll need as immediate fix, and
> > > > then maybe fix up DM to not be quite so silly ... or at least only do
> > > > the dm state stuff when really needed.
> > > > 
> > > > We could also sprinkle the drm_crtc_commit structure around a bit
> > > > (it's the glue that provides the synchronization across commits), but
> > > > since your dm state is global just grabbing all crtc states
> > > > unconditionally as part of that is probably best.
> > > > 
> > > > > > While we could duplicate a copy of that code with nothing but the
> > > > > > workqueue changed that isn't something I'd really like to maintain
> > > > > > going forward.
> > > > > 
> > > > > I'm not talking about duplicating the code, I'm talking about fixing the
> > > > > helpers. I don't know that code well, but from the outside it sounds
> > > > > like a bug there.
> > > > > 
> > > > > And executing work items in the order they are submitted is trivial.
> > > > > 
> > > > > Had anybody pinged Daniel or other people familiar with the helper code
> > > > > about it?
> > > > 
> > > > Yeah something is wrong here, and the fix looks horrible :-)
> > > > 
> > > > Aside, I've also seen some recent discussion flare up about
> > > > drm_atomic_state_get/put used to paper over some other use-after-free,
> > > > but this time related to interrupt handlers. Maybe a few rules about
> > > > that:
> > > > - dont
> > > > - especially not when it's interrupt handlers, because you can't call
> > > > drm_atomic_state_put from interrupt handlers.
> > > > 
> > > > Instead have an spin_lock_irq to protect the shared date with your
> > > > interrupt handler, and _copy_ the date over. This is e.g. what
> > > > drm_crtc_arm_vblank_event does.
> > > 
> > > Nicholas wrote a patch that attempted to resolve the issue by adding every
> > > CRTC into the commit to use use the stall checks. [1] While this forces
> > > synchronisation on commits, it's kind of a hacky method that may take a
> > > toll on performance.
> > > 
> > > Is it possible to have a DRM helper that forces synchronisation on some
> > > commits without having to add every CRTC into the commit?
> > > 
> > > Also, is synchronisation really necessary for fast updates in amdgpu?
> > > I'll admit, the idea of eliminating the use-after-free bug by eliminating
> > > the use entirely doesn't seem ideal; but is forcing synchronisation on
> > > these updates that much better?
> > 
> > Well clearing the dc_state pointer here and then allocating another
> > one in atomic_commit_tail also looks fishy. The proper fix is probably
> > a lot more involved, but yeah interim fix is to grab all crtc states
> > iff you also grabbed the dm_atomic_state structure. Real fix is to
> > only do this when necessary, which pretty much means the dc_state
> > needs to be somehow split up, or there needs to be some guarantees
> > about when it's necessary and when not. Otherwise parallel commits on
> > different CRTC are not possible with the current dc backend code.
> 
> Thanks for spending some time to help take a look at this as well.
> 
> The DRM documentation (at least at the time) seemed to imply that
> subclassing DRM private state was for legacy usage only and DRM wanted to
> move away from it. DRM private objects seemed to fit as the nicer atomic
> method for handling this since they have old/new, but as you can guess from
> this issue it's a mess (from our end).

Yeah, if it's actual state you put in there. But this dc_state structure
is more like a container of state pointers, like drm_atomic_state. It's
not 100% clear-cut, e.g. the bw stuff is more like a real state object I
guess, or maybe it's just temporary storage for computation results?

> The first step to fixing this is going back to subclassing DRM state.
> 
> It's actually the right tool for the job for allocating temporary state
> outside of the core DRM objects, and we need this to form the DC state
> object and necessary stream update bundles which might be too big to fit on
> the stack for commit check/commit tail. We'll be a lot closer to fixing the
> lockdep issues this way once we get around to getting rid of allocations in
> the DC commit paths.

So on the stream bundles ... where do these pointers point to? Are the
streams themselves in the crtc/plane states?

> The second step is to fix validation itself. The old state requirement for
> checking stream/plane updates was actually an entirely pointless endeavor
> since dc global validation doesn't every look at updates, just the final
> state for a set streams/planes - it's stateless.

Uh, is your hw that good, i.e. there's no impossible state transitions? Or
do you simply force a modeset in such cases? In which case, are the
modeset flags correctly updated so that userspace can control this with
ALLOW_MODESET?

> We wanted to rely on DC to internally notify DM when DRM changes would do
> this, but DM actually requires this logic as well to know when to use a fast
> path vs a full programming path to recreate planes/streams based on the new
> DRM state to pass into validation.
> 
> State updates will change to be formed from a delta of the old/new plane
> state, but the new one can be discarded if not needed.
> 
> Any update that requires clock/bandwidth changes will have to add all the
> CRTCs and stall for any fast updates to complete first. This is because they
> could potentially reshuffle around the pipes as well, but these updates
> happen infrequently enough that the stall isn't too bad here.
> 
> DC state unfortunately still does need to exist due to requirements on
> hardware resources/pipe splitting that don't fit nicely into the DRM
> infrastructure. It's really hard to shift everything over into the DRM
> infrastructure as well because of the DKMS problem we chatted about briefly
> last year at XDC.

Uh this is awkward, holding up upstream because of downstream kernels ...

Can't you fix this with a lot more glue in the downstream kernels, stuff
like copying the entire atomic helpers into your driver when there's new
stuff?

For the multi-pipe stuff, how other drivers handle this is by internally
remapping userspace visible crtc/plane objects to underlying hw objects.
And then if you have remapping going on you add the userspace state
structs for all underlying remmapped crtc/plane in use by the current
update. That should be enough to force just enough synchronization.

Then in your hw commit functions you simple iterate over all the states in
your update, as if you'd iterate over streams directly. So example:

struct amdgpu_crtc_state {
	struct drm_crtc_state base;
	struct dm_stream_mapping_state mapping;
	/* this crtc might not be using this stream! */
	struct dm_stream_state stream;
};

I think msm works like this, but there's also other drivers.

When you have to change the mapping then you grab the global mapping
private state, but in any other cases you use the read-only copy in the
crtc state. And the global state is only for book-keeping, so no sync
needed (aside from the sync provided by adding the crtc states for each
stream you touch).

Ofc might have gotten the stream lingo wrong, but this is roughly how to
do this in atomic.

> I'd really like to tackle a third step as well at some point, and that's
> cleaning up our IRQ management. Our interrupt handlers unfortunately access
> DRM state directly (since it's so easy to do) and thus introduce a
> requirement that it doesn't get changed while these are still enabled. This
> requires us to introduce our own stall checks in atomic_check and perform
> the interrupt disable in commit before the state swap.

Yeah don't do that :-) It might work if you guarantee that the atomic
commit_tail is waiting for all your irq handlers to complete, plus use rcu
dereferencing on these pointers.

Copying the relevant bits over should be much nicer imo, also passing
explicit pointers at least. I.e. if you don't want to copy, have a
dedicated pointer protected by irqsave spin_lock that you share with the
interrupt handler. Stopping interrupt handlers before swap_state isn't
really how this should work.

> The fix for this one isn't too bad, but it's tedious - copying all the state
> we need to the interrupt handlers before enabling them and letting them
> continue to work off of that state. This way we can remove the stall from
> atomic_check and actually disable/enable interrupts from commit_tail like we
> should be doing.

Yup. I think you can have some pointers to specific state, _iff_ you make
sure the commit_tail waits for all the interrupt handlers to complete
somewhere (depending upon how this all works). But copying is probably
simpler to understand - interrupt races are tricky.
> 
> > 
> > See also my dma-fence annotation fixup patch, there dc_state also gets
> > in the way:
> > 
> > https://lore.kernel.org/dri-devel/20200707201229.472834-21-daniel.vetter@ffwll.ch/
> > 
> > Nicholas, btw I'm still waiting for some dc feedback on that entire
> > series, and what/if there's plans to fix these issues properly.
> > 
> > Maybe even going back to the subclassed drm_atomic_state might be
> > better than what we currently have.
> > -Daniel
> 
> I've taken a look at that series but forgot to ACK. While this isn't the
> same thread for it, you can have my:
> 
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> 
> ...on the DC/DM bits. Everything you've identified there is correct and it's
> something I'd really like to get around to taking a look at by the end of
> the year, hopefully.
> 
> State allocations will be solved by the DM state allocation rework and the
> tiling flags thing needs to be solved by storing those in atomic_check
> instead on the plane.
> 
> Regards,
> Nicholas Kazlauskas
> 
> > > 
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=207383#c96
> > > 
> > > Thanks,
> > > Mazin Rezk
> > > 
> > > > 
> > > > Cheers, Daniel
> > > > 
> > > > > 
> > > > > Regards,
> > > > > Christian.
> > > > > 
> > > > > > 
> > > > > > Regards,
> > > > > > Nicholas Kazlauskas
> > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > Since this bug has only been spotted with fast commits, this patch
> > > > > > > > fixes
> > > > > > > > the bug by clearing the dm_state instead of using the old dc_state for
> > > > > > > > fast updates. In addition, since dm_state is only used for its dc_state
> > > > > > > > and amdgpu_dm_atomic_commit_tail will retain the dc_state if none is
> > > > > > > > found,
> > > > > > > > removing the dm_state should not have any consequences in fast updates.
> > > > > > > > 
> > > > > > > > This use-after-free bug has existed for a while now, but only caused a
> > > > > > > > noticeable issue starting from 5.7-rc1 due to 3202fa62f ("slub:
> > > > > > > > relocate
> > > > > > > > freelist pointer to middle of object") moving the freelist pointer from
> > > > > > > > dm_state->base (which was unused) to dm_state->context (which is
> > > > > > > > dereferenced).
> > > > > > > > 
> > > > > > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207383
> > > > > > > > Fixes: bd200d190f45 ("drm/amd/display: Don't replace the dc_state
> > > > > > > > for fast updates")
> > > > > > > > Reported-by: Duncan <1i5t5.duncan@cox.net>
> > > > > > > > Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> > > > > > > > ---
> > > > > > > >    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36
> > > > > > > > ++++++++++++++-----
> > > > > > > >    1 file changed, 27 insertions(+), 9 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > > > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > > > > index 86ffa0c2880f..710edc70e37e 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > > > > @@ -8717,20 +8717,38 @@ static int amdgpu_dm_atomic_check(struct
> > > > > > > > drm_device *dev,
> > > > > > > >             * the same resource. If we have a new DC context as part of
> > > > > > > >             * the DM atomic state from validation we need to free it and
> > > > > > > >             * retain the existing one instead.
> > > > > > > > +         *
> > > > > > > > +         * Furthermore, since the DM atomic state only contains the DC
> > > > > > > > +         * context and can safely be annulled, we can free the state
> > > > > > > > +         * and clear the associated private object now to free
> > > > > > > > +         * some memory and avoid a possible use-after-free later.
> > > > > > > >             */
> > > > > > > > -        struct dm_atomic_state *new_dm_state, *old_dm_state;
> > > > > > > > 
> > > > > > > > -        new_dm_state = dm_atomic_get_new_state(state);
> > > > > > > > -        old_dm_state = dm_atomic_get_old_state(state);
> > > > > > > > +        for (i = 0; i < state->num_private_objs; i++) {
> > > > > > > > +            struct drm_private_obj *obj = state->private_objs[i].ptr;
> > > > > > > > 
> > > > > > > > -        if (new_dm_state && old_dm_state) {
> > > > > > > > -            if (new_dm_state->context)
> > > > > > > > -                dc_release_state(new_dm_state->context);
> > > > > > > > +            if (obj->funcs == adev->dm.atomic_obj.funcs) {
> > > > > > > > +                int j = state->num_private_objs-1;
> > > > > > > > 
> > > > > > > > -            new_dm_state->context = old_dm_state->context;
> > > > > > > > +                dm_atomic_destroy_state(obj,
> > > > > > > > +                        state->private_objs[i].state);
> > > > > > > > +
> > > > > > > > +                /* If i is not at the end of the array then the
> > > > > > > > +                 * last element needs to be moved to where i was
> > > > > > > > +                 * before the array can safely be truncated.
> > > > > > > > +                 */
> > > > > > > > +                if (i != j)
> > > > > > > > +                    state->private_objs[i] =
> > > > > > > > +                        state->private_objs[j];
> > > > > > > > 
> > > > > > > > -            if (old_dm_state->context)
> > > > > > > > -                dc_retain_state(old_dm_state->context);
> > > > > > > > +                state->private_objs[j].ptr = NULL;
> > > > > > > > +                state->private_objs[j].state = NULL;
> > > > > > > > +                state->private_objs[j].old_state = NULL;
> > > > > > > > +                state->private_objs[j].new_state = NULL;
> > > > > > > > +
> > > > > > > > +                state->num_private_objs = j;
> > > > > > > > +                break;
> > > > > > > > +            }
> > > > > > > >            }
> > > > > > > >        }
> > > > > > > > 
> > > > > > > > --
> > > > > > > > 2.27.0
> > > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > 
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > 
> > > > 
> > > > 
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch/
> > 
> > 
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
