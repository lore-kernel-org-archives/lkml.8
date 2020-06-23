Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3C8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D912220771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAVFzV6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbgFWH3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731547AbgFWH3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:29:23 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE73C061797
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:29:23 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d67so18011678oig.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fWjmAOPbHTLJzpYz+sy+z31E1izVE1LPqGR/mFW6VFs=;
        b=yAVFzV6PVBFAy2hY3vXcJzS1GczJUTFS5vZPzQh5LZcYNqiikW53hpz3rIe2XDPo8C
         0hyeFHa2yN+Ye8/nXtjZtOhOL1j0LPwEJxWCN6qm0oH9pzbzqypUzz6M7LrVrIYlznYR
         NhGdWbIxmcaBZFgmiZUGKeN1Y16cQJbhVGCnzhBcm10bHi2azAS2TcLflPfW4V501Ywm
         hu5zz2nY5lDEAk4TY/YCQZUdvTHan+c876RDZsWeZvM4eHYGP7Ly34ba71vF1bae+e4m
         ylnmMJ77TfoocM9VeWTlg7Qtt2Z6Yalq/jxUn9zZ3CHvUOVsRCncA6S4/4H4F/i1U49o
         4NZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fWjmAOPbHTLJzpYz+sy+z31E1izVE1LPqGR/mFW6VFs=;
        b=H0iS+Yg98PKxkVOTRPMQc5V+Gr99Y6R/1+wKdejWnjisvj6a3d5ItCtWaW08OIPZJ/
         57pVvCOmx0yJ0ApXS4JmhMO17zGG5LLDrg4ABaGumIIiawrzCoJnI/zyfPfkIafUAKCH
         FgwD1zTyzaN2lXqWjnzLr48UD0MEGgy6WSWWYR93USSgK1H8SdZqsiae6l3Z8JFaSEEf
         65Ipwepnf33kbNlZtgpgJ5XdDjwNUeVGdKGTZnM2QIcfcOp/F0W9/k7Og3aG/ZEMHpX1
         D85vkP8Gjns8hs4rJGIs6MQ90DWlLjvB+IZEx3tBVBa5T5kGEAYhummJxzBuQnaXxVAe
         IlpQ==
X-Gm-Message-State: AOAM531ErlfBlC32YNRBxGpcDq5lhAY0c2UjmJZCB3DSDJjdOi8fLARR
        RBN0txETzN0rZdbPo8xymsSjhA==
X-Google-Smtp-Source: ABdhPJzP34B3Rwc4zxe2WgbBZFWKaQe90xa2tW61z475GjCUrbJCMHJrlaNe1KIzYpPZ5uM2CEUNCQ==
X-Received: by 2002:a54:4495:: with SMTP id v21mr15211852oiv.35.1592897362777;
        Tue, 23 Jun 2020 00:29:22 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m3sm4040184oop.37.2020.06.23.00.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 00:29:22 -0700 (PDT)
Date:   Tue, 23 Jun 2020 00:26:38 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/7] Documentation: Document pm660(l) SPMI GPIOs
 compatible
Message-ID: <20200623072638.GZ128451@builder.lan>
References: <20200622192558.152828-1-konradybcio@gmail.com>
 <20200622192558.152828-3-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622192558.152828-3-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Jun 12:25 PDT 2020, Konrad Dybcio wrote:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> index 7be5de8d253f..c3d1914381ae 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> @@ -23,6 +23,8 @@ PMIC's from Qualcomm.
>  		    "qcom,pmi8994-gpio"
>  		    "qcom,pmi8998-gpio"
>  		    "qcom,pms405-gpio"
> +		    "qcom,pm660-gpio"
> +		    "qcom,pm660l-gpio"
>  		    "qcom,pm8150-gpio"
>  		    "qcom,pm8150b-gpio"
>  		    "qcom,pm6150-gpio"
> -- 
> 2.27.0
> 
