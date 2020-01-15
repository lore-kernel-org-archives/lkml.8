Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74670C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC6E2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgAONRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:17:17 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:36177 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgAONRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:17:17 -0500
Received: from mail-qv1-f43.google.com ([209.85.219.43]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MiaLn-1jKiZI1H5b-00flU9; Wed, 15 Jan 2020 14:17:15 +0100
Received: by mail-qv1-f43.google.com with SMTP id t6so7303531qvs.5;
        Wed, 15 Jan 2020 05:17:14 -0800 (PST)
X-Gm-Message-State: APjAAAXUF7uwoly5PxRtodJvMfrQEtLMn876yokffdjv5Z92xD2YsrMs
        c19fuO+ci0nHeozC9yNB8N9sC/9w4k8HpbXx2DA=
X-Google-Smtp-Source: APXvYqw6NIFS97lqecGyqkucJJ9eR92lH8OkYLUR/9zn7Yxt/NLRzeCcRu106nWrGyp9+B+UV4pv/9O/RYpLvGnJKEc=
X-Received: by 2002:a0c:d788:: with SMTP id z8mr20666215qvi.211.1579094234004;
 Wed, 15 Jan 2020 05:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20191029182320.GA17569@mwanda> <CGME20191029190229epcas3p4e9b24bd8cde962681ef3dc4644ed2c2e@epcas3p4.samsung.com>
 <87zhhjjryk.fsf@x220.int.ebiederm.org> <fd4e6f01-074b-def7-7ffb-9a9197930c31@samsung.com>
 <CAK8P3a2uLm9pJtx42qDXJSdD71-dVW6+iDcRAnEB85Ajak-HLw@mail.gmail.com> <6ed59903-afe7-d5b2-73eb-ca626616dd6f@samsung.com>
In-Reply-To: <6ed59903-afe7-d5b2-73eb-ca626616dd6f@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 14:16:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3SJZ+j0jzYGtETaLGUXwwn0WqjN+wojUrYngOui9+h7A@mail.gmail.com>
Message-ID: <CAK8P3a3SJZ+j0jzYGtETaLGUXwwn0WqjN+wojUrYngOui9+h7A@mail.gmail.com>
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
X-Provags-ID: V03:K1:1sZUHtYS3cZfWONjHXH49q7U5+XCF6+oSN6oebSYZOEBhyv73Nn
 aNx9K6/QRsO9neZCDKSRMl07IFzzQc/w/Fdnehy5ik5KIPepjzza0OcSMjK+nAR5uOqoz2T
 w6keQbGUudpbjWs5YZ3sFz4/AMHKdXbKGtCqRXPb8ncQyTIdpuU+/B+Fs+Cw8s3/IvVXb3N
 6sPchdumTQIm2NCMDkSbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w/HC8ctDI9w=:xkndOO9xTeXLhIPWKCAj3O
 WoNMR1LjTrtESui2PCxFOtDk1ct9dNYL7U5+wucEQoPiPdv6aKNamiGMqE+qYQNTY6/7legFA
 OefH5d37/wBgdZkU5PDT60rixIQ2RvuD6XH6YXscGh8nYzPyRFVojEiKR7RVnJAog7uG/XcaM
 jxS+Y1T87cal/GLkPMnHvkj8fhBfnXl6047/kU81oE26SgL9JVHG/qqDDQmVdTIxYCc/SZ/j2
 J2NwQfVNG+x5oeLpKO4n/pzwyuDkvEa55BJm0BSIjUQ0kryoI3kCCDxmdOXZYPq9gYR11fgXu
 ll5oR51j+NyMPl4EpO0SfJmfIUaxK6Q+0OXxtVjFawVjrqgfQ4tBQJ/7CQARMjIBx9YKl1BVx
 UZpfr6GHks9qPEgcEMLbqjbDo43ufeIKZXQ8Rfcdrcjf0gXsWuw+8FfKUOFbhLgMChXSVsaoC
 qkImbG9QA/KxJwrjwq+fOAfo2hdmnh0SW6OKPfLrZNiJ1qRTNb+DoSudv1kBOiTd/77TlHAW3
 v+bLtf3Zzu/WbJfUJ0TsFlNV3OwXjVHWMTKbCIGJzDGDT7zAUcrtJSHkDUbne9J9RJFUpnHcx
 R8k1WWyhjnCQr8T+qPmQLK1gwxtQC10ZXVOBHJ9ylP9G6XFgGaC7XCnovAdO9Tmy/I5wQEsWw
 Gm33J4FXM5ddKjzeEH5ufbS9193/bwxe7oQQA1JcaWouo7RHaPaSp0FBqEQ995k6X46RLpaTP
 j5nEPC5Fh4xhGViW7RbV7ThYVCCAjRHQ81hxuG/k3E2+3Qaw7NC5ITQ2LZy1LzZ+4yW4VgPjm
 qkCvWv98W4JtGtJcxm1Uvl763jvdY79h8FqImGRKqeakomU8x6HSYRfqLbOZHWpA0z3QcOfmn
 rmuhMycZkbdP4tn/Bv7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 2:09 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

> > $ git grep -wl register_framebuffer | xargs grep -L framebuffer_alloc
> > Documentation/fb/framebuffer.rst
> > drivers/media/pci/ivtv/ivtvfb.c
> > drivers/media/platform/vivid/vivid-osd.c
> > drivers/video/fbdev/68328fb.c
> > drivers/video/fbdev/acornfb.c
> > drivers/video/fbdev/amba-clcd.c
> > drivers/video/fbdev/atafb.c
> > drivers/video/fbdev/au1100fb.c
> > drivers/video/fbdev/controlfb.c
> > drivers/video/fbdev/core/fbmem.c
> > drivers/video/fbdev/cyber2000fb.c
> > drivers/video/fbdev/fsl-diu-fb.c
> > drivers/video/fbdev/g364fb.c
> > drivers/video/fbdev/goldfishfb.c
> > drivers/video/fbdev/hpfb.c
> > drivers/video/fbdev/macfb.c
> > drivers/video/fbdev/matrox/matroxfb_base.c
> > drivers/video/fbdev/matrox/matroxfb_crtc2.c
> > drivers/video/fbdev/maxinefb.c
> > drivers/video/fbdev/ocfb.c
> > drivers/video/fbdev/pxafb.c
> > drivers/video/fbdev/sa1100fb.c
> > drivers/video/fbdev/stifb.c
> > drivers/video/fbdev/valkyriefb.c
> > drivers/video/fbdev/vermilion/vermilion.c
> > drivers/video/fbdev/vt8500lcdfb.c
> > drivers/video/fbdev/wm8505fb.c
> > drivers/video/fbdev/xilinxfb.c
> >
> > It's possible (even likely, the ones I looked at are fine) that they
> > all correctly
> > zero out the fb_info structure first, but it seems hard to guarantee, so
> > Eric's suggestion would possibly still be the safer choice.
>
> I've audited all above instances and they are all fine. They either
> use the fb_info structure embedded in a driver specific structure
> (which is zeroed out) or (in case of some m68k specific drivers) use
> a static fb_info instance.
>
> Since fbdev is closed for new drivers it should be now fine to use
> the simpler approach (just use memcpy()).

Yes, let's do that then. The complex approach seems more likely
to introduce a bug than one of the existing drivers to stop initializing
the structure correctly.

      Arnd
