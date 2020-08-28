Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A69C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A6C207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5gkz55L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgH1OaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgH1O37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:29:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB9FC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:29:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so1543709ljc.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QhL6kVPpf//E0eP09dB94FXNl/JWUcmK3etmXLgf2zA=;
        b=a5gkz55Ly8Ww7NOlesFahUpnsLDsAtIzYfNIYdjbFDIwxHQQn93XjqkA6aaDchNV/g
         chy2qTGRhmm/RRyS5JnIZmtatijKaYve2HNKMM476P7B/SFeZWfY3CP0ykeaxrrH7IeV
         6vP3dW+4W6P72ZHX0ycMjZGMm8wVVk0k0xUvlaZmPmTNTPRWSAs6wL8jl88pCCCnzRen
         fYGztnrARiL9jvY1mDDN9E6+IpIOWuqRBB2wEx9CXkwy5Bj/m0sfRbrsFEYTj+ypnbfn
         UE14SI2cp6Z3Voi+XA6tcej3ScRJpoHZYT4jlOkb9u+ypdrUlLTPy8Wa1ACm6fVFMdGC
         Z/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhL6kVPpf//E0eP09dB94FXNl/JWUcmK3etmXLgf2zA=;
        b=YXTntmOSFE1kBTbyBVuhdwCHLgPcYZrsStVip59gJQVU6+8cz7VDH2whPlPU/6s5wX
         F6Vi1q4iMrOBBQsWZuDU12iz7lCXDxOz9rhGkw48n6smmlC58GLDYAeJcGpwRx0owWcG
         Cp6uoRHky3uBqfpzt6gGu4rz0WpO4GAPN8Ym4mbeea0wgn2pDfcZw5jPPfIj4wuXLtsY
         5oTqBqj7UKyyV8Xs7HIhH2Eeh6/GrE4TDGF4bBDWPxTuQqKxRvBnj6HCTfnJE75tqg9e
         SD2jrhB8aiJ2gd9ls0wzByH7xPIt5TqVWrCtYFwTnFy68OZYX8gX06Pd2Rea8ZKlBjE+
         njgQ==
X-Gm-Message-State: AOAM532vhIAj+ODRd9Jg1iLF49HBWFIzAnHZjh7bD5vZ61w6DxDhecdh
        U6Asrrlpywm0VwGCEjNS9dCggIHJBhZZQDz1xkohog==
X-Google-Smtp-Source: ABdhPJxjSjwJMtLbZ73ue0D0jAiJz5PbaM9GY+WsI5Jf6eFad3tgUj3G3NcoClAPI011Qv/S53/oUnLmGtQnG6qHvMg=
X-Received: by 2002:a2e:558:: with SMTP id 85mr1048525ljf.293.1598624996774;
 Fri, 28 Aug 2020 07:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200827185829.30096-1-krzk@kernel.org> <20200827185829.30096-8-krzk@kernel.org>
In-Reply-To: <20200827185829.30096-8-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:29:45 +0200
Message-ID: <CACRpkdb-AfyD-E2yT5PEBw-GsteLw9HK9JLiZajixNBJUquR3g@mail.gmail.com>
Subject: Re: [PATCH v3 07/27] Input: bu21013_ts - Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 8:59 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
