Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9689C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3F320786
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FRD/breX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgG0VJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0VJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:09:42 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:09:42 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o72so7801762ota.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sVrhOI0oWt1hiMCtMZYhDjKeUZIuI1k5sXWV4N3yEl8=;
        b=FRD/breXAwpWD8QDqcmN3tYazNngjpp3utCTQSmN4Z8W9aeKDSGA0A+6ME9KRj/oII
         kCjodM4aI0IPh0o3g5lhRH47NVUUO7sNHUONXUbrLPZSMZZMgwiF7JBhk6z0YwDqjoQ7
         d6Wbh//FFKXQGN9KvmYEjzczKp9Se/KXLp6iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sVrhOI0oWt1hiMCtMZYhDjKeUZIuI1k5sXWV4N3yEl8=;
        b=EHffydNSGkSWKMrMgrj1jRYoncDlHmMflme63NT3lkV0fCqLviip2aHf42sad9xu4U
         8oG+qay3SSxmGDdLp7MgSV7JzoeONNdgJCAEngaJqig4eczK7VRMAwuDtU3zWtXU/VnC
         i6EjbG9H+bFsmcSKKku065pSgtyhQJyTHn1jTTXMGMvwK0cV0x4t0Bh9Pcwd42K40Baf
         2wBoSeCSNt97FEE0+GJTFAqwOydLUy1jP2BENRsTwIUERy2BZusfJtZYz+EIRaIND1im
         ln0WH3sWv0+P0++Bdrr+UvTxzgKD48T3UQfkcM0Pup4bZnoTGuYS6yBhgt9enjVYB4qT
         M3Bw==
X-Gm-Message-State: AOAM531OJHkxs+161adJaS8BE1kAI7h7Gfq9QTi42NkkYaeTAn5STMeh
        LJVjatfFVA1vkbpSMfywrt1LrM/847gihqYoo+uR0A==
X-Google-Smtp-Source: ABdhPJz6HArexn/UOG7ZWlFLAh+o2coTB14vkM72eseTd4rWdhJcqfmDRX4ifEC9KTBIXB8KozQxeWmvvcpWfzHUma8=
X-Received: by 2002:a05:6830:1e71:: with SMTP id m17mr8548782otr.188.1595884182094;
 Mon, 27 Jul 2020 14:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <M0lxN5AUlPvzBKULfIBe5BZRwfQGXeMQCdWItYcQ-9P79y32WzExYK2Y0DwyNVtyGelqbvV07_lFk1oeT4cApbT-P_oH0bnxQbMmFsJv_xg=@protonmail.com>
 <ba078fb0-0dbc-df06-cfe9-f9537883f82a@amd.com> <e2f55480-c24f-6c85-08d3-21131a22d0bf@amd.com>
 <3b7e3e50-2ff7-eff3-2ffc-abaa4b36ce7f@amd.com> <CAKMK7uHCu02P4tvhF4LQbtYeNciU61ONC9EZRmQ-0wEGFPzZgg@mail.gmail.com>
