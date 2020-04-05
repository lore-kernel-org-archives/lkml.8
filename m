Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FF5C2BA17
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F06620659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYwYgN7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgDEOLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:11:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33016 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgDEOLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:11:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so14267350wrd.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8d6AJalPWCNMrPOGz4TUIkHpGcbuci4u9pqA1PXRY4=;
        b=vYwYgN7F788ec2HchBK0gZg5sIYR9ljFlwIGKfHmBSUxHEvOXZQbgx+BkVjX7AT5Mi
         Rg95I3KaLsK3YliZlxnTwmJGhap+HcDW3XK3X+rWBHLKN9gS90dRxuBpWK5WZnDBUCtF
         oWH9X6a4G7l/NQ38u3iW/1mz+mnLazv6VZ+706fRVfwiz2ndImLjRdtLo+DaHkE0O5jd
         VbuDp/iUrnyZ58m9eKRtGGGGuGcgqcQdMDpgBSBLuoTicTIfF/JWEmkM17l8+55cXgxN
         J1Tc/3jsFpjLnEHITpQc5xjgDIW5PDpygrM3+kpAQiQc5Bn12KuEQh2uaTC6CiHJCKJF
         74AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8d6AJalPWCNMrPOGz4TUIkHpGcbuci4u9pqA1PXRY4=;
        b=LFA2xziejMUUt1FnIXI1y21qNEmwDA2mW+sxdCBbk369cs2VeVkxe/JFOafxxZER0V
         axQcia20gW4Z+QocxVVT7CYYMVnyl8X582xr3RSOFxQ2aRYEdhtH83evt6qSh95HMMEO
         uxE/d7xOF8UbCJdOIRwMDuDnptbmOgYtHvPkynXfwbQ08sr/reVkF8FJHOslE8FG1DoP
         v87eDAnEBRRiEs5G2U/zjalcAk+G52cXzdPrdzTHWDIPu8DO7UveGy8Q1W3gt83xD1B5
         nVZIW9PzRV4ndSinnY4B6jAaTKWeHeiPUIViBJPqny1H+2ps85oXejxgZ+fYg2lIKR9L
         I/Ew==
X-Gm-Message-State: AGi0PuYWt3IMVRJBGxvBPyezrNdBlWyUVKI/NjHIXsGZrUFzhvdja8ac
        1xwRdDhtpMxVWId37VT3c7tIoJ/9CpIr3DHzlk0=
X-Google-Smtp-Source: APiQypI1bpG7n23q0Oyvtk/yrSkc8iHjgkhHT4ACcnN2nkvQdBnroCMPII6M51C6TxRsgRuiEIfOF8NcN0WsL3MFu6s=
X-Received: by 2002:a5d:6742:: with SMTP id l2mr20105220wrw.124.1586095894440;
 Sun, 05 Apr 2020 07:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <5e863110.1c69fb81.17969.099e@mx.google.com> <187eeb8e-5c70-4479-d806-a7123f9023c8@collabora.com>
 <MN2PR12MB4488D9D3984D03030D3BACC3F7C70@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200404090658.nxfvi5zg2rgag2qo@gilmour.lan>
In-Reply-To: <20200404090658.nxfvi5zg2rgag2qo@gilmour.lan>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Sun, 5 Apr 2020 10:11:23 -0400
Message-ID: <CADnq5_NbDH+aDFAwj2-rajD8QgF2J=Zmq2w9-7mh8wwRYVWk8Q@mail.gmail.com>
Subject: Re: mainline/master bisection: baseline.login on peach-pi
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Shane Francis <bigbeeshane@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernelci@groups.io" <kernelci@groups.io>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Joerg Roedel <jroedel@suse.de>, Tom Murphy <murphyt7@tcd.ie>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 8:46 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Fri, Apr 03, 2020 at 03:47:46PM +0000, Deucher, Alexander wrote:
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Guillaume Tucker <guillaume.tucker@collabora.com>
> > > Sent: Friday, April 3, 2020 10:14 AM
> > > To: Michael J. Ruhl <michael.j.ruhl@intel.com>; Shane Francis
> > > <bigbeeshane@gmail.com>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>
> > > Cc: kernelci@groups.io; dri-devel@lists.freedesktop.org; linux-
> > > kernel@vger.kernel.org; Tom Murphy <murphyt7@tcd.ie>; Joerg Roedel
> > > <jroedel@suse.de>; David Airlie <airlied@linux.ie>; Maarten Lankhorst
> > > <maarten.lankhorst@linux.intel.com>; Daniel Vetter <daniel@ffwll.ch>;
> > > Maxime Ripard <mripard@kernel.org>; Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com>
> > > Subject: Re: mainline/master bisection: baseline.login on peach-pi
> > >
> > > Please see the bisection report below about a boot failure.
> > >
> > > Reports aren't automatically sent to the public while we're trialing new
> > > bisection features on kernelci.org but this one looks valid.
> > >
> > > This bisection was run with exynos_defconfig but the issue can also be
> > > reproduced with multi_v7_defconfig.  It doesn't appear to be affecting any
> > > other platforms on kernelci.org.  This looks like a DRM driver problem, the
> > > kernel image boots fine without the modules installed.  It actually started
> > > failing on Tuesday in mainline.
> >
> > Fixed with this patch:
> > https://patchwork.freedesktop.org/patch/359081/
> >
> > Just trying to get this into 5.7 and stable.  I was waiting for a
> > 5.6 back merge to drm-misc-next-fixes, but I could send it as a
> > separate PR if Dave or Daniel prefer.
>
> You should ask us next time, we're not doing them unless asked :)
>
> I've done it, it's compiling at the moment, it should be pushed in the
> next 10 minutes or so.
>

I sent out a generic ping on IRC.  Next time I'll be more specific.

Thanks!

Alex
