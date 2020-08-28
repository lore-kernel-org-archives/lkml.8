Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257A0C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E2720639
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXuwPRZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgH1Odb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgH1Od2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:33:28 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0D3C061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:33:27 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so1543191ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpmT8z3vCoI387yR05xFtDPOcMcQ4MSd+QWPcIK213o=;
        b=SXuwPRZCasKbRTNTD4rBVmpvxw5674fLb7D3nUZanlM12QZHv9w8tybE1ygcVHuyHf
         oInP73nxqRqG/m924yhoXHEfVfMd8UNcGRHcOgglzIGOvStEqWimRNUmkiNO8lXlxASX
         CCpDX7fmupyd+Q7PIqp/vvF9e1lBa3Fh+ICv7e70bLR/G0jT4Gkx4E349CQz9h+h21Rd
         J9n3piyD5XHKRoxk039mI9PtUaLpkGEORrwzNi7gop6r9A58+nzmeDGzRENEZ4/0F3H/
         ri4qABCfHUAxKq3affmj3xX920jjMz3hnbCzfllSaY6dfAWtXQUtN0eWy5GAs/w/o60R
         vy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpmT8z3vCoI387yR05xFtDPOcMcQ4MSd+QWPcIK213o=;
        b=Rwi2BH6u9OZIyKrZQfTgZcKAawptTpEgjQxFKK37Jgpq9nN/+3LYFLtglOTiyOnzzK
         xfuDB7b18b7cj360/E+3RHz1xPRG3xV6zFbeLzp8f2JkeRPC9C0hf/EJ0f8hSQYcHbSX
         yqZ2t5906P4nP07ZQtXfCMqE/6ZAbNQyHzw5txtH029znsrEAXq4eP13W0DVfZhBEgiB
         NOk4geUuKFxgValjnDcCmCo7RVZGehOKT9xmnKocmyiX4zBGStEVNqDNKLVlQvPbsRCM
         A3J+ZfmSuZvB6PbpPqpYKHzoALaVKveBWI7mGFcRfDWhjbDS0+xZy7Nmve6DXsXSMAAa
         kG/g==
X-Gm-Message-State: AOAM5300BAjh5FLHyC1FFD8NOzX4FUafQg1GuHcLp3eQOlY+Ay/+YvyL
        xfgnRyOv89xe7ZSogm5KLL+BdzLoIbdqeC4RlFhxtg==
X-Google-Smtp-Source: ABdhPJx50N3WCz+95xej33BT+LFzbgw+YdB2RFlR9a5r50nwxYsPt9Je6m4kpOoXdZYez8d1PPZWYNLG7DhnlToAq/A=
X-Received: by 2002:a2e:558:: with SMTP id 85mr1056326ljf.293.1598625206108;
 Fri, 28 Aug 2020 07:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-16-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-16-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:33:15 +0200
Message-ID: <CACRpkdZTTq=yARxK5uAu6f5rAJy0tH0V5HQU3d6ddEMa_a9KnQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] iio: magnetometer: ak8974: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 9:29 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
