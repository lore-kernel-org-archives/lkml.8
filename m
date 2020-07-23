Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555BBC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B321C20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="wJWQyTrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGWW6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:58:35 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:22437 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgGWW6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:58:34 -0400
Date:   Thu, 23 Jul 2020 22:58:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1595545112;
        bh=lg9xOnMsFhhdqALv0aeP/Vx2Gofelvm+74wmCknZsFo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=wJWQyTrNxzYCugTunHerczbSVBPFAyOkFnBt7X5S1XVzsUu/CqTghfT5XKiJqfCMb
         G1g3xRBuQI4aoyJodntEqzHGTw4zt+dQyEA0OkIP7e/Z9Q+YFww7/QLZdrEgJ35/qn
         M4P8GF7YJgW5MjILTKRXcogl6z7WEMPnUhlcPT04=
To:     Kees Cook <keescook@chromium.org>
From:   Mazin Rezk <mnrzk@protonmail.com>
Cc:     Mazin Rezk <mnrzk@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "1i5t5.duncan@cox.net" <1i5t5.duncan@cox.net>,
        "mphantomx@yahoo.com.br" <mphantomx@yahoo.com.br>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "anthony.ruhier@gmail.com" <anthony.ruhier@gmail.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
Message-ID: <4KGdosy_NHW6FYCc2rCq4e71vYI7e4InqrLJ4S1GJsLcfjHv_INF-CzIYusOFqznOxyvflBTlFCXvyy7J37fn-QKfNOQK78MM38VdjdUXks=@protonmail.com>
In-Reply-To: <202007231524.A24720C@keescook>
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com> <202007231524.A24720C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 23, 2020 6:32 PM, Kees Cook <keescook@chromium.org> wrote=
:

> On Thu, Jul 23, 2020 at 09:10:15PM +0000, Mazin Rezk wrote:
>
> > When amdgpu_dm_atomic_commit_tail is running in the workqueue,
> > drm_atomic_state_put will get called while amdgpu_dm_atomic_commit_tail=
 is
> > running, causing a race condition where state (and then dm_state) is
> > sometimes freed while amdgpu_dm_atomic_commit_tail is running. This bug=
 has
> > occurred since 5.7-rc1 and is well documented among polaris11 users [1]=
.
> > Prior to 5.7, this was not a noticeable issue since the freelist pointe=
r
> > was stored at the beginning of dm_state (base), which was unused. After
> > changing the freelist pointer to be stored in the middle of the struct,=
 the
> > freelist pointer overwrote the context, causing dc_state to become garb=
age
> > data and made the call to dm_enable_per_frame_crtc_master_sync derefere=
nce
> > a freelist pointer.
> > This patch fixes the aforementioned issue by calling drm_atomic_state_g=
et
> > in amdgpu_dm_atomic_commit before drm_atomic_helper_commit is called an=
d
> > drm_atomic_state_put after amdgpu_dm_atomic_commit_tail is complete.
> > According to my testing on 5.8.0-rc6, this should fix bug 207383 on
> > Bugzilla [1].
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D207383
>
> Nice work tracking this down!
>
> > Fixes: 3202fa62f ("slub: relocate freelist pointer to middle of object"=
)
>
> I do, however, object to this Fixes tag. :) The flaw appears to have
> been with amdgpu_dm's reference tracking of "state" in the nonblocking
> case. (How this reference counting is supposed to work correctly, though,
> I'm not sure.) If I look at where the drm helper was split from being
> the default callback, it looks like this was what introduced the bug:
>
> da5c47f682ab ("drm/amd/display: Remove acrtc->stream")
>
> ? 3202fa62f certainly exposed it much more quickly, but there was a race
> even without 3202fa62f where something could have realloced the memory
> and written over it.
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------
>
> Kees Cook


Thanks, I'll be sure to avoid using 3202fa62f as the cause next time.
I just thought to do that because it was what made the use-after-free cause
a noticeable bug.

Also, by the way, I just realised the patch didn't completely solve the bug=
.
Sorry about that, making an LKML thread on this was hasty on my part. Shoul=
d
I get further confirmation from the Bugzilla thread before submitting a pat=
ch
for this bug in the future?

Thanks,
Mazin Rezk
