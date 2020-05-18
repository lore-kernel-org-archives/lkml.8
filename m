Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57522C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA48207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+mKwNYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgERXiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgERXiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:38:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB050C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:38:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so4864862plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jUXXsTVi/ol985AWsfw16Z8ftNIvXp6W/qpkEYQEo4U=;
        b=s+mKwNYijhWIaplbTKQgFR81bjW3dhUrsvBZ7376un9NuP3I9BnY+6jNHD4t+ESEGL
         pdsEJyHKaNVvZ8/L5F5XsY8rGOchEDnWk4/7SsbN8CVOa//TA+YsGneY/7JT9DmUQFR3
         H2VS+nh+KO/dzlck7nYlysUPYGCrwwt0lz/g4jjtsFFQYuNnz4XgWZU0IwWMgWqynTqN
         v8u3q/9APfJ+yBh7DnuvgnXF4fdpQDb4Y8ajPAzLuM5YhhLJFLjzHTbSdU7acdyDoNOx
         m+1pO09nOIhxXKWbNq5038Xp7ZHJ7IdhAT65XzSsWnqhlG3z739aJMzXOD9rL2LuRX2F
         5UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jUXXsTVi/ol985AWsfw16Z8ftNIvXp6W/qpkEYQEo4U=;
        b=NKO+vgx1zN6HxrxHRxXCc5gMqBIdjTHon1A6sZjidN6b6MVWj+8YIBdTejMoPGqj0f
         C+vYq/X0QgdrC3x0/xJr1VQwdgHbDvRAoe4QG7fA+SecO2JT0jNy6dlSGSMtTGagfh1O
         qfwqt/gUM0Z9betSZsEzNpcnsDuOQdSMV56/jysplTwXy37RXNeuTLmkFkG8IGOntx6k
         h1K5fEKDC0Lnom3vI2XOYXHQHya78g5igmEJJYmSZBxxEcuGUAZbverkW+AuJrd8K9RT
         HncZfgvVQ5ablww8nAjwjfwaKUS339qWMv+RdfpzXbVLDLo/ey7isbjqSATMdjvDsgDi
         V0KA==
X-Gm-Message-State: AOAM530ajw31pf/j1cnCvuJWqRhRj4/16NoqBBjo9LoCzZbpHc/n5sd4
        j3ZXgUrV9XuLYd9Vhxvub3kwQQ==
X-Google-Smtp-Source: ABdhPJxYl66UOfL4Wmt6zKr1t0JLL0daGRW0Q1y3cPixiDFAjzScVKrnHuzvjxMckb9CWPsZyYjdgg==
X-Received: by 2002:a17:90a:5802:: with SMTP id h2mr1765854pji.221.1589845103175;
        Mon, 18 May 2020 16:38:23 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i2sm8490631pgb.14.2020.05.18.16.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 16:38:22 -0700 (PDT)
Date:   Mon, 18 May 2020 16:37:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     agross@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable Qualcomm IPA and RMNet modules
Message-ID: <20200518233700.GF279327@builder.lan>
References: <20200518215455.10095-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518215455.10095-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 May 14:54 PDT 2020, Alex Elder wrote:

> Enable building the Qualcomm IPA driver as a kernel module.  To be
> useful, the IPA driver also requires RMNet, so enable building that
> as a module as well.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Applied

Thanks,
Bjorn

> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 9c6500b71bc6..56261fd7ea8d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -306,6 +306,7 @@ CONFIG_MLX4_EN=m
>  CONFIG_MLX5_CORE=m
>  CONFIG_MLX5_CORE_EN=y
>  CONFIG_QCOM_EMAC=m
> +CONFIG_RMNET=m
>  CONFIG_RAVB=y
>  CONFIG_SMC91X=y
>  CONFIG_SMSC911X=y
> @@ -313,6 +314,7 @@ CONFIG_SNI_AVE=y
>  CONFIG_SNI_NETSEC=y
>  CONFIG_STMMAC_ETH=m
>  CONFIG_TI_K3_AM65_CPSW_NUSS=y
> +CONFIG_QCOM_IPA=m
>  CONFIG_MDIO_BUS_MUX_MMIOREG=y
>  CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
>  CONFIG_AQUANTIA_PHY=y
> -- 
> 2.20.1
> 
