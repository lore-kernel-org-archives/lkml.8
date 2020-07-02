Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5552EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312F920899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="L0zwwvq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgGBIWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgGBIWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:22:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB69FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 01:22:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j4so24640448wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3t9GLwryJTaOdXMZTnjC4mjz71cq4jtvm6cibUFNxhQ=;
        b=L0zwwvq4BVdjvUIxi+uPw5MuIa6xxrKv8PXWwwOqBnqQQayVI8X4r7GkFILmCbJVyx
         mGgsy107fK8syh3GtAmoXiKVwyVnUX5lFUIp3s9ZYD4uD3Yx903cMfVj48UJTzTmUTqh
         vKf8CinW3GqwTCffXrOsQH08fw02qBc+ShhaX3aMyDutoBmCQelhqd/pK9U9prEpvsyD
         4mnkRzzurB/44dgQElYhlUjjV4Qh0YcqpRbdA2sxhXAlW2fR9j1XcDe9jT6ErKzD7sWH
         HBcord3lfJqekNCuTV0MWM8j/1Po4uHSF5gpOIrseByAyfBFfmb/R0id4E+U7V7joXar
         cH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3t9GLwryJTaOdXMZTnjC4mjz71cq4jtvm6cibUFNxhQ=;
        b=mSZOf30exmD5YtZETPQeUfuE1wL+dLaK3hcokCPu7rGtyO6dkigpeAZ4+yPbhJ0WT1
         8scUMMwHCA3n8ag7bEQGEwZ4DeYERSkiGh1dMKZEft05sifFyFq12SFOwFrDrN33Nm5J
         Zwh6dpV9A39cp03aLeUQHvaeSqAccvonB8QAkTAa1xS9hZe4nzMhfJqu6DfcYnJ87xGM
         nSFlOw/qx6T7VhzIAOEcG++ZIt5Xq35z5XQfpNB73wCEWiuM8uFeAwheTb3se5jVxuuI
         CfITlyQ/0TP3+M5NJRAXKeX8hcJQJpTqHUEcJxKI6KuHJLe0RhBDnZKzNYfHJNQSt7wY
         pVpg==
X-Gm-Message-State: AOAM531xrGG9zDgEpXEdm6UXVLElk8YPbbb7C18haEEkgI0Tc2Gai83n
        1jwwRY652YuD2vkyXB6Ks2uukUrGP6B9kyoYkVNO4w==
X-Google-Smtp-Source: ABdhPJyIghecqPkmAYT+NI4s3yizDvT3Zx51BClqfp89CAi6K5ZYAPyQ1gPIGKCHrwC6RltmFFPoxv5AIS11N9RWTM0=
X-Received: by 2002:a5d:6288:: with SMTP id k8mr29524832wru.373.1593678163746;
 Thu, 02 Jul 2020 01:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200630230808.wj2xlt44vrszqfzx@box> <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
 <20200701075719.p7h5zypdtlhqxtgv@box> <20200701075902.hhmaskxtjsm4bcx7@box> <77e744b9-b5e2-9e9b-44c1-98584d2ae2f3@nvidia.com>
In-Reply-To: <77e744b9-b5e2-9e9b-44c1-98584d2ae2f3@nvidia.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Thu, 2 Jul 2020 09:22:32 +0100
Message-ID: <CAPj87rOrUHBZZR3cw+iqUMtZL1ZQyjd=RoM2yHt5oUeRO5uDTA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.8-rc1
To:     James Jones <jajones@nvidia.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 1 Jul 2020 at 20:45, James Jones <jajones@nvidia.com> wrote:
> OK, I think I see what's going on.  In the Xorg modesetting driver, the
> logic is basically:
>
> if (gbm_has_modifiers && DRM_CAP_ADDFB2_MODIFIERS != 0) {
>    drmModeAddFB2WithModifiers(..., gbm_bo_get_modifier(bo->gbm));
> } else {
>    drmModeAddFB(...);
> }

I read this thread expecting to explain the correct behaviour we
implement in Weston and how modesetting needs to be fixed, but ...
that seems OK to me? As long as `gbm_has_modifiers` is a proxy for 'we
used gbm_(bo|surface)_create_with_modifiers to allocate the buffer'.

> There's no attempt to verify the DRM-KMS device supports the modifier,
> but then, why would there be?  GBM presumably chose a supported modifier
> at buffer creation time, and we don't know which plane the FB is going
> to be used with yet.  GBM doesn't actually ask the kernel which
> modifiers it supports here either though.

Right, it doesn't ask, because userspace tells it which modifiers to
use. The correct behaviour is to take the list from the KMS
`IN_FORMATS` property and then pass that to
`gbm_(bo|surface)_create_with_modifiers`; GBM must then select from
that list and only that list. If that call does not succeed and Xorg
falls back to `gbm_surface_create`, then it must not call
`gbm_bo_get_modifier` - so that would be a modesetting bug. If that
call does succeed and `gbm_bo_get_modifier` subsequently reports a
modifier which was not in the list, that's a Mesa driver bug.

> It just goes into Mesa via
> DRI and reports the modifier (unpatched) Mesa chose on its own.  Mesa
> just hard-codes the modifiers in its driver backends since its thinking
> in terms of a device's 3D engine, not display.  In theory, Mesa's DRI
> drivers could query KMS for supported modifiers if allocating from GBM
> using the non-modifiers path and the SCANOUT flag is set (perhaps some
> drivers do this or its equivalent?  Haven't checked.), but that seems
> pretty gnarly and doesn't fix the modifier-based GBM allocation path
> AFAIK.  Bit of a mess.

Two options for GBM users:
* call gbm_*_create_with_modifiers, it succeeds, call
gbm_bo_get_modifier, pass modifier into AddFB
* call gbm_*_create (without modifiers), it succeeds, do not call
gbm_bo_get_modifier, do not pass a modifier into AddFB

Anything else is a bug in the user. Note that falling back from 1 to 2
is fine: if `gbm_*_create_with_modifiers()` fails, you can fall back
to the non-modifier path, provided you don't later try to get a
modifier back out.

> For a quick userspace fix that could probably be pushed out everywhere
> (Only affects Xorg server 1.20+ AFAIK), just retrying
> drmModeAddFB2WithModifiers() without the DRM_MODE_FB_MODIFIERS flag on
> failure should be sufficient.

This would break other drivers.

> Still need to verify as I'm having
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

I do think that they should also be reported to userspace if they are
accepted. Other users can and do look at the modifier list to see if
the buffer is acceptable for a given plane, so the consistency is good
here. Of course, in Mesa you would want to prioritise the new
modifiers over the legacy ones, and not allocate or return the legacy
ones unless that was all you were asked for. This would involve
tracking the used modifier explicitly through Mesa, rather than
throwing it away at alloc time and then later divining it from the
tiling mode.

Cheers,
Daniel
