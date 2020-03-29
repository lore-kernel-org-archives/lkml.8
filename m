Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6264C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 01:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638FE20663
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 01:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2CrChD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgC2BEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 21:04:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37340 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbgC2BEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 21:04:53 -0400
Received: by mail-io1-f66.google.com with SMTP id q9so13951806iod.4;
        Sat, 28 Mar 2020 18:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEq14gH8MJ7hv3D8jymXXOPTR88QaLueWbAQX3wPTCI=;
        b=g2CrChD5giKWudtUUGe7Dk4fpmJs/Q1hRfTmTMy7boQPFpx8ZRml/KS883rNanHpRn
         2ZqgiC854Qu40PaAk1IvSSbZdvemDyOcwZ1RxhJUI3MBWOBlzZjgmetBlDEKRxNd/YfD
         Ls1La1vTqcezL3Jwji56DbSpl7ugEsHjLFF+ZZjZ6UmVDj11Lbe0msce8dsMQaTNfR1m
         uvFlL9Sb4vDcuIm3kx68geUs8fcF3Zne24rlOOAyXaJY9I8dEqcv+jmzmoZ1/eOC3oUq
         WwBRICbuAPjeM6d2AGNSRoEm+J6wfiq0W/l/mE3MHy0Pya1qm7LKjtBdNlXYx88EVr/3
         UsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEq14gH8MJ7hv3D8jymXXOPTR88QaLueWbAQX3wPTCI=;
        b=ep0sJ5Twt5k1nrdLNi89NF6h+WmiHjv5aeXikYKbwLhFNLN28GKTu6LqlArC0Deezm
         LZ/8UQyp1VmZk8wf/XzEx/KWM4wMpqnXYK5Mk+2fMSQibTWzIuauHXXPSizyZZA5Tg6l
         WewisFjs5umDYE+MxQNrj9uURKRkS/mzCEcPKqcWKdSCoXGNcNbaFCdQAdqKd1+qi4bi
         JBBbXxTEj0JyK4ZFrdKp8TXDJTZAi13AbGHRDG+Tjcf+ApQetNaeERkFc5ooTorTTaIR
         jXlIwSX655ULT3vLOsEYeF6sm/XD0ImLIyJUW9OIPYqr45+g3jDEPrAnPSlAecPrk7Ns
         kDYg==
X-Gm-Message-State: ANhLgQ0uIDyhtIZ7hz+EcAA0V+5haX/21uv5pRv2mBla7ZiSDqHR/Dsm
        XUDRbgU9V4+e2EhU3jvwYaWfakury5e11DvOTpQ=
X-Google-Smtp-Source: ADFU+vt1KZuhCRM+OKkatVV3lTeceg4W8ntn06ZjFKjPPU9/MpP04h0cm6lxyPiDzVyULvca5SJ8ckIz8wyGD2DZEL8=
X-Received: by 2002:a6b:5406:: with SMTP id i6mr4908695iob.188.1585443892387;
 Sat, 28 Mar 2020 18:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200328151511.22932-1-hqjagain@gmail.com> <20200328181259.GA24335@ravnborg.org>
In-Reply-To: <20200328181259.GA24335@ravnborg.org>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Sun, 29 Mar 2020 09:04:41 +0800
Message-ID: <CAJRQjoeOfiyacHcFfQOop5jJ9MspDKL8HTjQeAY-_Wbm9PnFGg@mail.gmail.com>
Subject: Re: [PATCH] fbcon: fix null-ptr-deref in fbcon_switch
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        ghalat@redhat.com, dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 2:13 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Qiujun
>
> Thanks for looking into the sysbot bugs.
>
> On Sat, Mar 28, 2020 at 11:15:10PM +0800, Qiujun Huang wrote:
> > Add check for vc_cons[logo_shown].d, as it can be released by
> > vt_ioctl(VT_DISALLOCATE).
> >
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
> >               fbcon_update_softback(vc);
> >       }
> >
> > -     if (logo_shown >= 0) {
> > +     if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
> >               struct vc_data *conp2 = vc_cons[logo_shown].d;
> >
> >               if (conp2->vc_top == logo_lines
> > @@ -2852,7 +2852,7 @@ static void fbcon_scrolldelta(struct vc_data *vc, int lines)
> >                       return;
> >               if (vc->vc_mode != KD_TEXT || !lines)
> >                       return;
> > -             if (logo_shown >= 0) {
> > +             if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
> >                       struct vc_data *conp2 = vc_cons[logo_shown].d;
> >
> >                       if (conp2->vc_top == logo_lines
>
> I am not familiar with this code.
>
> But it looks like you try to avoid the sympton
> which is that logo_shown has a wrong value after a
> vc is deallocated, and do not fix the root cause.
>
> We have:
>
> vt_ioctl(VT_DISALLOCATE)
>  |
>  +- vc_deallocate()
>      |
>      +- visual_deinit()
>          |
>          +- vc->vc_sw->con_deinit(vc)
>              |
>              +- fbcon_deinit()
>
> Would it be better to update logo_shown
> in fbcon_deinit()?
> Then we will not try to do anything with
> the logo in fbcon_switch().
>
> fbcon_deinit() is called with console locked
> so there should not be any races.

Get that, thanks.

>
> I did not stare long enough on the code to come up with a patch,
> but this may be a better way to fix it.
>
>         Sam
