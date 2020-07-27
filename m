Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF3CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6182820792
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TCnJrzRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgG0VLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:11:43 -0400
Received: from mail-40141.protonmail.ch ([185.70.40.141]:49103 "EHLO
        mail-40141.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0VLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:11:42 -0400
Date:   Mon, 27 Jul 2020 21:11:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1595884297;
        bh=J5UnwDGjGDm1GIlnrWPWuIc1UUtS+SRgiZtCCMV1dgU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=TCnJrzRADNWeQKeNkq7j/brbkgXB3qrKl+Rp2Wc5h/nV1lC3QuG9kocLN7saKdlyG
         ZIuXvVqUS4x9x9Os8WxeECHqmYJ899OgEM5urtxygOH51zYh0hXOsHol8eViV2UTtN
         eFkrUeuCPy3dLPJNUkQ0oFVobzsxJiWJ71S2vK4k=
To:     Daniel Vetter <daniel@ffwll.ch>
From:   Mazin Rezk <mnrzk@protonmail.com>
Cc:     =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
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
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Subject: Re: [PATCH] drm/amd/display: Clear dm_state for fast updates
Message-ID: <Fnx2lsAReNccvQbyMYBgghvef4ekiQ_ZWL0m5BwF-2h48gvnNLghI4zkIWhQwy-H6CiytTXaxEtZ83dYRlzAXeKHujBRLc_tffmcJVWjwuo=@protonmail.com>
In-Reply-To: <CAKMK7uHCu02P4tvhF4LQbtYeNciU61ONC9EZRmQ-0wEGFPzZgg@mail.gmail.com>
References: <M0lxN5AUlPvzBKULfIBe5BZRwfQGXeMQCdWItYcQ-9P79y32WzExYK2Y0DwyNVtyGelqbvV07_lFk1oeT4cApbT-P_oH0bnxQbMmFsJv_xg=@protonmail.com> <ba078fb0-0dbc-df06-cfe9-f9537883f82a@amd.com> <e2f55480-c24f-6c85-08d3-21131a22d0bf@amd.com> <3b7e3e50-2ff7-eff3-2ffc-abaa4b36ce7f@amd.com> <CAKMK7uHCu02P4tvhF4LQbtYeNciU61ONC9EZRmQ-0wEGFPzZgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 27, 2020 4:29 PM, Daniel Vetter <daniel@ffwll.ch> wrote:

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
>
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

Nicholas wrote a patch that attempted to resolve the issue by adding every
CRTC into the commit to use use the stall checks. [1] While this forces
synchronisation on commits, it's kind of a hacky method that may take a
toll on performance.

Is it possible to have a DRM helper that forces synchronisation on some
commits without having to add every CRTC into the commit?

Also, is synchronisation really necessary for fast updates in amdgpu?
I'll admit, the idea of eliminating the use-after-free bug by eliminating
the use entirely doesn't seem ideal; but is forcing synchronisation on
these updates that much better?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D207383#c96

Thanks,
Mazin Rezk

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
