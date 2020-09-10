Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SHORT_URL,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B6EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E54421D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLq9mWWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgIJDqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgIJDqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:46:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415A3C061573;
        Wed,  9 Sep 2020 20:46:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so5068224wrn.6;
        Wed, 09 Sep 2020 20:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rhSOAxzgEOKoOxOwzGMZcjmfHSP4cW3qb6mj/Oykssg=;
        b=aLq9mWWaF38Dy5eOEHExYV5lho/30PcbufnqeW3T7BFS6Jr+fH0ogKDNVhLrYMhS1z
         KxxW5MHJol+AvT/ecOUKyv+YB8TV/ovPfAmr400PW7n2TYZZkEXlSeUVMjpxuHd9NQ4q
         ZTYs/gmQzKCRxNB4NJNp62JUe9e1aFYOvpinj6xlKE0gjbT3BVPCJjvSkJGdgiT6JyAj
         MInVlHypjdI8TS5jFvoPnfhA92qxSMW+kQcfGmgXv3FlgQ1YSwB/8X6JVU7UAtfB5AFs
         0WqZtoEkz9+roqY0JbKxrs+1X6docaLIFWurWK53GmzpEThCKI9gnnRv5ac0CmQ4kX00
         LdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rhSOAxzgEOKoOxOwzGMZcjmfHSP4cW3qb6mj/Oykssg=;
        b=pjpbFqDbmBt7hfCJ8ntmZ7PeoTQZuSLTXgFKkzMBnXI60vG9Cr6LZk2h82p5E6ipji
         IpF4D1T1p7pNFH9cgxi4+6M5mhfURzV1tFv4CT+FNWQvHL92CYl0NhuPj9MEyVrivkNV
         +0h6WhkNEHzDMRCKYOa+HyQTDqFIy3wb7gMs6r9SCP9xvmPJBqYwctrL6IURes1uBtwI
         AU9Tsrf9Xw2vA5l3gCizG4QApaDDcZrTDNsj3KtfzvLTyIfNnPYiAif8C/4jJ9qJWseb
         062i3Ifq7W3ZYQ5Q2nlu1I/EeJHZzISWNWfBAHdgk34y43NVoyBzHmhVOukincwEwHFE
         4f2w==
X-Gm-Message-State: AOAM530Ld6CnGE1dFMtlnOqzUnpe8difqgDKIE0rYcEXQPtqVKIlH/P6
        +8FPHK7Do3goi3MuIG1eUhbI9O85n+cXi8k6ZYo=
X-Google-Smtp-Source: ABdhPJx+2eU6THjZQjD1CoHAzuHm4Gf8MCQoh6RFpkf1JYTBt5XAIel3CxcfS0PtIABJs6VR4hwNRYQ0+t4r5i/wfTg=
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr6557082wrj.94.1599709592824;
 Wed, 09 Sep 2020 20:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <1599706954.10822.3.camel@suse.de> <D2C1360E-65CC-410A-8B39-48F7340FEFCE@marcansoft.com>
In-Reply-To: <D2C1360E-65CC-410A-8B39-48F7340FEFCE@marcansoft.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 9 Sep 2020 21:46:20 -0600
Message-ID: <CADvTj4o-T92C0bO6Bp9p1N-CjX80nzL+y6bPfosMqU2ftdex8Q@mail.gmail.com>
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     Hector Martin marcan <hector@marcansoft.com>
Cc:     Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 9:17 PM Hector Martin "marcan"
<hector@marcansoft.com> wrote:
>
>
>
> On September 10, 2020 12:02:34 PM GMT+09:00, Oliver Neukum <oneukum@suse.=
de> wrote:
> >Am Mittwoch, den 09.09.2020, 13:34 -0600 schrieb James Hilliard:
> >> This patch detects and reverses the effects of the malicious FTDI
> >> Windows driver version 2.12.00(FTDIgate).
> >
> >Hi,
> >
> >this raises questions.
> >Should we do this unconditionally without asking?
> >Does this belong into kernel space?
>
> I agree; this is very cute, but does it really need to be an automatic Li=
nux feature? Presumably someone looking to fix a bricked FTDI chip can just=
 run my script, and those who just want to use those chips with Linux alrea=
dy can since the driver binds to the zero PID.
Well for one your script is not easily useable with embedded platforms
like mine where I ran into this issue, I have no python2 interpreter
available in my production builds.
>
> I am deeply amused by the idea of Linux automatically fixing problems cau=
sed by malicious Windows drivers, but thinking objectively, I'm not sure if=
 that's the right thing to do.
From my understanding Linux fixing up hardware issues caused
by faulty/weird Windows drivers isn't exactly unusual.
>
> >
> >> +static int ftdi_repair_brick(struct usb_serial_port *port)
> >> +{
> >> +    struct ftdi_private *priv =3D usb_get_serial_port_data(port);
> >> +    int orig_latency;
> >> +    int rv;
> >> +    u16 *eeprom_data;
> >> +    u16 checksum;
> >> +    int eeprom_size;
> >> +    int result;
> >> +
> >> +    switch (priv->chip_type) {
> >> +    case FT232RL:
> >> +            eeprom_size =3D 0x40;
> >> +            break;
> >> +    default:
> >> +            /* Unsupported for brick repair */
> >> +            return 0;
> >> +    }
> >> +
> >> +    /* Latency timer needs to be 0x77 to unlock EEPROM programming */
> >> +    if (priv->latency !=3D 0x77) {
> >> +            orig_latency =3D priv->latency;
> >> +            priv->latency =3D 0x77;
> >> +            rv =3D write_latency_timer(port);
> >> +            priv->latency =3D orig_latency;
> >> +            if (rv < 0)
> >> +                    return -EIO;
> >> +    }
> >
> >Do you really want to change this without returning to the original?
> >
> >       Regards
> >               Oliver
>
> --
> Hector Martin "marcan" (hector@marcansoft.com)
> Public key: https://mrcn.st/pub
