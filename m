Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8648FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E17620758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgEOPl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:41:57 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgEOPl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:41:57 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mfpf7-1itw4J3q7l-00gDGA for <linux-kernel@vger.kernel.org>; Fri, 15 May
 2020 17:41:55 +0200
Received: by mail-qt1-f179.google.com with SMTP id p12so2264981qtn.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:41:54 -0700 (PDT)
X-Gm-Message-State: AOAM533tlzVeHdPQHmIcySd7Rx+CQAsb0LGzHxzBBLyb4P2hx71xMPaZ
        eXTdgn/bsXZKMbBVZiBUETLDApkWvvtprEowJNY=
X-Google-Smtp-Source: ABdhPJxngKHQcZz6BOs80Mu+bi2GH34RwxwzAb1hl7FEp7WA2xsYcLcb/mH4UlISlur28rnQ6tqBJjB5C0UeyiMg16A=
X-Received: by 2002:ac8:518f:: with SMTP id c15mr4010468qtn.142.1589557313823;
 Fri, 15 May 2020 08:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200504091018.GA24897@afzalpc> <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc> <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc> <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc> <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514162535.GP1551@shell.armlinux.org.uk> <CAK8P3a2KR+O5Ua5hsNgzLQV5-V1pat6JH_WM10Es-oUhXO2OgA@mail.gmail.com>
 <20200514234013.GQ1551@shell.armlinux.org.uk>
In-Reply-To: <20200514234013.GQ1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 May 2020 17:41:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1d-9B86uXxkZnDGf7u-2Vf9fCrUgWQ9HGNEcf3--Yg5w@mail.gmail.com>
Message-ID: <CAK8P3a1d-9B86uXxkZnDGf7u-2Vf9fCrUgWQ9HGNEcf3--Yg5w@mail.gmail.com>
Subject: Re: ARM: static kernel in vmalloc space
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VSN5a7/1IK/d0dPd83w7C9xX0pwKbsep9TBmkWFV1U/fQZ2nJAm
 kklnrLSzZziDLjUw02+hyKSLLekmT/BEiuDEg2oA3YxCOIyNGhUM3X49/wo87cieSE4hIAc
 77ovC1m8P4pOVlKZTVsrWzRfusSulRMJqRLvJnnmms2bI6tdb3UxiTZKqkoSfiIiuuQW1HZ
 Ww6JLdWvmXcoQOLta+8ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6fHZV0Wcic0=:0EEmYVXB+8hvrbJdYqSwqm
 XS7LUGBeisryIxlws0anbtsSPJ03dq1NzqsyvX5L5Tl4f2P8BqdXetamUpE4VfDVYJ+PEYla2
 xve/v+hag179j+hvjrFMT0Xw+enqb92G6WUyRPwNHR6UK+HfDHr7CFDvOY9Nmq/Cf7voyeks/
 38r7zYg+FKhJEV+EQqZDYsJi8dCRJnZEo93xcTf+5viCGax84zbjXuBqcYoRuTnBS1+Ov+ewc
 WkfdOyJ3n3pE7/bQI01MlW48Z08MvQhbOYuQMezgfOYBLNMVdNHgVwGz6RJ8NdG0Va38Db612
 JSl4bQOHLQudrVrJa4oiiHmwBYVPo4DJt0gmBXMbfbmvO6A3uOpYKx3kA0V9mFLU5Ygn2l+58
 XnMkEh5j5cc84pV89k4RqRQvMTBTt5L8sBiSQNkcxhHXlwPMWrMesotT6pKR/FF1ujdyzdN6T
 KrwwjSF+mAwU4esRBsty7nwZ54CFxZn1um3B4EBUcFQjx8QZM72R+4H+1MJdlcSf4T6DYWwyh
 3dwZpijOUsOo8wAad/8lbLrtqD+72Ue7OA/08bqijCwAraMSdHCpGUQePnJw58EUN/FEM4+YN
 AqyWUibJTdq6/X0hWPo0M7y709UuERK3bSBYHy1kPaHTd8hQgJlubRTfrlTRrhtLXywY+AIKb
 CwWZ/7FAtCcJDwmgo7Ben2l9QpODv8/hEO0oKUuthGvmo+x7Ftv1DOpyhx7lV4IZu1aoiu+oJ
 sYX2IuMLUTh6N2TzTdJvQcf1R2VOLPFWi7NGdwKOY7aS/oWUtAshyciUnAavmKZuHEVxengQt
 pAtvswggSpbu+LIW17I7cdv1e/SLjoUqZjbiyqxilyiElHmq14=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 1:40 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Thu, May 14, 2020 at 11:12:01PM +0200, Arnd Bergmann wrote:
> > On Thu, May 14, 2020 at 6:25 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > > On Thu, May 14, 2020 at 02:41:11PM +0200, Arnd Bergmann wrote:
> > > > On Thu, May 14, 2020 at 1:18 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> > I expected the non-aliasing VIPT caches to work the same as PIPT, can
> > you clarify if there is something to be aware of for those? I see that some
> > ARMv8 chips and most ARMv6 chips (not OMAP2 and Realview) are
> > of that kind, and at we clearly don't want to break running on ARMv8 at
> > least.
>
> There are some aliasing VIPT implementations on ARMv6, but I don't
> remember how common.

I thought it was only realview-pb and omap2, but it seems there
are more, at least ast2500 is an important example.

I could not find information about integrator-cp and picoxcell.
For reference, this is a list of the arm11 chips we currently support,
with the aliasing dcache ones marked '*':

* ast2500: armv6k, arm1176, ??KB aliasing VIPT
  bcm2835: armv6k, arm1176, 16KB non-aliasing VIPT
  cns3xxx: armv6k, arm11mpcore, 32kb PIPT
  imx3: armv6, arm1136r0, 16kb non-aliasing VIPT
  integrator CM1136JF-S core module: arm1136r?, 16kb non-aliasing VIPT
? integrator CTB36 core tile: arm1136r?, ???
  ox820: armv6k, arm11mpcore, ??KB PIPT
* omap2: armv6, arm1136r0, 32kb aliasing VIPT
? picoxcell: armv6k, arm11??
* realview-pb1176: armv6k, arm1176, 32kb aliasing VIPT
  realview-eb with 1176 core tile: armv6k, 16kb non-aliasing VIPT
  realview-eb with 11mpcore core tile: armv6k, 32kb PIPT
  s3c64xx: armv6k, arm1176, 16kb non-aliasing VIPT
  wm8750: armv6k, arm1176: 16kb non-aliasing VIPT

           Arnd
