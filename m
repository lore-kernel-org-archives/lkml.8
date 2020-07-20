Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E91C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A320C20729
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVZ4tQJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgGTJuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgGTJuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:50:23 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34684C0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:50:23 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t9so9358414lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRBYG5PaXpmuVbg9IqCWz5FWycJjiWEMOWVv1HmDXEY=;
        b=WVZ4tQJ5ADD0VQ+bDg36V5Rw5hBx8Ta3ZtG34BvPB1wkriVnL14/C55+iYqW88gidT
         yuS7kkbQazNWn5AerD3c7VrfVlK9FU6unNzQgm2llxznaIOxln49U9z21eyP590nkPEz
         asiMTAgG740UxTGJ4JPgq36RnUgEqTOK/qZakOMMReumgojXy8gx80LdAih01rRfJZSX
         FYkf5sTJFMr9Cu7F2yoTaYRfHdJPGCYm/uLLDLabE5cxErMriyclGImvf6930StLNvtm
         JHqCwWMLN/iH+1KtdzE6VC90QaUwxOzTvMrUBPKzBOvH3C3Aap6+kZDGrLmHEyedgXhv
         D1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRBYG5PaXpmuVbg9IqCWz5FWycJjiWEMOWVv1HmDXEY=;
        b=ngz0cUB1wzB/ufcDpi6ZGs3IOVY/Tofsovpw3YQ++luHc8CYAgYOWRX26Lk18XEKpq
         X4JrFI+FQ1iYypC7GI1ZzakI6hIgqb6L08uZCZDzTOIhj63+dZdtpXuxUYkTxf+6+E/r
         Su2IQcKtKPrqM8etjQZmIAuLb9FFpR2btxkmpZETnDFBbIJ+WSwcvveLSQCwKWCN5+Zd
         fuPzKueflkj1pxjVk6suysgadL96/xMS1rCkhb1RRnZqKjpb6eCuyJU4HWyW/NKCTcix
         D0qYgy6Em67penmHeFJ9amRHUPNrLJnyUuhnf+yszuXRfwGlHy/0hMjrybJeYfr4pRLz
         DwCw==
X-Gm-Message-State: AOAM5329a5z2sYSVQbj3DoxhEtZCa9WdBv7QkLn+8mZi3e68dbInBIBQ
        qsjDEck5k4BXBCgyzXsPPsQP/rI4/xkUrzG0cN0z4A==
X-Google-Smtp-Source: ABdhPJzD8k7+rJYR6jlVIluELoADRO+Lwj3Vg2NSdUF2/ZwjTWMJBoIuK3PV3zisuEsa8VNsjNqpKgIlpqfu9Tasxp4=
X-Received: by 2002:ac2:5325:: with SMTP id f5mr10437151lfh.6.1595238621552;
 Mon, 20 Jul 2020 02:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200716022817.30439-1-ansuelsmth@gmail.com> <20200716022817.30439-3-ansuelsmth@gmail.com>
In-Reply-To: <20200716022817.30439-3-ansuelsmth@gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 20 Jul 2020 15:20:10 +0530
Message-ID: <CAP245DVBra9hr8-domt9FAoSTqy42DdkMRLeK1fC3WPrRH=HXg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] drivers: thermal: tsens: try load regmap from
 parent for 8960
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 7:58 AM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> Devices based on 8060 tsens driver (ipq8064) use the reg of the gcc

typo: 8960

> driver. Try to load the regmap of the parent as they share the same
> regs.
>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/thermal/qcom/tsens-8960.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 2a28a5af209e..45788eb3c666 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -7,6 +7,7 @@
>  #include <linux/delay.h>
>  #include <linux/bitops.h>
>  #include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/thermal.h>
>  #include "tsens.h"
>
> @@ -168,8 +169,17 @@ static int init_8960(struct tsens_priv *priv)
>         u32 reg_cntl;
>
>         priv->tm_map = dev_get_regmap(priv->dev, NULL);
> -       if (!priv->tm_map)
> +       if (!priv->tm_map) {
> +               struct device *parent = priv->dev->parent;
> +
> +               if (parent)
> +                       priv->tm_map = syscon_node_to_regmap(parent->of_node);
> +       }
> +
> +       if (!priv->tm_map || IS_ERR(priv->tm_map)) {
> +               dev_err(priv->dev, "failed to get tsens regmap\n");
>                 return -ENODEV;
> +       }
>
>         /*
>          * The status registers for each sensor are discontiguous
> --
> 2.27.0
>
