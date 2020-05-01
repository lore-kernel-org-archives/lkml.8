Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA61C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 03:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA072073E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 03:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y9fzkmZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgEADWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 23:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgEADWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 23:22:45 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD25C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 20:22:44 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id z1so5626109vsn.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 20:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q8zKtdoBSqXZ/3UpfSxQ1WF/iLXzd6iSL9Ugo4OLKbs=;
        b=Y9fzkmZF4Md1uRBhwT6euvierZyC/AKxTpDXu7Dk6WxVg3y0tu2eqANLfaTNYAsVFj
         a81x+n+mdsfibDz+uGIqYRmjeK1yWKSgBb9Bd7t+s6+aEnVKOf0kz1o4Jv7DaTk8gl/X
         cOzvNmnegodNx/G1pM8yRemny6IiD33rdapu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q8zKtdoBSqXZ/3UpfSxQ1WF/iLXzd6iSL9Ugo4OLKbs=;
        b=O18rTMJrQp7aRas5I4ODmqTS1jstEXRTOreMvDoRGOvwZjown+IZ7YC5fKtVYvj9QC
         4QPdb5kFIQbMpKDAkiRcwiNDKkrj31wzvT++Cva7Hlk7JHAReXt0CRHUiDiIICH7KEGK
         pXCApBZX8cikMK9mI+YUVDF4r9y3mJ9b621CNtS6Xa11VZXcSk3PEFYtGHwshUjZH9ZQ
         50FgBcNZUSQYl6u7HHZzeYFXqtK8WmayNdMQck3KYCh3f4qsypG0H+cEpgw1eYoS98FI
         YiMe+qiAxEpSSL4i1Zjlv4aDg3NziXGeYVE+2gzjgmxzzkRSAr1jI/bz7Ps2eB2Txv2G
         wEDg==
X-Gm-Message-State: AGi0PuZsfibSX5Ima1AsgVDs9yNgiJQU+Es6Ih9ZLaMKIzosgnX9OVME
        0uwm0f5+QZ/gB8AjmouGeWtjQTZaQxgFmLnN7d2N/g==
X-Google-Smtp-Source: APiQypJsraivejPpvRInzgNAufivQ4doWR5sXSDjgvYk3ULfpSlPjvnG37hBADVwXE3SvlCNmHE9Ng6wkox5Wu0CQxc=
X-Received: by 2002:a67:79d0:: with SMTP id u199mr1728674vsc.115.1588303363042;
 Thu, 30 Apr 2020 20:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200428110253.1.I926f6741079cafb04ecb592130aef75b24ad31ae@changeid>
 <c57b0892-d68d-f0f2-3cc1-b8549983227e@collabora.com> <CAONX=-dLVBpz+p1si4cWGHEmQ_toO8kW=fCPcdUuX2KLc-o=2A@mail.gmail.com>
 <CAONX=-dDWjMQDGncSgXNf86Bt3C5OUtFqh=Pe2HToGPSv5qa4A@mail.gmail.com>
 <CACeCKacoEjQm0_VfZGYNEZVhKubPyqspNZupQk+7piJOsVzH+Q@mail.gmail.com>
 <fc7901ff-9e67-d6d5-f084-70233fd8344c@collabora.com> <CACeCKafnrMk_=Udg-roEbrkDzZe6m3mUk14OOVVROmn-agfpDA@mail.gmail.com>
 <CAONX=-cR0H2zrGEunwq2k3g+d=9asmeu39ssFN31yFs6i-wktQ@mail.gmail.com> <20200501005609.GA131713@google.com>
In-Reply-To: <20200501005609.GA131713@google.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Fri, 1 May 2020 13:22:31 +1000
Message-ID: <CAONX=-fs_4zA4DGxcoRTod+amjVgSdAaQ-CQ4wsC7J9=fnm6Zw@mail.gmail.com>
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

Hi Prashant,
I do not think it is present. Thinking about it, I do not think it
shall be an issue on any released device as it will have either a
firmware which wouldn't even trigger the typec probe or the one after
the hierarchy fix. Likely I just got a firmware which was somewhere in
between those two (As I did some unrelated FW testing). So, yes,
probably putting this upstream is not necessary, though IMO more
sanity checks - especially on non-critical run-once paths - are always
better than having a kernel panic lingering around the corner, not
like I am insisting on pushing the patch though with all the info, up
to Enric.
Cheers,
Daniil

On Fri, May 1, 2020 at 10:56 AM Prashant Malani <pmalani@chromium.org> wrot=
e:
>
> Hi Daniil,
>
> On Fri, May 01, 2020 at 10:15:18AM +1000, Daniil Lunev wrote:
> > On the official revision of coreboot for hatch it doesn't even try to
> > load Type C. However it gives some warning messages from
> > cros-usbpd-notify-acpi about EC, So I wonder why the check of the same
> > type is not appropriate in the typec driver?
>
> I think the difference is that GOOG0003 is already present on shipped /
> official versions of coreboot (so not having that check can cause
> existing release images/devices to crash), whereas for GOOG0014 that is /=
 isn't the case.
