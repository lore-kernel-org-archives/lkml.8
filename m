Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628EAC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F08206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPgqIvdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC1Q5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:57:43 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39198 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgC1Q5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:57:43 -0400
Received: by mail-il1-f193.google.com with SMTP id r5so11761026ilq.6;
        Sat, 28 Mar 2020 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLDYwWYbolvs0EFALE9dMKsppiAeImVTfUdChbO3aow=;
        b=pPgqIvdZ9uNU7ousZa8O2z2V+0gFzTJGZ7ABV8Gxi8q3uDmusxPuaKdRJSwm57b/cL
         ruYb656wWLtlY53QjVAUZSag3Ic2h5PDKDET4B6KrQ4YvXehJDb8JVrBSMKU2oro5vuz
         Z+KZjfk5YlZ2DFwobx/GMAQIFRWYxJwHEBSDRV9fQs9ADG4BJfSyMPunk+oJg3vfD7Ua
         vH3VBF077y1DVtJC2Gob+dulzgj6ELBrZH1wI/SLzDii9zSBTasHK8CazQAqJ4nleT5A
         vXX7suRnXWPWuxdeSUACQ2lwZ4ZLKDGPZrB0AuFsd09SRFIqO1/XMt3c/OH/3YXle8+v
         1zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLDYwWYbolvs0EFALE9dMKsppiAeImVTfUdChbO3aow=;
        b=QuHS9JwnV0YGnv6jbLbxNPn6CXidX43fO2vWYoQXr05QXULVtHlhOiKuo+xa1+hO4s
         V0R6dxR/iTunFF/AyN+P4Lvl6amVXstiIv/L//YpRoNB6F9wpk530lS6Wn4r4fo2reHv
         Y6u8zHFmt0f+EGQnlAaWFGSdYT4K+fqNKALDmYsgHhCw8ylhGTF+9hkIBbmGKehYb08N
         a0Vh5WCxW3Vpvi2A7zYYBAriWrz4yiwMYoQwqhiFGse8hOR0pN/YmC68WSeuA23StAt7
         GHz2ALvf3wLAu98wcPb21l+LcxOB0XdGZc5aRvXydpRy8sjUtmIvIqG85AWD9rifrqdg
         JOdQ==
X-Gm-Message-State: ANhLgQ0NG0IzlB5Py5nX/PLzAyFzX2Dz+CMU+wbkfZOFbAaNAeqHpXlj
        JP/uCPFHSe0Auy89WXHN58L6n81krN68jpj2Rjc=
X-Google-Smtp-Source: ADFU+vuddmVyw+A7IZajazkq9naRHRcxcUddjdccvYWE0Sz6p4/HG+6kcqL17pjFizx9jh7A3zQERI6a2RANMmH2NOY=
X-Received: by 2002:a92:77c2:: with SMTP id s185mr4244689ilc.297.1585414661819;
 Sat, 28 Mar 2020 09:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200328151511.22932-1-hqjagain@gmail.com> <CAKMK7uF2mipUSr-XRESrRJ8JdOZCekNTCVsDPW5hNp-mWwPj6Q@mail.gmail.com>
In-Reply-To: <CAKMK7uF2mipUSr-XRESrRJ8JdOZCekNTCVsDPW5hNp-mWwPj6Q@mail.gmail.com>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Sun, 29 Mar 2020 00:57:29 +0800
Message-ID: <CAJRQjocxe+KfSBX3uFv+_ajcY6agF9oXWvkon_kPM+3dk6Pz2Q@mail.gmail.com>
Subject: Re: [PATCH] fbcon: fix null-ptr-deref in fbcon_switch
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        ghalat@redhat.com, dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 12:31 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Sat, Mar 28, 2020 at 4:15 PM Qiujun Huang <hqjagain@gmail.com> wrote:
> > Add check for vc_cons[logo_shown].d, as it can be released by
> > vt_ioctl(VT_DISALLOCATE).
>
> Can you pls link to the syzbot report and distill the essence of the
> crash/issue here in the commit message? As-is a bit unclear what's
> going on. Patch itself looks correct.

https://lkml.org/lkml/2020/3/27/403
Thanks.

>
> Thanks, Daniel
>
> > Reported-by: syzbot+732528bae351682f1f27@syzkaller.appspotmail.com
> > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > ---
> >  drivers/video/fbdev/core/fbcon.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index bb6ae995c2e5..7ee0f7b55829 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -2254,7 +2254,7 @@ static int fbcon_switch(struct vc_data *vc)
> >                 fbcon_update_softback(vc);
> >         }
> >
> > -       if (logo_shown >= 0) {
> > +       if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
> >                 struct vc_data *conp2 = vc_cons[logo_shown].d;
> >
> >                 if (conp2->vc_top == logo_lines
> > @@ -2852,7 +2852,7 @@ static void fbcon_scrolldelta(struct vc_data *vc, int lines)
> >                         return;
> >                 if (vc->vc_mode != KD_TEXT || !lines)
> >                         return;
> > -               if (logo_shown >= 0) {
> > +               if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
> >                         struct vc_data *conp2 = vc_cons[logo_shown].d;
> >
> >                         if (conp2->vc_top == logo_lines
> > --
> > 2.17.1
> >
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
