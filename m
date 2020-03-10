Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CEFC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2839920873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="du2E0Fhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgCJTfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:35:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34041 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgCJTfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:35:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so3138176plm.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nKhwu1SDKAkcqVKvzUsWw/zCHl4XPJcIG2el7T4mPBQ=;
        b=du2E0Fhb4mJ/inZzgatzWqnzcvQZXtDZgmruya9zV4Gw+nnSIHd76VYPct8N7RGUkg
         UZ7vTHKGlquKipcijaAe92RqfW3igKTUmJRFBWBAA7h+XfKwmD5MCHVMgeW40XLczZKi
         OIHqUD3+FqEpQilbduiaEaWRgtRo+SsgbHYwfd+DSKp74W8tZJiz/b04q91tSg5Tt7KO
         Mk7rMARWOxAT1Qsnja4Gjy7Bl9owEbVprtyZGmMNAZjlvx4dZeuHdY0R2D8QvIjz8gB5
         tR3qEuKJsUjuy5KRr3kywpFl5nUUFLdDq/9GL5Mkv8KDkvljeeLA6pytKazAgqMlKeQw
         Dtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nKhwu1SDKAkcqVKvzUsWw/zCHl4XPJcIG2el7T4mPBQ=;
        b=fq+/KKhUtAEA96E937wU/DMepOx+UDZ+NOaNz61/0iSTIDWUdWvPT/5sRXbzeOUsPd
         MJohfTIxrAXQsW6TlKelUrslO2wkFJZzqxNbGqoTy47ZUs5sECtyc39lYwiQgdH+i+n5
         ey8U3vl5F1FSGNKYAzG+4MnLIT9lWIqJiYVkMZbfA87NyG6l9H4Zxp+uOSAQ9fH1DE6w
         g6BlKIADgeR9gfBnGi3uRq8+iUBvGFqGVq3HAWPCW3P5ahJY5GQfx44JBxfpzBn+zzQj
         hjEVKHgT2cXYKo9vyZKFC313h5/MYif46AQumm7Pvpaj6SIi5hFAXMGd74j5HDEyo/O5
         DUDw==
X-Gm-Message-State: ANhLgQ1ZnzxcsJJgxe52UJlcsrImNpN5N9Qy4v5RMeCdBdhIsEdgSa4m
        4P4D6rY5CAqZxyIG5WKEJycoaA==
X-Google-Smtp-Source: ADFU+vviFtgfAaWW0uY6/ztd897OrmyaVMgQQfuQtxMiBiAI3p2c1h6uHwAJhiBB9BSiymdPB6CFDA==
X-Received: by 2002:a17:902:321:: with SMTP id 30mr23122871pld.130.1583868928567;
        Tue, 10 Mar 2020 12:35:28 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c207sm8147791pfb.47.2020.03.10.12.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:35:27 -0700 (PDT)
Date:   Tue, 10 Mar 2020 12:35:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 1/3] i2c: qcom-geni: Let firmware specify irq trigger
 flags
Message-ID: <20200310193525.GM264362@yoga>
References: <20200310154358.39367-1-swboyd@chromium.org>
 <20200310154358.39367-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310154358.39367-2-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Mar 08:43 PDT 2020, Stephen Boyd wrote:

> We don't need to force IRQF_TRIGGER_HIGH here as the DT or ACPI tables
> should take care of this for us. Just use 0 instead so that we use the
> flags from the firmware. Also, remove specify dev_name() for the irq
> name so that we can get better information in /proc/interrupts about
> which device is generating interrupts.
> 
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 17abf60c94ae..4efca130035a 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -549,8 +549,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	init_completion(&gi2c->done);
>  	spin_lock_init(&gi2c->lock);
>  	platform_set_drvdata(pdev, gi2c);
> -	ret = devm_request_irq(&pdev->dev, gi2c->irq, geni_i2c_irq,
> -			       IRQF_TRIGGER_HIGH, "i2c_geni", gi2c);
> +	ret = devm_request_irq(&pdev->dev, gi2c->irq, geni_i2c_irq, 0,
> +			       dev_name(&pdev->dev), gi2c);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Request_irq failed:%d: err:%d\n",
>  			gi2c->irq, ret);
> -- 
> Sent by a computer, using git, on the internet
> 
