Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE87C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 10:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D471420663
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 10:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYGs3UKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgCUK7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 06:59:30 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46451 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgCUK7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 06:59:30 -0400
Received: by mail-ua1-f66.google.com with SMTP id b2so3203470uas.13;
        Sat, 21 Mar 2020 03:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9jH6QtcIM6fEYXW7t6vzcM0JbN7bcLGtLTKkbM3jl1Q=;
        b=XYGs3UKy2VuvkX35osskSk7QboPJVKu5o7HdY0vROgALCpAJBzPSA7z3u+TDdYbxIf
         PiIowHb8y2QTKxN9XKVxlhMNyoR+YCOL4bG8Dczv9FVbnW7UTK7I31o35P7kn5shzWIs
         PhsFCl8Zi4hNCtB8hTy5Lb2Y4xZLM1/ec/agnI67SmDa0wkzf8znvYH/IUZ3KRNlidnd
         nDlHWglgqN7IusRloAz/WK+wlcchvJq5i5Ly1VQEVppMNfFkU6m0jWyXvsoras5o8hXT
         5FAMwt8RyBlS9kvoJL4rU9cYK8WlBOtPk0KB9wjEHUBabxRjxJxY+dO1UF+3WmazzEFP
         cJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9jH6QtcIM6fEYXW7t6vzcM0JbN7bcLGtLTKkbM3jl1Q=;
        b=eRuGNDkEdIiGtZB+lsU6nAZNYq+AMWcebVApuwghInPPzHGP4Glodo3I8RRBpGTPs8
         1NZXIDBUf2D4/CAtnVXTUHam2sCp7Zl+c757fXzxYAd0IHECfWWfmkgfUYSuuLUU5Duv
         7jKcZNG6O+ool8zbIDudg7Z/eg+2NkbtZ2B9MdULUh2Zg63Z/kJbHc7mm3dYYeOIms25
         XG+uCb9Hd5yXbnQjVgWI4cbFvKmzbeZboOhXt+kNLM669FYKqAqd6yjcsp2ohE6XSSdJ
         JeDV+uiaWOAN+afhtJiKAn6ez13iCIaXJibt3IookqL6MnejM/UStofnpHVMirdESyew
         24Xw==
X-Gm-Message-State: ANhLgQ3p7spwHeqKr5se+O+n4iA6+I6OLWUQyVR8YUAL8XDiwceW6DW2
        FU+3dlEcyFYlMI4oeIIhRGVU7xIBL0CAu9LNe34=
X-Google-Smtp-Source: ADFU+vvVWEWvoTQXKS0dcG1ib/MHPvFuBK/B4kXRC7HnFmb1+qyzZISJghYui9zG/FTq+NkbH8fTIoae5dCzARAKRB4=
X-Received: by 2002:ab0:6693:: with SMTP id a19mr8847837uan.129.1584788368957;
 Sat, 21 Mar 2020 03:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200319084902.24747-1-martin.kepplinger@puri.sm>
In-Reply-To: <20200319084902.24747-1-martin.kepplinger@puri.sm>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Sat, 21 Mar 2020 18:59:17 +0800
Message-ID: <CAKgpwJXyt1O_J2HR5uHgAg3JTcwxSrOBPg7JcLnVyo-K9QRE8g@mail.gmail.com>
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

Martin Kepplinger <martin.kepplinger@puri.sm> =E4=BA=8E2020=E5=B9=B43=E6=9C=
=8819=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:50=E5=86=99=E9=81=93=
=EF=BC=9A
>
> The DRD module calls dwc3_set_mode() on role switches, i.e. when a device=
 is
> being pugged in. In order to support continuous runtime power management =
when
> plugging in / unplugging a cable, we need to call pm_runtime_get() in thi=
s path.
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>
> revision history
> ----------------
> v2: move pm_rumtime calls into workqueue (thanks Roger)
>     remove unrelated documentation patch
> v1: https://lore.kernel.org/linux-usb/ef22f8de-9bfd-c1d5-111c-696f1336dbd=
a@puri.sm/T/
>
>
>  drivers/usb/dwc3/core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 1d85c42b9c67..0c058b2ac21d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -121,17 +121,19 @@ static void __dwc3_set_mode(struct work_struct *wor=
k)
>         if (dwc->dr_mode !=3D USB_DR_MODE_OTG)
>                 return;
>
> +       pm_runtime_get(dwc->dev);

I think this needs _get_sync(), as the following mode settings may
require runtime resumed
to enable clocks...

Li Jun

> +
>         if (dwc->current_dr_role =3D=3D DWC3_GCTL_PRTCAP_OTG)
>                 dwc3_otg_update(dwc, 0);
>
>         if (!dwc->desired_dr_role)
> -               return;
> +               goto out;
>
>         if (dwc->desired_dr_role =3D=3D dwc->current_dr_role)
> -               return;
> +               goto out;
>
>         if (dwc->desired_dr_role =3D=3D DWC3_GCTL_PRTCAP_OTG && dwc->edev=
)
> -               return;
> +               goto out;
>
>         switch (dwc->current_dr_role) {
>         case DWC3_GCTL_PRTCAP_HOST:
> @@ -190,6 +192,9 @@ static void __dwc3_set_mode(struct work_struct *work)
>                 break;
>         }
>
> +out:
> +       pm_runtime_mark_last_busy(dwc->dev);
> +       pm_runtime_put_autosuspend(dwc->dev);
>  }
>
>  void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
> --
> 2.20.1
>
