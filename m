Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FCCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98A12065C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgEVKfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:35:04 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgEVKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:35:02 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MRTEr-1jNb3x49Dh-00NPcK for <linux-kernel@vger.kernel.org>; Fri, 22 May
 2020 12:35:01 +0200
Received: by mail-qk1-f174.google.com with SMTP id w3so4673975qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:35:00 -0700 (PDT)
X-Gm-Message-State: AOAM5301fMTLXCscwIgj5zmqD8NvVhUDld8pEXrBE9p1szdln3iqVBr7
        R35dckFaHIvzvOCe7mRd19Vl7z1k07vHcN3quPg=
X-Google-Smtp-Source: ABdhPJw02PN89jQLaghKhRZTtfY6WsfKzDAL+DXC4ThLX3EU4DLyXZpzZP+4lu/INdppa9h1Ex+aEXLdggZRZcql5jY=
X-Received: by 2002:a37:bc7:: with SMTP id 190mr14053233qkl.286.1590143699835;
 Fri, 22 May 2020 03:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200505150722.1575-1-geert+renesas@glider.be>
 <20200505150722.1575-7-geert+renesas@glider.be> <20200522181118.36de5dd9@xhacker.debian>
In-Reply-To: <20200522181118.36de5dd9@xhacker.debian>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 May 2020 12:34:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1qu-E8XKPiaBF0PqgGfBjNHbcONz-tgby3jt1X1X8Ymw@mail.gmail.com>
Message-ID: <CAK8P3a1qu-E8XKPiaBF0PqgGfBjNHbcONz-tgby3jt1X1X8Ymw@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] ARM: berlin: Drop unneeded select of HAVE_SMP
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
List-Id: <soc.lore.kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        SoC Team <soc@kernel.org>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wScuWOB3lDpbSmWnmsciaTQZtZSH2TcEz2dX/aED0fMTllLJ4N1
 8OevsIeq5i37Oa/5cqGGoXFX1t/H2IJuV1I+0nVaWbYaHqRcAW+Qsil7PBp9+ro2TTyVOHH
 LScdqfENR2rFGuHTds3bfWNMJUg+wkPli8L7K7Mb2BiT+PVH2STym11wIhfJPcN2UJWrXEX
 KkBmh20dmuJ+oc0cAQ7Iw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s9QqT+9x2M4=:f3R4KM+Xo3eqcFymP1DzbD
 KSo5VjkLWTKHmNGiwn8Hf51KEYW2sOP08Mo6p8JPake5UJ0+7h53CEYXq+UFPJjydBsHIOcgU
 0tuhgNfCCYTQ83sKIqvUeHgCuiDyteowAeVD+sBeT48fumc5apS8OVvZe4NvQDf1BvO3Qyk/j
 O3fUwAOMcU8oqhj6Ev1sXgXj4zbdWh8bej6d3Ui5cG05b9x2rJtRyzg8TIUPZl3EBjJ5kGhey
 UOveyocGLOdHSQCvBoJ3NesQDXfRlaI88eGOy7PJmbvT+fKxewA/NufrsxJPVwg/IV0p6EJt6
 LBPCMpmdlisMg1o32C+w9ouF0dtBRdgSwfyhI1cQ3b3O8zKE44l0bqr8ndLPXNu5BikebCFCH
 m7buhXVBUm8mQ4vWitP5eCyFnpGWSUlVhkwtuknpCqvXsKzoA9MkIBRW7tuc5N3F51BhfJMce
 Zzxo9dc9VCAB/b6oql/srkptG4uPqBvGi0IM5V0deeeMDFUsRieq/OPVxLwRulnuaeTJJSHXi
 eifQshig4UIkgcshIHEXiMmlXre3K378HT5KD1rCo7kGBXEckMx1Mv3WDkTh5+tNmOFw6VCU1
 kWjyY3JN2bxdGnyr625idpBGnYn1d3HLIdAOoee5HfmmXxsAy3quhfmkPXrOQjKyvxzSe+ZnB
 11bfYrvLQ9tWXFvst5XRIMUt7erdMr/x+TJBjBcxUwxErVHJHOPSwcuxpNi7z28kD7eGpLrbC
 FCgU25jJ1qDyMnZ0A5D4okCwKh8xspRYZRiCu+SLCgfW5dk4lY2puDP3AFUbWYETG5XO4Osrw
 2m3NYWmulXa6DfXC+HMVcM7WLkovDQUoyIbfByPAjHjnFa/OnU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 12:13 PM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> Hi Arnd, Kevin, Olof,
>
> On Tue,  5 May 2020 17:07:13 +0200 Geert Uytterhoeven wrote:
>
> >
> >
> > Support for Marvell Berlin SoCs depends on ARCH_MULTI_V7.
> > As the latter selects HAVE_SMP, there is no need for MACH_BERLIN_BG2 to
> > select HAVE_SMP.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> The patch looks good to me. I want to know what will be the mainline
> path of this series. SoC maintainers take it then send A PR to arm-soc?
> Or each SoC maintainers ack it, arm-soc will take the whole series?
> If later, then
>
> Acked-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>
>
> This is the first time I see a series touch different SoC platforms.

I have already merged it. The normal way we do this is that platform
maintainers can choose to merge individual patches when they
are happy with them on the early review, or provide an Ack for
them to get merged as a branch.

I picked up v2 of the series as there seemed to be a sufficient
number of Acks and everyone that commented had agreed
in principle.

      Arnd
