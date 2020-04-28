Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE90C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B39206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IlC/VOx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgD1L1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgD1L1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:27:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ECFC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:27:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so21069461ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4DBB5klIf0QGN/n9IvG0hKMODa1zR1xeD/KT5pKouk=;
        b=IlC/VOx7VfCTd5g54ZVjw1O2wowU46ZNSWyKU7C2o/3/+KitIdB8TuO0aNjIEXy/b3
         1CYsDa6aMA5AxnQMibCFECQw+g+U0px/vFoGMbzWNC/cjx3oVVU+3an0ngq/2hnxrMor
         1TRCEwFybe93aUXkf5s3QErJqGxX0H9v90MR4x+K/AKQlHer0jyoCZXIr7J57Kjr31h7
         iXi6D8HBLXmlRPYMg36hO4SczFFUE0PNBb/8EDLDuf0W8rP6Yyg+joeqAyoNORCOVwOE
         1Odn5dRJqRXNdpW6I/EfW4woZUUzM27PsCMtVOGBOikvLw8i2+QgctW5kmr9OUL13ORw
         vOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4DBB5klIf0QGN/n9IvG0hKMODa1zR1xeD/KT5pKouk=;
        b=m2RYzmKMwyd+952ffOvGbcDiva7ZbIV+6/zm+ht9ulj6xEyNkc56HHpUTnD9vduWQe
         pEsc3TXnJfAbytcQ6Z/a/ued2w9mS6323rUO8rh47ZYkzx7LtYG0iv0VZD/oVKR6ap89
         jrbdnbpicdrMQokKMF+hN1KshtJyiQ6tgbPippH7f3IyO1FW4yvoZHPnRxO2D9c0cmK7
         KAfeYDpn/R0d/E9Z27eJUo36R4OCZ4tMonVuJYENfMOhJbX99LQtWK8H371n4LLBJntX
         EOt0eOfTpFj3q3R+eZd4ZrqIuVzn1eGI/ubM4lYv5xtoQi3kiVWnv8umm3opAAsZ1KdF
         o1pA==
X-Gm-Message-State: AGi0PubZL9+9bjqIMwH2Dn9yPRSRxSd3HGOstdbs8bHwTvfP6n3d4GPg
        l4yBlNja+30p7YGQw7XvW70NUzbbeuKUYLxNVOTS7A==
X-Google-Smtp-Source: APiQypKV704QjuX9brkHXyi9vW51TMuZXm1a3RD2HH//58wkwqAcG575ohaDZ1tUc941Eh8di8C386pjHZ1m4wCHMpE=
X-Received: by 2002:a05:651c:1058:: with SMTP id x24mr17947683ljm.39.1588073259176;
 Tue, 28 Apr 2020 04:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200421142402.9524-1-zhengdejin5@gmail.com>
In-Reply-To: <20200421142402.9524-1-zhengdejin5@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 13:27:28 +0200
Message-ID: <CACRpkdaM88YebrRWPF=0navD8P9cEFYfepmEYb2+mw8LyNc5mw@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: fix several typos
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 4:24 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:

> use codespell to fix lots of typos over frontends.
>
> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
> v2 -> v3:
>         - remove the changed of "thru -> through" in the
>           pinctrl-nomadik-db8500.c by Joe's suggestion.

Patch applied.

Yours,
Linus Walleij
