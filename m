Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D52C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A854320702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYbs+Bkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgGLRZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 13:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgGLRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 13:25:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60469C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:25:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ch3so4979075pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6EsedWsSBU7+QbAVKXxR4rnaZ7gRL2P2rCCnvCziqfE=;
        b=PYbs+BklM37KkhaDrqT74iSZil79Wzi9Q/xPOBIMr7s7LhKWnUjeqCAwawM9yF6ktW
         Pdw4MFPZ5cdoLLaNKbWCw1D3OlmE9YUSxKtaDiX3e3UON5o0QMn6PxGpL5hnPyr9DQPc
         haKQ6dRblP1BQ36/wrBr10nbPAvoMT1FSsKlIZEXu6isXbAzfJPxzekDnccHjV6y8qmp
         /23Nzj9R/GtwS1P4ISJm/BjAbAWLrEZ0gI+ou7EmDzr70WfSY02RIUXLc6rItCrTlTP1
         lKiR7rdyeIkUeskXDAUk7pkzbm8vgwhanssusYIgApbywcAKU7TPPbYCkxHrJyrvxHs1
         eotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6EsedWsSBU7+QbAVKXxR4rnaZ7gRL2P2rCCnvCziqfE=;
        b=dUosK/On2C+9toXT9ydD1bxYazEtZv+3Qi2QrFUR18quDmQcIs+GnxsErSnBSAxAAB
         AiPjPViYcalz4d9svDSlMZm15mPRqJ+02ixHnNIad+wsFWq5YXxbYoKaDGJBAfX9ObIH
         B9pQrBJABh0uwubmumDrRIC3G8vVimCesm2qNhqT7SuyHldLIaUMWdbnDSLtJ9M57T6O
         GWBd4kpJKyfxLLU/hV/jLYFaWL45EFtCl8OTCOOC7wZXXqcnbFflo3I2OAwaG7vDFS3S
         PuPZRGCXB5mcQKouYPF/2OVoXXYAVmQaD8SYVeRzaAFbQm2ERJ4MsP6qUa+gPBkuceaM
         WQkw==
X-Gm-Message-State: AOAM5318/DZPlJ5N5yvwK/KfriPnHxaGkQLBYlf6nAQsMPjkmYvAhfvE
        AA8da6AMyvIzj+/CSvVfPoSsK1fqKw==
X-Google-Smtp-Source: ABdhPJxc+DhSSc40Se+WrM+yhdltZ8Yq5UM83EyxtWc9Apiohrjbi9vXe6wEB561QDNauaB+R76bSg==
X-Received: by 2002:a17:902:54c:: with SMTP id 70mr30488395plf.0.1594574707850;
        Sun, 12 Jul 2020 10:25:07 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6c81:c187:70f5:3123:b5de:e77f])
        by smtp.gmail.com with ESMTPSA id l207sm362799pfd.79.2020.07.12.10.25.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 10:25:07 -0700 (PDT)
Date:   Sun, 12 Jul 2020 22:55:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, robh+dt@kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 07/10] dt-bindings: reset: s700: Add binding constants
 for mmc
Message-ID: <20200712172501.GI6110@Mani-XPS-13-9360>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-8-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593701576-28580-8-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:22:53PM +0530, Amit Singh Tomar wrote:
> This commit adds device tree binding reset constants for mmc controller
> present on Actions S700 Soc.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes since v4:
> 	* No change.
> Changes since v3:
>         * No change.
> Changes since v2:
>         * No change.
> Changes since v1:
>         * No change.
> Changes since RFC:
>         * added Rob's acked-by tag
> ---
>  include/dt-bindings/reset/actions,s700-reset.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
> index 5e3b16b8ef53..a3118de6d7aa 100644
> --- a/include/dt-bindings/reset/actions,s700-reset.h
> +++ b/include/dt-bindings/reset/actions,s700-reset.h
> @@ -30,5 +30,8 @@
>  #define RESET_UART4				20
>  #define RESET_UART5				21
>  #define RESET_UART6				22
> +#define RESET_SD0				23
> +#define RESET_SD1				24
> +#define RESET_SD2				25
>  
>  #endif /* __DT_BINDINGS_ACTIONS_S700_RESET_H */
> -- 
> 2.7.4
> 
