Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5DEC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECE0206D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZJ+s2qx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgEAAPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 20:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbgEAAPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 20:15:32 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E6BC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 17:15:31 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id x136so5427470vsx.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 17:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=njxquvl5Pa3MBqLgNV6ZVO3HNq56Hs1EGBsX0EZCOPY=;
        b=ZJ+s2qx8B1To+g2Tx43OAluHxzmO5B9nZmAvvCzlRVPtR9hCBZINn1sREsaIScKaDV
         4qat8GeZcmJu6mcUe6RVN5A6pe6W2D09DkJszkzfOpDCu69u7zf7hRXSnlgk+mji0mva
         qV2sx9j08SethT7ezXNqi9nEE+KHVk0SINVWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=njxquvl5Pa3MBqLgNV6ZVO3HNq56Hs1EGBsX0EZCOPY=;
        b=CoI0+H7pv/agsO4Y05k9ADDQMThpVChtRYfnhJ3kKFgMoyuqBRzSFGK2vzRV1KC/Ci
         9338KC3ghr945S2TWlP2eLg5NQ+xxaR4cabfaBYFQ2m0XXBFLJz9FktlC5cNPMN42+im
         upJvzd59Yk4lJoeqBQO+uOXnRBJkP09Mt4iwTeJCL8xxtMOCk/O7Zxf88dpqcTBxUy0r
         C+wavfLMba87Dr4QsFIBqxIFC3EfBCJsfkA98veoz0VTxEWsPCouvDkTp+j+RAFxEJgn
         K/POrVRcemfxGm0DCcFLmQw+EU5Ik01lx4hfBv1sSJ+0HpzshQIunfdLyHy5vel716OZ
         Vb8A==
X-Gm-Message-State: AGi0PuZQGpBFTy8Ehf9U5uWLHh6nBYT1BWZNcTPiTMpWzqO42rVHU1fC
        wCtATKzKH4QbbNcIUyjhWchohxY5VlNhq6O0lK576Q==
X-Google-Smtp-Source: APiQypIa7tv44v8MfZWLxW/ITIxXc6+/F/SL570UsUpm7Qhmp/O0f8MCrmxWo4K8RnwVig30Q4z57xGb04cd/GaOuMc=
X-Received: by 2002:a67:e3b9:: with SMTP id j25mr1375783vsm.110.1588292129894;
 Thu, 30 Apr 2020 17:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200428110253.1.I926f6741079cafb04ecb592130aef75b24ad31ae@changeid>
 <c57b0892-d68d-f0f2-3cc1-b8549983227e@collabora.com> <CAONX=-dLVBpz+p1si4cWGHEmQ_toO8kW=fCPcdUuX2KLc-o=2A@mail.gmail.com>
 <CAONX=-dDWjMQDGncSgXNf86Bt3C5OUtFqh=Pe2HToGPSv5qa4A@mail.gmail.com>
 <CACeCKacoEjQm0_VfZGYNEZVhKubPyqspNZupQk+7piJOsVzH+Q@mail.gmail.com>
 <fc7901ff-9e67-d6d5-f084-70233fd8344c@collabora.com> <CACeCKafnrMk_=Udg-roEbrkDzZe6m3mUk14OOVVROmn-agfpDA@mail.gmail.com>
In-Reply-To: <CACeCKafnrMk_=Udg-roEbrkDzZe6m3mUk14OOVVROmn-agfpDA@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Fri, 1 May 2020 10:15:18 +1000
Message-ID: <CAONX=-cR0H2zrGEunwq2k3g+d=9asmeu39ssFN31yFs6i-wktQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Handle NULL EC pointer
 during probe.
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the official revision of coreboot for hatch it doesn't even try to
load Type C. However it gives some warning messages from
cros-usbpd-notify-acpi about EC, So I wonder why the check of the same
type is not appropriate in the typec driver?

../chrome/cros_usbpd_notify.c

/* Get the EC device pointer needed to talk to the EC. */
ec_dev =3D dev_get_drvdata(dev->parent);
if (!ec_dev) {
/*
* We continue even for older devices which don't have the
* correct device heirarchy, namely, GOOG0003 is a child
* of GOOG0004.
*/
dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
}


# dmesg
...
[    8.513351] cros-ec-spi spi-PRP0001:02: EC failed to respond in time
[    8.722072] cros-ec-spi spi-PRP0001:02: EC failed to respond in time
[    8.729271] cros-ec-spi spi-PRP0001:02: Cannot identify the EC: error -1=
10
[    8.736966] cros-ec-spi spi-PRP0001:02: cannot register EC,
fallback to spidev
[    8.767017] cros_ec_lpcs GOOG0004:00: Chrome EC device registered
[    8.807537] cros-usbpd-notify-acpi GOOG0003:00: Couldn't get Chrome
EC device pointer.
...

