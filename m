Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5949DC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A20A2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578664112;
	bh=5bhzj8NTS9TUhhhvKLr89+vsvBVQ2b9Sjce2cyH8YRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aq5zB8MchHB4pT7sNa0iwdhxYIAlszb0fLqvUa4OIynNc2r7YD8ZBy4890/q1Fnq5
	 VxeSLIXjYqQ1xlgbXHZvmpStyqaNpHn4UFdbrypQKcT2ArN+E7JQ5+zoe+bjo6LE/K
	 RAl9dCbzhqpMAVKGK0Sl3DxitAQIGQQEQG/6QjSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgAJNsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:48:31 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:36819 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgAJNsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:48:31 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 00ADmDGK010546
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 22:48:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 00ADmDGK010546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578664094;
        bh=YW6gHC2/TBjxwotOxX5lv+0ESK1IMSnDrePMsS8Y854=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v8CCJuH8FvCsIv3IH6Axc4E20isn2xwbyKkmVAwDnVUUP7XTnqD3pjWapoBDw1lDK
         50Kzuo/MtEXB6Hdwr/DwS4PqEiEcxxek9hC0xXLPGBXvk23RQcvKWJOdPrXh+dbFTm
         hpmWbFoqq3663QSC/2QzPboUMx6ebwb3aacYQkNQCrA5Y+ZDRM5od9ZbSll/jAcAHt
         tP1tLunrgFSOOGMTJQQt5oqhrSUz3D+a5yFCzM/uA1ViWLaKv4o+xwleENqDjAhw/d
         k1iD3mjIpplBsfHoDvGo0Ec7ARWXd5VV2aA0C0JsGj//ZOe644CI/9zUvVUrt5f+JH
         5+wStLmWTZdTg==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id s16so1248587vsc.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 05:48:14 -0800 (PST)
X-Gm-Message-State: APjAAAVXAqS9AinZ/RVjPPakjdkpoqrF7xcJ4d9EWsBbZTOVWNHFHP4u
        FPjIX5UOKi/bse+XUQaXX1zbkcVVK+23cVVjckg=
X-Google-Smtp-Source: APXvYqyTXk/T86I7dlwE/veGRIdMLqTqb+cooe/0yqEITlDnMG/B+hHLqdaNi4yTMsk16cN+BBr421ehKsnP9BOOcVw=
X-Received: by 2002:a67:f8ca:: with SMTP id c10mr1743990vsp.54.1578664092752;
 Fri, 10 Jan 2020 05:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20200104162829.20400-1-masahiroy@kernel.org> <20200110121951.GA1047840@kroah.com>
In-Reply-To: <20200110121951.GA1047840@kroah.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 10 Jan 2020 22:47:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNATGZwPE9m=4L6n-OFPSmenQvoRvNR=c4Go65x1opjkpOQ@mail.gmail.com>
Message-ID: <CAK7LNATGZwPE9m=4L6n-OFPSmenQvoRvNR=c4Go65x1opjkpOQ@mail.gmail.com>
Subject: Re: [PATCH] staging: vc04_service: remove unused header include path
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 9:24 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jan 05, 2020 at 01:28:29AM +0900, Masahiro Yamada wrote:
> > I can build drivers/staging/vc04_services without this.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  drivers/staging/vc04_services/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
> > index afe43fa5a6d7..54d9e2f31916 100644
> > --- a/drivers/staging/vc04_services/Makefile
> > +++ b/drivers/staging/vc04_services/Makefile
> > @@ -13,5 +13,5 @@ vchiq-objs := \
> >  obj-$(CONFIG_SND_BCM2835)    += bcm2835-audio/
> >  obj-$(CONFIG_VIDEO_BCM2835)  += bcm2835-camera/
> >
> > -ccflags-y += -Idrivers/staging/vc04_services -D__VCCOREVER__=0x04000000
> > +ccflags-y += -D__VCCOREVER__=0x04000000
> >
> > --
>
> This patch breaks the build for me:
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c:6:10: fatal error: interface/vchi/vchi.h: No such file or directory
>     6 | #include "interface/vchi/vchi.h"
>       |          ^~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
>
> So maybe you did't select all of the modules to build?
>
> Sorry, I can't take this as-is :(
>
> greg k-h


Sorry, I compile-tested it with O= option.

I should have tested it with/without O=
for this kind of patch.


I will fix up some relative paths.


-- 
Best Regards
Masahiro Yamada
