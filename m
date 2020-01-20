Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40788C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C4122314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgATSrY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:47:24 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:37265 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgATSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:47:24 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mnqfc-1jQywa2Fty-00pOPm for <linux-kernel@vger.kernel.org>; Mon, 20 Jan
 2020 19:47:22 +0100
Received: by mail-qt1-f172.google.com with SMTP id d18so562489qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 10:47:22 -0800 (PST)
X-Gm-Message-State: APjAAAW7PQ4l/mGpeR6SorZq933QYDkR9xkXXYQ1jdRmw1Qlmnk73xyt
        iBgb3inS7JV/WsJK8NIDgmTRiQmrJVG04gaWyis=
X-Google-Smtp-Source: APXvYqycyf0qqu0RCiFareFgGs8N2x/oLdMuYwKyff9Jjl/NAUx9wu9qn31edmJW7IBGpDJDuVlEPTWwYQ2T+6Hwf2g=
X-Received: by 2002:ac8:709a:: with SMTP id y26mr751883qto.304.1579546041415;
 Mon, 20 Jan 2020 10:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20191213204936.3643476-1-arnd@arndb.de> <20191213205417.3871055-4-arnd@arndb.de>
 <20200117154726.GA328525@bogon.m.sigxcpu.org> <aaf2f587a61dee42c25805c3fe7916bed4dbd0c3.camel@pengutronix.de>
In-Reply-To: <aaf2f587a61dee42c25805c3fe7916bed4dbd0c3.camel@pengutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Jan 2020 19:47:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3hyDeskg0ix=1+yNihqacZ5rqsXaHbRsBfPt7zFr8EOw@mail.gmail.com>
Message-ID: <CAK8P3a3hyDeskg0ix=1+yNihqacZ5rqsXaHbRsBfPt7zFr8EOw@mail.gmail.com>
Subject: Re: [PATCH v2 13/24] drm/etnaviv: reject timeouts with tv_nsec >= NSEC_PER_SEC
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:RkK7O8tf1VL8gbBNEIIqOX/iFUR5aWCFfwGMxoIMF5ceaPni2kE
 E8xgW0EQsU40Tk3VN9K1ykY1eGxdUwh4pdR64ryx5xqMNN0e7W1Jlg3nW+yV5ayw4eC1HaN
 YD1FPkSLmmhZG8KipwTCMxBRIcQJAgQ198kOHkf8DgnptW/y/RFSyLSxnL/q619Y+zVohoN
 e3MDcLM8lHWr3BlW69Piw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cwLvBhjMLMQ=:3ecNeA64wrY+FZ01nkaZMe
 G/+cSaUWF4OmPoZsz0MuZO1uCrrToG2pvC8+3Vgh99YQvTgX8C+Ws9rP7xnSJCe2DvVGxQ8a1
 cCPEkDeEXyJqLJoSnVPVwiLExoqsWISRH6quCr0MTppX2OZFgEDZVkxZJ+mIoPdXaOQD9babG
 UUIgbdN0ZOoq8CYvxALO56nDKlfA4HwfD6IzHQeJrTJSfKpEqtpSjhI/vp9LmnZBYTWTnDgM9
 efa6OCZdm4qsKSc0uzvoTtGi808ZvPsf5PzddvafLDOlT+pfJz1lEHiEyuh3wwYfizLPjNWIU
 4vEXoi87aGt5AaHApkQEQwBZ+uo1biD9wNbGiubhQkctQG7dRg8Y757B3pu2shwso1+8KHUbu
 a1T1mnnTmdB21HVVIATXvUcePS31s9/v3nWO67uXyESTJY81KpEbYfT1+JDTPY2MppiiYsHrq
 JgvQ5sgJfgpY9bTmLYhr09dqCwRrttqp+7uYZ+KBWhjvCO48Y2qxKxyBmu2FemTv8qfB2H/il
 uV+oUCG4Z6wbizxF+53Gm7fVPd8SqfMhjYQaDwgVL5lRmQK7M2LyWHcwn8hUNg7q0NDC1KPWM
 ZOxZ55/FOG7cf0FbMotn/Vp9wLA9nQipoTW0dgfxOq47VwWoLmtWrScp24S36jeXjo3tqY6Np
 gnMtxZrpNv8G+37bhYI83xQ6F+Tg8O0SZwySNxa5gPdn8D+zk9Z/YK+e/TTcOWaa+kbA3a2ta
 yl+NLIDUKeWPvHc5Ld7jtn0odf7qCttPxm9NwhQBKyVRBcCHNKXVAPpNOXTLe3heXvkMSJ3tB
 Z+gsPBtAU28v8cGyV1one6t7Eb1AGQ0Uice8/3mDG48qIJu0HZ7kIdzMOKp9egl99efRnnukP
 o1VnogI19nS+9P0O1Lag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 6:48 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> On Fr, 2020-01-17 at 16:47 +0100, Guido Günther wrote:
> >
> > This breaks rendering here on arm64/gc7000 due to
> >
> > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
> > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
> > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
> > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
> > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
> > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
> >
> > This is due to
> >
> >     get_abs_timeout(&req.timeout, 5000000000);
> >
> > in etna_bo_cpu_prep which can exceed NSEC_PER_SEC.
> >
> > Should i send a patch to revert that change since it breaks existing userspace?
>
> No need to revert. This patch has not been applied to the etnaviv tree
> yet, I guess it's just in one of Arnds branches feeding into -next.
>
> That part of userspace is pretty dumb, as it misses to renormalize
> tv_nsec when it overflows the second boundary. So if what I see is
> correct it should be enough to allow 2 * NSEC_PER_SEC, which should
> both reject broken large timeout and keep existing userspace working.

Ah, so it's never more than 2 billion nanoseconds in known user space?
I can definitely change my patch (actually add one on top) to allow that
and handle it as before, or alternatively accept any 64-bit nanosecond value
as arm64 already did, but make it less inefficient to handle.

       Arnd
