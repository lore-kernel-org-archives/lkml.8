Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SHORT_URL,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62328C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217E821D46
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOTchPWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgIJEH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgIJEHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 00:07:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE91C061573;
        Wed,  9 Sep 2020 21:07:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so4188831wme.5;
        Wed, 09 Sep 2020 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8xrolCd6+J8Mbo2hmZKIFa1uobUqrIU1pGogqZIxKE=;
        b=TOTchPWZDQwXPWWMUlf0jECodfQYz8tz4XVSre4nfLfYioggBjRqpafVsj4d/YonKV
         Xjv7qQEVY439VE53aS4/GdRwq6LoY28/dhaHbAE43erCmBJZCOub2/FLuwZgmAQCNy37
         +E6RGhLTQ6uB5clojQnTuGpv39VlkTVHZDd6mOzx/NuDT9Rk/uLkarSHVFNh2wiqCRVv
         JCPnfsluwM01S9w3NO6MamPtsePj1sZN7HXI06KN6ChJVMJKJ0Sev34LtQgZlzZGBZ5V
         n6wtj4XwTIUFT+1f3ZaLk/svHr7/XqaqIn0sZ/LY6LMu3jFq5hXL/w86QPcHbwqFQYrb
         TTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8xrolCd6+J8Mbo2hmZKIFa1uobUqrIU1pGogqZIxKE=;
        b=R/e9Cg20VaFSnN+7lJRF1vkGar7xGLYi4ubLBr4vbWpHQtfmGAR3pB09J006M34buv
         OOz1KWO9rrd3qv+zTJl1FvPnlX9BVOME6xlhy472fZ9C+JQel26SxjlO/cQXiFgCm6Ix
         w/q+qBxTnFzvT8X0uduBIxqS8+TVli0AZAWGxeRNGU4JT/HoLQV+DurMByu2FhK3IiOo
         KAEuZSHwGRAg1bXytTOgkSqoX4eJFDbXU9GzihNPgJy0mQ6TGUhJiq/QcEtUH/8woBeX
         s2w+6tTliN3KUsxZuZgSgOmXy9dPBth/IKKZEs4qUzOw+If43p3LegGp7wSQVtRChW0x
         Agmw==
X-Gm-Message-State: AOAM532oVQq9TOCz2UgxjGO3tpDtIRzrp8+l+zxZX9NGYSXxroyW/AYf
        ZNxDqtgQZZeh25ZODLG7sw0CuflfCbWYgSu3/VE=
X-Google-Smtp-Source: ABdhPJwsovHDrBeS+DA3X2q7mkTAgr+UHtZD5ytvEPFAHcd5BPaJ8aZSqhaxQ8Xgfr4yLfu0SHR1SV1tGnrgGUXUpdI=
X-Received: by 2002:a05:600c:2cc1:: with SMTP id l1mr6278282wmc.78.1599710868970;
 Wed, 09 Sep 2020 21:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <1599706954.10822.3.camel@suse.de> <CADvTj4oznyY=sfbmtmdcYMgkYriV_Ujk=+0Fz--XumNa8ZvD=A@mail.gmail.com>
 <36F0CEB4-DE2E-41DA-9569-4706B00FCF7D@marcansoft.com>
