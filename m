Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC268C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C66207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgA1NIK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:08:10 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:50073 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgA1NIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:08:10 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N2V8T-1jijaR3rLT-013uS8 for <linux-kernel@vger.kernel.org>; Tue, 28 Jan
 2020 14:08:09 +0100
Received: by mail-qv1-f47.google.com with SMTP id db9so2587937qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 05:08:08 -0800 (PST)
X-Gm-Message-State: APjAAAURzhIhdz4K1PIjCzvwoPA4opIz+b19iu5CtyG58vZX7jVOYCLo
        IegHkwpvFrH/GnXvKe75vtACSuGDttvmhG+JCNM=
X-Google-Smtp-Source: APXvYqwbF70fulmMWpYsvgtwTwVOULgFhaykqGynP3TsqaWJatV/77WMv6RcxE8VKIM0b3GG4JzZReLAuPl6Qcio2Zw=
X-Received: by 2002:a0c:d788:: with SMTP id z8mr20752657qvi.211.1580216887804;
 Tue, 28 Jan 2020 05:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20200121114553.2667556-1-arnd@arndb.de> <20200121125546.GA71415@bogon.m.sigxcpu.org>
 <1971902c68ff805ee0b4a66f558afe06e6edf0c5.camel@pengutronix.de>
 <CAK8P3a2E__zHPPEL37JwK=uHb_v-=C+-+zGaL3XoW5PZ+BUN5g@mail.gmail.com>
 <20200122103034.GA67385@bogon.m.sigxcpu.org> <20200122103553.GN25745@shell.armlinux.org.uk>
 <20200124085616.GA5680@bogon.m.sigxcpu.org>
In-Reply-To: <20200124085616.GA5680@bogon.m.sigxcpu.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Jan 2020 14:07:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a36b6OVW1izkmwML_iWof1BWcPSuh=zV5D=9Jx5Q+MRFg@mail.gmail.com>
Message-ID: <CAK8P3a36b6OVW1izkmwML_iWof1BWcPSuh=zV5D=9Jx5Q+MRFg@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: only reject timeouts with tv_nsec >= 2 seconds
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:OSdX+6i7GT66CAFwQ+vhxHK4bua8rOrudPhf7fhYfMGMxN9B6EX
 fqidXcTQLWSwpKs38T6HxM9m3mZGewm85sPs5p4rrKiXUKh/rVxeTXvRDBoxLCPofXBN0Oy
 z2iLCY+lzoyXzr92WaCa2RcKyxhndbZrDdMSOukLZ2R6GgfthbDx3Vp/LNI4otWnL5Onn4o
 OOReDPWj6hh7aZoqbzbXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xz9Cq3YR54Q=:eHF9kt6GuEyao/lu52FkNw
 XYjjNXa7PimYFfIut8n/maixe7zmw6GcceJUpWW/UcBkxfQy7a/cXJ7uaFHm/NYjTCfuJkzEj
 +VtgXbOR/hvrnLdkFVK0UWBiMryxbytlVup73MTt6I3obvxB4v7RkgDxrjIReimOGcYTTHkjU
 qyf0JmRC25Pog2EuJBFw4uYgSnbVwa2M6VvUY8yR3sQx6T7cuV1ZHrBI7qd9brS6+QtRYsQa4
 40/ZhKoX2bcEkQSgQ64hxhSIQRc0vstV00Q5QrpPIHOmDmc/90iIDa6iCj7gb+eCvYrFqAVD9
 SegrjkpqX4cSPASy2pg2Ga216oBh7d8sbIs5Tk5vUtO9Yy6MSQL0QrIVlKrx5PvteQEy8diUv
 PGxV+svMOYkBE8aJFt/AlNmKN6qHwL9bqKKdm1mHimfJ5Fu8XwawPZDSGGwxzMW0ofw6xyU6p
 k3ZcxnhxrYwLLF50Bcnsz5fRTUUl/MXo5fJlNzY5o93oBP7PbgmzY+NP1MmshdWEwziHvP22I
 Lh93RvmKHM5X+2xcHb+mlDS35RQQee2tZSUOdSjn3EhRJFIfoTButh/pWTqfMnPCP8NQWeXIh
 EhD0GZ0U61bmMXien1un/12WvcGWtA/eBc+Igl98P287yE97gA0Ba8pMrcrwPCYNO46tORwCz
 y/jTvo/mXIpIiQSVnQmr1FlhupThF/LHPgOkFLKrMy9jcmCO8wwdNmo/f+JlcTAR+T0hy6PXd
 9jKPYCsBw/mnRsbn79Yr+62/EqRoXxpOQ0aV+8zZEi5J7h+FXzdzNqAiFAwLq2BCYcxXh7N+U
 cjtP3a3lcl/9rb10ZNF9KqRIjWYXw3D8/x2awdGiAp4k4EWDOo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 9:56 AM Guido Günther <agx@sigxcpu.org> wrote:
> On Wed, Jan 22, 2020 at 10:35:53AM +0000, Russell King - ARM Linux admin wrote:
> > On Wed, Jan 22, 2020 at 11:30:34AM +0100, Guido Günther wrote:

> > I think it would probably be better for the kernel to print a
> > warning once when noticing over-large nsec values, suggesting a
> > userspace upgrade is in order, but continue the existing behaviour.
>
> That makes sense to me. This also makes sure we don't break other (non
> mesa using) stuff accidentally. We have
>
>   https://gitlab.freedesktop.org/mesa/mesa/commit/d817f2c69615cf37b78f484a25b7831ebe9dbe6f
>
> and
>
>   https://gitlab.freedesktop.org/mesa/mesa/merge_requests/3534
>
> to normalize nsec to [0..999999999] now.
>

I have reverted my patch that adds the range check now, so I can send the rest
of the series for inclusion.

I've played around with ways to add a ratelimited warning message and to
make sure that a malicious application cannot cause a long stall, but haven't
managed to get a version I'm actually happy with.

I'll follow up once the series is merged, and then we can add a better
workaround
later through the drm tree.

      Arnd
