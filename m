Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA0C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 01:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657F320714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 01:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585098869;
	bh=DX1u6DeppxRCrHzxGji1nY+IzMcI/Xcw2CsrqmnfwEI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VessED5dmRldpWgaM1dxdEbHkvHfQaCwxUJqEtEnwdFnrNOmnETiYRunLIOTjX+DE
	 qciHeFySVeFj9oi0cwth4n3utvZozwIAd9WuZPJMUWSDvqHrB5Jpkd2qCcDh09AC0i
	 mSGfwoFKI5XZFUpr2hzVnT4exP4dNDkHwny+fTf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCYBO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 21:14:28 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:34772 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbgCYBO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 21:14:28 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 02P1E3aD015611
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 10:14:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 02P1E3aD015611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585098844;
        bh=Du0zvU/kKAL8IvGiRqHBSbx7z6kjBsdUMl9fi/jYHfU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CmBBqcd636qqSj5ss3/pAlUApkkQw3SpDtaGjLBFVNgUjopNWmBHijKJ2t1GIv9sV
         ABjbr6WG0sDnmRZ9Mu7Q7ndHoShX0IVAagRmAnN07RUwv3Q2nK8KZnuxkn4pZAIO9i
         EUWCuFL5WUeO5/69pqB+6rLy+r7sXZjRilBNUWvWXyGifkZXknW/7sBGBCYqyyB72P
         ut72XASzzrV5vxCZQVb9nxcXov5YhyQ56W+EJsmsR2mYgeN9SFYj9igEHSbpD0LZLQ
         jezIoot7mFSV0RVZ1KSVAaekJDvlhsh6YZrP9pDmdVqTSkEepBu9siGl1VWwdfBVXL
         zEgAweVZWeU0A==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id o15so173948ual.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 18:14:04 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1LbcfLnryQ3H5nCjWeHu5gLRBrOOGXgH38nPCYxT3QCxkM+Omy
        UFuZLiH0baRBc8h+gcHQQhgFVSekpi4lgC1IPYY=
X-Google-Smtp-Source: ADFU+vsMC3zRa6ZCPZj56ljmM8HiIe+u3r7TwuTb0+ibRUQbbRZXBTBPHZ2fpKGbyXecBLtrlGGqLwlnGLzcN6iVsgo=
X-Received: by 2002:ab0:3485:: with SMTP id c5mr688955uar.109.1585098843120;
 Tue, 24 Mar 2020 18:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200213153928.28407-1-masahiroy@kernel.org> <CAK7LNARvxFk=ct9AoRLwjZ9cKRsA_bjiLaq0di12TRe5+fpmGA@mail.gmail.com>
 <CADnq5_Mieh9G-8hheKRdKe=qMbAQjwTheM2TWWSaZjeGU3635Q@mail.gmail.com>
In-Reply-To: <CADnq5_Mieh9G-8hheKRdKe=qMbAQjwTheM2TWWSaZjeGU3635Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 25 Mar 2020 10:13:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT2r3Octg-Pdjn6xNzGM49_PiGqoJSTzbmL4iBpH6_AaQ@mail.gmail.com>
Message-ID: <CAK7LNAT2r3Octg-Pdjn6xNzGM49_PiGqoJSTzbmL4iBpH6_AaQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/radeon: remove unneeded header include path
To:     Alex Deucher <alexdeucher@gmail.com>
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

On Wed, Mar 25, 2020 at 4:42 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Mar 24, 2020 at 12:48 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Hi,
> >
> > I think this series is a good clean-up.
> >
> > Could you take a look at this please?
>
> Can you resend?  I don't seem to have gotten it.  Must have ended up
> getting flagged a spam or something.


Can you take it from patchwork ?  (4 patches)

https://lore.kernel.org/patchwork/project/lkml/list/?series=429491


Thanks.






> Alex
>
> >
> >
> >
> > On Fri, Feb 14, 2020 at 12:40 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > A header include path without $(srctree)/ is suspicious because it does
> > > not work with O= builds.
> > >
> > > You can build drivers/gpu/drm/radeon/ without this include path.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  drivers/gpu/drm/radeon/Makefile | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
> > > index c693b2ca0329..9d5d3dc1011f 100644
> > > --- a/drivers/gpu/drm/radeon/Makefile
> > > +++ b/drivers/gpu/drm/radeon/Makefile
> > > @@ -3,8 +3,6 @@
> > >  # Makefile for the drm device driver.  This driver provides support for the
> > >  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> > >
> > > -ccflags-y := -Idrivers/gpu/drm/amd/include
> > > -
> > >  hostprogs := mkregtable
> > >  clean-files := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
> > >
> > > --
> > > 2.17.1
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Best Regards
Masahiro Yamada
