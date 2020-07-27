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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33B2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F73820714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Int6NshK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgG0Fk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:40:57 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:15455 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgG0Fk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:40:56 -0400
Date:   Mon, 27 Jul 2020 05:40:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1595828452;
        bh=f9E9zZQz6TG7mCxptgTH09Y9wak5F4Jj1SYOm0YNufQ=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Int6NshKrx1Ffc8MyTRH9fefJnr1kVBjUJWpHQdx46ak6d8wSiiMTanKhTGRZnX7G
         frVWJoGPVO3m258gffeEbskhsffc4E24gz305kTL0piiDDhEGxr0j3saXzoLRJMP+O
         XwztT1DUGAXlX41dPvlHcn9M6Rt8Al/vqzodxUaw=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
From:   Mazin Rezk <mnrzk@protonmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Mazin Rezk <mnrzk@protonmail.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Duncan <1i5t5.duncan@cox.net>,
        "mphantomx@yahoo.com.br" <mphantomx@yahoo.com.br>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "anthony.ruhier@gmail.com" <anthony.ruhier@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Subject: [PATCH] drm/amd/display: Clear dm_state for fast updates
Message-ID: <M0lxN5AUlPvzBKULfIBe5BZRwfQGXeMQCdWItYcQ-9P79y32WzExYK2Y0DwyNVtyGelqbvV07_lFk1oeT4cApbT-P_oH0bnxQbMmFsJv_xg=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a race condition that causes a use-after-free during
amdgpu_dm_atomic_commit_tail. This can occur when 2 non-blocking commits
are requested and the second one finishes before the first. Essentially,
this bug occurs when the following sequence of events happens:

1. Non-blocking commit #1 is requested w/ a new dm_state #1 and is
deferred to the workqueue.

2. Non-blocking commit #2 is requested w/ a new dm_state #2 and is
deferred to the workqueue.

3. Commit #2 starts before commit #1, dm_state #1 is used in the
commit_tail and commit #2 completes, freeing dm_state #1.

4. Commit #1 starts after commit #2 completes, uses the freed dm_state
1 and dereferences a freelist pointer while setting the context.

Since this bug has only been spotted with fast commits, this patch fixes
the bug by clearing the dm_state instead of using the old dc_state for
fast updates. In addition, since dm_state is only used for its dc_state
and amdgpu_dm_atomic_commit_tail will retain the dc_state if none is found,
removing the dm_state should not have any consequences in fast updates.

This use-after-free bug has existed for a while now, but only caused a
noticeable issue starting from 5.7-rc1 due to 3202fa62f ("slub: relocate
freelist pointer to middle of object") moving the freelist pointer from
dm_state->base (which was unused) to dm_state->context (which is
dereferenced).

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D207383
Fixes: bd200d190f45 ("drm/amd/display: Don't replace the dc_state for fast =
updates")
Reported-by: Duncan <1i5t5.duncan@cox.net>
Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 ++++++++++++++-----
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 86ffa0c2880f..710edc70e37e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8717,20 +8717,38 @@ static int amdgpu_dm_atomic_check(struct drm_device=
 *dev,
 =09=09 * the same resource. If we have a new DC context as part of
 =09=09 * the DM atomic state from validation we need to free it and
 =09=09 * retain the existing one instead.
+=09=09 *
+=09=09 * Furthermore, since the DM atomic state only contains the DC
+=09=09 * context and can safely be annulled, we can free the state
+=09=09 * and clear the associated private object now to free
+=09=09 * some memory and avoid a possible use-after-free later.
 =09=09 */
-=09=09struct dm_atomic_state *new_dm_state, *old_dm_state;

-=09=09new_dm_state =3D dm_atomic_get_new_state(state);
-=09=09old_dm_state =3D dm_atomic_get_old_state(state);
+=09=09for (i =3D 0; i < state->num_private_objs; i++) {
+=09=09=09struct drm_private_obj *obj =3D state->private_objs[i].ptr;

-=09=09if (new_dm_state && old_dm_state) {
-=09=09=09if (new_dm_state->context)
-=09=09=09=09dc_release_state(new_dm_state->context);
+=09=09=09if (obj->funcs =3D=3D adev->dm.atomic_obj.funcs) {
+=09=09=09=09int j =3D state->num_private_objs-1;

-=09=09=09new_dm_state->context =3D old_dm_state->context;
+=09=09=09=09dm_atomic_destroy_state(obj,
+=09=09=09=09=09=09state->private_objs[i].state);
+
+=09=09=09=09/* If i is not at the end of the array then the
+=09=09=09=09 * last element needs to be moved to where i was
+=09=09=09=09 * before the array can safely be truncated.
+=09=09=09=09 */
+=09=09=09=09if (i !=3D j)
+=09=09=09=09=09state->private_objs[i] =3D
+=09=09=09=09=09=09state->private_objs[j];

-=09=09=09if (old_dm_state->context)
-=09=09=09=09dc_retain_state(old_dm_state->context);
+=09=09=09=09state->private_objs[j].ptr =3D NULL;
+=09=09=09=09state->private_objs[j].state =3D NULL;
+=09=09=09=09state->private_objs[j].old_state =3D NULL;
+=09=09=09=09state->private_objs[j].new_state =3D NULL;
+
+=09=09=09=09state->num_private_objs =3D j;
+=09=09=09=09break;
+=09=09=09}
 =09=09}
 =09}

--
2.27.0

