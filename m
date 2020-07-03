Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A6EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FCB2088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HdKQPdez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgGCHRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgGCHRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:17:00 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A53C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 00:17:00 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w17so18166724otl.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 00:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4sOBL1SpWhQCdDOCcqpNN2i8EOfJd87ya10Qmo8jmQA=;
        b=HdKQPdezTWR2NMiivS9raddicQNww2R+YTIGXFZfq+k+GpbpkmL0VxJqEZ2KdVWvDz
         +R6esS7k5w/b3qU8vME5T0A5L7Zx4Ul6SKAvbzUPfSP6POEhTQ3NhYn2f2cQvPCVGZq1
         Fivucz4REE84BidkkuInrsMqcW8lbq2s7ripY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sOBL1SpWhQCdDOCcqpNN2i8EOfJd87ya10Qmo8jmQA=;
        b=tzixsOd2NUpQ2WuI7U7bZM/E0oVm7APRdKJXINiNUJv9aKFasnDai6gexjSOdiU1/u
         7KzYthoAJiiKvSykv/FxdisK+j8CyA2eGKcG/PevsSQq1aXdOvjkscWiY6KEsXvsfvSZ
         YepUop5yyFGlFlwXCWK7fbXBELaF191bUBxoZsGkhlP0VI/iHuGYGFWCc54yowkWQpST
         U413IFq0Xt0jB5LPXXIjPK48NS1urT2gq7QYwE/q21r+Yd7g0fWV/N5sXrfNVPcR0Kga
         mcXUbvo49am7GaDLVtiT706/gwbzhQ7L1nx3EJzOxmQYwS5XtB1M366Ardk95HerUIsZ
         TF9g==
X-Gm-Message-State: AOAM5323gY5JDwccf2Ea4+XH6rFLRwCGqSTD1aqKhkW3RSvoDKc8GIAv
        DbY+pxOAgacrbuyTnOOFnjfXgK96UcBgGpl2Da989Q==
X-Google-Smtp-Source: ABdhPJwBpXgcOmcjg/TSQXkOE8LArZNblH7ipmTW9RJ/VR+ll6/bVTe/IIXOKhUC3MbRfj5GoXcgzLF/XWZhwz88GPw=
X-Received: by 2002:a05:6830:1613:: with SMTP id g19mr16954562otr.303.1593760619959;
 Fri, 03 Jul 2020 00:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200630230808.wj2xlt44vrszqfzx@box> <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
 <20200701075719.p7h5zypdtlhqxtgv@box> <20200701075902.hhmaskxtjsm4bcx7@box>
 <77e744b9-b5e2-9e9b-44c1-98584d2ae2f3@nvidia.com> <CAPj87rOrUHBZZR3cw+iqUMtZL1ZQyjd=RoM2yHt5oUeRO5uDTA@mail.gmail.com>
 <5ffa32db-4383-80f6-c0cf-a9bb12e729aa@nvidia.com> <a3d331e9-d17e-9135-68c7-8e3e10df184d@nvidia.com>
In-Reply-To: <a3d331e9-d17e-9135-68c7-8e3e10df184d@nvidia.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 3 Jul 2020 09:16:48 +0200
Message-ID: <CAKMK7uG8x4dHrRnzK9FFrJbtWsdLk+TTObK9r-nSncKowHVe3A@mail.gmail.com>
Subject: Re: [git pull] drm for 5.8-rc1
To:     James Jones <jajones@nvidia.com>
Cc:     Daniel Stone <daniel@fooishbar.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 8:01 AM James Jones <jajones@nvidia.com> wrote:
>
> On 7/2/20 2:14 PM, James Jones wrote:
> > On 7/2/20 1:22 AM, Daniel Stone wrote:
> >> Hi,
> >>
> >> On Wed, 1 Jul 2020 at 20:45, James Jones <jajones@nvidia.com> wrote:
> >>> OK, I think I see what's going on.  In the Xorg modesetting driver, the
> >>> logic is basically:
> >>>
> >>> if (gbm_has_modifiers && DRM_CAP_ADDFB2_MODIFIERS != 0) {
> >>>     drmModeAddFB2WithModifiers(..., gbm_bo_get_modifier(bo->gbm));
> >>> } else {
> >>>     drmModeAddFB(...);
> >>> }
> >>
> >> I read this thread expecting to explain the correct behaviour we
> >> implement in Weston and how modesetting needs to be fixed, but ...
> >> that seems OK to me? As long as `gbm_has_modifiers` is a proxy for 'we
> >> used gbm_(bo|surface)_create_with_modifiers to allocate the buffer'.
> >
> > Yes, the hazards of reporting findings before verifying.  I now see
> > modesetting does query the DRM-KMS modifiers and attempt to allocate
> > with them if it found any.  However, I still see a lot of ways things
> > can go wrong, but I'm not going to share my speculation again until I've
> > actually verified it, which is taking a frustratingly long time.  The
> > modesetting driver is not my friend right now.
>
> OK, several hours of dumb build+config mistakes later, I was actually
> able to reproduce the failure and walk through things.  There is a
> trivial fix for the issues in the X modesetting driver, working off
> Daniel Stone's claim that gbm_bo_get_modifier() should only be called
> when the allocation was made with gbm_bo_create_with_modifiers().
> modeset doesn't respect that requirement now in the case that the atomic
> modesetting path is disabled, which is always the case currently because
> that path is broken.  Respecting that requirement is a half-liner and
> allows X to start properly.
>
> If I force modeset to use the atomic path, X still fails to start with
> the above fix, validating the second theory I'd had:
>
> -Current Mesa nouveau code basically ignores the modifier list passed in
> unless it is a single modifier requesting linear layout, and goes about
> allocating whatever layout it sees fit, and succeeds the allocation
> despite being passed a list of modifiers it knows nothing about.  Not
> great, fixed in my pending patches, obviously doesn't help existing
> deployed userspace.
>
> -Current Mesa nouveau code, when asked what modifier it used for the
> above allocation, returns one of the "legacy" modifiers nouveau DRM-KMS
> knows nothing about.
>
> -When the modeset driver tries to create an FB for that BO with the
> returned modifier, the nouveau kernel driver of course refuses.
>
> I think it's probably worth fixing the modesetting driver for the
> reasons Daniel Vetter mentioned.  Then if I get my Mesa patches in
> before a new modesetting driver with working Atomic support is released,
> there'll be no need for long-term workarounds in the kernel.

