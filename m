Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2C0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3FC21534
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI4dEliv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbgFPPwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732589AbgFPPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:52:17 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66E7C061573;
        Tue, 16 Jun 2020 08:52:16 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id i1so4922679vkp.8;
        Tue, 16 Jun 2020 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5tUwv8GZvt0tLegCth1XOp+6yS8yReQyRSOWrSBlQn4=;
        b=fI4dElivqPDBIde5zHrPQYVfRHoecvaR5xo2tlpmaSvwEURd0T3CLTe89tX8Ov7VVD
         pFh7Hu0POSS26z2glZ3JYCbowKhH5z7mjGkigZN/pcaPT2YYEurO7olee9W3e68oKtPx
         nF5bVCcpSA+9cLGc6xJZ6b0221kLKp8a3gSIpJmBvM7lf34BvnKlD9UJMArax01JPeTd
         rg2hy3AFr6C5NxGh/iBUQgibmY54+x5KUwnqUYHTXT3iuxvdOR4TRcoEil1s6Msr1bda
         DnI2Fg9A4r/DFruzrO0GCxCU/5Lzs+ffQmEuQ/lcZ1GLu4UQQpv95sQqImrT5bt5+3fG
         XXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5tUwv8GZvt0tLegCth1XOp+6yS8yReQyRSOWrSBlQn4=;
        b=GBVlB8hUcaTnkmMNSueXpOZ6Vo6JA3LBI60P3JbNFCfc3uYrlv2DHAnkX9Fi/zcmw2
         BoJwdMWZl/X1vmPBJK/8MiMML3BchcvoxgCK6F88jsjpCSP9a65vzBufzm3pjUImNei0
         xfs3q8nlhZ6TATxZzPzdmVZqNKd81xG5ZZnljYZn4DrZqmWx0QRS8QaNXkOgvI42F3QI
         jvSjrmc8DBjEKJDMe1JhS3pbNSFqxzFiZcTun7HzqAhZcxEL7IueeGf+XVCTcK4geL+A
         cevTZa2F6NPHaCImGWepNQWPrLe206H6gK4ZAYQQmq3E7ndwGzEQ8OjBu2MwgZ1Hvneg
         saPQ==
X-Gm-Message-State: AOAM533cZgM7LiRk3rMom2dRGZdz8VKDWnoBTOn26XR/H7avxJNGGJpM
        5FItuwy0NDUY4st0tD6uMkRvIuI1gJEbo5i0I+I=
X-Google-Smtp-Source: ABdhPJwHbzHiIoOeOqf88qGm635l6SYTNpkzRacF/MQtw+0fGQ+NRwhque+7rGZBn/dzalt7nyDZTCXKgzsXv6lYO+E=
X-Received: by 2002:a1f:ee81:: with SMTP id m123mr2257220vkh.51.1592322735381;
 Tue, 16 Jun 2020 08:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200614200121.14147-1-digetx@gmail.com> <CACvgo51QuXMgWhFk4C=3rGvUZDX1_W0RZtVb5RtRPiHTpMebWQ@mail.gmail.com>
 <8f789ef5-bebf-c869-784d-afda70fc1fb8@gmail.com>
