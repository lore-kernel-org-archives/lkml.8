Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBB5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1547020842
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GQTqRdC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDFV4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:56:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41647 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgDFV4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:56:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id z23so719823lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIodbdng2iq+cjZAGnqnsCo6bh/19JD01rrelHovZW8=;
        b=GQTqRdC2HOYaOWL2PWzovWG9HCNqRV2J3E4wPLl3IAkWzCJshJ174TLXtiPJ0tJ6iT
         ByKaFfWewXzRdLNpbRUyoHVA5KyRREIWMe+y4hcyXm0DviuUHvz8HydBUSN19CSBpuou
         wEjNRcdpfvZG0NSeDi3TlK2pn5LodtVN38kzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIodbdng2iq+cjZAGnqnsCo6bh/19JD01rrelHovZW8=;
        b=aKHXRN/VYkSn7awq9JerWKzJpBj1Qc09TwaDoyPuyeEtArAB8xdaenAYUiefXEyHBx
         pQEb1cYRUhY/Ic+Rtk52Ep3AoX6UD5DGD5l4eU6rpll5vpmiCE0aveUurbLbUVPe3pwf
         /sPcwvMVf8zriTASXs8lpkIcQTVyEEhTniSrxLpvrwSuKkUiF5pqi5xKFSE06NCrdXOD
         JC5bLfkEA9HGPiEAr810y9fcc2r5pM46lCnBZs463TTwnUUi1gZITbTgAE89M3TI6vXO
         YJiv/mGyXmsoNMzbvTGGSS1igYLizW/CZAtE0P56ADXmq79zd911S0XuKrHfs/GxekT0
         t0vg==
X-Gm-Message-State: AGi0PubxqptBPeVIfu7XPnK0bG1MF2E1P0s4fWag7TpwQK14GYugQX2t
        nh/MEy9YTjhfksvXcbm1qyMs9jKJbJD2aRlmkGyfOQ==
X-Google-Smtp-Source: APiQypKuxxagCw/Zltt6N1TB9kEkTrKSVaYD4kVKT3uMA3M4jAaTHVolnWpUL0sZ9Ib6yyVL/jAiCHhloc5B1myadfw=
X-Received: by 2002:a19:ef0e:: with SMTP id n14mr14264100lfh.61.1586210167662;
 Mon, 06 Apr 2020 14:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200404033118.22135-1-mcchou@chromium.org> <20200403203058.v5.3.I56c3ba2ec2bcfaadf57575c5c74a03dd4f8487d0@changeid>
 <3361CF04-0C56-4787-9A74-99664DCB4312@holtmann.org>
In-Reply-To: <3361CF04-0C56-4787-9A74-99664DCB4312@holtmann.org>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 6 Apr 2020 14:55:56 -0700
Message-ID: <CABmPvSFzaovuFNdAggm+ZwpH80YUHD2mVDb6dhEm-O0m0f+waA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Bluetooth: btusb: Indicate Microsoft vendor
 extension for Intel 9160/9260
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just realized that the patches had been applied to bluetooth-next.
Thanks for the note here, and we will continue the work on top of
these patches from bluetooth-next.

On Sun, Apr 5, 2020 at 11:14 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Miao-chen,
>
> > This adds a bit mask of driver_info for Microsoft vendor extension and
> > indicates the support for Intel 9160/9260. This was verified with Intel
> > ThunderPeak BT controller where msft_opcode is 0xFC1E.
> >
> > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> > ---
> >
> > Changes in v5:
> > - Extract the changes on btusb as a different commit.
> >
> > Changes in v4:
> > - Introduce CONFIG_BT_MSFTEXT as a starting point of providing a
> > framework to use Microsoft extension
> > - Create include/net/bluetooth/msft.h and net/bluetooth/msft.c to
> > facilitate functions of Microsoft extension.
> >
> > Changes in v3:
> > - Create net/bluetooth/msft.c with struct msft_vnd_ext defined internally
> > and change the hdev->msft_ext field to void*.
> > - Define and expose msft_vnd_ext_set_opcode() for btusb use.
> > - Init hdev->msft_ext in hci_alloc_dev() and deinit it in hci_free_dev().
> >
> > Changes in v2:
> > - Define struct msft_vnd_ext and add a field of this type to struct
> > hci_dev to facilitate the support of Microsoft vendor extension.
> >
> > drivers/bluetooth/btusb.c | 11 ++++++++++-
> > 1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 3bdec42c96123..f73ad18c04559 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -20,6 +20,7 @@
> >
> > #include <net/bluetooth/bluetooth.h>
> > #include <net/bluetooth/hci_core.h>
> > +#include <net/bluetooth/msft.h>
> >
> > #include "btintel.h"
> > #include "btbcm.h"
> > @@ -58,6 +59,7 @@ static struct usb_driver btusb_driver;
> > #define BTUSB_CW6622          0x100000
> > #define BTUSB_MEDIATEK                0x200000
> > #define BTUSB_WIDEBAND_SPEECH 0x400000
> > +#define BTUSB_MSFT_VND_EXT   0x800000
> >
> > static const struct usb_device_id btusb_table[] = {
> >       /* Generic Bluetooth USB device */
> > @@ -335,7 +337,8 @@ static const struct usb_device_id blacklist_table[] = {
> >
> >       /* Intel Bluetooth devices */
> >       { USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW |
> > -                                                  BTUSB_WIDEBAND_SPEECH },
> > +                                                  BTUSB_WIDEBAND_SPEECH |
> > +                                                  BTUSB_MSFT_VND_EXT },
> >       { USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW |
> >                                                    BTUSB_WIDEBAND_SPEECH },
> >       { USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
> > @@ -3800,6 +3803,12 @@ static int btusb_probe(struct usb_interface *intf,
> >               set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
> >               set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> >               set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> > +
> > +             /* All Intel controllers that support the Microsoft
> > +              * vendor extension are using 0xFC1E for VsMsftOpCode.
> > +              */
> > +             if (id->driver_info & BTUSB_MSFT_VND_EXT)
> > +                     msft_set_opcode(hdev, 0xFC1E);
>
> I decided to actually set the MSFT extension support in the btusb_setup_intel_new handler based on our firmware version information. I think that this will be better than USB products IDs. We can revisit this later, but for now, this should be enough.
>
> Johan also applied the whole series and you should base your next steps on bluetooth-next.
>
> Regards
>
> Marcel
>
