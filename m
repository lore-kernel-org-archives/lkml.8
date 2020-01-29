Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3991C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FD12064C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZAUxhz2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgA2K6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:58:01 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40316 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgA2K6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:58:01 -0500
Received: by mail-qv1-f65.google.com with SMTP id dp13so7779326qvb.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 02:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yKxyrAqGl7a1R1/QWH220u/1bHE8u+OV8pB8+E2QnoU=;
        b=ZAUxhz2q84lWZNe6eqKXYuhQ2pZLEJLlWMxIVzuqpzo1K6iNl6ACmX0USKBVw7SVxd
         nFFAlW6Pj9k/0p8NpA1qFYsEw9jln84XRktiXsfnOkXdnYIHMjCb0Bn7FtpWrjtBKu0L
         2iX8KEegZC0odj/pBTThDpYffWA+MDPaExdWnhwKya74njWpwsz8AlP7B5k8cT1T9JHA
         IrHs9Zj06oLxul4hddgSmeBaVp4ohkUn9XNnB1i7BB5act+fKRO1QkYneT6AXaFxrCSC
         9RuR/X0Ye+uYu2yeFllIYArbhLR/I5HvnuePPMCTSfpW03dT4RKhKGXQDnPkm3hHws/+
         nRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yKxyrAqGl7a1R1/QWH220u/1bHE8u+OV8pB8+E2QnoU=;
        b=sTtZNOZwYmCxhk0zqhqkGUeNRmvRQJYMCfGFMoGGP8q3Xv7sB6tk1qbQ3Jep+ygpmf
         0t7kCv7Ukou7w7tuVm5TcoFmO4RCmdFZWgCS2buelSyN4BtfYemllPXt7RnwMFA2HsMc
         +xrPntc5ciHrk4JXQihPuvzS76RcAeFchaL6FglL4GwWsQJoA2Ril9gwoFBywSEs0U4E
         3COEXfjSfkLfQEyA50XsXJYz7zfQ+t0obD5tnB1iBCnRLfKPqTllaNDfrhMG5BkKHrYB
         LK3Ii7B+hOEg3j7X9nUUzQ7g6UHiMRcTMUuHAFwbR5FEZMm6RLaBljyxeFygIlsAYudP
         908A==
X-Gm-Message-State: APjAAAUvyk0UyuHLdPY5TzxnhUeTULe5cUTuPwMeztKW7RqPloULo+5A
        eF/SOrQje0YxH5biqkGZzuP6jOuhtQoJkvNVuGqQ2w==
X-Google-Smtp-Source: APXvYqxfaDAmsIuN1bvsnJEHcFFsZdR29dZd8O6D8f6FJk3JFeFujCb48q3cbymyjef5xyaYHGCPdYxE9FQsmG8jOjY=
X-Received: by 2002:ad4:446b:: with SMTP id s11mr27014935qvt.148.1580295480158;
 Wed, 29 Jan 2020 02:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20200127103541.6975-1-o.rempel@pengutronix.de>
In-Reply-To: <20200127103541.6975-1-o.rempel@pengutronix.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 29 Jan 2020 11:57:49 +0100
Message-ID: <CAMpxmJVa4aWt+dyCEsNyTzppbCO2zs6mAESWLD773AVUDPG-cg@mail.gmail.com>
Subject: Re: [PATCH V1] eeprom: at24: add TPF0001 ACPI ID for 24c1024 device
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Markus Pietrek <mpie@msc-ge.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 27 sty 2020 o 11:35 Oleksij Rempel <o.rempel@pengutronix.de> napisa=
=C5=82(a):
>
> From: Markus Pietrek <mpie@msc-ge.com>
>
> This ID is used at leas on some variants of MSC C6B-SLH board.
>
> Signed-off-by: Markus Pietrek <mpie@msc-ge.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/misc/eeprom/at24.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2cccd82a3106..1c8e2ff96d9d 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -228,6 +228,7 @@ MODULE_DEVICE_TABLE(of, at24_of_match);
>
>  static const struct acpi_device_id at24_acpi_ids[] =3D {
>         { "INT3499",    (kernel_ulong_t)&at24_data_INT3499 },
> +       { "TPF0001",    (kernel_ulong_t)&at24_data_24c1024 },
>         { /* END OF LIST */ }
>  };
>  MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
> --
> 2.25.0
>

Looks good, I'll queue it for v5.7 after the merge window.

Bartosz
