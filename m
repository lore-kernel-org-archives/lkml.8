Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6D3C5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F69206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SvUvd1yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgD0GtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgD0GtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:49:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25F3C061A10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:49:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j1so19127886wrt.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OIRTtsyYCkg1t+ohXCk6lMBH379NOlwqIHq+QRjBm7Y=;
        b=SvUvd1yxOiPnMe9YAUHgv8lQk0A2/6HHwopTOUCWs8NALsr8IaE+hEzfoKEo1yuqs2
         TjmUIlPobyTTQwgv36TEaJLcVdpJsaOogMMa4AuCDJpBCcsgiZU/DME2f/khPL6iHlIg
         EK+qQPX4JJRFUEvhskXLGcPGW04SF1toxWWM+RmxQ3XLi2BNb7WkSIEi+Hr6YfkXUGV9
         7r/ITt+NXy5qzPvRpN8Ht1AKkwLhwe14aeKCNyTT33vTINcvj7L/SRGzEV1yKIvqLi/8
         9pMTJn7ubL6lG8FAp4pE5t90T8NoZdw8q65UAq+7ypuxycxcTarTTWVpeWiyRhymWdH5
         vfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OIRTtsyYCkg1t+ohXCk6lMBH379NOlwqIHq+QRjBm7Y=;
        b=YZ+J866KE+rZmFXY6AiUJeYsf6AoE+eL7zF5aWU3GLFX0IeLq5qa8+RnHgc1Lzo8jQ
         YQm2TpgvRhbPpy2tp2PSRMKHVjmqdzahch5Hd0Qjn6900hDAyo6r/qYwLe9rfZD7sWsV
         QHgj2TPDYg0thgBeKQIxnQ6tJ+EOaJ/Dr76PM0MGwbh6+3YcR70nGsfdyBpByoX2HJG9
         iZjWKcxPVUSc241crBieQZfP1s624i1ZBYQ45zvy/COGYXFxSXtgSiif0DRa7BCSGfjZ
         UqngqBMKZfc7HRUbYwT9+WHuv5K5bYfmtH8F+LcYCJZLWZjxWzTRtot04FrltEOZoNmU
         xkmA==
X-Gm-Message-State: AGi0Pub8XqzhlV7Bcd+TxWMQCSPu/iG2u61uXYsodwo9RlW/0u+teqe3
        GOvBiCdiqlSjLpAxGXSCc3goVA==
X-Google-Smtp-Source: APiQypI8chzF5P4rL2qpeRVXfTfA1qmduiJM0OWyA6AOLxbJHzUHnF5rqPqCGyojl0yXIHmSI+roCA==
X-Received: by 2002:adf:f884:: with SMTP id u4mr25202217wrp.171.1587970153463;
        Sun, 26 Apr 2020 23:49:13 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id z10sm20140795wrg.69.2020.04.26.23.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 23:49:12 -0700 (PDT)
Date:   Mon, 27 Apr 2020 07:49:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Adrian Pop <pop.adrian61@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] arm: dt-bindings: mfd: stm32f-rcc: Add missing DSI
 clock
Message-ID: <20200427064910.GC3559@dell>
References: <20200424181642.32084-1-pop.adrian61@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200424181642.32084-1-pop.adrian61@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020, Adrian Pop wrote:

> Add missing clock.
> 
> Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
> ---
>  include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
>  1 file changed, 1 insertion(+)

I assume patch 2 depends on this?

If so, where is it?  Why isn't it in my inbox?

> diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-bindings/mfd/stm32f7-rcc.h
> index a90f3613c584..ba5cb7456ee4 100644
> --- a/include/dt-bindings/mfd/stm32f7-rcc.h
> +++ b/include/dt-bindings/mfd/stm32f7-rcc.h
> @@ -107,6 +107,7 @@
>  #define STM32F7_RCC_APB2_SAI1		22
>  #define STM32F7_RCC_APB2_SAI2		23
>  #define STM32F7_RCC_APB2_LTDC		26
> +#define STM32F7_RCC_APB2_DSI		27
>  
>  #define STM32F7_APB2_RESET(bit)	(STM32F7_RCC_APB2_##bit + (0x24 * 8))
>  #define STM32F7_APB2_CLOCK(bit)	(STM32F7_RCC_APB2_##bit + 0xA0)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
