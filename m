Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC013C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CABAC207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFLUHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:07:48 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgFLUHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 16:07:47 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mn2iP-1j1wyU31Vv-00k3rz for <linux-kernel@vger.kernel.org>; Fri, 12 Jun
 2020 22:07:45 +0200
Received: by mail-qk1-f181.google.com with SMTP id n11so10206817qkn.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 13:07:45 -0700 (PDT)
X-Gm-Message-State: AOAM5302nC5DUcGADxQ0E9uhe9JyBVRjynO0NXcdiz4Qv3Mal3Io7vWf
        sPRoHA6PQW2/wJ53Na79jHosqn6CCrTQno01V/o=
X-Google-Smtp-Source: ABdhPJxZJreofZ36189crpVnTyu17fqhOg6nCgeQSutwsT65QiKE0mUuYvNz0bxVS7IwDeSIM7UEmHDrtH4eO16x54Y=
X-Received: by 2002:ae9:de85:: with SMTP id s127mr5067153qkf.352.1591992464544;
 Fri, 12 Jun 2020 13:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com> <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com> <20200612135538.GA13399@afzalpc>
In-Reply-To: <20200612135538.GA13399@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jun 2020 22:07:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
Message-ID: <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wnKgIIafkqC4S9WUag5C5XJRHsW5xbkOHPp58HSdk67k1EKgusQ
 r45Im61HXyT9LAsoJ760LJk8Zcp5RyrUw3slYwk8Htm96SNB7qmESLCHp5V28A01733Sh1n
 uXCMS5ylz+vY+KhtYIzYGBoLmVqoIJVCmOQaf/XvyHN9UAGSHyyCg3OQtu+a11jxHQ3m5hW
 NegPj3GFXQTeLA2Ylje2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tJog34BI47M=:2eGAp2Kmz2QfpSmCW3oyig
 XA2CiSs5rn4awHsg9grcVNnabuxHb/aRNSXJCJ56LaU4fRjmn6mN5gvJV073BXhf6hR+GpvUb
 +znpxnC82ZGM2HwYuIw8lFzylmtiz9OEaQnVDRiXj+/7lXlcUbSYtnn3qWH0uWwhqRT3MScjt
 yB5wnmPFcgI3qH6hM3AUxApg7h/l+8S8lI3/+XYlzt/t9rlnVjuG6PyrAZ4v/91xEK5CVIo/D
 PMFjl90xRwzK8ohaSAmFSWJph5d+Lc5B3YH2loDOpGspmx9f6B8N4gG4KaaQH/cgdqy7KroU2
 5jbPcTPF5eMjaWIYIJNzYc7Ln6AQzKAVytyGPf9Z+Q1ghci4qVL3E4PLzjgf33wXR5EKxqEat
 6aaDN+D9Hc841P4RP5feVzPKpO8jETr3MqBulav7dAIJzaPLAV9rXmNWivt/dE9y/CdGKLez4
 hLl/UP/Ti5O1YfTyHMRHlZSeEal5hF9aSZS82U7/IK4Sx8Dy7lDnnnwY7qvbLeWUJpl2TvhuH
 l1Q96j3gUSxtvFPZahBrM1t02iSnC+gByJWC1ArQs58Sgc+NjdivSR6XvAHupRAmcY4pzIxqP
 wZPd766kp7FsKgRdoE9D0d2p+MRBv+hzDQ4iae2YT68AoIi7z948J0zGPyTM3Mt+EzZ1Bt0tE
 MLNaXeDLXfooS1RwR4G8a+LKjpIxyJewiDZW9FTIFk4xrdQTvs76EluubBfwg3/ut3xRnLeCb
 v3vIr1cTq0hUKxP5MylGxl9hnMNzEPEL0boxaYqJJCI+4d8+Fa8PdseasbTe2tjUVlD7f5IY6
 EFhZS92JrIcUK8dQBePNBKmrIRGKpI9i9ILTDUL4kxx1RTTMkk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 3:55 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> On Fri, Jun 12, 2020 at 02:02:13PM +0200, Arnd Bergmann wrote:
> > On Fri, Jun 12, 2020 at 12:18 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> > > Roughly a one-third drop in performance. Disabling highmem improves
> > > performance only slightly.
>
> > There are probably some things that can be done to optimize it,
> > but I guess most of the overhead is from the page table operations
> > and cannot be avoided.
>
> Ingo's series did a follow_page() first, then as a fallback did it
> invoke get_user_pages(), i will try that way as well.

Right, that could help, in particular for the small copies. I think a lot
of usercopy calls are only for a few bytes, though this is of course
highly workload dependent and you might only care about the large
ones.

> Yes, i too feel get_user_pages_fast() path is the most time consuming,
> will instrument & check.
>
> > What was the exact 'dd' command you used, in particular the block size?
> > Note that by default, 'dd' will request 512 bytes at a time, so you usually
> > only access a single page. It would be interesting to see the overhead with
> > other typical or extreme block sizes, e.g. '1', '64', '4K', '64K' or '1M'.
>
> It was the default(512), more test results follows (in MB/s),
>
>                 512     1K      4K      16K     32K     64K     1M
>
> w/o series      30      46      89      95      90      85      65
>
> w/ series       22      36      72      79      78      75      61
>
> perf drop       26%     21%     19%     16%     13%     12%    6%
>
> Hmm, results ain't that bad :)

There is also still hope of optimizing small aligned copies like

set_ttbr0(user_ttbr);
ldm();
set_ttbr0(kernel_ttbr);
stm();

which could do e.g. 32 bytes at a time, but with more overhead
if you have to loop around it.

        Arnd
