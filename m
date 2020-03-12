Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F04C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8B620650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hlXc9bv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgCLOVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:21:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45107 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbgCLOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:21:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id e18so6621650ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79OHKgNVg5IiTjP/EryhR/on7yjmd+OeOqFhBOB19Rg=;
        b=hlXc9bv7wKtJYos/CvmIf1aWytTx7tjjvZA7MyZXi7udPi5CdammboSrae1hgCitp/
         MSpq1qvYRN9mFEXkFN/xNTTmmao3V3GjlW0KxdQXRUqYqGp5IwObLZ7yB+renP8z+pfN
         tTWRkIMDIS1GZe95+PfMemVe3rr1Kwnkd636g3iGRWP+yiHdYGH7FrFNCkkgIeRsEdxg
         L1z1MSWPXkvi5ST+LYKisjEtlJI83foQzqkY8AUQk+nrdOaavjVDuTxl3sWpnDBKyxpA
         I+Y+/KkkggsGEGEO3b8x79C2+nvBFhV0SVSG0v4dMd8b9iZmSihZqNyIYhxl61ZhaL+L
         SMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79OHKgNVg5IiTjP/EryhR/on7yjmd+OeOqFhBOB19Rg=;
        b=EvTMv+P4uuTVWdoSNhzI6VhDDuVQu7M8H8KjNTtxfpDNSzQYFjvcAt1NHUrK9H3XlI
         GQQsOBCMg9zRiw2VWSheK6uUicVq6metFN3APSyhPU6qrv9AeWO1+DBJwdrhAfKN+m97
         3O5UIWptWKvDY/h+PS2LzRxlI1N+GR6utFa4QV4Edcx9tWrA8SqJ6U5F10GABSSf4ziL
         u5/DdhtznWLfpL9dOVrD3x3Z9r17gYW3ViD38Xh8FqV+ocYp4H/HRiQIPFr9b7aegT8d
         Eo0X3B0BW50fToajNzilweWR1wB7z8izCf2j7oJFTtARxi7pfYjvZKI0cLWOKPGZMFth
         hgAQ==
X-Gm-Message-State: ANhLgQ281yN3WR9WBLH2yKDaPdsnkKiFiUheNiI7rGrLrW85JjX6AwCb
        h+x990VhYgFsDtLKPtdayNg1qfxfHvdYXqiHEkLQRQ==
X-Google-Smtp-Source: ADFU+vtcIZFKaUxv+zzMf8n7cOQduYtCadrIv8wfIOW4HDImubBu1ngGLVdiQB+7d6huEorOiDcjWc0JqvkBbK9RrNg=
X-Received: by 2002:a05:651c:2c1:: with SMTP id f1mr5239338ljo.125.1584022905409;
 Thu, 12 Mar 2020 07:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be> <20200218151812.7816-3-geert+renesas@glider.be>
In-Reply-To: <20200218151812.7816-3-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 15:21:34 +0100
Message-ID: <CACRpkda1JAnC=Feb39GeKEEP6q8Qwpsth6J+4OKj6A8S3YAUyQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] gpiolib: Add support for GPIO line table lookup
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Alexander Graf <graf@amazon.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Reid <preid@electromag.com.au>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

I'm sorry for the slow review, it's a large patch set and
takes some time to sit down and review, and see whether my
earlier comments have been addressed.

On Tue, Feb 18, 2020 at 4:18 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Currently GPIOs can only be referred to by GPIO controller and offset in
> GPIO lookup tables.
>
> Add support for looking them up by line name.
> Rename gpiod_lookup.chip_label to gpiod_lookup.key, to make it clear
> that this field can have two meanings, and update the kerneldoc and
> GPIO_LOOKUP*() macros.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
> Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

I will try to understand why this change is necessary to implement
the gpio aggregator (probablt I will comment that on the other
patches like "aha now I see it" or so, but it would help a lot if the
commit message
would state the technical reason to why we need to do this change,
like what it is that you want to do and why you cannot do it without
this change.

Yours,
Linus Walleij
