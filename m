Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F057FC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F652080D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hV5nmls0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgANBGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:06:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24388 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729153AbgANBGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578963970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pcPgHMjbM1tTuJs57rpRm00UDVEplEHbWgFk0hTeOZ4=;
        b=hV5nmls0y+UjjLdXrdHioATIafPa74aOEh3qZHQJvgy5NC7qEDePpvhwg5hdNV3a2liUXr
        NmAh3TeJFoNw8tYD7ZNmETxkud3jxtY1S+9MR/TiJo4DuibrIH4CynbsIr0Ja+UMrWz5fn
        hfhrY0AeLkUhtu80W49bSBmGLgjeamI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-2wdm5lbuMTuscRUgDvVePA-1; Mon, 13 Jan 2020 20:06:08 -0500
X-MC-Unique: 2wdm5lbuMTuscRUgDvVePA-1
Received: by mail-qv1-f72.google.com with SMTP id f16so7657661qvr.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 17:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pcPgHMjbM1tTuJs57rpRm00UDVEplEHbWgFk0hTeOZ4=;
        b=pcOdjthsEFnAx3Gxmwy0vvFfdufqUJ/GQWkWVy4bDCuwHGj6dMVHLMxE6BRBvsbes2
         3ZCU6OInKgh+TRBx1J7RfUISqFqLX1Q76VhMTGktZslvWfDon6v9moN0t1gkDAubO7ip
         YQ1mxKZletdlZoZWx/IznCO+DXx++3L4+AcYN6VuotYEla17gfi7CaMjjVRm6x9GfqZS
         EUOxuvsLHKlDfL8BGzt4eYnK3/bbrjVXttkvXUVAbijz5/9SPDs1lbLq78g9kY/FB4CE
         +QSFKJkpo/GEvYWhQNHt28Liu6nJ1n/mPHXA+xCv3EUh1J/ezXIvSHXE5STKoYa42UnR
         sRow==
X-Gm-Message-State: APjAAAXuDSG27/sQzayeZHVdfkcwuvVTptoDpxFo2L4tDCzOpJMYP9ml
        phy6fYKqmxdr38E3STpMXw+vhQR4/GrOX0DROer8L46FwLfUxlPfLQv4KwsyRJzVZ8H+EjGhZXU
        jKtYhcDmUkdBMx+dZCpU9Re7l0MvPr/Mbjfub3dmZ
X-Received: by 2002:a37:a086:: with SMTP id j128mr14135968qke.459.1578963968132;
        Mon, 13 Jan 2020 17:06:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFgUVJ57OMm6qYtoPN41WVqMHNymaDdu9B+b9YyZZgWZjfQ9S0NylFBVceVMYo3g/DIWX4riFinR12zotGq5c=
X-Received: by 2002:a37:a086:: with SMTP id j128mr14135942qke.459.1578963967884;
 Mon, 13 Jan 2020 17:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20200112220612.3448741-1-lains@archlinux.org>
In-Reply-To: <20200112220612.3448741-1-lains@archlinux.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 14 Jan 2020 21:03:30 +1000
Message-ID: <CAO-hwJJJYRc8_kRiGGu9E4Dx-WpSADro4b28D8QoE87FBUTnOA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: logitech-hidpp: add support for the Powerplay mat/receiver
To:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Filipe,

On Mon, Jan 13, 2020 at 8:07 AM Filipe La=C3=ADns <lains@archlinux.org> wro=
te:
>
> The Logitech G Powerplay has a lightspeed receiver with a static HID++
> device with ID 7 attached to it to. It is used to configure the led on
> the mat. For this reason I increased the max number of devices.
>
> I also marked all lightspeed devices as HID++ compatible. As the
> internal powerplay device does not have REPORT_TYPE_KEYBOARD or
> REPORT_TYPE_MOUSE it was not being marked as HID++ compatible in
> logi_hidpp_dev_conn_notif_equad.
>
> Signed-off-by: Filipe La=C3=ADns <lains@archlinux.org>
> ---
>  drivers/hid/hid-logitech-dj.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.=
c
> index bb50d6e7745b..732380b55b15 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -16,11 +16,11 @@
>  #include <asm/unaligned.h>
>  #include "hid-ids.h"
>
> -#define DJ_MAX_PAIRED_DEVICES                  6
> +#define DJ_MAX_PAIRED_DEVICES                  7
>  #define DJ_MAX_NUMBER_NOTIFS                   8
>  #define DJ_RECEIVER_INDEX                      0
>  #define DJ_DEVICE_INDEX_MIN                    1
> -#define DJ_DEVICE_INDEX_MAX                    6
> +#define DJ_DEVICE_INDEX_MAX                    7
>
>  #define DJREPORT_SHORT_LENGTH                  15
>  #define DJREPORT_LONG_LENGTH                   32
> @@ -971,7 +971,7 @@ static void logi_hidpp_recv_queue_notif(struct hid_de=
vice *hdev,
>         case 0x0c:
>                 device_type =3D "eQUAD Lightspeed 1";
>                 logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &work=
item);
> -               workitem.reports_supported |=3D STD_KEYBOARD;
> +               workitem.reports_supported |=3D STD_KEYBOARD | HIDPP;

This feels wrong. The whole initial code was hack-ish, and now this is
even more hack-ish.

I don't have a simple solution right now (at a conference this week),
but I will need to be convinced this is the only sane solution :/

Cheers,
Benjamin

>                 break;
>         case 0x0d:
>                 device_type =3D "eQUAD Lightspeed 1_1";
> @@ -1850,6 +1850,10 @@ static const struct hid_device_id logi_dj_receiver=
s[] =3D {
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>                 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1),
>          .driver_data =3D recvr_type_gaming_hidpp},
> +       { /* Logitech powerplay mat/receiver (0xc539) */
> +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> +               0xc53a),
> +        .driver_data =3D recvr_type_gaming_hidpp},
>         { /* Logitech 27 MHz HID++ 1.0 receiver (0xc513) */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_REC=
EIVER),
>          .driver_data =3D recvr_type_27mhz},
> --
> 2.24.1
>

