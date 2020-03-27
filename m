Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08F6C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F3A20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lahDEBVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgC0Vhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:37:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37875 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgC0Vhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:37:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so9097538lfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6P/ugUG8QPN1PLqi6CLq7SxjX8NFnDCuavJA3Wde1E=;
        b=lahDEBVq+V7MEitEv24mEfdDx+ECSXtHN+KA62Gf5ItiJ1T+tDT8IWT4Oy22V9BsXC
         6JaUyn62gDbbeAweC22pKUYqIidnovzsnM7DZS/3dAC/3/rSk5L52uSrG8+ZEpNokRoF
         DAcc3GvLOC/ssSMB8MQ5gqL2f74Gp6tRux0EURwEZRovg6fD33++EMNMJHG8TpO81M7J
         Mt83QcXquqLJVR9ORbRpZm1ECFmS406DJdA7rkOGaLuwywkPfYQtd7G56RMATPaHmnNG
         GJdQYRUgmxyx9hZzmpIXWlpouQK7AOtyGExNg/CAyJqJkZU/svLfvM9MdHzKmMqw3M9X
         2vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6P/ugUG8QPN1PLqi6CLq7SxjX8NFnDCuavJA3Wde1E=;
        b=YrcsuEafmz5xr+MEMlUcupvx9rDLiSE06CrCR0Ty2tWCnK9G7cvhutGVEE/XZX7CPr
         keBOB8Rtk9AyIjDXrJMKvwyhvq6DRLA+ystiSdwTJ9cJcu2Kc3TW8s6F45HqkHMjqmqr
         X4LaZ9mE2JcLPZ2GOMobTpzrkfiqVxJ4uSNFy+TEZ+7Db47Sle94GMFfcAK4OpHMMj+L
         YGSKM4EVtMgEcjQHmVIW/ijaeqsztrOUl6HzurK4bhaSkOrEaw3cItPJtZtDXMZ56CsC
         Za2PUkdrIxPXgW1c/d2k+6mRgTQ9LPtCR4luLeFtkokycM+l1qF/qwrIYOItyd6F+/fV
         YjvQ==
X-Gm-Message-State: AGi0PuZj+/G3QJYwCf6yJm1L0kMfyqJtSz/43n8OGdnkce9jTKsHfNPC
        6cS/OIzDbXrqPs8X5Wd/SNv8+aiqu/A5kFiC7HQM1Q==
X-Google-Smtp-Source: APiQypLBRjm8m9TRh5E1Wf02gWdM2GuN6ua450wAQk3DBPj55sqZgue9A3EKHJXEe1wTh5T/OQvRR8bY8YYI7pRonwA=
X-Received: by 2002:a05:6512:6c4:: with SMTP id u4mr806577lff.89.1585345054013;
 Fri, 27 Mar 2020 14:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be> <20200324135653.6676-5-geert+renesas@glider.be>
In-Reply-To: <20200324135653.6676-5-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Mar 2020 22:37:22 +0100
Message-ID: <CACRpkda8Uc7fDbV8EsG+EpDGw35-k+9-U7njhaaQVvhY5rwmcg@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] gpiolib: Introduce gpiod_set_config()
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

On Tue, Mar 24, 2020 at 2:57 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The GPIO Aggregator will need a method to forward a .set_config() call
> to its parent gpiochip.  This requires obtaining the gpio_chip and
> offset for a given gpio_desc.  While gpiod_to_chip() is public,
> gpio_chip_hwgpio() is not, so there is currently no method to obtain the
> needed GPIO offset parameter.
>
> Hence introduce a public gpiod_set_config() helper, which invokes the
> .set_config() callback through a gpio_desc pointer, like is done for
> most other gpio_chip callbacks.
>
> Rewrite the existing gpiod_set_debounce() helper as a wrapper around
> gpiod_set_config(), to avoid duplication.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v6:
>   - New.

Patch applied in preparation for the next kernel cycle
so we get Geert's patch stack down.

Yours,
Linus Walleij
