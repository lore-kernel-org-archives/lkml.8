Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB89C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC22420659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D5XU9GqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgBEJ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:28:09 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42044 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgBEJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:28:08 -0500
Received: by mail-qk1-f193.google.com with SMTP id q15so1122345qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 01:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DOZKl+jyEdXIGkIdajoySMy9zPjKLhC/a+xIEBxsxXk=;
        b=D5XU9GqOuZEqsknkmoU2UyU2VefkTcVHdwhwVIPs7ODqU9wNN7pRKXhw3iHDkie6oG
         v9Z/loMI+UMoe0sLdFMFZtAhZEXWa71Mfkg2I2MkwtbiwT6a0tPPTh0gIf8wwZ2mR/a8
         OG7JYIO+BfBRD63Uoztt26mRNhfOE3QE2Rz+jaEO3alMe4lF1np+h6OyHx55mGCegb2T
         KUzLXrQGWQOdtzPSmE/iEgm1zjByFo+fuJte8JQcDTrv4q0dROC3EO9EO0k1iYydULaJ
         C94eSApcv3N3I5lczlx4qYqZiPPf3WVk89/mvV72mpP4J49uA8n40gDnzKISaYm1RT0V
         JNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DOZKl+jyEdXIGkIdajoySMy9zPjKLhC/a+xIEBxsxXk=;
        b=jZ62IAFNB/kzJvMWzV2SawQAxP3ee3+zpJ6rsD2VsqtWK3AzYdyb+UUB1QWhztcnjI
         fJhmTqqGP41oYQMA6EXOuUYUqfQ5CfADDLefiSwRsrqMHowuwUiWwUL7n5VlH8CZfvoW
         USJVt+s/3wzO5F6RPaBLXgli6ZL5NusW9gYBJNVyzP72J1OtS9mpLq+7iB+JS2jqNU1F
         tp3tl/U+Mj6BdlEsWLa8TGhAnpoh8bL8HudJW6MFBTeZ0hSQhJDKb6nPzR+/OPFigv/T
         p1PJjnWOCQdIMOfa4EcbD3uzuZi0IaFGeLp51tU608OAeScV9Y5ikNfRvjad270u1Hl2
         25yg==
X-Gm-Message-State: APjAAAX0mmkvML4MNReeCq2O16sAucv4WNJLhL7KOfX6fBzRc+SMXpi0
        kdEmPaW/LQO777NCMuKwG/DR2BRdVU2SSvK6h0q0+g==
X-Google-Smtp-Source: APXvYqxkQh8e7zfg1X10X24Oj6Q1KGfQ1s+5IdP/481BmZM+/zl1XxSjzuCkRa8x4WiFbPJjlcmM64CyjYN2Hb+PWTc=
X-Received: by 2002:a05:620a:11ba:: with SMTP id c26mr31801616qkk.323.1580894887619;
 Wed, 05 Feb 2020 01:28:07 -0800 (PST)
MIME-Version: 1.0
References: <CAF=tPv+iL5JSO2NLG0X7EQjcP0rsxXoTPCUZkznh7PmAcR4c-g@mail.gmail.com>
In-Reply-To: <CAF=tPv+iL5JSO2NLG0X7EQjcP0rsxXoTPCUZkznh7PmAcR4c-g@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 5 Feb 2020 10:27:56 +0100
Message-ID: <CAMpxmJXquoGYUKnwWUV+tDUx7YA0aFqoKqneELDdWj7nyW5Q+Q@mail.gmail.com>
Subject: Re: [PATCH] GPIO: it87: fixed a typo
To:     Sachin Agarwal <asachin591@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 4 lut 2020 o 17:17 Sachin Agarwal <asachin591@gmail.com> napisa=C5=82(=
a):
>
> From: sachin agarwal <asachin591@gmail.com>
>
> We had written "IO" rather than "I/O".
>
> Signed-off-by: Sachin Agarwal <asachin591@gmail.com>
> ---
>  drivers/gpio/gpio-it87.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-it87.c b/drivers/gpio/gpio-it87.c
> index b497a1d18ca9..79b688e9cd2a 100644
> --- a/drivers/gpio/gpio-it87.c
> +++ b/drivers/gpio/gpio-it87.c
> @@ -53,7 +53,7 @@
>   * @io_size size of the port rage starting from io_base.
>   * @output_base Super I/O register address for Output Enable register
>   * @simple_base Super I/O 'Simple I/O' Enable register
> - * @simple_size Super IO 'Simple I/O' Enable register size; this is
> + * @simple_size Super I/O 'Simple I/O' Enable register size; this is
>   *     required because IT87xx chips might only provide Simple I/O
>   *     switches on a subset of lines, whereas the others keep the
>   *     same status all time.
> --
> 2.24.1
>
>

Sachin,

you're spamming the list with these patches. This is I think the
fourth time I see it without any version change and still with a wrong
subject message.

Bartosz
