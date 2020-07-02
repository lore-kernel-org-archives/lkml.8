Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2ACC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CCB206BE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TQ4ehxP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgGBHgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgGBHgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:36:41 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5866BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 00:36:41 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id h17so22915866oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 00:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FsHECmH34HAntg3dstt1YGzFECGsABxoC49cUDBrcU=;
        b=TQ4ehxP7BJbr9mopAR414qKLO8bJUiKApfKdTjiZC2awjIaI7jXRoIPITXDaWmEydy
         TGO7gP3COW1H71+Mtlgu6Tc2McuggJhKjDw/jd5visI5bFNUT84AAbCznADj8qX+fQXx
         CVmOrm6nz4SlCrQIDr+eWsizmp7eBo9YRt90A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FsHECmH34HAntg3dstt1YGzFECGsABxoC49cUDBrcU=;
        b=lCxrebvmPP7oWYYrh966svqblCtw/iVItJEz4Bhp+I57rXun7agmimauX3aPoy2qRp
         e48hR00jMgZl9s24CicgGcwr4U7LglXLfKRit4+eXU/6BdBmBnJoOoMQOD7vr/KPd5/G
         GghUH2kJTDCtH1tZX9p5AyASJEGkDTjqUbpOtuTrI2LWaGBCshcJLsjTR1iRwCQgCJjI
         CIgmz3VMXJZ798TUzoGac39IwiYFhOuKJnPiKRqzgTUOTu9FsaCjBvht8+Ew7hBHqhLS
         aHAe2I6rnyzTZEK3QK5WWZ8rtIHKFUYHvRtkztV2zXCZfqp5XxvCLFM6d3iquZLfA84H
         QG+A==
X-Gm-Message-State: AOAM532p4Z6+Mg8YPAoWKB8c4BOIqdm9S0HMiVo0GqbVIjfP20QaCeeX
        fDzFiYCZlFJhkApRBTJie0FVJPYbe/BoCzW0/B7YwA==
X-Google-Smtp-Source: ABdhPJwAujqbEPdBrqDKTWbkFKE6PCpXce8tnzumMJPKj2uYw2G9tUKVRgJEYqquq0aQcapNXIWcNA8YRwwT62yRVhs=
X-Received: by 2002:a05:6808:88:: with SMTP id s8mr6840160oic.101.1593675400631;
 Thu, 02 Jul 2020 00:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200630230808.wj2xlt44vrszqfzx@box> <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
 <20200701075719.p7h5zypdtlhqxtgv@box> <20200701075902.hhmaskxtjsm4bcx7@box> <77e744b9-b5e2-9e9b-44c1-98584d2ae2f3@nvidia.com>
