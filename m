Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F04C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B736320873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O+Alrd3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgD3QRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgD3QRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:17:15 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798B8C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:17:15 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k12so5481874qtm.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1ywhvVtyaBoKC3XFG8v7uMK9P4ingTUxeVNCtR26SJM=;
        b=O+Alrd3ANyUNfJgulqXODq31NAax7hf0J5B9ih1dwg8jTcUqlXwl3faP2rQE6s4bkS
         foEmGBVV6mHEPsIKcA60YL2ovTfFzjVfBUgUSyme7jYnRbm4+meB3JyMVoJnZSUFa620
         ce4m7nMBlWaqs0h9AZ6Vu+DY9rO/Ap9Xr8Bno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ywhvVtyaBoKC3XFG8v7uMK9P4ingTUxeVNCtR26SJM=;
        b=cknLU58uapVPI9u/q09K+s3J7JupFtegvpKyNH3CCvFI8HdZZNb0BH35tGD/Vp6xgh
         tkSqtR3eGV9MyW3vPseGfZEgR4lKSm/mTPRE71QVjyHo1zaLMyYZBa6swYAMlL/vypBK
         71OH119/r4a1eymJn2v1GnNod//S7llCDKddXR4XM2noEKaHdj5XkEUGmJk2DIFGGqBM
         QeR7oNTHnkG2X4yLvJUmBe6FMwEVccSZoYp+0sfu3AEEjWOv/lizUinV9aWUkDnbD59h
         eKqWGuwLz9ydtm6O9K6zCk/Z8htripURx1FIpdd3QJDBMTpjmUzv36WSJ8137Px/WW7c
         WtSw==
X-Gm-Message-State: AGi0PuY3zHXr6s2+dvXemMpo1YG1Tl9h9sg2G2D7WgrbkOglzFOl8LMr
        fMlnA8TxPjeFVP+s4GdQfx6ONc3hpkF+0IaaG/hIwg==
X-Google-Smtp-Source: APiQypIm2Hb2/agRq2f7sDN4r842PYER25oTmM7J4V78IP9RhtXqiptcwBYdCZgABrIxIPRtcnObIL8eG0gr3gS59no=
X-Received: by 2002:ac8:746:: with SMTP id k6mr2290106qth.141.1588263434577;
 Thu, 30 Apr 2020 09:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200428110253.1.I926f6741079cafb04ecb592130aef75b24ad31ae@changeid>
 <c57b0892-d68d-f0f2-3cc1-b8549983227e@collabora.com> <CAONX=-dLVBpz+p1si4cWGHEmQ_toO8kW=fCPcdUuX2KLc-o=2A@mail.gmail.com>
 <CAONX=-dDWjMQDGncSgXNf86Bt3C5OUtFqh=Pe2HToGPSv5qa4A@mail.gmail.com>
 <CACeCKacoEjQm0_VfZGYNEZVhKubPyqspNZupQk+7piJOsVzH+Q@mail.gmail.com> <fc7901ff-9e67-d6d5-f084-70233fd8344c@collabora.com>
In-Reply-To: <fc7901ff-9e67-d6d5-f084-70233fd8344c@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 30 Apr 2020 09:17:03 -0700
Message-ID: <CACeCKafnrMk_=Udg-roEbrkDzZe6m3mUk14OOVVROmn-agfpDA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Handle NULL EC pointer
 during probe.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Thu, Apr 30, 2020 at 8:26 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 30/4/20 2:43, Prashant Malani wrote:
> > On Wed, Apr 29, 2020 at 5:38 PM Daniil Lunev <dlunev@chromium.org> wrot=
e:
> >>
> >> [to make it appear on the mailing list as I didn't realize I was in
> >> hypertext sending mode]
> >>
> >> On Thu, Apr 30, 2020 at 10:11 AM Daniil Lunev <dlunev@chromium.org> wr=
ote:
> >>>
> >>> Hi Enric.
> >>> I encountered the issue on a Hatch device when trying running 5.4 ker=
nel on that. After talking to Prashant it seems that any device with corebo=
ot built before a certain point (a particular fix for device hierarchy in A=
CPI tables of Chrome devices which happened in mid-April) will not be able =
to correctly initialize the driver and will get a kernel panic trying to do=
 so.
> >
> > A clarifying detail here: This should not be seen in any current
> > *production* device. No prod device firmware will carry the erroneous
> > ACPI device entry.
> >
>
> Thanks for the clarification. Then, I don't think we need to upstream thi=
s. This
> kind of "defensive-programming" it's not something that should matter to =
upstream.

Actually, on second thought, I am not 100% sure about this:
Daniil, is the erroneous ACPI device on a *production* firmware for
this device (I'm not sure about the vintage of that device's BIOS)?

My apologies for the confusion, Enric and Daniil; but would be good to
get clarification from Daniil.

Best regards,
>
> Thanks,
>  Enric
>
>
> >>> Thanks,
> >>> Daniil
> >>>
> >>> On Thu, Apr 30, 2020 at 7:58 AM Enric Balletbo i Serra <enric.balletb=
o@collabora.com> wrote:
> >>>>
> >>>> Hi Daniil,
> >>>>
> >>>> Thank you for the patch.
> >>>>
> >>>> On 28/4/20 3:02, Daniil Lunev wrote:
> >>>>> Missing EC in device hierarchy causes NULL pointer to be returned t=
o the
> >>>>> probe function which leads to NULL pointer dereference when trying =
to
> >>>>> send a command to the EC. This can be the case if the device is mis=
sing
> >>>>> or incorrectly configured in the firmware blob. Even if the situati=
on
> >>>>
> >>>> There is any production device with a buggy firmware outside? Or thi=
s is just
> >>>> for defensive programming while developing the firmware? Which devic=
e is
> >>>> affected for this issue?
> >>>>
> >>>> Thanks,
> >>>>  Enric
> >>>>
> >>>>> occures, the driver shall not cause a kernel panic as the condition=
 is
> >>>>> not critical for the system functions.
> >>>>>
> >>>>> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> >>>>> ---
> >>>>>
> >>>>>  drivers/platform/chrome/cros_ec_typec.c | 5 +++++
> >>>>>  1 file changed, 5 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/plat=
form/chrome/cros_ec_typec.c
> >>>>> index 874269c07073..30d99c930445 100644
> >>>>> --- a/drivers/platform/chrome/cros_ec_typec.c
> >>>>> +++ b/drivers/platform/chrome/cros_ec_typec.c
> >>>>> @@ -301,6 +301,11 @@ static int cros_typec_probe(struct platform_de=
vice *pdev)
> >>>>>
> >>>>>       typec->dev =3D dev;
> >>>>>       typec->ec =3D dev_get_drvdata(pdev->dev.parent);
> >>>>> +     if (!typec->ec) {
> >>>>> +             dev_err(dev, "Failed to get Cros EC data\n");
> >>>>> +             return -EINVAL;
> >>>>> +     }
> >>>>> +
> >>>>>       platform_set_drvdata(pdev, typec);
> >>>>>
> >>>>>       ret =3D cros_typec_get_cmd_version(typec);
> >>>>>
