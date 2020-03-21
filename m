Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33229C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 11:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC2720732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 11:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjEz3dcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgCULFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 07:05:38 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35337 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgCULFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 07:05:37 -0400
Received: by mail-vk1-f195.google.com with SMTP id n198so1274562vkc.2;
        Sat, 21 Mar 2020 04:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wjk3ypI3dZf435CgzcIi9qC6un7+JOF8jIyY4A4nu3s=;
        b=RjEz3dcWNjghPKNfR+K5nt69UDHMD7iBXiJesyKQ2Skfw8qUt+Rqphzu4iXNS7m3Ve
         s1mUHhNOECdWuRSk05xrTXWAeK0gtTTtmRWr5dVlbYnZ0qtPNGgTghy8YvbRu4Irts82
         E0d6Ycv70BdiZLWAqTx1zf/qKpcptJP8e8LGPFCdGVAJYFKDgh3ZebKfqYfJVgyeKmqy
         pMr2iRe1HgFn9xG0fPdZGVmVh+fMWo3clLKYBLBh9KtHPUKOSnVQW8IhO9jFSWFF3Vzl
         dNKAdBJuHU9wo++7qdiKsKYPgoOZMcX2D5W/Ebj1f6pzWC8b+BabOf8sxPKmtqTpCRQq
         w9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wjk3ypI3dZf435CgzcIi9qC6un7+JOF8jIyY4A4nu3s=;
        b=twFGdhb/C8ci0yXVliC7YYczz0vN0+9QDj/rbERuJ+aiU0TMsz6AS08MRPAGqqKfmr
         Pseu+ycv9wt1pG9HxKE4b5eyNhG5Mh5qYI/GdQ/ULEdXmYFAJfC1ayqrO72LmcUNPV8e
         XWKWr79qNuWR4cptX6SPSux31v8sj+88sQxgsbdplZ/XUla/gtN1Gr1B3FynCVdARMwb
         l48bH3j6y8xfaahSt8Bo29mZf503lesbMTQBa4sPZivp1VAzUnwLReytG+lKrSSYbpZn
         U5TWVMrRO5Yi1B5Qw+LGq70wAWBngPqizE+6osg6TCOi9+qU6ig15lVlPDjriSWuHXFZ
         ctdg==
X-Gm-Message-State: ANhLgQ1c22h01JTK/Xfwd5IVTw55C+X7Lw7Xwr2OZ4vsKjK2gNvMjms5
        fgf0LPDK2CPFi8mXI9cazWXuvYmVYOiIPOFlrrb2Dk+P
X-Google-Smtp-Source: ADFU+vszKLL4yYmgUwbkPfZQxiC7ZgSUrlxN32FC1CEOojgE6O6d980XAdOHGc2iMUXx+7RYnBtYR81+CXcNhF88uhw=
X-Received: by 2002:a1f:2543:: with SMTP id l64mr9191186vkl.69.1584788736106;
 Sat, 21 Mar 2020 04:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200319084902.24747-1-martin.kepplinger@puri.sm> <CAKgpwJXyt1O_J2HR5uHgAg3JTcwxSrOBPg7JcLnVyo-K9QRE8g@mail.gmail.com>
In-Reply-To: <CAKgpwJXyt1O_J2HR5uHgAg3JTcwxSrOBPg7JcLnVyo-K9QRE8g@mail.gmail.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Sat, 21 Mar 2020 19:05:24 +0800
Message-ID: <CAKgpwJWg8TE8-dduQ99CFK9vwgh=2AYwaPfhSN0Scoo_W-8Q8A@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: support continuous runtime PM with dual role
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rogerq@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jun Li <lijun.kernel@gmail.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8821=E6=97=A5=
=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=886:59=E5=86=99=E9=81=93=EF=BC=9A
>
> Martin Kepplinger <martin.kepplinger@puri.sm> =E4=BA=8E2020=E5=B9=B43=E6=
=9C=8819=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:50=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> > The DRD module calls dwc3_set_mode() on role switches, i.e. when a devi=
ce is
> > being pugged in. In order to support continuous runtime power managemen=
t when
> > plugging in / unplugging a cable, we need to call pm_runtime_get() in t=
his path.
> >
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >
> > revision history
> > ----------------
> > v2: move pm_rumtime calls into workqueue (thanks Roger)
> >     remove unrelated documentation patch
> > v1: https://lore.kernel.org/linux-usb/ef22f8de-9bfd-c1d5-111c-696f1336d=
bda@puri.sm/T/
> >
> >
> >  drivers/usb/dwc3/core.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 1d85c42b9c67..0c058b2ac21d 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -121,17 +121,19 @@ static void __dwc3_set_mode(struct work_struct *w=
ork)
> >         if (dwc->dr_mode !=3D USB_DR_MODE_OTG)
> >                 return;
> >
> > +       pm_runtime_get(dwc->dev);
>
> I think this needs _get_sync(), as the following mode settings may
> require runtime resumed
> to enable clocks...
>

See your v3, it's ok now.

> Li Jun
>
> > +
> >         if (dwc->current_dr_role =3D=3D DWC3_GCTL_PRTCAP_OTG)
> >                 dwc3_otg_update(dwc, 0);
> >
> >         if (!dwc->desired_dr_role)
> > -               return;
> > +               goto out;
> >
> >         if (dwc->desired_dr_role =3D=3D dwc->current_dr_role)
> > -               return;
> > +               goto out;
> >
> >         if (dwc->desired_dr_role =3D=3D DWC3_GCTL_PRTCAP_OTG && dwc->ed=
ev)
> > -               return;
> > +               goto out;
> >
> >         switch (dwc->current_dr_role) {
> >         case DWC3_GCTL_PRTCAP_HOST:
> > @@ -190,6 +192,9 @@ static void __dwc3_set_mode(struct work_struct *wor=
k)
> >                 break;
> >         }
> >
> > +out:
> > +       pm_runtime_mark_last_busy(dwc->dev);
> > +       pm_runtime_put_autosuspend(dwc->dev);
> >  }
> >
> >  void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
> > --
> > 2.20.1
> >
