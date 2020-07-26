Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49629C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 22:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236742065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 22:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDMGD4iB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgGZWfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 18:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGZWfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 18:35:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CB0C0619D5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 15:35:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a27so5691747ljn.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMOTG0PO+s5CwQFVuZNWBPHyIul1aA0fgUibL6tdegM=;
        b=hDMGD4iB8N6MW08e5ijsZsVqQDqAcRXmHyhX06vvU+sz7Un/KjdLfrrh5L6yx+6/SB
         hch1sgS+OylR31eFhuN5okRW/045rSJmOzNFObfozuYaNN/Wto2jJuCvmBwOYtEdQX0L
         TWocChB/EY+iYJagjeMGEzcM3ErFpyim+h8qxVt+vIFPpk2EwBnlbGIsuSo3vbaE929s
         1YgrPVpXedOWJOhjcFqX8qtoLCFsW1RXSA26dnPMS2/ltWIkCzIWlKSD71LCU14crCOy
         roD2OpjtjR6OO0p215DhzcrnUBunnVLkZ988eIc0jqJY8zvk4P4xkyk2ujvdcaYDM7dF
         Xirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMOTG0PO+s5CwQFVuZNWBPHyIul1aA0fgUibL6tdegM=;
        b=me7MAAyVal1ryg0QGLUGBsUcQKhsbrzhp849rS43htBExde5GROKnrgNJ0gG+XVExM
         RoO1fSYBTvpYTalR8JJz//4AglB75gwT18IwtAJkMNgT53H8sK8Dv8IQUuUQeD2rp38M
         dpGVqF4aIf8+1oWtX1sRVBqWRdy3PibbKWBZqIkfyH2nFEUeafae26rFioSQvT3hrN3W
         KCFEl0FXJTRUOjnKaZ+tKicYdy5vMRC7XbKZd0Q+EfjkpiydifqqWCiJ/w97Idx+ER7I
         2RYx9FqVt5xrfnHbt1+ZyFk5V8uhq0gqjomLVPdb0dkV4yw06ETzdIyy0GQKqkRkSGj8
         NuIQ==
X-Gm-Message-State: AOAM532OfblRM2FjGzE6t/b9TeJXQWNpxXXk+TBy8KWCmDSG9pa0xiVu
        LhsgzstJS8mu42cNB/48lNkucb/Xout4/Xsm9wChXA==
X-Google-Smtp-Source: ABdhPJxpoI4Wz0qFGlLsoQ0qfnzhIbW7RXo+Pg6uMltg+pY1lVTlif7DJngj4Tw0aAxErsl+kDQaFXGMGvRhjoiKyoE=
X-Received: by 2002:a2e:9d4a:: with SMTP id y10mr4059257ljj.104.1595802922025;
 Sun, 26 Jul 2020 15:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200722122751.266440-1-drew@beagleboard.org>
In-Reply-To: <20200722122751.266440-1-drew@beagleboard.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Jul 2020 00:35:08 +0200
Message-ID: <CACRpkdbL6KD1fNWKBNuqVZDaMDH=S61XSU5Qhza4CuQMx=277A@mail.gmail.com>
Subject: Re: [PATCH v5] pinctrl: core: print gpio in pins debugfs file
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 2:29 PM Drew Fustini <drew@beagleboard.org> wrote:

> If there is a gpio range mapping for the pin, then print out the gpio
> chip and line index for the pin in the debugfs 'pins' file with the
> format: "[line-index]:[gpio-label]"
>
> Here is example output on the BeagleBoard.org PocketBeagle (AM3358):
> /sys/kernel/debug/pinctrl/44e10800.pinmux-pinctrl-single/pins
>
> pin 25 (PIN25) 25:gpio-32-63 44e10864 00000037 pinctrl-single
> pin 26 (PIN26) 26:gpio-32-63 44e10868 00000037 pinctrl-single
> pin 27 (PIN27) 27:gpio-32-63 44e1086c 00000037 pinctrl-single
> pin 28 (PIN28) 0:? 44e10870 00000036 pinctrl-single
> pin 29 (PIN29) 0:? 44e10874 00000006 pinctrl-single
> pin 30 (PIN30) 28:gpio-32-63 44e10878 00000027 pinctrl-single
> pin 31 (PIN31) 29:gpio-32-63 44e1087c 00000037 pinctrl-single
> pin 32 (PIN32) 30:gpio-32-63 44e10880 00000037 pinctrl-single
> pin 33 (PIN33) 31:gpio-32-63 44e10884 00000037 pinctrl-single
> pin 34 (PIN34) 0:gpio-64-95 44e10888 00000037 pinctrl-single
> pin 35 (PIN35) 1:gpio-64-95 44e1088c 00000037 pinctrl-single
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>

Neat, this v5 patch applied!

Yours,
Linus Walleij
