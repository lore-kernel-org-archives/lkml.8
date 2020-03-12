Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B1C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1949C206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XdThVGVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgCLIXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:23:00 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41132 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgCLIXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:23:00 -0400
Received: by mail-qv1-f68.google.com with SMTP id a10so2168929qvq.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 01:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P9izz9GwKEkmwA2CN2dI9HFL+pLvd99ZgSLtApoaeDU=;
        b=XdThVGVLJ8fCTlPp04bt767nww/R0JNiDAgMPRu09nMpRox4DHlFpxcQWyDiIzhi4l
         zPVbbL4xp6o5xCpctS7Jp/3wRpRJ0j2+c141ucsFPPZ3W/hCO0WyUNj59CUWyKWUbpCr
         ceV9QtJMukXVzTgsXjnC0BIyprWSiwrhx5yp6mZbqXTFDAYTZ43cmbHSTcodDP8d1Y/K
         u1Kv5F3EC1oaAjdZLlagq368xSL7t3dTHl7DcezV1iAJSdaZ4v0Epmd4C570b1Ec2YZi
         /Db/T+9bJl2eydi+gBR8XLQvTZ7bd020wd8IQb/8d11ruupX0FCBQYpAd3ggUotu2DJd
         W7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P9izz9GwKEkmwA2CN2dI9HFL+pLvd99ZgSLtApoaeDU=;
        b=RXxPFZxcbH6k5kaj0ek+W0lqI/NUNco+3D34EhLWAzppc9F6IMVkNWDG1FHTYo53AY
         pspRHzog4SE3Wjk4epsOOEZ72RX4zSlth47IWAF9Wj842AU/5bv1RocTG9qJP3sHKmLt
         IW8+5ZH3kut5eXkFWX6Cvxl7PzJSV4Da3xatRcEU3kPHRsQHbdYr/6TCkCTOg4pE+cRH
         YTeXh32Pj1uQT0Z+rORll1D/DI0zwL+XofZ8c1nLa18DhhpeajU9OV23cjGKxDDd0pxO
         MOsMqkATvaKuRlwX5pWNKj9XqXk62VpTTwRkf7yGMxP+4U8GCNyfipEFMZshi/Ll9dhf
         EgwA==
X-Gm-Message-State: ANhLgQ2p6AzNDd2TXICGwKd9tR2auDy3q+Rtf5baJlKEc081Y4YBb2kb
        H6Z8x+Cgu67wAnhCQTpaKZoqwYysZHzVQh82QMe2AqRq
X-Google-Smtp-Source: ADFU+vsJMDMQ1KzRZrYFym7/k0h4j5yi56oLBBmOZI8IRsJ++T2KNTs2w7I/VIUzjgv1K8oDQuyP8jHKibG5FlX1gps=
X-Received: by 2002:ad4:5429:: with SMTP id g9mr6058767qvt.134.1584001379162;
 Thu, 12 Mar 2020 01:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <1583780521-45702-1-git-send-email-opendmb@gmail.com>
 <CAMpxmJXNQQTxRWZSP0RZTUuefAk3+AeDMVeVkgERy7f9X=CBsA@mail.gmail.com> <7fcc5cb2-5fdb-d1cf-e55b-c0f2d407e072@gmail.com>
In-Reply-To: <7fcc5cb2-5fdb-d1cf-e55b-c0f2d407e072@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 12 Mar 2020 09:22:47 +0100
Message-ID: <CAMpxmJX40tfNUqrqDwa+GEGAD9QuLym=jLi2MPuQX-FZS2Z9sQ@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: brcmstb: support gpio-line-names property
To:     Doug Berger <opendmb@gmail.com>
Cc:     Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 11 mar 2020 o 20:03 Doug Berger <opendmb@gmail.com> napisa=C5=82(=
a):
>
> The label names are viewed as a convenience for the user and are not
> necessary for the proper functionality of the driver and device, so we
> don't want to prevent the driver from succeeding at probe due to an
> error in the gpio-line-names property. The bank->gc.names member is
> still made non-NULL which is what we really care about to prevent the
> misapplication of label names by devprop_gpiochip_set_names().
>
> In fact, it is expected that the device-tree will only include label
> strings up to the last GPIO of interest so the ENODATA error is
> considered a valid result to terminate any further labeling so there is
> no need for an error message in that case.
>
> Other error results are unexpected so an error message indicating the
> consequence of the error is appropriate here.
>
> I'm not sure which aspect is confusing to you, so it's not clear to me
> how best to comment the code. I can hazard a guess, but if you have a
> suggestion I'm happy to submit a v3.
>
> Thanks for taking the time to review this,
>     Doug

No it's fine, thank you for the explanation.

Bartosz
