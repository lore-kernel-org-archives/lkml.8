Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682BEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B3820726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="c8z+98Nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBGTpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 14:45:24 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34155 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGTpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 14:45:24 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so832451iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 11:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lPYHWB1clo/zt5lx0lgH0H2d974i2DzLaBDz4EaGRF8=;
        b=c8z+98NjP4L+ykxX8U06pwkB7VD1RmMWX/Wp/g6Y8MdIoarhI6g3jhrfPuVqpmaa+/
         BmNJVlGh3DIO2OsJyVTThP5j2ZzBlgKz4InQBznBp3KIXPZsHoCnjSBrBiXRB58m5OH8
         su4MYFV+hdopRXpfIkOTp7MxcJhgOYl1GgGBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lPYHWB1clo/zt5lx0lgH0H2d974i2DzLaBDz4EaGRF8=;
        b=Z6ldLt1F3u+2ULChUCdjcCDVXVFikjBOsi5qyTjJ7pjVbPOv1cT7f1yW9pRs5nIPT1
         0ghFdL+XuUaRpqUKI3VFcFOLQj19SL5dpNSXB6XbEXwE4sPsWN1Zlc7bzyGR9Gxv3/HA
         VwpLyysK0mP9XMZdkPOgTRLfRsxN3yoHjbV81tq/na1af3m/y0OqfSLcNDP8FwklbdCH
         3x1ooqU7F1q7RhpPDlhx2pOycXknd/bKdHrczd/+obuocW33LsRxC9XKPXuCP1+Q9BEA
         e/qM2FqCm23Yk0zmNQl8ORKR0FWDEH8jgf/s9ii6xVAXmTKKY6Ha1xcf+MMjJryMkiN3
         B52Q==
X-Gm-Message-State: APjAAAU0Gml4uQzGvqxriTC6eiyUzNGIgDLSQngzoXCBToWPrljfAjG0
        FnR5tQFkK0dawzgcs0nCxNzpNmyx8nHwljFfv9xlnw==
X-Google-Smtp-Source: APXvYqw5uwAkn33O9wLLDDnI9SFctWgc3sYeTPDCRMkhYPJlzb3CFnceG1Cmvj9Ijpygjy1Je0NxH79gDV/y2sIkoyM=
X-Received: by 2002:a02:ce87:: with SMTP id y7mr148364jaq.26.1581104723318;
 Fri, 07 Feb 2020 11:45:23 -0800 (PST)
MIME-Version: 1.0
References: <19efdcd597b21ece9ad0ff894b6566d2ef4e2c02.1581066317.git.agx@sigxcpu.org>
In-Reply-To: <19efdcd597b21ece9ad0ff894b6566d2ef4e2c02.1581066317.git.agx@sigxcpu.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Fri, 7 Feb 2020 11:45:12 -0800
Message-ID: <CAJCx=gmoX2NO_AQKX_MddYAB7uVyB2OTDSSJE1yLb7Y36QMntA@mail.gmail.com>
Subject: Re: [PATCH] iio: vncl4000: Fix early return in vcnl4200_set_power_state
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 1:12 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> Don't return early unconditionally.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

>
> ---
> I've not added a 'Fixes:' line since this is not part of Linus tree yet.
> Tested proximity and ambient light on a vcnl4040 and checked the driver
> suspends/resumes correctly and puts out valid data right after resume.
>
>  drivers/iio/light/vcnl4000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 3b71c7d538af..38fcd9a26046 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -149,7 +149,7 @@ static int vcnl4200_set_power_state(struct vcnl4000_d=
ata *data, bool on)
>         if (ret < 0)
>                 return ret;
>
> -       return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,=
 val);
> +       ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1=
, val);
>         if (ret < 0)
>                 return ret;
>
> --
> 2.23.0
>
