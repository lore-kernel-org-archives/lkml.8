Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFAFC54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D2A20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loukMwfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCXTmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:42:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40725 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCXTmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:42:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so4926767wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcB+tq5Rgj7hEjAm6kQlVEkLWTkSJ/gNL53xHmD0Uck=;
        b=loukMwfTiUhp+6HSA/DQrYEvGm4YpFdj/AZfft93YrG45642/xWkNAz+KiBQ//2Fhu
         KYi2mcD+sf0TPAbxvqar6SsFqJCdutLLxZCMnFoWmw4vhOABdBN2QakoJsWLuRwXLuYd
         x/9zJJF1hjNB/yowWZXOGBKrfRefrCM7logsrjjfZ3+rKbV5xXpbFXFPUnoUWDXBpyyy
         AFBIPqgdpNmuh4mx+3HpDF7idzcXJXlbMFf3U/gBXqDBfGOVY/QnTmvxVQcb9+2GAiEm
         /LB/GkdLOVCz+2nMe5yn4uqWV5AqN6CTg2mffguLfmarOc2DmX4zZ+v5JlDxxmXYdpSQ
         YcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcB+tq5Rgj7hEjAm6kQlVEkLWTkSJ/gNL53xHmD0Uck=;
        b=VsAyfz+lGCnMyZKxVwEvS7NO0sMtIUyQD4tJCFBgfWOHhnLTwYC0yEKd3tl2/1xUyk
         yPiORbEaIf0GMrKdZwNvjd3GbKQNw4f3LLL5dZ7XMfpDKBTrRVuF9JYyaB6USw24fX0F
         I6yTrr/ZyHfgRIkOaXdl5S5h1kM8OkTnzgClwybPtti4jDVuPYjYGmOEHkvo5I6kjjdl
         PhbHcntMrJtSJc5l+lp/7a9RTbWlRIq1TPh2PhnfUPBGION4px5pcFKW7O2D+ZNoveUr
         p8C9lI3kr2eLYMAiZS0D9H3FNk/uAmKzUiycxnGSM2YxU9uhgoaLfqeIgJrcLCwfbSqK
         nKUA==
X-Gm-Message-State: ANhLgQ2OsTxnP/zji1q14tQAIruodPBx+djI9tsRNV36vQ1+Q1RC1UQ2
        ffGji2p5TIADvHJiMqF5OwtfE8uYRtO2i5mFHFs=
X-Google-Smtp-Source: ADFU+vsVLJ3Wj1PXVDBegxztfsXqTfDXiYljZ9KRzUr6EG1nA8pDji3GfkC+UKjBBDi2SC8Erl5pb8UqUJ/LI8O7+zo=
X-Received: by 2002:a1c:2842:: with SMTP id o63mr7494442wmo.73.1585078968451;
 Tue, 24 Mar 2020 12:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200213153928.28407-1-masahiroy@kernel.org> <CAK7LNARvxFk=ct9AoRLwjZ9cKRsA_bjiLaq0di12TRe5+fpmGA@mail.gmail.com>
In-Reply-To: <CAK7LNARvxFk=ct9AoRLwjZ9cKRsA_bjiLaq0di12TRe5+fpmGA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Mar 2020 15:42:37 -0400
Message-ID: <CADnq5_Mieh9G-8hheKRdKe=qMbAQjwTheM2TWWSaZjeGU3635Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/radeon: remove unneeded header include path
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?B?Q2hyaXN0aWFuIEvvv73vv73Dk25pZw==?= 
        <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 12:48 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi,
>
> I think this series is a good clean-up.
>
> Could you take a look at this please?

Can you resend?  I don't seem to have gotten it.  Must have ended up
getting flagged a spam or something.

Alex

>
>
>
> On Fri, Feb 14, 2020 at 12:40 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > A header include path without $(srctree)/ is suspicious because it does
> > not work with O= builds.
> >
> > You can build drivers/gpu/drm/radeon/ without this include path.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  drivers/gpu/drm/radeon/Makefile | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
> > index c693b2ca0329..9d5d3dc1011f 100644
> > --- a/drivers/gpu/drm/radeon/Makefile
> > +++ b/drivers/gpu/drm/radeon/Makefile
> > @@ -3,8 +3,6 @@
> >  # Makefile for the drm device driver.  This driver provides support for the
> >  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> >
> > -ccflags-y := -Idrivers/gpu/drm/amd/include
> > -
> >  hostprogs := mkregtable
> >  clean-files := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
> >
> > --
> > 2.17.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