In-Reply-To: <36F0CEB4-DE2E-41DA-9569-4706B00FCF7D@marcansoft.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 9 Sep 2020 22:07:36 -0600
Message-ID: <CADvTj4omztaEz09qXYCvspNowqavOSOM1qaXvtAt1KQZuWDisw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     Hector Martin marcan <hector@marcansoft.com>
Cc:     Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 9:47 PM Hector Martin "marcan"
<hector@marcansoft.com> wrote:
>
>
>
> On September 10, 2020 12:40:59 PM GMT+09:00, James Hilliard <james.hilliard1@gmail.com> wrote:
> >On Wed, Sep 9, 2020 at 9:02 PM Oliver Neukum <oneukum@suse.de> wrote:
> >>
> >> Am Mittwoch, den 09.09.2020, 13:34 -0600 schrieb James Hilliard:
> >> > This patch detects and reverses the effects of the malicious FTDI
> >> > Windows driver version 2.12.00(FTDIgate).
> >>
> >> Hi,
> >>
> >> this raises questions.
> >> Should we do this unconditionally without asking?
> >Well I think since we can reliably detect devices that have been
> >bricked by the malicious windows driver it's fine. I was careful to
> >ensure that this will bail out and not try to change anything unless
> >all
> >conditions match this specific brick attack.
> >> Does this belong into kernel space?
> >This seemed to be by far the simplest option for embedded systems
> >that need to automatically detect and repair the bricked eeproms.
> >
> >People seem to have plugged a bunch of counterfeit FTDI Arduino's
> >that normally attach to an embedded Linux host into windows for
> >some reason for a kiosk platform of mine which messed up the
> >userspace detection/mappings. This seemed like the best way to
> >avoid this being a support issue requiring manual unbricking
> >prochedures.
>
> If you need to update the kernel on this platform anyway to use this feature, why not just introduce a userspace script to fix the bricked units instead?
I considered that but it appeared to be far more complex as I would
have to validate all the interactions with my other userspace apps.

I haven't tested this but I suspect there may also be issues having
userspace code access these control messages, especially since
I build the ftdi_sio driver into my kernels rather than using a module.
>
> Needing this autofixed seems like somewhat of a niche use case better served by a script on platforms where it might be a problem, rather than upstream kernel code.
I figured this would be useful for anyone with these bricked devices
as I have wasted a lot of time debugging this issue since I wasn't
expecting the ID's to have changed.

I'm assuming it happened because I use USB hubs and firmware was
being flashed for different hub attached hardware devices by moving
the entire hub to Windows even though the userspace arduino control
application doesn't run on Windows at the moment.

I can't think of any case where this would be harmful as I have
plenty of sanity checks before fixing the brick to ensure it only
unbricks devices that have the preimage attack signature.

This is an annoying enough issue that I think autofixing makes sense
simply so that everyone can avoid wasting time debugging the issue
manually.
>
> >>
> >> > +static int ftdi_repair_brick(struct usb_serial_port *port)
> >> > +{
> >> > +     struct ftdi_private *priv = usb_get_serial_port_data(port);
> >> > +     int orig_latency;
> >> > +     int rv;
> >> > +     u16 *eeprom_data;
> >> > +     u16 checksum;
> >> > +     int eeprom_size;
> >> > +     int result;
> >> > +
> >> > +     switch (priv->chip_type) {
> >> > +     case FT232RL:
> >> > +             eeprom_size = 0x40;
> >> > +             break;
> >> > +     default:
> >> > +             /* Unsupported for brick repair */
> >> > +             return 0;
> >> > +     }
> >> > +
> >> > +     /* Latency timer needs to be 0x77 to unlock EEPROM
> >programming */
> >> > +     if (priv->latency != 0x77) {
> >> > +             orig_latency = priv->latency;
> >> > +             priv->latency = 0x77;
> >> > +             rv = write_latency_timer(port);
> >> > +             priv->latency = orig_latency;
> >> > +             if (rv < 0)
> >> > +                     return -EIO;
> >> > +     }
> >>
> >> Do you really want to change this without returning to the original?
> >> @@ -2255,6 +2364,12 @@ static int ftdi_sio_port_probe(struct
> >usb_serial_port *port)
> >>         ftdi_set_max_packet_size(port);
> >>         if (read_latency_timer(port) < 0)
> >>                 priv->latency = 16;
> >> +       vendor_id =
> >le16_to_cpu(port->serial->dev->descriptor.idVendor);
> >> +       product_id =
> >le16_to_cpu(port->serial->dev->descriptor.idProduct);
> >> +       if (vendor_id == FTDI_VID &&
> >> +               product_id == FTDI_BRICK_PID &&
> >> +               priv->chip_type == FT232RL)
> >> +               ftdi_repair_brick(port);
> >>         write_latency_timer(port);
> >It should get restored here.
> >>         create_sysfs_attrs(port);
> >>
> >>
> >>         Regards
> >>                 Oliver
> >>
>
> --
> Hector Martin "marcan" (hector@marcansoft.com)
> Public key: https://mrcn.st/pub
