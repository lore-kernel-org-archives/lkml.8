Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96465C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A45A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0HCE20cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgFOIHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgFOIHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:07:16 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A6CC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:07:15 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id u17so11924508qtq.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vBzkHQlUwNAKecOw5worB4oaU4+t5XgOuetCS8fy4xw=;
        b=0HCE20cZGkuIwMcp/lz/00XZljW2XEyhB3Z82BIBuS/JPlnHoQqMuTSqVDF2TrmdtY
         ftrlj1aZ5tb+IDbDfdudEYv48TVoouxw9a2DqiZRJ+g6CIuMYJojNi+1OfPsAivMrWwd
         JhDrUvY8FuBfDZ2QfshHQvYMoQJPfEVPLcGGBD7a+gmHU3syS5c5QeE9P4mwVTh627et
         tEGs8NPttHYYqYKfj+B7FbuUjSarvnFEZLbmM0T6n6V9dbwjRmThUSwL+c+dPK4wXgH5
         KBuP4m0BnJDWAiATNhYfBoxWm4vdXLJRAD5pJyHQDD2O6ODvCPMEXGEoseZaKvzqj6F/
         StKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vBzkHQlUwNAKecOw5worB4oaU4+t5XgOuetCS8fy4xw=;
        b=T+JTB2I+YgxnCWgEZSJP18V88CMEY7KQc84J+Fyb4xzDzLm9bFP0ALXQS88K6+8Bb5
         APG/cK0tmV37v2kd2UxhQK4LKcVOXlyf4IkGwCSc00Oy8zjcPlFzFaS8DT5TTQ5BDQCi
         mRym2mfPC7ic2/O8yehSx6/Mt9HM+LbmRR3Z+GAbb5t3EiVRKAVPfvHXHLtx/vS5gPX9
         PwbnU9TbR2qov4YoT+4887D18lb4sf2HaqDeErK6vS7N0KDKgLswRW2sTGOR3ZBsR/Rc
         eRnc9E9aXsaADwPXDl2TV0cnAI8EV8q0sv8LcZPtmcr0tp/nN9XTUKWOk3yAH/XAzoWs
         dwLg==
X-Gm-Message-State: AOAM5319j/xFea877BvqOieKaa0krvkgmUdR1mbzTjvmvmnaoR3KgYNt
        mgLlozFw9xEPzpQw5J8iTD0/dEEULmlxyUpqlBUTXQ==
X-Google-Smtp-Source: ABdhPJx9Qqx9M5g6QH85LC2+JvGtPaEH/e5Mu1JucgvCN1amgjGhgTI8taMjFjSeSSmIAPFNXsz11PUVMXfMp48SL4E=
X-Received: by 2002:ac8:38bc:: with SMTP id f57mr14972204qtc.131.1592208434926;
 Mon, 15 Jun 2020 01:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <53b5504b-dd06-c1d5-5334-d4c5525eca93@web.de>
In-Reply-To: <53b5504b-dd06-c1d5-5334-d4c5525eca93@web.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 15 Jun 2020 10:07:04 +0200
Message-ID: <CAMpxmJWgb_s2QgSsdw8_8gTF+hQSLHiXNMiu1-wj3Bct7L5ceQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: Add support for the PCAL9535
To:     Jan Kiszka <jan.kiszka@web.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 13 cze 2020 o 16:44 Jan Kiszka <jan.kiszka@web.de> napisa=C5=82(a):
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The PCAL9535 [1] is compatible to the PCA9535. Additionally, it comes
> with interrupt support and input latching. Other features are not
> supported by the GPIO subsystem.
>
> [1] https://www.nxp.com/docs/en/data-sheet/PCAL9535A.pdf
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 1fca8dd7824f..34d635e51dda 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -1131,6 +1131,7 @@ static const struct of_device_id pca953x_dt_ids[] =
=3D {
>         { .compatible =3D "nxp,pca9505", .data =3D OF_953X(40, PCA_INT), =
},
>         { .compatible =3D "nxp,pca9534", .data =3D OF_953X( 8, PCA_INT), =
},
>         { .compatible =3D "nxp,pca9535", .data =3D OF_953X(16, PCA_INT), =
},
> +       { .compatible =3D "nxp,pcal9535", .data =3D OF_953X(16, PCA_LATCH=
_INT), },
>         { .compatible =3D "nxp,pca9536", .data =3D OF_953X( 4, 0), },
>         { .compatible =3D "nxp,pca9537", .data =3D OF_953X( 4, PCA_INT), =
},
>         { .compatible =3D "nxp,pca9538", .data =3D OF_953X( 8, PCA_INT), =
},
> --
> 2.26.2
>

There should be a corresponding device-tree bindings change in the
same series but in a separate patch.

Bartosz
