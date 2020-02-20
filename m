Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD77C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB402465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tDOc3Zzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgBTJiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:38:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39827 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgBTJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:38:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so1237691wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 01:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=91hJOg6mkO0g2GWClGuxRVigkpNiaYP+nKzj4TFaDHY=;
        b=tDOc3ZzhHCw3tQK9vmGLOg1WdfVWzGtbuuzsRJx/BgZ4qvQJdyNACmmIvCTjmpCd09
         lNXL2rbbLhR8eksjg4eCL28QEjCo6L9SPVxihR/YS9Uv1M4Ck9Qs/PjF0aBCzYViwZ4c
         7lqectiY9wU/r7O0Fs7elIkRanR4z9ZLunF6xIZQwKiXgEItBDf36uZLH8iznutginQz
         5tfUIcBQjA1CyfsuZUTtMtf1ACtjYbdfqOaYsnWaePSPGU55A/4cCwLIZ65JSLjkEN1o
         epYoZq365UnpMLy8qi1aWvE5MRJEQ93Le+SZKsSKSa2Fu/BHxACCBir43JeMtHIpPt8A
         ED8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=91hJOg6mkO0g2GWClGuxRVigkpNiaYP+nKzj4TFaDHY=;
        b=Lls4os5BeCHFwbB0Hg3OfCENL7xd8J02W3HpVodTZGG0axPeC2mO2J5EU2tbt93EUQ
         LHR+OLNp02sUCmyzo1xVy1luoWJF4LcG4z0t4J3e59tipLJqqZ49CZSUez++u9HmmJK/
         F20sH+iEvV7bLPeML/LrhCFf/gZ1cTbE3LM46899b9W+V0aO4v7d12VZgY+bAIHJ1lfz
         Wsw7P6ckkJSN0/lPJmQQvSbsmeZ6pllybJUwmCm/srGZn67zI7EkycY2mc7pCyKUtSkc
         X6q1t02Ep9Gn0D7IPT3L5zNjndaJDFSG+s1MPc7T7rdUb2Wx8ROZGMJoLcdqAP1M09Qh
         7PHw==
X-Gm-Message-State: APjAAAXebjLBd6ERcyJKKRvppSD6wNaNfS/1+Cul8yPb8Lr22QK8h/Ws
        +LXvxqUtQoGyVXy9lS+zUVndHwbr4nA=
X-Google-Smtp-Source: APXvYqzoG3nBri3g1BPDtmvxxv+KOfrysBzEib4/n1Zp8hr2ySi6LK5uYqHVZcun9F260Utu4C6kIQ==
X-Received: by 2002:a1c:bdc6:: with SMTP id n189mr3482954wmf.102.1582191481981;
        Thu, 20 Feb 2020 01:38:01 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1d8d:74ba:7173:f47f? ([2a01:e34:ed2f:f020:1d8d:74ba:7173:f47f])
        by smtp.googlemail.com with ESMTPSA id q124sm3745544wme.2.2020.02.20.01.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 01:38:01 -0800 (PST)
Subject: Re: [PATCH v4 2/3] mfd: stm32: Add defines to be used for clkevent
 purpose
To:     Benjamin Gaignard <benjamin.gaignard@st.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        tglx@linutronix.de, fabrice.gasnier@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200217134546.14562-1-benjamin.gaignard@st.com>
 <20200217134546.14562-3-benjamin.gaignard@st.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e9f7eaac-5b61-1662-2ae1-924d126e6a97@linaro.org>
Date:   Thu, 20 Feb 2020 10:38:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217134546.14562-3-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lee,

On 17/02/2020 14:45, Benjamin Gaignard wrote:
> Add defines to be able to enable/clear irq and configure one shot mode.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Are you fine if I pick this patch with the series?

> ---
> version 4:
> - move defines in mfd/stm32-lptimer.h
> 
>  include/linux/mfd/stm32-lptimer.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/mfd/stm32-lptimer.h b/include/linux/mfd/stm32-lptimer.h
> index 605f62264825..90b20550c1c8 100644
> --- a/include/linux/mfd/stm32-lptimer.h
> +++ b/include/linux/mfd/stm32-lptimer.h
> @@ -27,10 +27,15 @@
>  #define STM32_LPTIM_CMPOK		BIT(3)
>  
>  /* STM32_LPTIM_ICR - bit fields */
> +#define STM32_LPTIM_ARRMCF		BIT(1)
>  #define STM32_LPTIM_CMPOKCF_ARROKCF	GENMASK(4, 3)
>  
> +/* STM32_LPTIM_IER - bit flieds */
> +#define STM32_LPTIM_ARRMIE	BIT(1)
> +
>  /* STM32_LPTIM_CR - bit fields */
>  #define STM32_LPTIM_CNTSTRT	BIT(2)
> +#define STM32_LPTIM_SNGSTRT	BIT(1)
>  #define STM32_LPTIM_ENABLE	BIT(0)
>  
>  /* STM32_LPTIM_CFGR - bit fields */
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

