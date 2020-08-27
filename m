Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0210C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3972177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U49jQz3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgH0O3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgH0OQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:16:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB9C061236
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:51:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so1683934wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gVkUKTaskmscEtJ5ZzwNNX4gLUBJNoLUiPlck3rKbv8=;
        b=U49jQz3y2e7EBaQRi0qQ8rVwz+yVCuKIkU3XMjTPV0+omeVKFMKkRkG1gj9Z1Qs0e+
         9/0eC6U3p2vdfQyOzwun5pf9Tgf3/WZK43hOtQZrAmXwbrTx+ZcmOCjxqbEFi/mTvLdR
         9QfHSL8A+03Qb/FkGs0R3usdDG+Cu4cehsMOL2SgT0SuW0RLJk3B2Yih4xj+1w0SiYhX
         3uvT4T8iKUPGuYAPD/H9xXeId5nuIflMmqrtHnkj2zYKDt9ysmD0UvCQhdSFAhZ9b4P2
         ahfSfh3d4Xf9Iti9vX/BS1QEv8Gd56wgLUwKxS28ZyBOsP7CixS9ed9DCUpS2gAyTvml
         LAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gVkUKTaskmscEtJ5ZzwNNX4gLUBJNoLUiPlck3rKbv8=;
        b=cdk5R39jFpBAmlO2M2HmbP6XSPKn0pq7nD8UH6Ylrb/CpSRdbdJrG0OHCzzQk99MYW
         tDQmAjgmgwMCKjZiKvf6Xl3mSiRZPjq8UQVxY1SD9IB4znqklLfXh4KpkhLqLMZyNrN7
         UDqECJ5kFNIEft5sh4qNb9yLswHgV+UstzhacNJ+zWidwICWyDWWixnVuW6zLMJxiAq7
         HMtquVav3bDHM6n4lTHvxw01kU/qfBP7DbnrEcIwpTQZt4//Q741zp4EcC8Y5A63KgB5
         ZylqnRxreA7c9ZiEoDq6DiydAW+gfHyGklZlz64xhaerxAd0brIFY7SvVPjaoPlF9uy0
         hNDw==
X-Gm-Message-State: AOAM532neeTrOH9IzodMehdNLfiFCmoxVUxgGy1npsmuS3IdCD9gJq7J
        pbi7xo5eovTRtUJjprDI/4qC7YI/4KhjwJuKyyI=
X-Google-Smtp-Source: ABdhPJxUZbYiTHvH8yDDYRyp/OquPDJR8jlbS1sFzWfTl9o8bEGgVH+bzOnmOMvlXjdes3JSpG739Z6gh+aJGBfj90Q=
X-Received: by 2002:adf:fecc:: with SMTP id q12mr21109309wrs.374.1598536279457;
 Thu, 27 Aug 2020 06:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200825173349.24580-1-kai.heng.feng@canonical.com> <36ccb6ad-d005-4c39-fc32-7ecf4e71331f@amd.com>
In-Reply-To: <36ccb6ad-d005-4c39-fc32-7ecf4e71331f@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 Aug 2020 09:51:08 -0400
Message-ID: <CADnq5_NX8xmYbz8EiXZMRLXUV46W7cLUsBEj+AHX=we-sN=m8w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Prefer lower feedback dividers
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Aug 27, 2020 at 7:18 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 25.08.20 um 19:33 schrieb Kai-Heng Feng:
> > Commit 2e26ccb119bd ("drm/radeon: prefer lower reference dividers")
> > fixed screen flicker for HP Compaq nx9420 but breaks other laptops like
> > Asus X50SL.
> >
> > Turns out we also need to favor lower feedback dividers.
>
> Mhm, let's hope that this works out for all others as well :)
>
> >
> > Users confirmed this change fixes the regression and doesn't regress th=
e
> > original fix.
> >
> > Fixes: 2e26ccb119bd ("drm/radeon: prefer lower reference dividers")
> > BugLink: https://bugs.launchpad.net/bugs/1791312
> > BugLink: https://bugs.launchpad.net/bugs/1861554
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_display.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/=
radeon/radeon_display.c
> > index e0ae911ef427..7b69d6dfe44a 100644
> > --- a/drivers/gpu/drm/radeon/radeon_display.c
> > +++ b/drivers/gpu/drm/radeon/radeon_display.c
> > @@ -933,7 +933,7 @@ static void avivo_get_fb_ref_div(unsigned nom, unsi=
gned den, unsigned post_div,
> >
> >       /* get matching reference and feedback divider */
> >       *ref_div =3D min(max(den/post_div, 1u), ref_div_max);
> > -     *fb_div =3D DIV_ROUND_CLOSEST(nom * *ref_div * post_div, den);
> > +     *fb_div =3D max(nom * *ref_div * post_div / den, 1u);
> >
> >       /* limit fb divider to its maximum */
> >       if (*fb_div > fb_div_max) {
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
