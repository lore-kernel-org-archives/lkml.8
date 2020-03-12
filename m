Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C8CC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE06A20650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3vlWoDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgCLO2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:28:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37061 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgCLO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:28:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id a141so6557404wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dY/RhFMUP0nQ5TAbXB37oNSJMhhJygxiAwBiWfEJ74A=;
        b=t3vlWoDN2RG9FJdNKId8QZcDeUw31SKq4nKNnGovgVG7xia7I1dZVWUWWa2f/vEd43
         NdEOZzIDZwwwOIUNG+BLRw/3m3BGFi8dy3nc9G+X7taOp/VK+EBrwAmD2G8B84H1VCuo
         S010Kc+PTnMaVGP9bjnyrNW55HhvLaU4z6RoYBNBAdj5cS9+lsgH831WLtegEhHni/1t
         4H3TjD7dnseVcoOoWqf1q9rDzn3+55dyeW6qlPH0RTfrdTjb+i91EVSrwK2HUMGdTxZp
         VdVbEH+vkMQXwlcyaKdzvcgfBBZQ/qKzOEHOmoXmcz+m2bMbcdcw+lppsED7uadFkEGw
         tyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dY/RhFMUP0nQ5TAbXB37oNSJMhhJygxiAwBiWfEJ74A=;
        b=TdrVtvkjGkLGnBRisOfDNML90ivAvjrAnsTocOL6gzr9H/KLb3dCqhWnEWPlHefPEx
         laUPBThdsouIrNL7W0R6xIjMPjmYE/j1DWbmUFfKcritLaoVjizP4AsdtGf1ASk3VDm5
         giUlccm6iBrXKPZBR43u9Z9UdFLGfxT14TCLVrSRkO0+4ay1Q8s2gas69mnnG43g22D9
         rzCqzElRVRch8GQqfiBzHeFHxAv9uHq9Kl4JZZYzUGxiy0Nu1/gu/99HU6OC2Cl1HoEK
         a2OixdYwIJrsq7yuTKv7juyy/jpdNKxmanaYqZpkfOWgF7VL/4DA5bKqzlR0H9wuJsXq
         iSQg==
X-Gm-Message-State: ANhLgQ3FnodhsolUITcXPfLiVnlOTnh1RIEazvPYHdCxYU/BIMbzlKMO
        HRCm9oVahVltK4e/rVUSw6eDGjb6AKkKegixaK4=
X-Google-Smtp-Source: ADFU+vsXshP7RsY77gDiaFil4BUsOOPxIIdV/vB0PFEE91IG8O0YaxhLKjOpgVnaVm7DWBSYZyORgDrSf9xUmjEHvMI=
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr5139239wmc.39.1584023326879;
 Thu, 12 Mar 2020 07:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200124010744.102849-1-lyude@redhat.com> <f9ab0fdf-b235-2709-8431-5a094b539531@amd.com>
In-Reply-To: <f9ab0fdf-b235-2709-8431-5a094b539531@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 Mar 2020 10:28:34 -0400
Message-ID: <CADnq5_MoWMHq_t4KozoqgxfFB1LUqh=Uz20pOREsiQXNE_5nBA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Stop using the DRIVER debugging flag for
 vblank debugging messages
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Francis <David.Francis@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Fri, Jan 24, 2020 at 9:48 AM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2020-01-23 8:07 p.m., Lyude Paul wrote:
> > These are some very loud debug statements that get printed on every
> > vblank when driver level debug printing is enabled in DRM, and doesn't
> > really tell us anything that isn't related to vblanks. So let's move
> > this over to the proper debug flag to be a little less spammy with our
> > debug output.
> >
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> Thanks. Great change.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 9402374d2466..3675e1c32707 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -407,8 +407,9 @@ static void dm_vupdate_high_irq(void *interrupt_params)
> >       if (acrtc) {
> >               acrtc_state = to_dm_crtc_state(acrtc->base.state);
> >
> > -             DRM_DEBUG_DRIVER("crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
> > -                              amdgpu_dm_vrr_active(acrtc_state));
> > +             DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
> > +                           acrtc->crtc_id,
> > +                           amdgpu_dm_vrr_active(acrtc_state));
> >
> >               /* Core vblank handling is done here after end of front-porch in
> >                * vrr mode, as vblank timestamping will give valid results
> > @@ -458,8 +459,9 @@ static void dm_crtc_high_irq(void *interrupt_params)
> >       if (acrtc) {
> >               acrtc_state = to_dm_crtc_state(acrtc->base.state);
> >
> > -             DRM_DEBUG_DRIVER("crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
> > -                              amdgpu_dm_vrr_active(acrtc_state));
> > +             DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
> > +                           acrtc->crtc_id,
> > +                           amdgpu_dm_vrr_active(acrtc_state));
> >
> >               /* Core vblank handling at start of front-porch is only possible
> >                * in non-vrr mode, as only there vblank timestamping will give
> > @@ -522,8 +524,8 @@ static void dm_dcn_crtc_high_irq(void *interrupt_params)
> >
> >       acrtc_state = to_dm_crtc_state(acrtc->base.state);
> >
> > -     DRM_DEBUG_DRIVER("crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
> > -                             amdgpu_dm_vrr_active(acrtc_state));
> > +     DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
> > +                   amdgpu_dm_vrr_active(acrtc_state));
> >
> >       amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
> >       drm_crtc_handle_vblank(&acrtc->base);
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
