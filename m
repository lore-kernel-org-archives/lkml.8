Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87987C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5753D20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DyOBHrHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgA2Ng3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:36:29 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37385 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgA2Ng3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:36:29 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so17011118qky.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 05:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3V6xmU3srA+se3hcicm5DWexrikGI8dUa+mXdjGXknk=;
        b=DyOBHrHd5BqYv9mIpfnW6WvCaFIoyTvOEgcISOB4GhL5+pTjagzqJtDyYV4OMewGZ2
         /pUGtZS5H5oenY9pX4V6gr2QbSvxuggpRlAuWiOkkHKlVM1+zQnHPwM3ho3X+99G1Md5
         71XUsAe+Uf/jdIjjfRUaluv+2kcnKl9hLaP2XvT8ynLxvYww5N0KZgG8LhXkhkR+HCpn
         SUsIoVrzHW4Drw01pRZ1fWTcGuWSpnq1VFkwinajQMSqa0aaxivhMhVtbETM4z13n3cp
         +uI3Ew5pFrK5TvwOPFJNhwkZWx6/xa6EvnCOJTG8sa4ndrJq8dFdyLwXsO0IRFI/A0ZF
         Jt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3V6xmU3srA+se3hcicm5DWexrikGI8dUa+mXdjGXknk=;
        b=RTCY5LbGtGdjMQTfbWEbokwiV5gsKs9bisg6vLwI2qkjvERRxH8sPN1BWtN+B4hsg7
         H8btgdZcwibxndXsrXXRltMEIUxhTiyl++l1fzjYDwM9wRIS0C09nfg24sqMdMZWuxUt
         Haalhh4Bi2w5QMna1xrT/bYFhWMipFMpmBYgvhQTWM9BXEZni5LjSRUs4+1OpZgIAuMX
         zLygIgGo3peDmqNgGPo/h1KGZ29JPjBYnuL3lRWAA/oEE2Ufct6faOVqgsW+l3GK/5Es
         jL0rNm11ODVUB26bSe1pCPFDWCKIuH/s0GdWadzYrIh1IlZnEm25A1zllgB04pRjVrgE
         1LDw==
X-Gm-Message-State: APjAAAU9tj9ALZKvg2MyVvOf04Lfl+YmkHVymh77OPDWxHqLJ/7LKNgc
        Cr7czpSwKG8duOocEWKldw1blXwKujTxKbVDvsnO1w==
X-Google-Smtp-Source: APXvYqxfZlmtcKRvq/YwL8Dt6Hqy3CSN0gsp5gSGv3hLHa6C1T6oKCVRnJJbvsu5E48hvFVjf2+832MwZ1IBH9CbsV4=
X-Received: by 2002:a37:4808:: with SMTP id v8mr25569122qka.263.1580304988349;
 Wed, 29 Jan 2020 05:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20200121134157.20396-1-sakari.ailus@linux.intel.com> <20200121134157.20396-6-sakari.ailus@linux.intel.com>
In-Reply-To: <20200121134157.20396-6-sakari.ailus@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 29 Jan 2020 14:36:17 +0100
Message-ID: <CAMpxmJU5dG49N2FA0oSQsOfKrCr3KQ1BisON4c+nUJJmZQG=bQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] at24: Support probing while off
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, Bingbu Cao <bingbu.cao@intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rajmohan.mani@intel.com, Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 21 sty 2020 o 14:41 Sakari Ailus <sakari.ailus@linux.intel.com> napisa=
=C5=82(a):
>
> In certain use cases (where the chip is part of a camera module, and the
> camera module is wired together with a camera privacy LED), powering on
> the device during probe is undesirable. Add support for the at24 to
> execute probe while being powered off. For this to happen, a hint in form
> of a device property is required from the firmware.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/misc/eeprom/at24.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 0681d5fdd538a..5fc1162b67618 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -564,6 +564,7 @@ static int at24_probe(struct i2c_client *client)
>         bool i2c_fn_i2c, i2c_fn_block;
>         unsigned int i, num_addresses;
>         struct at24_data *at24;
> +       bool low_power;
>         struct regmap *regmap;
>         bool writable;
>         u8 test_byte;
> @@ -701,19 +702,24 @@ static int at24_probe(struct i2c_client *client)
>
>         i2c_set_clientdata(client, at24);
>
> -       /* enable runtime pm */
> -       pm_runtime_set_active(dev);
> +       low_power =3D acpi_dev_state_low_power(&client->dev);
> +       if (!low_power)
> +               pm_runtime_set_active(dev);
> +
>         pm_runtime_enable(dev);
>
>         /*
> -        * Perform a one-byte test read to verify that the
> -        * chip is functional.
> +        * Perform a one-byte test read to verify that the chip is functi=
onal,
> +        * unless powering on the device is to be avoided during probe (i=
.e.
> +        * it's powered off right now).
>          */
> -       err =3D at24_read(at24, 0, &test_byte, 1);
> -       pm_runtime_idle(dev);
> -       if (err) {
> -               pm_runtime_disable(dev);
> -               return -ENODEV;
> +       if (!low_power) {
> +               err =3D at24_read(at24, 0, &test_byte, 1);
> +               pm_runtime_idle(dev);
> +               if (err) {
> +                       pm_runtime_disable(dev);
> +                       return -ENODEV;
> +               }
>         }
>
>         if (writable)
> @@ -728,8 +734,12 @@ static int at24_probe(struct i2c_client *client)
>
>  static int at24_remove(struct i2c_client *client)
>  {
> +       bool low_power;
> +
>         pm_runtime_disable(&client->dev);
> -       pm_runtime_set_suspended(&client->dev);
> +       low_power =3D acpi_dev_state_low_power(&client->dev);

This is inconsistent. You define the low_power field in the context
structure (BTW the name low_power is a bit vague here - without
looking at its assignment it would make me think it's about something
battery-related, how about 'off_at_probe'?) and instead of reusing
this field here, you call acpi_dev_state_low_power() again. Either
don't store the context for the life-time of the device if not
necessary or don't call acpi_dev_state_low_power() at remove, although
the commit message doesn't describe whether the latter is done on
purpose.

Bartosz

> +       if (!low_power)
> +               pm_runtime_set_suspended(&client->dev);
>
>         return 0;
>  }
> @@ -743,6 +753,7 @@ static struct i2c_driver at24_driver =3D {
>         .probe_new =3D at24_probe,
>         .remove =3D at24_remove,
>         .id_table =3D at24_ids,
> +       .probe_low_power =3D true,
>  };
>
>  static int __init at24_init(void)
> --
> 2.20.1
>
