Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C44C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5377A20656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLLo7z94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404390AbgFXPMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390826AbgFXPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:11:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16386C061573;
        Wed, 24 Jun 2020 08:11:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h5so2650873wrc.7;
        Wed, 24 Jun 2020 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ujwQciPl+L7lbdcyijKwCUqH7IK4/9USSSXUk6qmZOg=;
        b=SLLo7z94ccgwtDRo0DFIuN0STQWBcNUVZRVpDAX0TnbXHV/3AfY7PhJ3vY6yeCIH/p
         J/bRTe2lxeuS/kMB3cPIpFqxkvT0V9JUW7F1Ogi7YXj5mrC0SW4YKpNJGfXyMdgUTSBN
         SL7zioevlWWqq2F5+Iyq0KGMeVPqSp2qDGZpkKCoQzpDrArtAR+pd1Fg3z7EVwTM3afV
         rv5/iz2fwdHuzU1R8q0Hq0Bm1wz3GL/3HDF1q9XuOipEvbPrfp6UC8cg3iTIEEsBxCq0
         sJN8yqiKVu+Zr9WIQvF4U2zzpiW7BoCgHCEFi3VDNhDmtRVpsaAFiutq3h55vS7ysc2w
         jVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ujwQciPl+L7lbdcyijKwCUqH7IK4/9USSSXUk6qmZOg=;
        b=sMA2JR1COlUatbElHVpZrJPGadKjAFyyekKte6KTNd1a3BCbB3lhhDzX6IpoJ4K1FT
         530TXA8V9aswpOcdAgHkGYgyu1KSc7VOiA8dv8OA3eRotVrIYHTRiMT83VU8gbFUHy5i
         +F3KoxvbGnVzwHW1bZzjdMvtsfrpIcWDfQR9GbOqTlQmpviE8UhBXF66od5t8ZkV5BdK
         rX4shM/6v8rHF/XcUf0Ah/nbBjyuZ4t2kptGjqhcRjiJtwuGwHXLCOTicUHfzpaQUoAg
         M5BUesNjw2c9mKJDhU+i+Jjj3BFiCiIYLbAOQ03g2cR6M1pkkSj670aP4+lmdmQMj/IM
         pUEg==
X-Gm-Message-State: AOAM533YPCDY89ejBq/pj6FyPw0FSZQ0mOZ2D2j9l++NTWKr4QdPz2Du
        vGyJ7B1K9eOUvO4ui2cUuj7yVyUxrVyfKOIOVXU=
X-Google-Smtp-Source: ABdhPJxcZ8Rrz4WTVA4JzfkWUwnDA9iyEW5D2N5Bj7502ovzHh8Sp8ZDl5fWVo+v3zOctaqg18jwU0autp6y1oTfP34=
X-Received: by 2002:a5d:5549:: with SMTP id g9mr28913930wrw.419.1593011516671;
 Wed, 24 Jun 2020 08:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200624141423.6307-1-colin.king@canonical.com> <f9ceecb4-2679-c0e2-8f64-4dd2a4f5401f@amd.com>
In-Reply-To: <f9ceecb4-2679-c0e2-8f64-4dd2a4f5401f@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 24 Jun 2020 11:11:45 -0400
Message-ID: <CADnq5_PA+Qs=oBkWwSneD1ptAVMdLcN3zL=UrjsNQFnaA2wLYQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm: amdgpu: fix premature goto because of missing braces
To:     Nirmoy <nirmodas@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Sonny Jiang <sonny.jiang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Jun 24, 2020 at 10:32 AM Nirmoy <nirmodas@amd.com> wrote:
>
> Acked-by: Nirmoy Das <nirmoy.das@amd.com>
>
>
> Thanks,
>
> Nirmoy
>
> On 6/24/20 4:14 PM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently the goto statement is skipping over a lot of setup code
> > because it is outside of an if-block and should be inside it. Fix
> > this by adding missing if statement braces.
> >
> > Addresses-Coverity: ("Structurally dead code")
> > Fixes: fd151ca5396d ("drm amdgpu: SI UVD v3_1")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > index 599719e89c31..7cf4b11a65c5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > @@ -642,9 +642,10 @@ static int uvd_v3_1_hw_init(void *handle)
> >       uvd_v3_1_start(adev);
> >
> >       r = amdgpu_ring_test_helper(ring);
> > -     if (r)
> > +     if (r) {
> >               DRM_ERROR("amdgpu: UVD ring test fail (%d).\n", r);
> > -     goto done;
> > +             goto done;
> > +     }
> >
> >       r = amdgpu_ring_alloc(ring, 10);
> >       if (r) {
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
