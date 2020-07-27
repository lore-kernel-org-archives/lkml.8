Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F175C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F906206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbgG0PpM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:45:12 -0400
Received: from omta012.uswest2.a.cloudfilter.net ([35.164.127.235]:56223 "EHLO
        omta012.uswest2.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728015AbgG0PpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:45:11 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2020 11:45:10 EDT
Received: from cxr.smtp.a.cloudfilter.net ([10.0.16.145])
        by cmsmtp with ESMTP
        id 00M5kTac7mUuy05CUkkwzh; Mon, 27 Jul 2020 15:38:02 +0000
Received: from ws ([68.106.48.162])
        by cmsmtp with ESMTPSA
        id 05CIkRkFGKrUj05CJkzNoN; Mon, 27 Jul 2020 15:38:02 +0000
Authentication-Results: cox.net; auth=pass (LOGIN)
 smtp.auth=1i5t5.duncan@cox.net
X-Authority-Analysis: v=2.4 cv=Wu6VjfTv c=1 sm=1 tr=0 ts=5f1ef4da
 a=fEuF7Lzz1MGHEe1xFtqdOg==:117 a=fEuF7Lzz1MGHEe1xFtqdOg==:17
 a=IkcTkHD0fZMA:10 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=kviXuzpPAAAA:8
 a=sfOm8-O8AAAA:8 a=GEFCdFOGbQv7mSB_pWQA:9 a=tqTlq1B0_eMsoCT5:21
 a=h_W-Jm2LaEDf4Mgu:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=qrIFiuKZe2vaD64auk6j:22 a=TvTJqdcANYtsRzA46cdi:22
Date:   Mon, 27 Jul 2020 08:37:49 -0700
From:   Duncan <1i5t5.duncan@cox.net>
To:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Mazin Rezk <mnrzk@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Harry Wentland <Harry.Wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        "mphantomx@yahoo.com.br" <mphantomx@yahoo.com.br>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "anthony.ruhier@gmail.com" <anthony.ruhier@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] drm/amd/display: Clear dm_state for fast updates
Message-ID: <20200727083749.7b0fe41d@ws>
In-Reply-To: <e2f55480-c24f-6c85-08d3-21131a22d0bf@amd.com>
References: <M0lxN5AUlPvzBKULfIBe5BZRwfQGXeMQCdWItYcQ-9P79y32WzExYK2Y0DwyNVtyGelqbvV07_lFk1oeT4cApbT-P_oH0bnxQbMmFsJv_xg=@protonmail.com>
        <ba078fb0-0dbc-df06-cfe9-f9537883f82a@amd.com>
        <e2f55480-c24f-6c85-08d3-21131a22d0bf@amd.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4xfGkEX9Tay6GTZG9sI91aPbcWvbf0prl9drr0Vb6zi1HgHYrb/SN12LpKXhuWCazaf+qGdIhr0rDqn9HLwAXeM3wycfWeeljqu1boy1ql56iXYF2bAXJz
 4PrWzP+Uy36trlqXirzeMrGeboMFt5LYoa6RHk/m4z70GBnLHEb6dD51SPsGoU4nyO9+XjhxIA7nzI+kH3dHHRcaTZJKCsWPmAKdNAFR85/ZzNe/G505umhL
 h5CVTpg7b1YPJw/h0qcK/1supgqADO8HdqrrhcUkwDxg0wBbbhtvN4knfxZ15D9ZP7Vdp3TwhRWBocd9U846F4Myu7GiNfD1fEPPgypGBriCShImbrMLiNMt
 I8jOgqdsreoANf1ywhz9Rmlj+/tPyho79HkyyOJslD72GwFlmp+FtkCAExRvUWW5o3PuuZ1k8068az/563afztRlxPOQjjl6JZlAwYnBQZBWcc2zGrVJLf21
 A0WiYWxTG32RH9chFcrpewHDI5k9VQICRbmygXFqWm72nVjpGOXgsSEESMKBd7pC9eEmiuhV1gGAFrl2i6kuFALoqDWw22oWX4OE8XA3fSlsvUckRa429M7i
 F+PNepcnIOHv/i8opDVBn1KoLqr4xLXANds5JsRyi7cHs5Z1vOKxnyuCIJ7Ku+iNvZQikjzJ31959ojtKu9vJwdVZ04RpiXp0mpWHlVh4edw/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 10:05:01 -0400
"Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com> wrote:

> On 2020-07-27 9:39 a.m., Christian König wrote:
> > Am 27.07.20 um 07:40 schrieb Mazin Rezk:
> >> This patch fixes a race condition that causes a use-after-free
> >> during amdgpu_dm_atomic_commit_tail. This can occur when 2
> >> non-blocking commits are requested and the second one finishes
> >> before the first. Essentially, this bug occurs when the following
> >> sequence of events happens:
> >>
> >> 1. Non-blocking commit #1 is requested w/ a new dm_state #1 and is
> >> deferred to the workqueue.
> >>
> >> 2. Non-blocking commit #2 is requested w/ a new dm_state #2 and is
> >> deferred to the workqueue.
> >>
> >> 3. Commit #2 starts before commit #1, dm_state #1 is used in the
> >> commit_tail and commit #2 completes, freeing dm_state #1.
> >>
> >> 4. Commit #1 starts after commit #2 completes, uses the freed
> >> dm_state 1 and dereferences a freelist pointer while setting the
> >> context.
> > 
> > Well I only have a one mile high view on this, but why don't you
> > let the work items execute in order?
> > 
> > That would be better anyway cause this way we don't trigger a cache
> > line ping pong between CPUs.
> > 
> > Christian.
> 
> We use the DRM helpers for managing drm_atomic_commit_state and those 
> helpers internally push non-blocking commit work into the system
> unbound work queue.
> 
> While we could duplicate a copy of that code with nothing but the 
> workqueue changed that isn't something I'd really like to maintain
> going forward.
> 
> Regards,
> Nicholas Kazlauskas

