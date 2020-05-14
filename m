Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07FBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C5F206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1/r/aHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgENMxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENMxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:53:36 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471ADC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:53:36 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id a11so1058997uah.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lAir05Eo5P9ux6gvYCphk9uuOIJoYrt4qmvNbEYiFrs=;
        b=f1/r/aHfC9g71wQLKLx9qJqzfaRQgGxEr8wZgUFPTg0bvVKSEj9c1ComzA+KxXFBgi
         psHsRZ2OdE9PubDJuoqdi4qg1Ch7Z9um+GkBfcLNqT1k1wVz9ZLuMaJ8Q1ZiRTfGWY46
         EAhE07VszzPoOudVzsEwUM5P8llatySPpqlv7D+KnLEq2jeQzJ2L1AH4gK6unTZVb7wg
         RdTl0/9rCTWxHF2JTuEZtodIReoret4aPHd9l3WCIhs1tx5lMIClir1N8zK8eztNSF49
         dNukeITkWEWPQ/eJIpu/8KYz3XQ1t/SwkAdjE9YU85tXib7fpA9SCDCKTx8eG7v+mpZ6
         zYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAir05Eo5P9ux6gvYCphk9uuOIJoYrt4qmvNbEYiFrs=;
        b=r/dlAp0kvRviQtthUbKGJWjltpHFtYy0NiGa+Z/7MKsbEJ8N6R12C03jXWKX9+A9go
         0qDuOFUcSxA831LebSNheDznEueyS5LchF2dKuY5lB8gslVwlT65eZOr2NLUZDf1eJ+G
         L6G8pXmksOT2qctXMnj7dJCLJXhRVEUWNYtMR7cFt/Uw5qqzT5Fuuw0dfqcCF8L86TJK
         TUuN+CEfBFbgEA7yhPB7dQNpo8wMHuvTqmsVT4nVyQtuDY1pzcvw38XoiR4eGhhajInp
         5IunwRQSZIVCfheJ091yiRfkSt7qC/3ORLhGTOL4pHfnD2zH3R8f2sY2FEgZb5z2Fk6R
         S/cQ==
X-Gm-Message-State: AOAM531i0Nj0Abjj8xOHA5rhN25fhyjy442VJEKzBqJOZlC5YD9XIJUD
        mVnOvS8tTU4k1n8mbZKFF5GQ4WSRc8a+buRjCV8=
X-Google-Smtp-Source: ABdhPJxhyXjcjWUiMhsuzaEhLnVDWUEaS0KTIweQ+2fS1GhHKM7jEjT7Uye7bgVjnXU8reznyiKHvcxwSg6v2eCLA50=
X-Received: by 2002:ab0:6f0b:: with SMTP id r11mr2968555uah.47.1589460815268;
 Thu, 14 May 2020 05:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <125a8c31e106dc68e6d3e3395cecc766db7fb897.camel@gmail.com>
 <20200513070847.GM2571@lahna.fi.intel.com> <CAD2FfiHsUjLC1K=HvF74LbRaKoc_zz6bOmGLQrQbW4CywWCP9A@mail.gmail.com>
 <20200513091100.GY2571@lahna.fi.intel.com> <CAD2FfiGNErUhz=7DH6Z37X573hSkJkzbOEXbb++X+Ey5WLc9=Q@mail.gmail.com>
 <20200513162513.GI2571@lahna.fi.intel.com> <c4602e6768377179ff3204ea0c2d5944e6d35844.camel@gmail.com>
 <20200514121536.GS2571@lahna.fi.intel.com>
In-Reply-To: <20200514121536.GS2571@lahna.fi.intel.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Thu, 14 May 2020 13:53:23 +0100
Message-ID: <CAD2FfiEEzL0D5uRWgt=Hb6ngD2KY_NrZYJFAYtJi4CmS08zpfA@mail.gmail.com>
Subject: Re: [PATCH] mfd: Export LPC attributes for the system SPI chip
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     ptyser@xes-inc.com, Lee Jones <lee.jones@linaro.org>,
        tudor.ambarus@microchip.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, tglx@linutronix.de, jethro@fortanix.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 at 13:15, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> > +What:                /sys/kernel/security/firmware/bioswe
> Should this still be "firmware_protections" or similar. Plain "firmware"
> sounds again too generic. Maybe its just me..

It's not always going to be protections provided by the firmware; it
might also be restrictions put on the firmware. My first choice was
/sys/kernel/security/firmware_security/ but having the double
'security' just looked redundant.

> > +     LPC_SPT,        /* Sunrise Point */
> > +     LPC_KBL,        /* Kaby Lake */
> > +     LPC_TGL,        /* Tiger Lake */
>
> These all have the SPI-NOR controller as separate PCI device (as ICL and
> others).

For Sunrise Point I see:

00:1f.0 ISA bridge [0601]: Intel Corporation CM236 Chipset LPC/eSPI
Controller [8086:a150] (rev 31)
00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point LPC
Controller/eSPI Controller [8086:9d4e] (rev 21)

For Kaby Lake I see:

00:1f.0 ISA bridge [0601]: Intel Corporation HM175 Chipset LPC/eSPI
Controller [8086:a152] (rev 31)",

You're indeed correct about Tiger Lake, my apologies.

> > +     [LPC_SPT] = {
> > +             .name = "Sunrise Point",
> > +             .spi_type = INTEL_SPI_LPC,
> > +     },
>
> So all of these have LCP/eSPI controller but the SPI-NOR controller is
> not accessible through it - it is a separate PCI device.

I have a Sunrise Point system here -- the lspci is here:
https://people.freedesktop.org/~hughsient/temp/lspci.txt

Is the SPI-NOR controller perhaps hidden? If I read the BCR @ 0xdc
from the 00:1f.0 ISB bridge I get the expected BIOS_WE, BLE and
SMM_BWP results.

> Like you said, Evolution seems to mangle these.

I'll use git for future patches, thanks.

> > +             pci_read_config_dword(dev, BCR, &bcr);
> > +             info->writeable = !!(bcr & BCR_WPD);
> > +             break;
> > +
> > +     case INTEL_SPI_LPC:
>
> So instead of this, you can add the security attributes to the existing
> entries where we are sure there is SPI-NOR controller behind LPC. Here
> it is not the case and further..

Sooo I'd use INTEL_SPI_LPT? On my system RCBA isn't set, and so "if
(!res->start)" bails out with  return -ENODEV;"

> Otherwise this looks good, nice work :)

I thank you for your patience so far, what I've got the hang of this I
promise to start being more useful.

Richard.