On Fri, May 1, 2020 at 2:17 AM Prashant Malani <pmalani@chromium.org> wrote=
:
>
> Hi Enric,
>
> On Thu, Apr 30, 2020 at 8:26 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Hi Prashant,
> >
> > On 30/4/20 2:43, Prashant Malani wrote:
> > > On Wed, Apr 29, 2020 at 5:38 PM Daniil Lunev <dlunev@chromium.org> wr=
ote:
> > >>
> > >> [to make it appear on the mailing list as I didn't realize I was in
> > >> hypertext sending mode]
> > >>
> > >> On Thu, Apr 30, 2020 at 10:11 AM Daniil Lunev <dlunev@chromium.org> =
wrote:
> > >>>
> > >>> Hi Enric.
> > >>> I encountered the issue on a Hatch device when trying running 5.4 k=
ernel on that. After talking to Prashant it seems that any device with core=
boot built before a certain point (a particular fix for device hierarchy in=
 ACPI tables of Chrome devices which happened in mid-April) will not be abl=
e to correctly initialize the driver and will get a kernel panic trying to =
do so.
> > >
> > > A clarifying detail here: This should not be seen in any current
> > > *production* device. No prod device firmware will carry the erroneous
> > > ACPI device entry.
> > >
> >
> > Thanks for the clarification. Then, I don't think we need to upstream t=
his. This
> > kind of "defensive-programming" it's not something that should matter t=
o upstream.
>
> Actually, on second thought, I am not 100% sure about this:
> Daniil, is the erroneous ACPI device on a *production* firmware for
> this device (I'm not sure about the vintage of that device's BIOS)?
>
> My apologies for the confusion, Enric and Daniil; but would be good to
> get clarification from Daniil.
>
> Best regards,
> >
> > Thanks,
> >  Enric
> >
> >
> > >>> Thanks,
> > >>> Daniil
> > >>>
> > >>> On Thu, Apr 30, 2020 at 7:58 AM Enric Balletbo i Serra <enric.balle=
tbo@collabora.com> wrote:
> > >>>>
> > >>>> Hi Daniil,
> > >>>>
> > >>>> Thank you for the patch.
> > >>>>
> > >>>> On 28/4/20 3:02, Daniil Lunev wrote:
> > >>>>> Missing EC in device hierarchy causes NULL pointer to be returned=
 to the
> > >>>>> probe function which leads to NULL pointer dereference when tryin=
g to
> > >>>>> send a command to the EC. This can be the case if the device is m=
issing
> > >>>>> or incorrectly configured in the firmware blob. Even if the situa=
tion
> > >>>>
> > >>>> There is any production device with a buggy firmware outside? Or t=
his is just
> > >>>> for defensive programming while developing the firmware? Which dev=
ice is
> > >>>> affected for this issue?
> > >>>>
> > >>>> Thanks,
> > >>>>  Enric
> > >>>>
> > >>>>> occures, the driver shall not cause a kernel panic as the conditi=
on is
> > >>>>> not critical for the system functions.
> > >>>>>
> > >>>>> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> > >>>>> ---
> > >>>>>
> > >>>>>  drivers/platform/chrome/cros_ec_typec.c | 5 +++++
> > >>>>>  1 file changed, 5 insertions(+)
> > >>>>>
> > >>>>> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/pl=
atform/chrome/cros_ec_typec.c
> > >>>>> index 874269c07073..30d99c930445 100644
> > >>>>> --- a/drivers/platform/chrome/cros_ec_typec.c
> > >>>>> +++ b/drivers/platform/chrome/cros_ec_typec.c
> > >>>>> @@ -301,6 +301,11 @@ static int cros_typec_probe(struct platform_=
device *pdev)
> > >>>>>
> > >>>>>       typec->dev =3D dev;
> > >>>>>       typec->ec =3D dev_get_drvdata(pdev->dev.parent);
> > >>>>> +     if (!typec->ec) {
> > >>>>> +             dev_err(dev, "Failed to get Cros EC data\n");
> > >>>>> +             return -EINVAL;
> > >>>>> +     }
> > >>>>> +
> > >>>>>       platform_set_drvdata(pdev, typec);
> > >>>>>
> > >>>>>       ret =3D cros_typec_get_cmd_version(typec);
> > >>>>>
