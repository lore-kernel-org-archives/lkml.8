Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63A9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833DA20707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNpzDrmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgFVIGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFVIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:06:16 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45339C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:06:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g7so12313824oti.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RCGFWVoC+22vi5fGF/Lzmf9sDoYHuK/JibjQYr3rU/Y=;
        b=RNpzDrmu/1ExMjMNc3/90lZOQTc6y1Ts0qeHUevG26B05m1/F/EMtiDaHXeF8qfsr7
         GKoEFysjLRg6rx9Zx1JSdq7fHG/cCuZJyre4QKxW1VSZ5aF/zw5+9I8ohCiSH94IQWNc
         z0wSthDKVujjSIBEINJWoJlPBNYblC99IVxxx5HDdmk3QS0AXZVlK2JN91MFMeMs/ZYl
         BYwa6zOxzp7ToJ0ny1CbEZgzfbsK6QZ2TVdjSA0CJ0zUFsh6MbyiM8CTTD1jJSFfAZ0x
         uBJpEgb05sarWVdKVLuM+THYvmvCoprm03aRDMwMbEzVczRiUBbXdA7UvnvQYoGUmOV5
         Ls+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RCGFWVoC+22vi5fGF/Lzmf9sDoYHuK/JibjQYr3rU/Y=;
        b=lduRRvZuFi6Nhs/6xkiVAPvfwxsuFIbOynTcMao+pfuWY1NELxcVMVSFLga0sY6ZiY
         zFmHDqmcinQf/62qXbmavre+y/CPVLoD7Hoc9qPJtfpiBVk5qLOCOWppDSoth2/wSfTT
         gsM6FrVgM6jDZHc1p/AYGlhuOmAO1oQrookqSckpoYC4JJ+bTwW6aiNvkRv6ucwciYvJ
         mfNtGbQZqrpfqjAGfhptElvzY/OERXMnvjGK0RUC7XpPK1K0u0nJsPJ9llRmzr4WvnTw
         R0klzxhoYAvnLG84Ce4gSVcq7YqPIoXB9I3hjxnyiDWVJYPGIkeI8rXVosgy9u+9dFcQ
         QdZA==
X-Gm-Message-State: AOAM532cdjWPwItCjqAnHjZaSdQ2qx6C5amgjjSBE55s4Ab99hwEXfs7
        qQviu8dwCeGLbetNVDTqY4oB/A==
X-Google-Smtp-Source: ABdhPJx3DnAh2tMtG2FaBUndVdH5/vjM9U66Owh7njm0BJFz0Y2FVlFk93FnZDPI61FWL/XHCPvV2Q==
X-Received: by 2002:a9d:7b41:: with SMTP id f1mr13350822oto.363.1592813175637;
        Mon, 22 Jun 2020 01:06:15 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f5sm3239196oou.47.2020.06.22.01.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 01:06:14 -0700 (PDT)
Date:   Mon, 22 Jun 2020 01:03:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/8] Documentation: Document pm660(l) SPMI GPIOs
 compatible
Message-ID: <20200622080329.GD2421@builder.lan>
References: <20200622075749.21925-1-konradybcio@gmail.com>
 <20200622075749.21925-3-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622075749.21925-3-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Jun 00:57 PDT 2020, Konrad Dybcio wrote:

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
