Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D1EC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046F22078E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sciv+inv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgIJDle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIJDlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:41:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DCBC061573;
        Wed,  9 Sep 2020 20:41:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o5so5009109wrn.13;
        Wed, 09 Sep 2020 20:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RV3JhQ0QrU39E+lQO0xIaUDW05mKR2Brp3o0EwUp+KA=;
        b=sciv+invHn9PJ1ccTmvXk3hwTs7w5CUYYvb5Vs9i9GRLCbhpfGZv6LEvFxWSJqiqt6
         u8T1Ck6RAHh2w6T9PT0wUGDWiDo+a7Zd6Hx4Yt1aWqR/8Twyc4WjouWdPOQEeNiH2At6
         ToI7B99CoPgF0RxBM7145ujkUgmzDJMdbs2ESiDa7pWWnr9fYCe0X5IUdQN3SYZlDFSk
         BVtbxGOs0TR0x2oOMqfgJUostYx50v/GCiDMDusI8sRh5DRYGSvpgtWlj9KEl6uVfNV4
         xfQ/nrh641hz+dOg/e6nRe3aWRk22CUVLOfeQXtsJjVJW2nK6Dexda9zUkCdKaSSOSBy
         ROMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RV3JhQ0QrU39E+lQO0xIaUDW05mKR2Brp3o0EwUp+KA=;
        b=DIbODLzqRtWPl6cUsUR4xie3MJaWzcgYjEQk0GWzqtKb/HY/NR0rjgqeigNAAHn4UA
         4Y7+FnT0P5euxrScXHrlDMd/LTGNaaNHnsDwX24NUHENtLItHB17dGZwHHa/SWAQFqAq
         H4o9hGstAE7Ba28B5Cdb/YB2LNOT9ePKjf6ejANxGr0Vt98kgQnNNdE3ADvdu7Btst3y
         uxx7rrz96h59i+7XV91lAyDCyWJ26SHXlhcGC/cua9YUIh3C76VIprNudVicouvqcmLu
         9a6XxgPPgd5ErxY2lb5aj6N0ChUoKLLJVFtQqtpTpgT/QKw4EuImZ/NWjFbVSFw0cRgO
         PqEQ==
X-Gm-Message-State: AOAM533HYrsv1s4QKckTlKi9f6uPjKRnwpBXE/hVWIm7SO44CCCuZBwj
        uwoWA75VUH6BATfvfJgbB+sWJj3WDGASe+eFu269l7AjeYo=
X-Google-Smtp-Source: ABdhPJyxUCvs11LE1Qixn/Lu3hO6JNOIaSffZiU564Y2L8dQlgRpFkbW6XgPj0S9M0mJJohXJjWZijldB11noMDYc/w=
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr6648189wrx.173.1599709271452;
 Wed, 09 Sep 2020 20:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200909193419.2006744-1-james.hilliard1@gmail.com> <1599706954.10822.3.camel@suse.de>
In-Reply-To: <1599706954.10822.3.camel@suse.de>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 9 Sep 2020 21:40:59 -0600
Message-ID: <CADvTj4oznyY=sfbmtmdcYMgkYriV_Ujk=+0Fz--XumNa8ZvD=A@mail.gmail.com>
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     Oliver Neukum <oneukum@suse.de>
Cc:     linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>,
        Hector Martin <hector@marcansoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 9:02 PM Oliver Neukum <oneukum@suse.de> wrote:
>
> Am Mittwoch, den 09.09.2020, 13:34 -0600 schrieb James Hilliard:
> > This patch detects and reverses the effects of the malicious FTDI
> > Windows driver version 2.12.00(FTDIgate).
>
> Hi,
>
> this raises questions.
> Should we do this unconditionally without asking?
Well I think since we can reliably detect devices that have been
bricked by the malicious windows driver it's fine. I was careful to
ensure that this will bail out and not try to change anything unless all
conditions match this specific brick attack.
> Does this belong into kernel space?
This seemed to be by far the simplest option for embedded systems
that need to automatically detect and repair the bricked eeproms.

People seem to have plugged a bunch of counterfeit FTDI Arduino's
that normally attach to an embedded Linux host into windows for
some reason for a kiosk platform of mine which messed up the
userspace detection/mappings. This seemed like the best way to
avoid this being a support issue requiring manual unbricking
prochedures.
>
> > +static int ftdi_repair_brick(struct usb_serial_port *port)
> > +{
> > +     struct ftdi_private *priv = usb_get_serial_port_data(port);
> > +     int orig_latency;
> > +     int rv;
> > +     u16 *eeprom_data;
> > +     u16 checksum;
> > +     int eeprom_size;
> > +     int result;
> > +
> > +     switch (priv->chip_type) {
> > +     case FT232RL:
> > +             eeprom_size = 0x40;
> > +             break;
> > +     default:
> > +             /* Unsupported for brick repair */
> > +             return 0;
> > +     }
> > +
> > +     /* Latency timer needs to be 0x77 to unlock EEPROM programming */
> > +     if (priv->latency != 0x77) {
> > +             orig_latency = priv->latency;
> > +             priv->latency = 0x77;
> > +             rv = write_latency_timer(port);
> > +             priv->latency = orig_latency;
> > +             if (rv < 0)
> > +                     return -EIO;
> > +     }
>
> Do you really want to change this without returning to the original?
> @@ -2255,6 +2364,12 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
>         ftdi_set_max_packet_size(port);
>         if (read_latency_timer(port) < 0)
>                 priv->latency = 16;
> +       vendor_id = le16_to_cpu(port->serial->dev->descriptor.idVendor);
> +       product_id = le16_to_cpu(port->serial->dev->descriptor.idProduct);
> +       if (vendor_id == FTDI_VID &&
> +               product_id == FTDI_BRICK_PID &&
> +               priv->chip_type == FT232RL)
> +               ftdi_repair_brick(port);
>         write_latency_timer(port);
It should get restored here.
>         create_sysfs_attrs(port);
>
>
>         Regards
>                 Oliver
>