In-Reply-To: <8f789ef5-bebf-c869-784d-afda70fc1fb8@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 16 Jun 2020 16:48:34 +0100
Message-ID: <CACvgo50oSMbgXw1vHwVT4hhGe6g3YzKQEohCLJdfDq+0UaN1jw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] 180 degrees rotation support for NVIDIA Tegra DRM
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, linux-tegra@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 at 12:40, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 16.06.2020 01:26, Emil Velikov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hi Dmitry,
> >
> > On Mon, 15 Jun 2020 at 08:28, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> Hello!
> >>
> >> This series adds 180=C2=B0 display plane rotation support to the NVIDI=
A Tegra
> >> DRM driver which is needed for devices that have display panel physica=
lly
> >> mounted upside-down, like Nexus 7 tablet device for example [1]. Since
> >> DRM panel rotation is a new thing for a userspace, currently only
> >> Opentegra Xorg driver handles the rotated display panel [2], but this
> >> is good enough for the start.
> >>
> >> Note that later on it should be possible to implement a transparent 18=
0=C2=B0
> >> display rotation for Tegra DRM driver which will remove the need to ha=
ve
> >> a bleeding edge userspace that knows how to rotate display planes and =
I'm
> >> slowly working on it. For the starter we can go with the minimal rotat=
ion
> >> support, so it's not a blocker.
> >>
> >> This series is based on the work that was made by Derek Basehore for t=
he
> >> Mediatek driver [3], his patch is included into this patchset. I added
> >> my tested-by tag to the Derek's patch.
> >>
> >> Please review and apply, thanks in advance!
> >>
> >> [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200607154=
327.18589-3-digetx@gmail.com/
> >> [2] https://github.com/grate-driver/xf86-video-opentegra/commit/28eb20=
a3959bbe5bc3a3b67e55977093fd5114ca
> >> [3] https://lkml.org/lkml/2020/3/5/1119
> >>
> >> Changelog:
> >>
> >> v2: - Dropped "drm/panel: Set display info in panel attach" patch, whi=
ch
> >>       turned out to be obsolete now.
> >>
> >>     - Renamed the cover-latter, hopefully this will fix the bouncing e=
mails.
> >>
> >> Derek Basehore (1):
> >>   drm/panel: Add helper for reading DT rotation
> >>
> >> Dmitry Osipenko (4):
> >>   drm/panel: lvds: Set up panel orientation
> >
> > IMHO it's perfectly reasonable to report the panel orientation to
> > userspace, which can apply plane rotation as needed.
> >
> > Although I see that this series, alike Derek's, has a couple of issues:
> >  - only a single panel driver is updated
> >  - rotation is _not_ listed as supported property, in said panel
> > driver device-tree bindings
> >
> > My personal inclination is that we should aim for a comprehensive solut=
ion:
> >  - wire all panel drivers, as currently documented (quick grep list bel=
ow)
> >  - document and wire-up the lvds and boe panels - as proposed by you
> > and Derek respectively
> >
> > HTH
> > Emil
> >
> > Documentation/devicetree/bindings/display/himax,hx8357d.txt:2
> > Documentation/devicetree/bindings/display/ilitek,ili9225.txt:2
> > Documentation/devicetree/bindings/display/ilitek,ili9341.txt:2
> > Documentation/devicetree/bindings/display/ilitek,ili9486.yaml:2
> > Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt:2
> > Documentation/devicetree/bindings/display/panel/panel-common.yaml:2
> > Documentation/devicetree/bindings/display/sitronix,st7586.txt:1
> > Documentation/devicetree/bindings/display/sitronix,st7735r.yaml:2
>
> Rotation is a common DT panel property that is described in the
> panel-common.yaml.
The property was introduced almost exclusively for tiny drm panels.
Those ones are a bit different from the rest (in panel/) -
MIPI-DBI/SPI w/o (not connected at least) an actual GPU.

To make it a bit better, the rotation is seemingly performed in the
tiny driver itself ouch.

> This property is supported by all panel bindings
> because these bindings inherent the common properties from the
> panel-common.yaml.
>
Seems like that was an unintentional change with the conversion to YAML.
Beforehand only a few selected panels had rotation. Upon closer look -
some panels do have follow-up fixes, to remove/limit the implicit
inclusion.

Sam seems like you've done most of the YAML conversion. IMHO it would
make sense to revisit the patches and inherit common properties only
as applicable.

> I don't think that it makes sense to wire up rotation property to all
> panel drivers at once because those drivers will be untested, at least I
> don't know anything about those other panels and can't test them. It
> will be much better to support the rotation on by as-needed basis for
> each panel driver individually.

How about CCing the author and reviewer asking them to test the patch?
The only place where the patches might cause an issue is with tiny,
although patches would still be appreciated.

-Emil