In-Reply-To: <CAKMK7uHCu02P4tvhF4LQbtYeNciU61ONC9EZRmQ-0wEGFPzZgg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 27 Jul 2020 23:09:30 +0200
Message-ID: <CAKMK7uHo9YDOFtz4HCp2OowD1m2ZSmg-MCrG45-wVMyonsZrXA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clear dm_state for fast updates
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Mazin Rezk <mnrzk@protonmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:29 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Jul 27, 2020 at 9:28 PM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Am 27.07.20 um 16:05 schrieb Kazlauskas, Nicholas:
> > > On 2020-07-27 9:39 a.m., Christian K=C3=B6nig wrote:
> > >> Am 27.07.20 um 07:40 schrieb Mazin Rezk:
> > >>> This patch fixes a race condition that causes a use-after-free duri=
ng
> > >>> amdgpu_dm_atomic_commit_tail. This can occur when 2 non-blocking
> > >>> commits
> > >>> are requested and the second one finishes before the first.
> > >>> Essentially,
> > >>> this bug occurs when the following sequence of events happens:
> > >>>
> > >>> 1. Non-blocking commit #1 is requested w/ a new dm_state #1 and is
> > >>> deferred to the workqueue.
> > >>>
> > >>> 2. Non-blocking commit #2 is requested w/ a new dm_state #2 and is
> > >>> deferred to the workqueue.
> > >>>
> > >>> 3. Commit #2 starts before commit #1, dm_state #1 is used in the
> > >>> commit_tail and commit #2 completes, freeing dm_state #1.
> > >>>
> > >>> 4. Commit #1 starts after commit #2 completes, uses the freed dm_st=
ate
> > >>> 1 and dereferences a freelist pointer while setting the context.
> > >>
> > >> Well I only have a one mile high view on this, but why don't you let
> > >> the work items execute in order?
> > >>
> > >> That would be better anyway cause this way we don't trigger a cache
> > >> line ping pong between CPUs.
> > >>
> > >> Christian.
> > >
> > > We use the DRM helpers for managing drm_atomic_commit_state and those
> > > helpers internally push non-blocking commit work into the system
> > > unbound work queue.
> >
> > Mhm, well if you send those helper atomic commits in the order A,B and
> > they execute it in the order B,A I would call that a bug :)
>
> The way it works is it pushes all commits into unbound work queue, but
> then forces serialization as needed. We do _not_ want e.g. updates on
> different CRTC to be serialized, that would result in lots of judder.
> And hw is funny enough that there's all kinds of dependencies.
>
> The way you force synchronization is by adding other CRTC state
> objects. So if DC is busted and can only handle a single update per
> work item, then I guess you always need all CRTC states and everything
> will be run in order. But that also totally kills modern multi-screen
> compositors. Xorg isn't modern, just in case that's not clear :-)
>
> Lucking at the code it seems like you indeed have only a single dm
> state, so yeah global sync is what you'll need as immediate fix, and
> then maybe fix up DM to not be quite so silly ... or at least only do
> the dm state stuff when really needed.

Just looked a bit more at this struct dc_state, and that looks a lot
like an atomic side-wagon. I don't think that works as a private
state, this should probably be embedded into a subclass of
drm_atomic_state.

And probably a lot of these pointers moved to other places I think, or
I'm not entirely clear on what exactly this stuff is needed for ...

dc_state is also refcounted, which is definitely rather funny for a
state structure.

Feels like this entire thing (how the overall dc state machinery is
glued into atomic) isn't quite thought thru just yet :-/
-Daniel