>
> Is GOOG0014 present on the official release coreboot image for this
> device? If so, what's its path (/sys/bus/acpi/devices/<HID>/path) ?
>
> Best regards,
>
> -Prashant
> >
> > ../chrome/cros_usbpd_notify.c
> >
> > /* Get the EC device pointer needed to talk to the EC. */
> > ec_dev =3D dev_get_drvdata(dev->parent);
> > if (!ec_dev) {
> > /*
> > * We continue even for older devices which don't have the
> > * correct device heirarchy, namely, GOOG0003 is a child
> > * of GOOG0004.
> > */
> > dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
> > }
> >
> >
> > # dmesg
> > ...
> > [    8.513351] cros-ec-spi spi-PRP0001:02: EC failed to respond in time
> > [    8.722072] cros-ec-spi spi-PRP0001:02: EC failed to respond in time
> > [    8.729271] cros-ec-spi spi-PRP0001:02: Cannot identify the EC: erro=
r -110
> > [    8.736966] cros-ec-spi spi-PRP0001:02: cannot register EC,
> > fallback to spidev
> > [    8.767017] cros_ec_lpcs GOOG0004:00: Chrome EC device registered
> > [    8.807537] cros-usbpd-notify-acpi GOOG0003:00: Couldn't get Chrome
> > EC device pointer.
> > ...
> >
> > On Fri, May 1, 2020 at 2:17 AM Prashant Malani <pmalani@chromium.org> w=
rote:
> > >
> > > Hi Enric,
> > >
> > > On Thu, Apr 30, 2020 at 8:26 AM Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com> wrote:
> > > >
> > > > Hi Prashant,
> > > >
> > > > On 30/4/20 2:43, Prashant Malani wrote:
> > > > > On Wed, Apr 29, 2020 at 5:38 PM Daniil Lunev <dlunev@chromium.org=
> wrote:
> > > > >>
> > > > >> [to make it appear on the mailing list as I didn't realize I was=
 in
> > > > >> hypertext sending mode]
> > > > >>
> > > > >> On Thu, Apr 30, 2020 at 10:11 AM Daniil Lunev <dlunev@chromium.o=
rg> wrote:
> > > > >>>
> > > > >>> Hi Enric.
> > > > >>> I encountered the issue on a Hatch device when trying running 5=
.4 kernel on that. After talking to Prashant it seems that any device with =
coreboot built before a certain point (a particular fix for device hierarch=
y in ACPI tables of Chrome devices which happened in mid-April) will not be=
 able to correctly initialize the driver and will get a kernel panic trying=
 to do so.
> > > > >
> > > > > A clarifying detail here: This should not be seen in any current
> > > > > *production* device. No prod device firmware will carry the erron=
eous
> > > > > ACPI device entry.
> > > > >
> > > >
> > > > Thanks for the clarification. Then, I don't think we need to upstre=
am this. This
> > > > kind of "defensive-programming" it's not something that should matt=
er to upstream.
> > >
> > > Actually, on second thought, I am not 100% sure about this:
> > > Daniil, is the erroneous ACPI device on a *production* firmware for
> > > this device (I'm not sure about the vintage of that device's BIOS)?
> > >
> > > My apologies for the confusion, Enric and Daniil; but would be good t=
o
> > > get clarification from Daniil.
> > >
> > > Best regards,
> > > >
> > > > Thanks,
> > > >  Enric
> > > >
> > > >
> > > > >>> Thanks,
> > > > >>> Daniil
> > > > >>>
> > > > >>> On Thu, Apr 30, 2020 at 7:58 AM Enric Balletbo i Serra <enric.b=
alletbo@collabora.com> wrote:
> > > > >>>>
> > > > >>>> Hi Daniil,
> > > > >>>>
> > > > >>>> Thank you for the patch.
> > > > >>>>
> > > > >>>> On 28/4/20 3:02, Daniil Lunev wrote:
> > > > >>>>> Missing EC in device hierarchy causes NULL pointer to be retu=
rned to the
> > > > >>>>> probe function which leads to NULL pointer dereference when t=
rying to
> > > > >>>>> send a command to the EC. This can be the case if the device =
is missing
> > > > >>>>> or incorrectly configured in the firmware blob. Even if the s=
ituation
> > > > >>>>
> > > > >>>> There is any production device with a buggy firmware outside? =
Or this is just
> > > > >>>> for defensive programming while developing the firmware? Which=
 device is
> > > > >>>> affected for this issue?
> > > > >>>>
> > > > >>>> Thanks,
> > > > >>>>  Enric
> > > > >>>>
> > > > >>>>> occures, the driver shall not cause a kernel panic as the con=
dition is
> > > > >>>>> not critical for the system functions.
> > > > >>>>>
> > > > >>>>> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> > > > >>>>> ---
> > > > >>>>>
> > > > >>>>>  drivers/platform/chrome/cros_ec_typec.c | 5 +++++
> > > > >>>>>  1 file changed, 5 insertions(+)
> > > > >>>>>
> > > > >>>>> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/driver=
s/platform/chrome/cros_ec_typec.c
> > > > >>>>> index 874269c07073..30d99c930445 100644
> > > > >>>>> --- a/drivers/platform/chrome/cros_ec_typec.c
> > > > >>>>> +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > > >>>>> @@ -301,6 +301,11 @@ static int cros_typec_probe(struct platf=
orm_device *pdev)
> > > > >>>>>
> > > > >>>>>       typec->dev =3D dev;
> > > > >>>>>       typec->ec =3D dev_get_drvdata(pdev->dev.parent);
> > > > >>>>> +     if (!typec->ec) {
> > > > >>>>> +             dev_err(dev, "Failed to get Cros EC data\n");
> > > > >>>>> +             return -EINVAL;
> > > > >>>>> +     }
> > > > >>>>> +
> > > > >>>>>       platform_set_drvdata(pdev, typec);
> > > > >>>>>
> > > > >>>>>       ret =3D cros_typec_get_cmd_version(typec);
> > > > >>>>>
