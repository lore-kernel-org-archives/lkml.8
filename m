Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B7AC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA01020578
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgC0Kzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:55:55 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgC0Kzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:55:55 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Md6V1-1jr7Ck3rut-00aCVD for <linux-kernel@vger.kernel.org>; Fri, 27 Mar
 2020 11:55:54 +0100
Received: by mail-qk1-f181.google.com with SMTP id k13so10292925qki.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 03:55:53 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0SkL9vtLDiCzNm7x/TTBLm20EGsdfEdPJDkX23+duj0CBER8Qm
        QFjD/0kQ1N8tO6QrtpMW9725SRz1qFvpp+UBNvY=
X-Google-Smtp-Source: ADFU+vu/SBluPJe4SG/RVo/VOSCt5yg8qCa0C0hT1HJWo2MkHT9vfnjXTH3ldYZD2r/o7bjQOUlqAYVkLLzc9qdU5cI=
X-Received: by 2002:a37:a4d6:: with SMTP id n205mr13487320qke.352.1585306552796;
 Fri, 27 Mar 2020 03:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <87mu8ppknv.fsf@FE-laptop> <20200302031736.5or4ww5a4l7zomfo@vireshk-i7>
 <20200308161903.GA156645@furthur.local> <20200301122226.4068-1-afzal.mohd.ma@gmail.com>
 <m3ftepbtxm.fsf@t19.piap.pl> <51cebbbb-3ba4-b336-82a9-abcc22f9a69c@gmail.com>
 <20200304163412.GX37466@atomide.com> <20200313154520.GA5375@afzalpc>
 <20200317043702.GA5852@afzalpc> <20200325114332.GA6337@afzalpc> <20200327104635.GA7775@afzalpc>
In-Reply-To: <20200327104635.GA7775@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 27 Mar 2020 11:55:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0kVvkCW+2eiyZTkfS=LqqnbeQS+S-os=vxhaYXCwLK+A@mail.gmail.com>
Message-ID: <CAK8P3a0kVvkCW+2eiyZTkfS=LqqnbeQS+S-os=vxhaYXCwLK+A@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
List-Id: <soc.lore.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>, arm-soc <arm@kernel.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eGcuhSAiGrRQoEppFKm7A4PdslXwF0gaWKNb5ZwO0MyIjmoM14P
 692hUMtoO5bSnbsl4cH70X5C9+J/kvfo5jRMd8dBasEkM7cqfAJbOdru9b3Bci+wAUohfWu
 F/FfoqWGiEONMxrGXpwai2m6dxlsUHdv1rsDeTb1d/O8uafsIoV0mlglVWGOetpVc/7YV6w
 kbzFV/PhLWkoUr6vvLrCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oAbNTvQNORc=:4TlCRANWGFvOYVNzZKeBfH
 cm59hdNs2JHKx0QxLEPuJgoQJ+GmC8EaLPGbxJHjI/vKiUSOj3yjLgoDRRAFjgBi+JzBr6AA+
 TAWow/twxbKwcOXixsrDmLscy7gFbUR0xXTBlxe7VJj/O533DzbyTSIefnEhIxGnXxabykrSg
 ZZa8/824EkxBKbCgr3RCElnVFtheBHEPGvDLrpUJI/NyNIfwOvqyhKktS9PJPSaI8LzKd9vK6
 Ps2tOa3J7Mz4I+rR/gUSvVErxIMZq82YD2HA/fTtqj3HqH3lnbBsuzQzSgo00e2gZtXKA4okA
 FzgO1I7M3VW9krsewoQC6r+940anlE0eoeUuJl2YiBN7undJguGRPdM3hN7k8isrqQ3JiKawn
 Z+rLtZB3wesgeibCosKgTJNQJbiAqNYScwe9llL7TzYx5tF/aW2pODIa9qazKjxTzvOfLX/Xx
 MJA/CoQJJ9eisT94GeORwEHKDjH/MthN9I9bTyUg7hN5orjeRgHCIh/eMKsckXnlIxniMUe32
 msig1uYRK9CrvL4vdH6JMjPVWDbztAYYXs9k/lb4CBNTi+npvg0OzYsF1c+12Be83JXyT3YjS
 T8rNmPnOakdD1L6SbkQ0PZ5qMqL9GNUGc4kPm0gqkvulnsEJWsWsJybIuVREJlhI/jC038gyx
 YVaEb/xNlSYEQW8Y54+cL7e+PQ/Lr8DORk9DCtPiGx4RKvBkJiOnJBlTh1qGNw9BGxZ+iXNuJ
 yd2L2fK0exKdJO/JB49l8ayt9m9XISznICuAZ0X+dJtjTO4f41JsGr9rRtP3Fl+q3f69dX6Wt
 AYjxClLVH2SOVRST5Bj3rp6NWUqsi7/KnSm0WHB6srNLmh4p10=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:46 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> Hi Arnd,
>
> On Wed, Mar 25, 2020 at 05:13:32PM +0530, afzal mohammed wrote:
> > On Tue, Mar 17, 2020 at 10:07:02AM +0530, afzal mohammed wrote:
> > > On Fri, Mar 13, 2020 at 09:15:20PM +0530, afzal mohammed wrote:
>
> > > > Can you please include the patches 6-10 directly into the armsoc tree ?,
> > > > Let me know if anything needs to be done from my side.
> >
> > Can you please consider for inclusion the above 5 patches.
> >
> > Sorry for pestering, i understand that none of the ARM SoC pull requests
> > has been picked up as opposed to what happens normally by this time of
> > development cycle.
>
> i think you have pulled the ARM SoC pull requests, but above changes
> doesn't seem to be applied, can you please respond on how to proceed ?
> (of all the tree-wide changes, the above are the only ones in limbo)

Hi afzal,

To make sure I get the right ones, could you bounce all the patches that are
still missing to soc@kernel.org to let them show up in patchwork?

I'll apply them right away after that. Sorry I forgot about them as I went
through the patchwork backlog.

       Arnd
