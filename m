Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73938C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA13206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="YGj/lN+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGXVJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:09:16 -0400
Received: from mail-40137.protonmail.ch ([185.70.40.137]:15968 "EHLO
        mail-40137.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGXVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:09:16 -0400
X-Greylist: delayed 79557 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jul 2020 17:09:13 EDT
Date:   Fri, 24 Jul 2020 21:09:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1595624951;
        bh=Y8a3UGIVUH//nWWAHOfJ574aWDANSyRzuKfaeg2ulx4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=YGj/lN+HFANsv1agtWAfUQJ7IvssJEJY15hq9PWChRGnsw5JEgsYYiWDl31LukOud
         dOE/V34tZUicUA8wP8eoHSncAd542wShdz8LPbuUbbzSPBZJ5Dc7yEPvZxzXeW/Ik6
         Q9yTCzgVKFotxwH/ft0g8N6MDWQonb3zGWZES6KI=
To:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
From:   Mazin Rezk <mnrzk@protonmail.com>
Cc:     Mazin Rezk <mnrzk@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "1i5t5.duncan@cox.net" <1i5t5.duncan@cox.net>,
        "mphantomx@yahoo.com.br" <mphantomx@yahoo.com.br>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "anthony.ruhier@gmail.com" <anthony.ruhier@gmail.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
Message-ID: <84wa2rcw2dJSFkRVMxsGwnf-BOUvLL6jFG8orKz4_sjwWChkTbrAUVmOupfV1AmPm0MxqbRGwtvn_v_EAMhM_ngI73p-sjscgKg106fcu4U=@protonmail.com>
In-Reply-To: <3iDgskt5iP3y77MHUJ2_5uSThyUteHxPvVqoL5SpnpTIpz5cdkifyDOynpiVukS_peaYGOkn9bHSpvRYa-vFOCjUYH68taIuKyZqhOByAVI=@protonmail.com>
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com> <ccd5d51b-b018-a3db-169b-ba6278a7be9f@amd.com> <3iDgskt5iP3y77MHUJ2_5uSThyUteHxPvVqoL5SpnpTIpz5cdkifyDOynpiVukS_peaYGOkn9bHSpvRYa-vFOCjUYH68taIuKyZqhOByAVI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 23, 2020 6:57 PM, Mazin Rezk <mnrzk@protonmail.com> wrote=
:

> It seems that I spoke too soon. I ran the system for another hour after
> submitting the patch and the bug just occurred. :/
>
> Sadly, that means the bug isn't really fixed and that I have to go
> investigate further.
>
> At the very least, this patch seems to delay the occurrence of the bug
> significantly which may help in further discovering the cause.
>
> On Thursday, July 23, 2020 6:16 PM, Kazlauskas, Nicholas nicholas.kazlaus=
kas@amd.com wrote:
>
> > On 2020-07-23 5:10 p.m., Mazin Rezk wrote:
> >
> > > When amdgpu_dm_atomic_commit_tail is running in the workqueue,
> > > drm_atomic_state_put will get called while amdgpu_dm_atomic_commit_ta=
il is
> > > running, causing a race condition where state (and then dm_state) is
> > > sometimes freed while amdgpu_dm_atomic_commit_tail is running. This b=
ug has
> > > occurred since 5.7-rc1 and is well documented among polaris11 users [=
1].
> > > Prior to 5.7, this was not a noticeable issue since the freelist poin=
ter
> > > was stored at the beginning of dm_state (base), which was unused. Aft=
er
> > > changing the freelist pointer to be stored in the middle of the struc=
t, the
> > > freelist pointer overwrote the context, causing dc_state to become ga=
rbage
> > > data and made the call to dm_enable_per_frame_crtc_master_sync derefe=
rence
> > > a freelist pointer.
> > > This patch fixes the aforementioned issue by calling drm_atomic_state=
_get
> > > in amdgpu_dm_atomic_commit before drm_atomic_helper_commit is called =
and
> > > drm_atomic_state_put after amdgpu_dm_atomic_commit_tail is complete.
> > > According to my testing on 5.8.0-rc6, this should fix bug 207383 on
> > > Bugzilla [1].
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D207383
> > > Fixes: 3202fa62f ("slub: relocate freelist pointer to middle of objec=
t")
> > > Reported-by: Duncan 1i5t5.duncan@cox.net
> > > Signed-off-by: Mazin Rezk mnrzk@protonmail.com
> >
> > Thanks for the investigation and your patch. I appreciate the help in
> > trying to narrow down the root cause as this issue has been difficult t=
o
> > reproduce on my setups.
> > Though I'm not sure this really resolves the issue - we make use of the
> > drm_atomic_helper_commit helper function from DRM which internally does
> > what you're doing with this patch:
> > drm_atomic_state_get(state);
> > if (nonblock)
> > queue_work(system_unbound_wq, &state->commit_work);
> >
> >     else
> >     =09commit_tail(state);
> >
> >
> > So even when it gets queued off to the unbound workqueue we still have =
a
> > reference on the state.
> > That reference gets dropped as part of commit tail helper in DRM as wel=
l:
> > if (funcs && funcs->atomic_commit_tail)
> >
> >     =09funcs->atomic_commit_tail(old_state);
> >
> >     else
> >     =09drm_atomic_helper_commit_tail(old_state);
> >
> >
> > commit_time_ms =3D ktime_ms_delta(ktime_get(), start);
> > if (commit_time_ms > 0)
> >
> >     =09drm_self_refresh_helper_update_avg_times(old_state,
> >     =09=09=09=09=09 (unsigned long)commit_time_ms,
> >     =09=09=09=09=09 new_self_refresh_mask);
> >
> >
> > drm_atomic_helper_commit_cleanup_done(old_state);
> > drm_atomic_state_put(old_state);
>
> I initially noticed that right after I wrote this patch so I was expectin=
g
> the patch to fail. However, after several hours of testing, the crash jus=
t
> didn't occur so I believed the bug was fixed.
>
> > So instead of a use after free happening when we access the state we ge=
t
> > a double-free happening later at the end of commit tail in DRM.
> > What I think would be the right next step here is to actually determine
> > what sequence of IOCTLs and atomic commits are happening under your
> > setup with a very verbose dmesg log. You can set a debug level for DRM
> > in your kernel parameters with something like:
> > drm.debug=3D0x54
> > I don't see anything in amdgpu_dm.c that looks like it would be freeing
> > the state so I suspect something in the core is this doing this.
>
> Going through the KASAN use-after-free bug report in the Bugzilla
> attachments, it appears that the state is being freed at the end of
> commit_tail. Perhaps amdgpu_dm_atomic_commit_tail is being called on the
> the same old state twice? I can't quite think of any other possible
> explanation as to why that happens.

I think I've more or less confirmed that this is the case.

I created two padding variables, one to store debug magic numbers and one
to store the freelist pointer. I had magic numbers for initialised,
preuse, and used states. When the dm_atomic_state is initialised, the
padding is set to the init magic number. Right before commit_tail is
called, the padding is set to the preuse magic number. During
dm_atomic_get_new_state checks the magic number to confirm that it
was in the preuse state and then set it to used. If it failed that check
and it was already in a used state, there was a breakpoint set so I could
gather further information.

At one point (presumably where the crash would have occurred), the debug
padding variable was set to the used state during the call to commit_tail
which I believe confirms my guess that amdgpu_dm_atomic_commit_tail is
being called on the same state twice.

What's weird, however, is that dmesg (w/ drm.debug=3D0x54) says this right
before amdgpu_dm_atomic_commit_tail is called:

[ 3277.580205] [drm:drm_atomic_state_init [drm]] Allocated atomic state 000=
00000a06f4024
[ 3277.580262] [drm:drm_atomic_get_crtc_state [drm]] Added [CRTC:49:crtc-1]=
 000000003b9da5c1 state to 00000000a06f4024
[ 3277.580316] [drm:drm_atomic_get_plane_state [drm]] Added [PLANE:44:plane=
-4] 000000003488c027 state to 00000000a06f4024
[ 3277.580366] [drm:drm_atomic_set_fb_for_plane [drm]] Set [FB:103] for [PL=
ANE:44:plane-4] state 000000003488c027
[ 3277.580417] [drm:drm_atomic_check_only [drm]] checking 00000000a06f4024
[ 3277.580519] [drm:drm_atomic_get_private_obj_state [drm]] Added new priva=
te object 0000000002a633ab state 00000000695dff15 to 00000000a06f4024
[ 3277.580579] [drm:drm_atomic_nonblocking_commit [drm]] committing 0000000=
0a06f4024 nonblocking
[ 3277.582325] [drm:drm_atomic_state_default_clear [drm]] Clearing atomic s=
tate 00000000a06f4024
[ 3277.582393] [drm:__drm_atomic_state_free [drm]] Freeing atomic state 000=
00000a06f4024

From the log, I'm noticing that drm_atomic_nonblocking_commit is only
called once and that whatever is calling the second non-blocking
commit_tail on the same state doesn't seem to be using
drm_atomic_nonblocking_commit.

Perhaps someone with more knowledge of the code can give a possible
explanation as to why that's happening.

Thanks,
Mazin Rezk

>
> > > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
> > > 1 file changed, 3 insertions(+)
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index 86ffa0c2880f..86d6652872f2 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -7303,6 +7303,7 @@ static int amdgpu_dm_atomic_commit(struct drm_d=
evice *dev,
> > >
> > > -   unset legacy_cursor_update
> > >     */
> > >
> > >
> > > -   drm_atomic_state_get(state);
> >
> > Also note that if the drm_atomic_helper_commit() call fails here then
> > we're going to never free this structure. So we should really be
> > checking the return code here below before trying to do this, if at all=
.
>
> Oh right, that's true. I looked at amdgpu_dm_atomic_commit_tail and didn'=
t
> see any return statements in there, so I thought it was safe.
>
> > Regards,
> > Nicholas Kazlauskas
> >
> > >       return drm_atomic_helper_commit(dev, state, nonblock);
> > >
> > >       /*TODO Handle EINTR, reenable IRQ*/
> > >
> > >
> > > @@ -7628,6 +7629,8 @@ static void amdgpu_dm_atomic_commit_tail(struct=
 drm_atomic_state *state)
> > >
> > >       if (dc_state_temp)
> > >       =09dc_release_state(dc_state_temp);
> > >
> > >
> > > -
> > > -   drm_atomic_state_put(state);
> > >     }
> > >
> > >
> > > --
> > > 2.27.0
>
> Thanks,
> Mazin Rezk