> We could also sprinkle the drm_crtc_commit structure around a bit
> (it's the glue that provides the synchronization across commits), but
> since your dm state is global just grabbing all crtc states
> unconditionally as part of that is probably best.
>
> > > While we could duplicate a copy of that code with nothing but the
> > > workqueue changed that isn't something I'd really like to maintain
> > > going forward.
> >
> > I'm not talking about duplicating the code, I'm talking about fixing th=
e
> > helpers. I don't know that code well, but from the outside it sounds
> > like a bug there.
> >
> > And executing work items in the order they are submitted is trivial.
> >
> > Had anybody pinged Daniel or other people familiar with the helper code
> > about it?
>
> Yeah something is wrong here, and the fix looks horrible :-)
>
> Aside, I've also seen some recent discussion flare up about
> drm_atomic_state_get/put used to paper over some other use-after-free,
> but this time related to interrupt handlers. Maybe a few rules about
> that:
> - dont
> - especially not when it's interrupt handlers, because you can't call
> drm_atomic_state_put from interrupt handlers.
>
> Instead have an spin_lock_irq to protect the shared date with your
> interrupt handler, and _copy_ the date over. This is e.g. what
> drm_crtc_arm_vblank_event does.
>
> Cheers, Daniel
>
> >
> > Regards,
> > Christian.
> >
> > >
> > > Regards,
> > > Nicholas Kazlauskas
> > >
> > >>
> > >>>
> > >>> Since this bug has only been spotted with fast commits, this patch
> > >>> fixes
> > >>> the bug by clearing the dm_state instead of using the old dc_state =
for
> > >>> fast updates. In addition, since dm_state is only used for its dc_s=
tate
> > >>> and amdgpu_dm_atomic_commit_tail will retain the dc_state if none i=
s
> > >>> found,
> > >>> removing the dm_state should not have any consequences in fast upda=
tes.
> > >>>
> > >>> This use-after-free bug has existed for a while now, but only cause=
d a
> > >>> noticeable issue starting from 5.7-rc1 due to 3202fa62f ("slub:
> > >>> relocate
> > >>> freelist pointer to middle of object") moving the freelist pointer =
from
> > >>> dm_state->base (which was unused) to dm_state->context (which is
> > >>> dereferenced).
> > >>>
> > >>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D207383
> > >>> Fixes: bd200d190f45 ("drm/amd/display: Don't replace the dc_state
> > >>> for fast updates")
> > >>> Reported-by: Duncan <1i5t5.duncan@cox.net>
> > >>> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> > >>> ---
> > >>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36
> > >>> ++++++++++++++-----
> > >>>   1 file changed, 27 insertions(+), 9 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > >>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > >>> index 86ffa0c2880f..710edc70e37e 100644
> > >>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > >>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > >>> @@ -8717,20 +8717,38 @@ static int amdgpu_dm_atomic_check(struct
> > >>> drm_device *dev,
> > >>>            * the same resource. If we have a new DC context as part=
 of
> > >>>            * the DM atomic state from validation we need to free it=
 and
> > >>>            * retain the existing one instead.
> > >>> +         *
> > >>> +         * Furthermore, since the DM atomic state only contains th=
e DC
> > >>> +         * context and can safely be annulled, we can free the sta=
te
> > >>> +         * and clear the associated private object now to free
> > >>> +         * some memory and avoid a possible use-after-free later.
> > >>>            */
> > >>> -        struct dm_atomic_state *new_dm_state, *old_dm_state;
> > >>>
> > >>> -        new_dm_state =3D dm_atomic_get_new_state(state);
> > >>> -        old_dm_state =3D dm_atomic_get_old_state(state);
> > >>> +        for (i =3D 0; i < state->num_private_objs; i++) {
> > >>> +            struct drm_private_obj *obj =3D state->private_objs[i]=
.ptr;
> > >>>
> > >>> -        if (new_dm_state && old_dm_state) {
> > >>> -            if (new_dm_state->context)
> > >>> -                dc_release_state(new_dm_state->context);
> > >>> +            if (obj->funcs =3D=3D adev->dm.atomic_obj.funcs) {
> > >>> +                int j =3D state->num_private_objs-1;
> > >>>
> > >>> -            new_dm_state->context =3D old_dm_state->context;
> > >>> +                dm_atomic_destroy_state(obj,
> > >>> +                        state->private_objs[i].state);
> > >>> +
> > >>> +                /* If i is not at the end of the array then the
> > >>> +                 * last element needs to be moved to where i was
> > >>> +                 * before the array can safely be truncated.
> > >>> +                 */
> > >>> +                if (i !=3D j)
> > >>> +                    state->private_objs[i] =3D
> > >>> +                        state->private_objs[j];
> > >>>
> > >>> -            if (old_dm_state->context)
> > >>> -                dc_retain_state(old_dm_state->context);
> > >>> +                state->private_objs[j].ptr =3D NULL;
> > >>> +                state->private_objs[j].state =3D NULL;
> > >>> +                state->private_objs[j].old_state =3D NULL;
> > >>> +                state->private_objs[j].new_state =3D NULL;
> > >>> +
> > >>> +                state->num_private_objs =3D j;
> > >>> +                break;
> > >>> +            }
> > >>>           }
> > >>>       }
> > >>>
> > >>> --
> > >>> 2.27.0
> > >>>
> > >>
> > >
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
