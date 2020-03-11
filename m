Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C1AC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB7E20848
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KK2szt1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgCKI1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:27:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42640 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgCKI1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:27:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id e11so1238721qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vuzfa5Ii3C+114ZZwPqdNHymYuyp0hGwxEjG+i+rX1M=;
        b=KK2szt1h7nFFVCO3f9nxfC++kUNef5i7vZty9U/gBtxe1i+yMWak1f4jIR5Kb4+ZLA
         4vw5Iye+6iBjmx4V99eSyyfZWKslZbhILLwKA+Fh0R3xZ4NGcf7fD2K+qr0lK8OL/e1j
         HEvSqaPf47seotvIOR/52luoXum5Qp7c7fwsU135RB1sY9c8iV1SxIsluGw4hoP8ENKU
         6Dc3TfE8HEo36qIXRqrCwGcnJ8/oVPIEMnJh0529oXSU0ZV2sLh+72GfO4C5jjxotBCF
         ZU43ziooQvVB2uodGzLDDFl0uwQyXL4tiyfagbq7qk+JhQfeh5xNtG0zV0/ao45KwBlg
         xzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vuzfa5Ii3C+114ZZwPqdNHymYuyp0hGwxEjG+i+rX1M=;
        b=RWspj9KMm98cVF2TDY8CKg13m2yNWxzXjoRIYFGMg8udYDEn0hUtFvQOV27PbePfHH
         Ll0BHjudfIPefNHTQQUnL9CDdjdoiIMPMM3HLmD7AV7xONsN6CCwJTPOnrhRlat3raUA
         r62JxF37dX+CE1cKK8qrelr9Dx1s9ZROAwH09XafAu/piLIZ4HH5h+4omEgriR9vmTUN
         CWvmUJ7bngU8vS3KpKtaPbcZO5ArV0byzsUChpeRT4AHay4KLJlsx0OAo76BtfmMfHjY
         zamr6Q7Cmk5Hts5TRVwzauUj7Xs6Ddn02S6RWSofjW7mxNMeOhjn8K+IY0pmwL2U4Kv/
         5Icg==
X-Gm-Message-State: ANhLgQ1UdVfYomRpUHjab4P8R3EgpvkSHxlADeScB4/XAQiGuHNpR0Ub
        c1p2t90L3/8mxyTW4AHsvCXOm/oBvEi0BwfI3zL/ow==
X-Google-Smtp-Source: ADFU+vtRG2ZTrHb7CXb7FLMFpUdds0tOVt2N9o3unR9wlTcKNLgyYsV64mnNuo/+Q1Bnfi60U9+WJIUiDfOg7LEc+Cc=
X-Received: by 2002:a37:b9c7:: with SMTP id j190mr1583102qkf.21.1583915225914;
 Wed, 11 Mar 2020 01:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200310205841.123084-1-michael.auchter@ni.com>
In-Reply-To: <20200310205841.123084-1-michael.auchter@ni.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 11 Mar 2020 09:26:54 +0100
Message-ID: <CAMpxmJXBN_qTwHpcD-anHVB-uhatuN-PZDUUe6boD0GoFiMVXw@mail.gmail.com>
Subject: Re: [PATCH] misc: eeprom: at24: fix regulator underflow
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 10 mar 2020 o 21:59 Michael Auchter <michael.auchter@ni.com> napisa=C5=
=82(a):
>
> The at24 driver attempts to read a byte from the device to validate that
> it's actually present, and if not, disables the vcc regulator and
> returns -ENODEV. However, between the read and the error handling path,
> pm_runtime_idle() is called and invokes the driver's suspend callback,
> which also disables the vcc regulator. This leads to an underflow of the
> regulator enable count if the EEPROM is not present.
>
> Move the pm_runtime_suspend() call to be after the error handling path
> to resolve this.
>
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> ---
>  drivers/misc/eeprom/at24.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 031eb64549af..282c9ef68ed2 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -712,13 +712,14 @@ static int at24_probe(struct i2c_client *client)
>          * chip is functional.
>          */
>         err =3D at24_read(at24, 0, &test_byte, 1);
> -       pm_runtime_idle(dev);
>         if (err) {
>                 pm_runtime_disable(dev);
>                 regulator_disable(at24->vcc_reg);
>                 return -ENODEV;
>         }
>
> +       pm_runtime_idle(dev);
> +
>         if (writable)
>                 dev_info(dev, "%u byte %s EEPROM, writable, %u bytes/writ=
e\n",
>                          byte_len, client->name, at24->write_max);
> --
> 2.24.1
>

Patch applied for fixes.

Bartosz
