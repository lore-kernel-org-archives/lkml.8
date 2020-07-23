Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FB2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FFE2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="PqRfO9+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgGWVKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:10:21 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:12645 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgGWVKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:10:20 -0400
Date:   Thu, 23 Jul 2020 21:10:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1595538618;
        bh=/v8hsn4vji93LSAwL+yRiHgNCReHoDDH4axY/SRPmKE=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=PqRfO9+GqZTufIG+oR4srHLcqDGsQQCoyux3C8Vt6Xz6kwNRHtX9CeN989yIimZ9w
         A0+avVpS6Bn8ubJZ1TRxVT39JUxZbt5WngqQXKh1gn25FutDexD3jsLiaYILD0BGsd
         4Tz6V6YIpKZZi6+ZvJ9EqR5blmY+mVmbPEEk6D6s=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
From:   Mazin Rezk <mnrzk@protonmail.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "mnrzk@protonmail.com" <mnrzk@protonmail.com>,
        "nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "1i5t5.duncan@cox.net" <1i5t5.duncan@cox.net>,
        "mphantomx@yahoo.com.br" <mphantomx@yahoo.com.br>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "anthony.ruhier@gmail.com" <anthony.ruhier@gmail.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Subject: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
Message-ID: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When amdgpu_dm_atomic_commit_tail is running in the workqueue,
drm_atomic_state_put will get called while amdgpu_dm_atomic_commit_tail is
running, causing a race condition where state (and then dm_state) is
sometimes freed while amdgpu_dm_atomic_commit_tail is running. This bug has
occurred since 5.7-rc1 and is well documented among polaris11 users [1].

Prior to 5.7, this was not a noticeable issue since the freelist pointer
was stored at the beginning of dm_state (base), which was unused. After
changing the freelist pointer to be stored in the middle of the struct, the
freelist pointer overwrote the context, causing dc_state to become garbage
data and made the call to dm_enable_per_frame_crtc_master_sync dereference
a freelist pointer.

This patch fixes the aforementioned issue by calling drm_atomic_state_get
in amdgpu_dm_atomic_commit before drm_atomic_helper_commit is called and
drm_atomic_state_put after amdgpu_dm_atomic_commit_tail is complete.

According to my testing on 5.8.0-rc6, this should fix bug 207383 on
Bugzilla [1].

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D207383

Fixes: 3202fa62f ("slub: relocate freelist pointer to middle of object")
Reported-by: Duncan <1i5t5.duncan@cox.net>
Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 86ffa0c2880f..86d6652872f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7303,6 +7303,7 @@ static int amdgpu_dm_atomic_commit(struct drm_device =
*dev,
 =09 * unset legacy_cursor_update
 =09 */

+=09drm_atomic_state_get(state);
 =09return drm_atomic_helper_commit(dev, state, nonblock);

 =09/*TODO Handle EINTR, reenable IRQ*/
@@ -7628,6 +7629,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_a=
tomic_state *state)

 =09if (dc_state_temp)
 =09=09dc_release_state(dc_state_temp);
+
+=09drm_atomic_state_put(state);
 }


--
2.27.0

