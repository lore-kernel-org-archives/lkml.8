Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD8BC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD85720740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX/mueEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgCYPvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:51:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42552 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbgCYPvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:51:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15so3737260wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 08:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdzCJSQMgm0oyL98baNgXzwRjxVHoWxbruLDM0oUMk4=;
        b=BX/mueElGQ2pf5TxuXX1CUbBcr7X3BOPwGSt2wLZHkfy08N/rTANbsO/1zOe1fkxGE
         4XZAV/FMJvqzZZyr6Wv4pXgV0+Fip/4hAZs5GPTXS2vDmoC8VA76e0QA8XEGwSGvxNrf
         zYigoBJngcvnWPAFT4E10OhZ7R+76I0d0w7MN7nrfqpV3GKVqxxaUdzS3GjbVLD9TRML
         rregJC2ikLGw+s59YJ/ActxK4orduHalzGtdQKpIML/MvCQ2lMlI7NZvr44yANbgI+rz
         hVLc/W9TKopWDTISoc0dn5PgSIu6lX63hlQbFbv3cFWxf4iPByzQsAxns94rQFpz9p1/
         rE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdzCJSQMgm0oyL98baNgXzwRjxVHoWxbruLDM0oUMk4=;
        b=nY2oa8qtTIt2djhp7uuaHn/xTygfmnvAU44R5vGHuNNo6XDCjaLLJIGbVYBIvOEDlH
         kSL2csK5Pwf8sx2i7oy36W734nE4a92LOKC7CkFhQZfxbNarfFxuSJ8aZV0JeGNZVkBz
         x6Dtxcrv0hMhxF9CV0SmTp4RSIPicwfLknFADlmi48UNA5zYEVo1dU286B0qKbBJl9X3
         Abzv6gAIXPopJLyvFpkmTN9FExeSruLS5ES/akUckILbtB+eX99pk0U4GUO8Ah0pDZxV
         OaKhfhksQKz1YlTkMMa4kuOArxB26NK1gVG3fQe4Ybf1vDqQKazpSqYrnGx+6uohLoA0
         E3rg==
X-Gm-Message-State: ANhLgQ2bK589r0A42/HmL3E3vzvsemucoLZd9lLTpOFMtn8Ceunn6yPV
        AjWOY3SOMrF2xsypU9MUp0MI0LmACSoJiE9fp+bVyA==
X-Google-Smtp-Source: ADFU+vv+tNQ8YPWvfibugvCnhwLOYJlgXo6GRSCXcpR6TQyErbNU+Sksiez3chDL5nslTuI6gv9Wi3hMfyEPl8slG1Q=
X-Received: by 2002:a05:6000:111:: with SMTP id o17mr4069115wrx.111.1585151471221;
 Wed, 25 Mar 2020 08:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200213153928.28407-1-masahiroy@kernel.org> <CAK7LNARvxFk=ct9AoRLwjZ9cKRsA_bjiLaq0di12TRe5+fpmGA@mail.gmail.com>
 <CADnq5_Mieh9G-8hheKRdKe=qMbAQjwTheM2TWWSaZjeGU3635Q@mail.gmail.com> <CAK7LNAT2r3Octg-Pdjn6xNzGM49_PiGqoJSTzbmL4iBpH6_AaQ@mail.gmail.com>
In-Reply-To: <CAK7LNAT2r3Octg-Pdjn6xNzGM49_PiGqoJSTzbmL4iBpH6_AaQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 25 Mar 2020 11:50:59 -0400
Message-ID: <CADnq5_PN4orASM4F9VMtrmuL6W7B4MwvgOX00_Tdw2c-UJ6WrA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/radeon: remove unneeded header include path
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?B?Q2hyaXN0aWFuIEvvv73vv73Dk25pZw==?= 
        <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 9:14 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Mar 25, 2020 at 4:42 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Tue, Mar 24, 2020 at 12:48 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > I think this series is a good clean-up.
> > >
> > > Could you take a look at this please?
> >
> > Can you resend?  I don't seem to have gotten it.  Must have ended up
> > getting flagged a spam or something.
>
>
> Can you take it from patchwork ?  (4 patches)
>
> https://lore.kernel.org/patchwork/project/lkml/list/?series=429491


Applied.  thanks!

Alex

>
>
> Thanks.
>
>
>
>
>
>
> > Alex
> >
> > >
> > >
> > >
> > > On Fri, Feb 14, 2020 at 12:40 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > A header include path without $(srctree)/ is suspicious because it does
> > > > not work with O= builds.
> > > >
> > > > You can build drivers/gpu/drm/radeon/ without this include path.
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > > >
> > > >  drivers/gpu/drm/radeon/Makefile | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
> > > > index c693b2ca0329..9d5d3dc1011f 100644
> > > > --- a/drivers/gpu/drm/radeon/Makefile
> > > > +++ b/drivers/gpu/drm/radeon/Makefile
> > > > @@ -3,8 +3,6 @@
> > > >  # Makefile for the drm device driver.  This driver provides support for the
> > > >  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> > > >
> > > > -ccflags-y := -Idrivers/gpu/drm/amd/include
> > > > -
> > > >  hostprogs := mkregtable
> > > >  clean-files := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
> > > >
> > > > --
> > > > 2.17.1
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > > Masahiro Yamada
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>
> --
> Best Regards
> Masahiro Yamada
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
