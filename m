Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC22C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB4C2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P8+X/m92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBDVIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:08:12 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45427 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBDVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:08:12 -0500
Received: by mail-vk1-f196.google.com with SMTP id g7so5606028vkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NE9H4AjLU7qeu0mbmE//LIZqJwhQlWyPoAREOrQ5X8U=;
        b=P8+X/m92d/POWNkLsBIXlnVJT3dn0x9yNui8PIaNGXM+CoMBQXQPWGXteEZTY+ifc4
         ML3OR3zOQ6lT2Llny1GxwbTra+sPe66wTkGALKhQNs+nubwkebpQ2Puq96/KDFzvP4hm
         MwcYrKWgiq5MeuwjTV4klynvFSrSth4JsgO6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NE9H4AjLU7qeu0mbmE//LIZqJwhQlWyPoAREOrQ5X8U=;
        b=PenqjRDNQ5ldFagW7O1+77E9u+oPLZXpLfoXBFKF9u3F97EMSt8agA3iU60emJ6ZFY
         Ot9y1ElsAA0f+RFBFaw69oyKZG97hdBJM9JMWefiyngFra6a2b0OnfEeXlcb1wV+DANH
         /rjsxOOoWKEWkoxTqAqWTKGl8UPQeq4imYhw4LRY57sGKuWbvxRFgHOcUN3aOoUT8gCc
         1qsaTnxsh6Kwc9QwAGf6tBr6qrZEnBvz9Jfksh3FVCbVeqB3BkrqjII87Hq2HBmx1zeE
         /Yo/3+cr5eeasJTU18S9eX3djSe35QPcpJtheyaUlOQfhsG2ogfyeJz5Q+VB05CSBvqB
         Ti/g==
X-Gm-Message-State: APjAAAVqP5qU669ShdlT9V3rGUb8Fg8WAqUZ59dA5A6gCd57lPryW/fl
        GoAjgLhNrijc/gpxwzX42jbeNvHlMt0=
X-Google-Smtp-Source: APXvYqxUxJO41tjDrTbgflamTfC5aSZd7zs1i9SAit9TKxqvYcSuHloAsy+g1R5+3K5xxiipoD6Uzg==
X-Received: by 2002:a1f:2753:: with SMTP id n80mr19375871vkn.24.1580850489389;
        Tue, 04 Feb 2020 13:08:09 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id l125sm4088305vke.24.2020.02.04.13.08.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:08:08 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id g23so12408880vsr.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:08:08 -0800 (PST)
X-Received: by 2002:a67:8704:: with SMTP id j4mr21015690vsd.106.1580850488353;
 Tue, 04 Feb 2020 13:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20200204191206.97036-1-swboyd@chromium.org> <20200204191206.97036-3-swboyd@chromium.org>
In-Reply-To: <20200204191206.97036-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 13:07:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U6Yiv5i4PdDFqNhp0STqAvVi_=F_iuKyonx=MsOQFABQ@mail.gmail.com>
Message-ID: <CAD=FV=U6Yiv5i4PdDFqNhp0STqAvVi_=F_iuKyonx=MsOQFABQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] spi: spi-geni-qcom: Grow a dev pointer to simplify code
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 11:12 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Some lines are long here. Use a struct dev pointer to shorten lines and
> simplify code. The clk_get() call can fail because of EPROBE_DEFER
> problems too, so just remove the error print message because it isn't
> useful.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 46e501fc87f3..f0ca7f5ae714 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -536,6 +536,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>         struct spi_geni_master *mas;
>         void __iomem *base;
>         struct clk *clk;
> +       struct device *dev = &pdev->dev;
>
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
> @@ -545,28 +546,25 @@ static int spi_geni_probe(struct platform_device *pdev)
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>
> -       clk = devm_clk_get(&pdev->dev, "se");
> -       if (IS_ERR(clk)) {
> -               dev_err(&pdev->dev, "Err getting SE Core clk %ld\n",
> -                                               PTR_ERR(clk));
> +       clk = devm_clk_get(dev, "se");
> +       if (IS_ERR(clk))

There could be other errors besides -EPROBE_DEFER and devm_clk_get()
won't have printed in all cases.  ...but I agree that it seems highly
unlikely we'd ever hit any of those but highly likely we _would_ print
out a needless shout about -EPROBE_DEFER, so this is fine:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
