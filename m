Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB0BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A100720760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v23iSweX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgGHHQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbgGHHQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:16:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CB6C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:16:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h22so45768244lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QkfJYzPGnOMpKG+ZFcmubOHnwB8gAssiAAxbH64D1Os=;
        b=v23iSweXgVsXKUdOxxg/lno3rnKJT5so4Q1FckB4o54uePZGBH6Bv5dwLjdKxdoHyF
         Ire9DkQ0wSOBZ/6+Jg0AAYC8wtkDKf9/siUYTIZlgUbzqixFTP6895Ra1GAk6YCFuohl
         x+y6i/RbUv3YdzwivmLgScI07z0O8dweZdrBp3weUksD0J3EzNTxc7Hz0lXYE8K+TP3X
         w6vLfF4fvpDjs4j7dxgXrgeMh5hlwNXsGxQgWwtEM83O7OTsu5RiGQhltl1N1vEznQW0
         lGAHJO34oeAR5ItX7GtTa8pCAwAUodck/cFiyzl8m1xuauaxTJ+jdoQUA5tXtLqxzwjR
         Za/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkfJYzPGnOMpKG+ZFcmubOHnwB8gAssiAAxbH64D1Os=;
        b=DQGZPH3I//418Z/+d9uEpmNxWt/khAYYqyBDiGuYI1SFDtds81XJDl1B2ZXZk5h/PR
         BUP4bx2fvfwUTdnXe6cmkD/U1yqdTqRdQUbb9lAZrXRsspLpL/OQP4+gvLCrmuqRFPG1
         0BRzqW1wFF8Zp42sTiv1C7pdHMb5X0dml5az4TH6TTNUD1Ntpb7FzHJmQaJNGuegbpvJ
         PQmMqMUee/sHMRGSG5xFR+z13VCHcTJKmgfALYbyXTTqpGIXTp22IBN/V/VcbnQJI9Jq
         se+4NOOue4S7dWZ1l7+tg0+J78Bryqa6sqYtkM56L3vP3PW8MPZcuPtiX0OPkAQ+I0T6
         QlJg==
X-Gm-Message-State: AOAM5308Z+y6x9A2ErFJ3p9ioeOyeOu2zCrZ+vIGpYjnRHwhU+YcXwEf
        bAfplgXU1c6DvdEFmvycsgrz1RprsIrpjkGduQmMCg==
X-Google-Smtp-Source: ABdhPJz/BY0ubh5lFlvcwaCxE8m83cbsKbPYMczIH7G8X19q2JkKCkjg6IDxFGQ4sceQqyL82aY2xnRQoeGrU76PwIQ=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr26808667ljg.144.1594192612283;
 Wed, 08 Jul 2020 00:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133345.2232932-1-lee.jones@linaro.org> <20200630133345.2232932-5-lee.jones@linaro.org>
In-Reply-To: <20200630133345.2232932-5-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jul 2020 09:16:41 +0200
Message-ID: <CACRpkdbUpWSNur2thrZ4Cea-eNazMopcQRt5uc9cyKOuHX4dBQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] gpio: gpio-pmic-eic-sprd: Fix incorrectly named
 property 'map'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:33 PM Lee Jones <lee.jones@linaro.org> wrote:

> A good attempt has been made to properly document 'struct
> sprd_pmic_eic', but 'map' has been incorrectly described as
> 'regmap' since the driver's inception in 2018.
>
> Fixes the following W=1 kernel build warning:
>
>  drivers/gpio/gpio-pmic-eic-sprd.c:65: warning: Function parameter or member 'map' not described in 'sprd_pmic_eic'
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied!

Yours,
Linus Walleij
