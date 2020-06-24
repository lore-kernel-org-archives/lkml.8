Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88FAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C350420B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Zs0iesBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390213AbgFXKSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388551AbgFXKSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:18:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DC1C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 03:18:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l188so1271008qkf.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8jgfU2E0apwMh6wsaejptHHCTw5UgOkwm0wLww38xJk=;
        b=Zs0iesBVSboLL0pPa3SmzoU3GGAhIWocMZKNz/qHAInfUbsED3WVXRTwdFNtSOLfoA
         s3NnIhn6Oy8edwR99FVaom1dOVGIg6yLJ0AXEU/8fe2BoOdUH2ZUJ8W5FMIGNbj0PaJZ
         xS4h/W3uokUCTPMzUX4LCrPvcTeGV/W/7ODHCVYPXG17R7e3e88iU6uDKjdZEfYLz1DO
         SoX8Lk8wfKkLDOI9SyR675ieJCNw9l8sgtRMM7d0eXQJWapYbBR6pTCz0YOycsvICdEz
         IwHHiKIaeCjowv8l5AzigbdoDUqnCb02xVESinUoiM5inJrLXcxnuxOQh6nw5+DIeg63
         u9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8jgfU2E0apwMh6wsaejptHHCTw5UgOkwm0wLww38xJk=;
        b=ieafJxvvhVSmWSLjm3jsreKkGo8Zw2ES7OuXG/y3He6LDvYFDtWhUK7wieRUGoHZgQ
         Mm/pB4Uuyw/8i57OJw0ZvpzcJJvhI1u/FPch8gwte5XmihoHksVjcNm4mSmLZLW3TEUD
         N/+hwAq0z2+CxZUm9ah5xH1rUUSXv6vHM2NEP9TCGWk6nN0lRoKJjcgdRfia8xDmlJTK
         1I5Wlo2Rbf7SF6HhgXzGXLTYJ17grCdKiWWWK9bQMXs53KZwJqwyX2TP3P8yB/7foKQx
         VGW1wvhiBaUFiLR9ZLyZjA6IP94LbvIhAzVatL38QAG+1HK7XVJDBDSN8/Ci738JyElW
         dUkg==
X-Gm-Message-State: AOAM530K7xkIGSfIUASRGRSf6pldvrD9X4p4e8RyRZyfdPAAhVU3AyzO
        wLRGy40WoNosqEerYB1hAZsQVTsdx6c3d3T14SD+C2y2
X-Google-Smtp-Source: ABdhPJxNRfFJkbDxdLxofIwKZguLERV2rujyL4vJHjYoiDq6+3W5IMkv5upBRlgurYdNM8aGw0dOWaZAKREOcHxHBpQ=
X-Received: by 2002:a37:aac4:: with SMTP id t187mr22208491qke.263.1592993899699;
 Wed, 24 Jun 2020 03:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <1592393847-1415-1-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1592393847-1415-1-git-send-email-srinivas.neeli@xilinx.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 12:18:08 +0200
Message-ID: <CAMpxmJX1YQWEiY-Oa-UvniHJcX=sM2uCVG8q+p=3Or3ZCt_kbg@mail.gmail.com>
Subject: Re: [PATCH V4 0/7] gpio: zynq: Update on gpio-zynq driver
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        shubhrajyoti.datta@xilinx.com, sgoud@xilinx.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 17 cze 2020 o 13:37 Srinivas Neeli <srinivas.neeli@xilinx.com> na=
pisa=C5=82(a):
>
> This patch series does the following:
> -protect direction in/out with a spinlock
> -Add binding for Versal gpio
> -Add binding for pmc gpio node
> -Add Versal support
> -Disable the irq if it is not a wakeup source
> -Add pmc gpio support
> -Remove error prints in EPROBE_DEFER
>
> ---
> Changes in V2:
> - In previous series [PATCH 1/8] already applied on "linux-next".
> - Fixed checkpatch warning for spinlock description.
> - Added description for Versal PS_GPIO and PMC_GPIO.
> Changes in V3:
> - Updated commit description for PATCH 4 and 6.
> Changes in V4:
> - Updated commit description for PATCH 2 and 3.
> ---
>
> Glenn Langedock (1):
>   gpio: zynq: protect direction in/out with a spinlock
>
> Shubhrajyoti Datta (6):
>   dt-bindings: gpio: Add binding for Versal gpio
>   devicetree-binding: Add pmc gpio node
>   gpio: zynq: Add Versal support
>   gpio: zynq: Disable the irq if it is not a wakeup source
>   gpio: zynq: Add pmc gpio support
>   gpio: zynq: Remove error prints in EPROBE_DEFER
>
>  .../devicetree/bindings/gpio/gpio-zynq.txt         |  4 +-
>  drivers/gpio/gpio-zynq.c                           | 66 ++++++++++++++++=
+++++-
>  2 files changed, 67 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>

Series applied to for-next.

Bart
