Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805E4C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F63D2184D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmAwXjqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEIIKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgEIIKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:10:32 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248F4C061A0C;
        Sat,  9 May 2020 01:10:32 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a5so2550786vsm.7;
        Sat, 09 May 2020 01:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hg2j4yDUwU/HdTy91WVT+D8cDbi67SkruoSAu6walPg=;
        b=cmAwXjqzTs4mGPYVsr1LRa/7NH7QWL+ied3aAdEqVx+8AhccAWLtdFRjQJVW4AujgG
         NzhEAj/FI/1az32WuUjuIlt/beelqF3cUYZyJkt3uDV0ppjLKRH65s9Oa5Uj2OQnodmN
         IeETq/CyU5jych/jLblezYeAVvA9S8a6harjeNvjsIXHQdyDTJ/8WgHPsxDn/t+KnqX2
         isAzn++2aPYs/Bf61eR05iUUmdQ7ND69oNlHPXG3+FA4u3QwlcjtS53Va4OwRzk0Dv30
         N10GxSA/KX+L5BsSt8RVO4bWTc6khulHWVB5wR1YUhS8Q8KwJFVsod1mVWF8hWAMBDLz
         6r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hg2j4yDUwU/HdTy91WVT+D8cDbi67SkruoSAu6walPg=;
        b=uZS2JNhuL0SJT+JnXoslxNf/1NRYMDxav6Ab4QV5BSYiln2mVLRKPReo71YGCFvltL
         DsD31BySuZ5FmKmwvr5fOOBeB7asxV9kJ3LReeNC1RHsboU03vjzRVHOD1tInyE4bIXp
         Jy24ycolFwnt9O4Lkq9j7arDQcHvgh140tVEXnO8Wx2Rw9mGcOrldwwZfXWashM8imF0
         DeTnLHcr4bOejdEM8fPMDTnMim/qaeWLyT8XyTQmzzZP2hubZIvsFvOn9N5PZNdDvvsf
         fIOcL8jKutQSeKxdJBD9mPYAML/k+jeF+PnD0Ucup3frYcVH591pPlzFTR9RUnERksmK
         RrcQ==
X-Gm-Message-State: AGi0Puag3+oG7poBX5U7XlDePXvFWb47ggnl7mBaOK9z8pnTAdyv1B3s
        cUnA2ClZX1hAObRUvFVAaE1GFHVr2ADaEqLmUds=
X-Google-Smtp-Source: APiQypKhiLPAytkBC1so8+Xa11Vq69wFO63GCNQ8pk3I0jEMQahK0ObW836JL5fza3z6uG0EO6M3gq1OoNA5x0K77U4=
X-Received: by 2002:a67:fe8c:: with SMTP id b12mr4980915vsr.186.1589011831107;
 Sat, 09 May 2020 01:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
 <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
 <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com> <87h7wqmwrv.fsf@kernel.org>
In-Reply-To: <87h7wqmwrv.fsf@kernel.org>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Sat, 9 May 2020 16:10:19 +0800
Message-ID: <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
To:     Felipe Balbi <balbi@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, peter.chen@nxp.com,
        Li Jun <jun.li@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Felipe Balbi <balbi@kernel.org> =E4=BA=8E2020=E5=B9=B45=E6=9C=888=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:33=E5=86=99=E9=81=93=EF=BC=9A
>
>
> Hi,
>
> Jun Li <lijun.kernel@gmail.com> writes:
> > John Stultz <john.stultz@linaro.org> =E4=BA=8E2019=E5=B9=B410=E6=9C=883=
0=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:18=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> On Tue, Oct 29, 2019 at 2:11 AM Felipe Balbi <balbi@kernel.org> wrote:
> >> > John Stultz <john.stultz@linaro.org> writes:
> >> > > From: Yu Chen <chenyu56@huawei.com>
> >> > >
> >> > > It needs more time for the device controller to clear the CmdAct o=
f
> >> > > DEPCMD on Hisilicon Kirin Soc.
> >> >
> >> > Why does it need more time? Why is it so that no other platform need=
s
> >> > more time, only this one? And which command, specifically, causes
> >> > problem?
> >
> > Sorry for my back to this so late.
> >
> > This change is required on my dwc3 based HW too, I gave a check
> > and the reason is suspend_clk is used in case the PIPE phy is at P3,
> > this slow clock makes my EP command below timeout.
>
> The phy needs to woken up before the command is triggered. Currently we
> only wake up the HS PHY. Does it help you if we wake up the SS phy as
> well?
>
> Something like below ought to do it:
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index a0555252dee0..ee46c2dacaeb 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -274,7 +274,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsi=
gned cmd,
>         const struct usb_endpoint_descriptor *desc =3D dep->endpoint.desc=
;
>         struct dwc3             *dwc =3D dep->dwc;
>         u32                     timeout =3D 1000;
> -       u32                     saved_config =3D 0;
> +       u32                     saved_hs_config =3D 0;
> +       u32                     saved_ss_config =3D 0;
>         u32                     reg;
>
>         int                     cmd_status =3D 0;
> @@ -293,19 +294,28 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, un=
signed cmd,
>         if (dwc->gadget.speed <=3D USB_SPEED_HIGH) {
>                 reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>                 if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
> -                       saved_config |=3D DWC3_GUSB2PHYCFG_SUSPHY;
> +                       saved_hs_config |=3D DWC3_GUSB2PHYCFG_SUSPHY;
>                         reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
>                 }
>
>                 if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
> -                       saved_config |=3D DWC3_GUSB2PHYCFG_ENBLSLPM;
> +                       saved_hs_config |=3D DWC3_GUSB2PHYCFG_ENBLSLPM;
>                         reg &=3D ~DWC3_GUSB2PHYCFG_ENBLSLPM;
>                 }
>
> -               if (saved_config)
> +               if (saved_hs_config)
>                         dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>         }
>
> +       reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
> +       if (unlikely(reg & DWC3_GUSB3PIPECTL_SUSPHY)) {
> +               saved_ss_config |=3D DWC3_GUSB3PIPECTL_SUSPHY;
> +               reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
> +       }
> +
> +       if (saved_ss_config)
> +               dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
> +
>         if (DWC3_DEPCMD_CMD(cmd) =3D=3D DWC3_DEPCMD_STARTTRANSFER) {
>                 int             needs_wakeup;
>
> @@ -397,12 +407,18 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, un=
signed cmd,
>                         dwc3_gadget_ep_get_transfer_index(dep);
>         }
>
> -       if (saved_config) {
> +       if (saved_hs_config) {
>                 reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> -               reg |=3D saved_config;
> +               reg |=3D saved_hs_config;
>                 dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>         }
>
> +       if (saved_ss_config) {
> +               reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
> +               reg |=3D saved_ss_config;
> +               dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
> +       }
> +
>         return ret;
>  }

Unfortunately this way can't work, once the SS PHY enters P3, disable
suspend_en can't force SS PHY exit P3, unless do this at the very beginning
to prevent SS PHY entering P3(e.g. add "snps,dis_u3_susphy_quirk" for test)=
.

thanks
Li Jun
>
> --
> balbi
