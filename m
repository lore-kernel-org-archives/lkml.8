Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF29C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE84E207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgAMMtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:49:51 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:59001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgAMMtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:49:50 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MGi6m-1ivuqF03wQ-00DrnK; Mon, 13 Jan 2020 13:49:49 +0100
Received: by mail-qt1-f178.google.com with SMTP id d5so8957935qto.0;
        Mon, 13 Jan 2020 04:49:48 -0800 (PST)
X-Gm-Message-State: APjAAAUL/nH/v9bWPYRP8YJpHanBsQwHTVZb607yHl2wwT5fuWQyIxSM
        qlDNPAIcKddfz+9xeQUDwo61b4pqsbU3Y2SPP0I=
X-Google-Smtp-Source: APXvYqzFNee6oMqlwdnJFaK96+kqQeTvX1mVko2+fsSOjGGm7mJkzAnLuZGtaJ8nkF1quBL2liWsixLifYLOWUujuDc=
X-Received: by 2002:ac8:709a:: with SMTP id y26mr13837250qto.304.1578919787752;
 Mon, 13 Jan 2020 04:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20191029182320.GA17569@mwanda> <CGME20191029190229epcas3p4e9b24bd8cde962681ef3dc4644ed2c2e@epcas3p4.samsung.com>
 <87zhhjjryk.fsf@x220.int.ebiederm.org> <fd4e6f01-074b-def7-7ffb-9a9197930c31@samsung.com>
In-Reply-To: <fd4e6f01-074b-def7-7ffb-9a9197930c31@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Jan 2020 13:49:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2uLm9pJtx42qDXJSdD71-dVW6+iDcRAnEB85Ajak-HLw@mail.gmail.com>
Message-ID: <CAK8P3a2uLm9pJtx42qDXJSdD71-dVW6+iDcRAnEB85Ajak-HLw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: potential information leak in do_fb_ioctl()
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Peter Rosin <peda@axentia.se>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, security@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Z86KGNz51oiEIbBwBmTRv1ygKjG0C0oJVToiYX8G7GmKClLf85N
 NxX50AhreeFufMRAYcsX5mIWe4vF1q9dqwzjp1me5o9Om9Wzb9DVtsQMhOXuXWvKCjz3Wht
 Fh/iCbvwpJOj3Wi6jtF9ISpm9Xw8l9kX7Yku9tQwJGTbpwbeb9Zq1lVn8KRVF6ImrXa000T
 PBOk7r2qkNiADqHmh/adQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9wOE/U8AERY=:AyuhiL5DijWN3TEddRb/Vh
 RXvq/IR8r+JpcYSRGy3udJCcE7aKqDhokzRZN7q6EOKhFcLZhSGBQLIt6Swp//hcYAcEPfiSK
 BuMqRA1UOsO5ftu1CHaNCyOKlVi2yvQCPpt25UKVu3ImQwebEe2jILvL63oXQYFUJgWbVytSg
 CXiFleX9B+hI3Ou5/5PCdxlz95kHHEGrzdsAZlQJ6gtand+Jo+x9Vb0Keu8QaH6QY5v4ZDGK/
 Q1NIewK1EptszTFZhm4Tj0OWxxxMIQDfTTaRRwUUIp0URIyGn3Lk6l1PHALMbt/RPyNbb/g1Q
 p4K5PujpLsdnPdOAfwT4LaRlwF6+quugJiWLQA5yyLGxZ63DuaclfDTPcxWm5A72kjdeHbMaT
 B4jYnGIMbCltmcWQjx/lo1OgXR8hoYCKGGaS6LMOTvWhXAt9kDmXa+4AP3sC+TYZ+cs+km+Ht
 kpCCIZNjDyBb0BqjOmrA8oBlVp4QwU5aMK2u2j3d2HTZjhkee0NvYuPu/2Q5RRTXuUEtRhZ6r
 uABrdiRsbwOXThMhbsftOa/COk1O86y18Vs8Vdkb8rlv8+TjAaTZ8IYU6TZmQCmm5o6CYB6+5
 6JQB40q4vK4fQS4sXxYI0RoOmoNZfHHOAYHkQiqiXNz8kh+iVwsNy6FEP/Ze97lqR9YrUL+ws
 +NaK1plV8BoqQtHD7v+3wa+HdKXQ8sYHKgEiphjEvTUF3KXXtxHt3IAmW97iGoc5UcF4k1sx+
 +41lZMgHtGK3nz6LZ88B5UXwju2Pi6yBkQGs5kfcCMM7ZnwN+52HHYLqFcT27JzhGwNULgKK+
 FrFUGEKDdn4OHPDjpdRKsz/pkmiTJnjoYRa8xIjokp1fdeQAGjcvzhgfxGMX7jOSkihqNr2QW
 f2eMJznjCBvCzqPcocMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 2:09 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On 10/29/19 8:02 PM, Eric W. Biederman wrote:
> >
> > The goal is to avoid memory that has values of the previous users of
> > that memory region from leaking to userspace.  Which depending on who
> > the previous user of that memory region is could tell userspace
> > information about what the kernel is doing that it should not be allowed
> > to find out.
> >
> > I tried to trace through where "info" and thus presumably "info->fix" is
> > coming from and only made it as far as  register_framebuffer.  Given
>
> "info" (and thus "info->fix") comes from framebuffer_alloc() (which is
> called by fbdev device drivers prior to registering "info" with
> register_framebuffer()). framebuffer_alloc() does kzalloc() on "info".
>
> Therefore shouldn't memcpy() (as suggested by Jeo Perches) be enough?

Is it guaranteed that all drivers call framebuffer_alloc() rather than
open-coding it somewhere?

Here is a list of all files that call register_framebuffer() without first
calling framebuffer_alloc:

$ git grep -wl register_framebuffer | xargs grep -L framebuffer_alloc
Documentation/fb/framebuffer.rst
drivers/media/pci/ivtv/ivtvfb.c
drivers/media/platform/vivid/vivid-osd.c
drivers/video/fbdev/68328fb.c
drivers/video/fbdev/acornfb.c
drivers/video/fbdev/amba-clcd.c
drivers/video/fbdev/atafb.c
drivers/video/fbdev/au1100fb.c
drivers/video/fbdev/controlfb.c
drivers/video/fbdev/core/fbmem.c
drivers/video/fbdev/cyber2000fb.c
drivers/video/fbdev/fsl-diu-fb.c
drivers/video/fbdev/g364fb.c
drivers/video/fbdev/goldfishfb.c
drivers/video/fbdev/hpfb.c
drivers/video/fbdev/macfb.c
drivers/video/fbdev/matrox/matroxfb_base.c
drivers/video/fbdev/matrox/matroxfb_crtc2.c
drivers/video/fbdev/maxinefb.c
drivers/video/fbdev/ocfb.c
drivers/video/fbdev/pxafb.c
drivers/video/fbdev/sa1100fb.c
drivers/video/fbdev/stifb.c
drivers/video/fbdev/valkyriefb.c
drivers/video/fbdev/vermilion/vermilion.c
drivers/video/fbdev/vt8500lcdfb.c
drivers/video/fbdev/wm8505fb.c
drivers/video/fbdev/xilinxfb.c

It's possible (even likely, the ones I looked at are fine) that they
all correctly
zero out the fb_info structure first, but it seems hard to guarantee, so
Eric's suggestion would possibly still be the safer choice.

      Arnd