Additionally, I don't see mentioned on-thread (it's on the bug and now
in the details below) that we're talking multi-monitor, not
single-monitor. Presumably that goes some way toward answering the "why
not force order?" question, considering the outputs may be running at
different refresh frequencies, etc...

All the reports on the bug seem to be multi-monitor (after seeing
multi-monitor/output in several reports I asked if anyone was seeing it
with only one monitor and no answers), and as you commented on the bug
for your proposed patch but seems missing from this one here (different
author/proposal) ...

Commits #1 and #2 don't touch any of the same core DRM objects (CRTCs,
Planes, Connectors) so Commit #2 does not stall for Commit #1. DRM
Private Objects have always been avoided in stall checks, so we have no
safety from DRM core in this regard.

> >>
> >> Since this bug has only been spotted with fast commits, this patch
> >> fixes the bug by clearing the dm_state instead of using the old
> >> dc_state for fast updates. In addition, since dm_state is only
> >> used for its dc_state and amdgpu_dm_atomic_commit_tail will retain
> >> the dc_state if none is found,
> >> removing the dm_state should not have any consequences in fast
> >> updates.
> >>
> >> This use-after-free bug has existed for a while now, but only
> >> caused a noticeable issue starting from 5.7-rc1 due to 3202fa62f
> >> ("slub: relocate freelist pointer to middle of object") moving the
> >> freelist pointer from dm_state->base (which was unused) to
> >> dm_state->context (which is dereferenced).
> >>
> >> Bugzilla: 
> >> https://bugzilla.kernel.org/show_bug.cgi?id=207383 
> >>
> >> Fixes: bd200d190f45 ("drm/amd/display: Don't replace the dc_state
> >> for fast updates")
> >> Reported-by: Duncan <1i5t5.duncan@cox.net>
> >> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> >> ---
> >>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36
> >> ++++++++++++++----- 1 file changed, 27 insertions(+), 9
> >> deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
> >> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 86ffa0c2880f..710edc70e37e 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -8717,20 +8717,38 @@ static int amdgpu_dm_atomic_check(struct 
> >> drm_device *dev,
> >>            * the same resource. If we have a new DC context as
> >> part of
> >>            * the DM atomic state from validation we need to free
> >> it and
> >>            * retain the existing one instead.
> >> +         *
> >> +         * Furthermore, since the DM atomic state only contains
> >> the DC
> >> +         * context and can safely be annulled, we can free the
> >> state
> >> +         * and clear the associated private object now to free
> >> +         * some memory and avoid a possible use-after-free later.
> >>            */
> >> -        struct dm_atomic_state *new_dm_state, *old_dm_state;
> >>
> >> -        new_dm_state = dm_atomic_get_new_state(state);
> >> -        old_dm_state = dm_atomic_get_old_state(state);
> >> +        for (i = 0; i < state->num_private_objs; i++) {
> >> +            struct drm_private_obj *obj =
> >> state->private_objs[i].ptr;
> >>
> >> -        if (new_dm_state && old_dm_state) {
> >> -            if (new_dm_state->context)
> >> -                dc_release_state(new_dm_state->context);
> >> +            if (obj->funcs == adev->dm.atomic_obj.funcs) {
> >> +                int j = state->num_private_objs-1;
> >>
> >> -            new_dm_state->context = old_dm_state->context;
> >> +                dm_atomic_destroy_state(obj,
> >> +                        state->private_objs[i].state);
> >> +
> >> +                /* If i is not at the end of the array then the
> >> +                 * last element needs to be moved to where i was
> >> +                 * before the array can safely be truncated.
> >> +                 */
> >> +                if (i != j)
> >> +                    state->private_objs[i] =
> >> +                        state->private_objs[j];
> >>
> >> -            if (old_dm_state->context)
> >> -                dc_retain_state(old_dm_state->context);
> >> +                state->private_objs[j].ptr = NULL;
> >> +                state->private_objs[j].state = NULL;
> >> +                state->private_objs[j].old_state = NULL;
> >> +                state->private_objs[j].new_state = NULL;
> >> +
> >> +                state->num_private_objs = j;
> >> +                break;
> >> +            }
> >>           }
> >>       }
> >>
> >> -- 
> >> 2.27.0
> >>
> > 
> 

-- 
Duncan - No HTML messages please; they are filtered as spam.
"Every nonfree program has a lord, a master --
and if you use the program, he is your master."  Richard Stallman
