Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A941C4BA11
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0278624683
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="giOc/T0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBZK4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:56:13 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38863 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgBZK4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:56:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id i23so1909649qtr.5;
        Wed, 26 Feb 2020 02:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3j9UKE4CU10RkojeSW3IlQzPeeFXpX/sxvomC4elck=;
        b=giOc/T0TXl+iIxlOUYfUQ+tWKJrb3RxKjhDveWCkvkLIVtnsOdxkcnt0ESXCKSc1TS
         FiRS/OcFWkNbN6ZZbnISyj+Gcaq5JHAlfQbkSUkEMT/fl1OcnIu7vgqbMCuNMug80vmL
         2PWczE+el7IRqrtvshhUbc5PCoiYZhO9GfaNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3j9UKE4CU10RkojeSW3IlQzPeeFXpX/sxvomC4elck=;
        b=QWMe8gzpbX46W/bxvfxqStb91a0x6en+6L2NfsiULecyz0/gVj8x0rRo3K+ED9pxAJ
         CtpBnxhyN8TRrQ6U6pCO21zKTYZqM5m6iyvKnF+7DSq6EXWF1oAH0vngkVNf5TJe0ej8
         0iCS2wiIsXsl0q5uQK9+TQmdcXrhlmEI2piH+7XLl6aIPzRTuQE8koG4IGDcj502YQV2
         35cX7O5ysotcWYaJj0hAPwAMzCQhVJai860MoHAx+4oBVBNB0347O3ooLa9Zp+y8oeri
         ficTy342EKLQ0zDtJEkqOZgMGPrH16u1g4eSs2CwMbDMFv1ybvncMngcuwW+70M9CX0v
         s/sw==
X-Gm-Message-State: APjAAAXZ94T/MUcLiAG5oPTFspBRGAx/+PHPFyNfxBX2Ixb78el+51OQ
        CcTBAGBwx1+Qm14zqMp1xWtMMfKib2K6EVkC47E=
X-Google-Smtp-Source: APXvYqzIPt5oXV3k/5jmxtXuEfikPuiPbXvjlG9fRqNJ2BaeGuQJX0lMhbp46aXUXmxRSrxBf1S4ddt08lc8oggcF+8=
X-Received: by 2002:ac8:1ac1:: with SMTP id h1mr4525735qtk.255.1582714570954;
 Wed, 26 Feb 2020 02:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20200220055255.22809-1-Ben_Pai@wistron.com>
In-Reply-To: <20200220055255.22809-1-Ben_Pai@wistron.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 26 Feb 2020 10:55:59 +0000
Message-ID: <CACPK8Xf=t+PY42qxF9jProYGGZZJONb=H1D4xZJc7teFWJ2FrA@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: mihawk: Change the name of mihawk led
To:     Ben Pai <Ben_Pai@wistron.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangat@tw.ibm.com, Claire_Ku@wistron.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 at 05:53, Ben Pai <Ben_Pai@wistron.com> wrote:
>
> 1.Change the name of power, fault and rear-id.
> 2.Remove the two leds.

The patch looks okay. Why do you remove the other two leds?

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
> index e55cc454b17f..6c11854b9006 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
> @@ -120,35 +120,24 @@
>         leds {
>                 compatible = "gpio-leds";
>
> -               fault {
> +               front-fault {
>                         retain-state-shutdown;
>                         default-state = "keep";
>                         gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_LOW>;
>                 };
>
> -               power {
> +               power-button {
>                         retain-state-shutdown;
>                         default-state = "keep";
>                         gpios = <&gpio ASPEED_GPIO(AA, 1) GPIO_ACTIVE_LOW>;
>                 };
>
> -               rear-id {
> +               front-id {
>                         retain-state-shutdown;
>                         default-state = "keep";
>                         gpios = <&gpio ASPEED_GPIO(AA, 2) GPIO_ACTIVE_LOW>;
>                 };
>
> -               rear-g {
> -                       retain-state-shutdown;
> -                       default-state = "keep";
> -                       gpios = <&gpio ASPEED_GPIO(AA, 4) GPIO_ACTIVE_LOW>;
> -               };
> -
> -               rear-ok {
> -                       retain-state-shutdown;
> -                       default-state = "keep";
> -                       gpios = <&gpio ASPEED_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
> -               };
>
>                 fan0 {
>                         retain-state-shutdown;
> --
> 2.17.1
>
>
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------
> This email contains confidential or legally privileged information and is for the sole use of its intended recipient.
> Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited.
> If you are not the intended recipient, you may reply to the sender and should delete this e-mail immediately.
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------
