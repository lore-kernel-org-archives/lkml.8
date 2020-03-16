Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607B4C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AFF20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xCBTTjg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgCPJ2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:28:51 -0400
Received: from mail-qv1-f43.google.com ([209.85.219.43]:41083 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbgCPJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:28:50 -0400
Received: by mail-qv1-f43.google.com with SMTP id a10so8403017qvq.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SlnHcEUyAXhhBJTuxvcx5n9cVWT6MWBEtfmnj6NVAkw=;
        b=xCBTTjg7+2+l/sXdvcUuVTjFgeY15EPF67ZSsmNlr0RbLQ6WG2awltClbyDNN9qsWc
         LJIZ9jy8TF6sDix0G3908K3ARc/4Zgc+HprhfUnODXb8Ca89J/I4OiHyc9kJ7jHy4fxk
         LNJokixn3Cp1xu27cWtiOURlz8CG7UEkcnACaW1xl0DSids4SVm8AMlACzlS5qNtSTu4
         dFd/aANQ/b9daRAajrSwTv2R786pJwT0sStgYdWbC4bZqSOCePowSnIgFy8d93Twst8g
         DWja+bf9MDG/MCKQT+3X21tuMC37OUZ/cDuU7q/O0E+praW5C1xSCBJB1+nLBURttyym
         mElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SlnHcEUyAXhhBJTuxvcx5n9cVWT6MWBEtfmnj6NVAkw=;
        b=n11AbNBMs7Xt5GPywyTHAl5It/EBU18k+9PsX9OXL8RGDMA1abmeiDoUNdMtxk+bLR
         t0fEXRqewoMJ9mKECl8Hds0s/ulwozBmUcyjTyEvgEK4EevTKzLMyRGa5Rb2ceEQwFY/
         HStTiiWGqz4Wjb9KBBWKOn2G0yCmaBBhZ9juQIRqzObShi8C5vUtr/Mfgdf+bIvekdkI
         WGhNKUxuSdTSJuqoV/YnYJxeYoTridCBOs/Gt3RuI5fVZEceUPRMZLq4hUeNkleT7s5j
         NuIaOKtxahsS13JkzCl+WCJhBIe9aw8Y/yl05lS1on41fmxK2oWllvV2LN+7dfudk1pq
         ggng==
X-Gm-Message-State: ANhLgQ3c3WofdUP+dKXusAm6sTezqgogxJwWIyt2Pj4TG1YI60eCrDND
        bGK8+bTeLlTCWicub3pKqjSco44lRFNSa4gavKw+wA==
X-Google-Smtp-Source: ADFU+vv9/MKP80W+Vi0dxJrqEXaWFhKiMZB6p3ZHnw6LAmw7NOyop46daJwcHltOfC98RD2Mcmpi+oZ9pXy6EOej54A=
X-Received: by 2002:ad4:4a6c:: with SMTP id cn12mr21012782qvb.148.1584350929335;
 Mon, 16 Mar 2020 02:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200316092340.114125-1-colin.king@canonical.com>
In-Reply-To: <20200316092340.114125-1-colin.king@canonical.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 16 Mar 2020 10:28:38 +0100
Message-ID: <CAMpxmJVxPzH1rhfKrGMHWAyKiPAy3CSx9xJqjw-2nKzy=-8ccg@mail.gmail.com>
Subject: Re: [PATCH][next] tools: gpio-hammer: fix spelling mistake:
 "occurences" -> "occurrences"
To:     Colin King <colin.king@canonical.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 16 mar 2020 o 10:23 Colin King <colin.king@canonical.com> napisa=C5=
=82(a):
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in an error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/gpio/gpio-hammer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/gpio/gpio-hammer.c b/tools/gpio/gpio-hammer.c
> index 083399d276e4..28d2329e83d2 100644
> --- a/tools/gpio/gpio-hammer.c
> +++ b/tools/gpio/gpio-hammer.c
> @@ -153,7 +153,7 @@ int main(int argc, char **argv)
>
>         if (i >=3D GPIOHANDLES_MAX) {
>                 fprintf(stderr,
> -                       "Only %d occurences of '-o' are allowed, %d were =
found\n",
> +                       "Only %d occurrences of '-o' are allowed, %d were=
 found\n",
>                         GPIOHANDLES_MAX, i + 1);
>                 return -1;
>         }
> --
> 2.25.1
>

Patch applied, thanks!

Bartosz