So atm there's 0 working -modesetting with atomic because all of them
are caught up by the kernel's check to refuse to hand out atomic
support to X. I think we'd also need a patch to pump the atomic setcap
to 2 (which should bypass the kernel's hack), plus of course someone
needs to release 1.21.

> Down to the real question of what to do in the kernel to support current
> userspace code: I still think the best fix is to accept the old
> modifiers but not advertise them.  However, Daniel Stone and others, if
> you think this will actually break userspace in other ways (Could you
> describe in a bit more detail or point me to test cases if so?), I
> suppose the only option would be to advertise & accept the old modifiers
> for now, and I suppose at a config option at some point to phase the old
> ones out, eventually drop them entirely.  This would be unfortunate,
> because as I mentioned, it could sometimes result in situations where
> apps think they can share a buffer between two devices but will get
> garbled data in practice.
>
> I've included an initial version of the kernel patch inline below.
> Needs more testing, but I wanted to share it in case anyone has feedback
> on the idea, wants to see the general workflow, or wants to help test.

I think the only risk I'm seeing if nouveau currently also allocates
formats (sometimes, maybe) that you then can't always scan out. If
that's not the case, then silently allowing old modifiers to keep
things working sounds like the best option.

Otherwise sounds all reasonable, maybe more comments and hints to what
exactly is broken in userspace for the real patch (once tested and
all).
-Daniel

> >>> There's no attempt to verify the DRM-KMS device supports the modifier,
> >>> but then, why would there be?  GBM presumably chose a supported modifier
> >>> at buffer creation time, and we don't know which plane the FB is going
> >>> to be used with yet.  GBM doesn't actually ask the kernel which
> >>> modifiers it supports here either though.
> >>
> >> Right, it doesn't ask, because userspace tells it which modifiers to
> >> use. The correct behaviour is to take the list from the KMS
> >> `IN_FORMATS` property and then pass that to
> >> `gbm_(bo|surface)_create_with_modifiers`; GBM must then select from
> >> that list and only that list. If that call does not succeed and Xorg
> >> falls back to `gbm_surface_create`, then it must not call
> >> `gbm_bo_get_modifier` - so that would be a modesetting bug. If that
> >> call does succeed and `gbm_bo_get_modifier` subsequently reports a
> >> modifier which was not in the list, that's a Mesa driver bug.
> >>
> >>> It just goes into Mesa via
> >>> DRI and reports the modifier (unpatched) Mesa chose on its own.  Mesa
> >>> just hard-codes the modifiers in its driver backends since its thinking
> >>> in terms of a device's 3D engine, not display.  In theory, Mesa's DRI
> >>> drivers could query KMS for supported modifiers if allocating from GBM
> >>> using the non-modifiers path and the SCANOUT flag is set (perhaps some
> >>> drivers do this or its equivalent?  Haven't checked.), but that seems
> >>> pretty gnarly and doesn't fix the modifier-based GBM allocation path
> >>> AFAIK.  Bit of a mess.
> >>
> >> Two options for GBM users:
> >> * call gbm_*_create_with_modifiers, it succeeds, call
> >> gbm_bo_get_modifier, pass modifier into AddFB
> >> * call gbm_*_create (without modifiers), it succeeds, do not call
> >> gbm_bo_get_modifier, do not pass a modifier into AddFB
> >>
> >> Anything else is a bug in the user. Note that falling back from 1 to 2
> >> is fine: if `gbm_*_create_with_modifiers()` fails, you can fall back
> >> to the non-modifier path, provided you don't later try to get a
> >> modifier back out.
> >>
> >>> For a quick userspace fix that could probably be pushed out everywhere
> >>> (Only affects Xorg server 1.20+ AFAIK), just retrying
> >>> drmModeAddFB2WithModifiers() without the DRM_MODE_FB_MODIFIERS flag on
> >>> failure should be sufficient.
> >>
> >> This would break other drivers.
> >
> > I think this could be done in a way that wouldn't, though it wouldn't be
> > quite as simple.  Let's see what the true root cause is first though.
> >
> >>> Still need to verify as I'm having
> >>> trouble wrangling my Xorg build at the moment and I'm pressed for time.
> >>> A more complete fix would be quite involved, as modesetting isn't really
> >>> properly plumbed to validate GBM's modifiers against KMS planes, and it
> >>> doesn't seem like GBM/Mesa/DRI should be responsible for this as noted
> >>> above given the general modifier workflow/design.
> >>>
> >>> Most importantly, options I've considered for fixing from the kernel
> >>> side:
> >>>
> >>> -Accept "legacy" modifiers in nouveau in addition to the new modifiers,
> >>> though avoid reporting them to userspace as supported to avoid further
> >>> proliferation.  This is pretty straightforward.  I'll need to modify
> >>> both the AddFB2 handler (nouveau_validate_decode_mod) and the mode set
> >>> plane validation logic (nv50_plane_format_mod_supported), but it should
> >>> end up just being a few lines of code.
> >>
> >> I do think that they should also be reported to userspace if they are
> >> accepted. Other users can and do look at the modifier list to see if
> >> the buffer is acceptable for a given plane, so the consistency is good
> >> here. Of course, in Mesa you would want to prioritise the new
> >> modifiers over the legacy ones, and not allocate or return the legacy
> >> ones unless that was all you were asked for. This would involve
> >> tracking the used modifier explicitly through Mesa, rather than
> >> throwing it away at alloc time and then later divining it from the
> >> tiling mode.
> >
> > Reporting them as supported is equivalent to reporting support for a
> > memory layout the chips don't actually support (It corresponds to a
> > valid layout on Tegra chips, but not on discrete NV chips).  This is
> > what the new modifiers are trying to avoid in the first place: Implying
> > buffers can be shared between these Tegra chips and discrete NV GPUs.
> >
> > Thanks,
> > -James
> >
> >> Cheers,
> >> Daniel
> >>
>
> nouveau: Accept 'legacy' format modifiers
>
> Accept the DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK()
> family of modifiers to handle broken userspace
> Xorg modesetting and Mesa drivers.
> ---
>   drivers/gpu/drm/nouveau/nouveau_display.c | 26 +++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c
> b/drivers/gpu/drm/nouveau/nouveau_display.c
> index 496c4621cc78..31543086254b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> @@ -191,8 +191,14 @@ nouveau_decode_mod(struct nouveau_drm *drm,
>                    uint32_t *tile_mode,
>                    uint8_t *kind)
>   {
> +       struct nouveau_display *disp = nouveau_display(drm->dev);
>         BUG_ON(!tile_mode || !kind);
>
> +       if ((modifier & (0xffull << 12)) == 0ull) {
> +               /* Legacy modifier.  Translate to this device's 'kind.' */
> +               modifier |= disp->format_modifiers[0] & (0xffull << 12);
> +       }
> +
>         if (modifier == DRM_FORMAT_MOD_LINEAR) {
>                 /* tile_mode will not be used in this case */
>                 *tile_mode = 0;
> @@ -227,6 +233,16 @@ nouveau_framebuffer_get_layout(struct
> drm_framebuffer *fb,
>         }
>   }
>
> +static const u64 legacy_modifiers[] = {
> +       DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(0),
> +       DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(1),
> +       DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(2),
> +       DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(3),
> +       DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(4),
> +       DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(5),
> +       DRM_FORMAT_MOD_INVALID
> +};
> +
>   static int
>   nouveau_validate_decode_mod(struct nouveau_drm *drm,
>                             uint64_t modifier,
> @@ -247,8 +263,14 @@ nouveau_validate_decode_mod(struct nouveau_drm *drm,
>              (disp->format_modifiers[mod] != modifier);
>              mod++);
>
> -       if (disp->format_modifiers[mod] == DRM_FORMAT_MOD_INVALID)
> -               return -EINVAL;
> +       if (disp->format_modifiers[mod] == DRM_FORMAT_MOD_INVALID) {
> +               for (mod = 0;
> +                    (legacy_modifiers[mod] != DRM_FORMAT_MOD_INVALID) &&
> +                    (legacy_modifiers[mod] != modifier);
> +                    mod++);
> +               if (legacy_modifiers[mod] == DRM_FORMAT_MOD_INVALID)
> +                       return -EINVAL;
> +       }
>
>         nouveau_decode_mod(drm, modifier, tile_mode, kind);
>
> --
> 2.17.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
