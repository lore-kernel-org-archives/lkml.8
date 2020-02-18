Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6390C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F7A2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UcxFtM3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgBRJur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:50:47 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41660 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgBRJur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:50:47 -0500
Received: by mail-qv1-f65.google.com with SMTP id s7so8851689qvn.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CMpbsuUrAguPuwyvtKyydMgGKcHAmQpZ4ST+OIxCEvo=;
        b=UcxFtM3QvoELxSrxXjAyIIXy3ToxtOp8v/RoUtffuAnl+jI58nEFBR1JfxJY6YtEQw
         9bYRta+CO8LsBnfm/X4eLsihAf5TgEDgmxF4Bs5PE4fRh4/h//8ujYNZxkb/Mm4Sb7mE
         Pi7Xvy5MjSfNG4TV0lpR+UxwArd/G1fzDVmtqd2vyDsNRPzBqc+NURhylRKULiboYYvF
         lWHTHJZVF4CySygCylj+JeRXkC95mF3hk5uK4Bh2fLxSKi46PMaN+rFyPssMcSzFT3FE
         1912mA/8K9fr3BZd/ovrfL67iBHvZ7vBCRcoTsF0XuWtmLafy8R1n5hjtG95q+ZSPHd+
         EiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CMpbsuUrAguPuwyvtKyydMgGKcHAmQpZ4ST+OIxCEvo=;
        b=RB+Dp2Ex5IZFY7EjoHkFCk+V/mj/rV75YkoAbdpx19DFPmxlVdw7q+ZD3YSHwY8ZYs
         70CTbWVQQ6cgft+EMQbAdjO3N7j0eZoiVRtG8ZM4fRU1HNOmowaPzNaec5Ejn5O1czAm
         Vyj+j5453bFYhGW/UBspFCzDr8OcjAi6qMZVObPtL7xGjH9EgKP/cfTYjLwm8ttTeRZd
         c+8MsNq6chZ0wSRrnT3BbCl9g/74cye8UBqyaOyDeXYF1fac2H4S/zd2BSb+aPh96T6y
         You+sCBU73yDaS1ozuxmWR0cX3R+nERGAYS5kUNO9aFv8c9xGZmLEcXR/3ExeJBQfa7I
         f0Bw==
X-Gm-Message-State: APjAAAUVhNJI0xxxEaqgsvT300aYJVmpSyhAlRp19seXVGsnFedAEo5x
        sZPkaPpe72iARyKs8zdl844Zeuryk6GWznoKSdR39A==
X-Google-Smtp-Source: APXvYqzay4vxReDT+unINvbnfD9zstcDUK4FIQOUDAgcsMRXsQNMHebbaD1kPFF714OvcWTxxfS3Pe6fQRaEZjqn1fc=
X-Received: by 2002:a0c:f28f:: with SMTP id k15mr15645199qvl.76.1582019446430;
 Tue, 18 Feb 2020 01:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20200218094234.23896-1-brgl@bgdev.pl> <20200218094234.23896-3-brgl@bgdev.pl>
 <9519ba1b-17fe-7121-ce00-d940b3de2777@linaro.org>
In-Reply-To: <9519ba1b-17fe-7121-ce00-d940b3de2777@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 18 Feb 2020 10:50:35 +0100
Message-ID: <CAMpxmJX5mo239fe3Y6a7uaLFpWSAbLg5mUpCw-idJuBjYxOdYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] nvmem: fix another memory leak in error path
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Stable # 4 . 20+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 18 lut 2020 o 10:47 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa=C5=82(a):
>
>
>
> On 18/02/2020 09:42, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The nvmem struct is only freed on the first error check after its
> > allocation and leaked after that. Fix it with a new label.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> looks like 1/7 introduced the bug and 2/7 fixes it.
> IMO, you should 1/7 and 2/7 should be single patch.
>

The bug already exists in mainline - the nvmem object is only freed if
ida_simple_get() fails, but any subsequent error leads to a memory
leak. In other words: it doesn't matter if it's a single patch or two.

Bart