In-Reply-To: <77e744b9-b5e2-9e9b-44c1-98584d2ae2f3@nvidia.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 2 Jul 2020 09:36:29 +0200
Message-ID: <CAKMK7uGJW7S6msS6MzxMAzNoUvfcZbajhc8rhD39d4TUk4Vx8w@mail.gmail.com>
Subject: Re: [git pull] drm for 5.8-rc1
To:     James Jones <jajones@nvidia.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 9:45 PM James Jones <jajones@nvidia.com> wrote:
>
> OK, I think I see what's going on.  In the Xorg modesetting driver, the
> logic is basically:
>
> if (gbm_has_modifiers && DRM_CAP_ADDFB2_MODIFIERS != 0) {
>    drmModeAddFB2WithModifiers(..., gbm_bo_get_modifier(bo->gbm));
> } else {
>    drmModeAddFB(...);
> }
>
> There's no attempt to verify the DRM-KMS device supports the modifier,
> but then, why would there be?  GBM presumably chose a supported modifier
> at buffer creation time, and we don't know which plane the FB is going
> to be used with yet.  GBM doesn't actually ask the kernel which
> modifiers it supports here either though.  It just goes into Mesa via
> DRI and reports the modifier (unpatched) Mesa chose on its own.  Mesa
> just hard-codes the modifiers in its driver backends since its thinking
> in terms of a device's 3D engine, not display.  In theory, Mesa's DRI
> drivers could query KMS for supported modifiers if allocating from GBM
> using the non-modifiers path and the SCANOUT flag is set (perhaps some
> drivers do this or its equivalent?  Haven't checked.), but that seems
> pretty gnarly and doesn't fix the modifier-based GBM allocation path
> AFAIK.  Bit of a mess.
>
> For a quick userspace fix that could probably be pushed out everywhere
> (Only affects Xorg server 1.20+ AFAIK), just retrying
> drmModeAddFB2WithModifiers() without the DRM_MODE_FB_MODIFIERS flag on
> failure should be sufficient.  Still need to verify as I'm having
> trouble wrangling my Xorg build at the moment and I'm pressed for time.
> A more complete fix would be quite involved, as modesetting isn't really
> properly plumbed to validate GBM's modifiers against KMS planes, and it
> doesn't seem like GBM/Mesa/DRI should be responsible for this as noted
> above given the general modifier workflow/design.
>
> Most importantly, options I've considered for fixing from the kernel side:
>
> -Accept "legacy" modifiers in nouveau in addition to the new modifiers,
> though avoid reporting them to userspace as supported to avoid further
> proliferation.  This is pretty straightforward.  I'll need to modify
> both the AddFB2 handler (nouveau_validate_decode_mod) and the mode set
> plane validation logic (nv50_plane_format_mod_supported), but it should
> end up just being a few lines of code.
>
> -Don't validate modifiers in AddFB.  This doesn't really gain anything
> because it just pushes the failure down to mode set time, so it's not
> that useful, so I don't plan on pursuing this.
>
> As noted, need to run just now, but I should have a kernel patch to test
> out either tonight or tomorrow.
>
> If anyone's curious, the reason my testing missed this was I did most of
> my verification of "old" code against the Xorg 1.19 build included with
> my distro.  I did hack up a Xorg 1.20-ish build to test as well that
> would have included this path, but I must not have properly configured
> it with GBM modifier support somehow.  I was pretty focused on just
> testing the forcibly-disabled atomic path in the modesetting driver in
> this build, so I didn't look too closely at things beyond that.

Yeah, so modifier support in -modesetting is totally broken. It should
be disabled by default because the stuff just doesn't really work.

If that doesn't help then I guess we need to do the same thing as what
we've done for atomic already in:

commit 26b1d3b527e7bf3e24b814d617866ac5199ce68d
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu Sep 5 20:53:18 2019 +0200

    drm/atomic: Take the atomic toys away from X

For added insult for the atomic stuff: Xorg master branch is actually
fixed, but no one has done a release of that in over 2 years, so the
fixes never got anywhere. I have little hope the Xorg will get back
into shape, seems abandoned unfortunately.
-Daniel

>
> Thanks,
> -James
>
> On 7/1/20 12:59 AM, Kirill A. Shutemov wrote:
> > On Wed, Jul 01, 2020 at 10:57:19AM +0300, Kirill A. Shutemov wrote:
> >> On Tue, Jun 30, 2020 at 09:40:19PM -0700, James Jones wrote:
> >>> This implies something is trying to use one of the old
> >>> DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK format modifiers with DRM-KMS without
> >>> first checking whether it is supported by the kernel.  I had tried to force
> >>> an Xorg+Mesa stack without my userspace patches to hit this error when
> >>> testing, but must have missed some permutation.  If the stalled Mesa patches
> >>> go in, this would stop happening of course, but those were held up for a
> >>> long time in review, and are now waiting on me to make some modifications.
> >>>
> >>> Are you using the modesetting driver in X? If so, with glamor I presume?
> >>
> >> Yes and yes. I attached Xorg.log.
> >
> > Attached now.
> >
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
