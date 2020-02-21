Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A52C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B962F20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHFJssvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgBUOQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:16:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46606 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgBUOQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:16:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id x14so2302851ljd.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9bkxUVE/BaGEsePvJG94FHSx4HKNwzho1ZimVG4ZU7U=;
        b=NHFJssvv1/a6TfSVnJMOtNTzSVZKMxcb+si901Fg2lUVauvB20CGGqCqJGgoe+1e1g
         Lbj4ou8rjIPF9xv9DKAYH90jZ+mObOp0rIjvZ7Dg9ySiio4iaK/btk0x2htCZeXbtCIs
         s/6iqp5Gry2+Cn6zijm95lF/j4t7ZzDSE8o0BWPX8/4eSxMP10r0KunPtjnJkN+cxZLS
         hrO4qp8YYuGoiQqOtGRt/oBkz38Qo3VLeSWUeTdL0KgCXOFPncrLa26IHW488Fp/bAVV
         JyVPUu8OgRqzn7esCc+CO76f3ej/1vpiQrHunvANngKpIiFP9V0rPnMltKixXQJd4lQO
         EcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bkxUVE/BaGEsePvJG94FHSx4HKNwzho1ZimVG4ZU7U=;
        b=KFhN1iyAMGndErrjFFV9rn6FbqMyaOLjIo2VjxGl/TLPAlC60SEfFu/wAF3Gp92CZt
         vOEHZNZ/lbi8uJafpZ6SYt2hAFlsg9Omsq2JGtnPlxqhRSJKwJtVS2tCPu5KqNgUYTBV
         yJuOw+dPJeO2aTYI+gl9D78k8bfxV4HnlxqsGVbEF7UQZT3cezR+yLBh6Oqv+5L0kwhi
         cJR1o91jE04qlARZYIe09bR4CCmxsNDTXn4+VicKA3Dw1YJy7BNXxqhxShyd94WGqe90
         bYJbjFtJqBKYN/8TgqGSTswz052EkPZdWjFdLnlWml0w5KfQQ1H6xzT43jyEJRzvdelQ
         2Z1Q==
X-Gm-Message-State: APjAAAXzsaioLTu14taajVynpi1RekfX0UzFYoz7smn+uVNWDW2q15q8
        qPqaKRNY4XXSeIMuhgzYbBZOcQP3M7tI2R/Qw2L9jw==
X-Google-Smtp-Source: APXvYqyMEW7xOoeU5aAqEunqkJEjZidoADakWQrFSuJrs2CPUv7HagGQ0QOJnoIk9QZdE7SPDJb+a06x21oCDVibGj4=
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr23122512ljc.39.1582294562607;
 Fri, 21 Feb 2020 06:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20200117213340.47714-1-samuel@sholland.org> <20200117213340.47714-2-samuel@sholland.org>
In-Reply-To: <20200117213340.47714-2-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 15:15:51 +0100
Message-ID: <CACRpkdajokCMpJ98yfFp-s23jG96wO_N9R2ZXvXB+hU6XMs=ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: sunxi: Mask non-wakeup IRQs on suspend
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:33 PM Samuel Holland <samuel@sholland.org> wrote:

> The pin controller hardware does not distinguish IRQs intended for
> wakeup from other IRQs, so we must mask non-wakeup IRQs in software to
> prevent inadvertent wakeups. This is accomplished at the irqchip level
> via the IRQCHIP_MASK_ON_SUSPEND flag.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Patch applied.

Yours,
Linus Walleij
