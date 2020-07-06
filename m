Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA37C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECAD206DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JMDq9eXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgGFRQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbgGFRQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:16:12 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EFFC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 10:16:11 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x62so29545547qtd.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=45tIWdm+dVxESjLr3PMmxKwleOkKwq9BzEXHEaJCoao=;
        b=JMDq9eXgXHSz9XSGQQAFTayjYJyh/tUQl1//Q4SkgSjvcQN/7UUCIntCwRNQVTaFQY
         sCCXXuilBV9Tv6o/mG+3Gs1hC3f4BRXmR1pSXMhK5BQGI4VXuqDSKW8dRkt2GEav9JZw
         QzhyGUa8yyPyHGv/5tqIFV1mJ+b2J8Dvb9Kgj3zNuF2GflY6G7LyEq9lRczsYAjg/3+/
         0qdkOLT2W639EfXwFIJBqYn+2WcY1BlcWhngpTd1oHh9BPaX1UPFmc/2fyXvDqF1+E8N
         MIJbH5tMcJA0avlrJV+MTID4JbeNr3+ksEItenYFf9G2jqy5RA7tkBx83MWTCnbpWxgt
         Rsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=45tIWdm+dVxESjLr3PMmxKwleOkKwq9BzEXHEaJCoao=;
        b=mYFKzNE+PSlgCmKNObPkJMDEHDLvMW46RQH8+MWQ9Bn5MODZLmoR3C6hWyv++DjZ5c
         IBNMvB3fFiUP53aPKAx7hJGueYe73mgLrggiyMcxKSn0ELBKocxLvbecnLq6QhPzMSy6
         YP2cPRpbuBpn9c3M6JqUEGwIC+VkQThQx1v3mpdMPaVPaTyyKm9CPN8tIvieg+/u9t8c
         8AKjTuDc0X6kzw0dk/iBch4+zr2tIKuhFPBfyo6Lbq2Nb0wtVLuKcT2TCR8BPq1/Gq9r
         4sStm0+rVmmCSaUgGY7UM2KvNmX1BqilVpMBdCiRXElfvTLs0JGZPoVpQ6PKk//3niKL
         hK3Q==
X-Gm-Message-State: AOAM532X3qA+j7xPBejb6fojSgB23iqUDUtctzKofZJirok9/zQeGcaN
        JA8zoYqp7zUPj2H3PxJ+gY0Nn8QdqVyExDa4xjsqXA==
X-Google-Smtp-Source: ABdhPJyO73KvUDsn/Tc1RQWALC7DpTQJfJo+SXyquB51RqmZRw6Pyb4IInF6wxz/MkxuF3xyg0XayJvSgCNmnp6HDWQ=
X-Received: by 2002:aed:2684:: with SMTP id q4mr49474415qtd.208.1594055771190;
 Mon, 06 Jul 2020 10:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200701083118.45744-1-lee.jones@linaro.org> <20200701083118.45744-27-lee.jones@linaro.org>
 <20200701093616.GX1179328@dell>
In-Reply-To: <20200701093616.GX1179328@dell>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 6 Jul 2020 19:16:00 +0200
Message-ID: <CAMpxmJW0q5nHtz=Td_8EiLnnO3H-+047bVE1aCByqj8J2Ldm8g@mail.gmail.com>
Subject: Re: [PATCH v2 26/30] misc: eeprom: at24: Tell the compiler that ACPI
 functions may not be used
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 11:36 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> ... as is the case when !CONFIG_ACPI.
>
> Fixes the following W=3D1 kernel build warning:
>
>  drivers/misc/eeprom/at24.c:228:36: warning: =E2=80=98at24_acpi_ids=E2=80=
=99 defined but not used [-Wunused-const-variable=3D]
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> - Resending to add the I2C ML and Bartosz to the conversation
>   - Looks like I missed them when running get_maintainer.pl
> - This patch, like all the others in the set, should go in via Misc
>   - Although the patches are orthogonal, this makes life easier for Greg
>
>  drivers/misc/eeprom/at24.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 9ff18d4961ceb..2591c21b2b5d8 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -225,7 +225,7 @@ static const struct of_device_id at24_of_match[] =3D =
{
>  };
>  MODULE_DEVICE_TABLE(of, at24_of_match);
>
> -static const struct acpi_device_id at24_acpi_ids[] =3D {
> +static const struct acpi_device_id __maybe_unused at24_acpi_ids[] =3D {
>         { "INT3499",    (kernel_ulong_t)&at24_data_INT3499 },
>         { "TPF0001",    (kernel_ulong_t)&at24_data_24c1024 },
>         { /* END OF LIST */ }

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Please, drop the "Re:" prefix from the subject next time, I nearly
missed this in my inbox.

Thanks!
Bartosz
