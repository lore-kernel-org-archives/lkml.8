Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5435C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B3F206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MLqBA+ES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgGLR25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 13:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgGLR25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 13:28:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D136DC08C5DB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:28:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc9so4989026pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L5dSr1nC5D/IYDKhdvnMqPrHsXwtIdTJ8WWjQdsf8D8=;
        b=MLqBA+ESgd4NyRvFeI669J84ywiAGrd14vy7HyOanZr1zFRenEmrFvUXtdNPCixsy+
         yk0L3FwmzxNZ7CCGti2xLlKmaPIXoLIwUzanv7B+w8gR7sbrAxjOXvypsG7jdNlVLNmR
         BMHyEBymNE0c1GVdnySL8qSwfUlj18y9sPnmJLjbOEALWaWSPbzY2f+wnnsXm5Dk+5hx
         Wg51+8Wlo20c3MIW0mR++sAYvf4+SNsYknU+MSctB8EkfyzOzkcWmnop/rdWIWK/ItPS
         A5ovwfuRtaaBuqXPxOsVNwSYI4EOhHX9Sjlg+UcOmBJVVXErYmZPQxYOJWzOjHZSbMu3
         Dl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L5dSr1nC5D/IYDKhdvnMqPrHsXwtIdTJ8WWjQdsf8D8=;
        b=b19Hw7jpLrrQfwhmE3hod9ucg48YBSbYfV577WlJFncvk1IX8csaJ2CUONBku4pBUB
         KHzvmCsjaPjFWzpJms0gldfJC0T/wM/CWzovuBelIXVhaPNwOn9EXzckuMndOC3/zYfr
         xhqRvZq2SnGsGwNZxAohoq/j7ylp4KMe/Rkd7dmJmL3QUDzM/yoWoajOAybDS+39zOYh
         Q7xYF6uTyiDtaasTaR9vOFl0bXQo0Zol7yW4SUyBUhb8QmZkgyQdeFQPrkklu5JuJU5p
         IMfoDQaYq4p9XTrGjrQvLtSwpIN/G+pO15iZxmqK59UdatGG/77zTX5/L42TBkjA22so
         qAKQ==
X-Gm-Message-State: AOAM531huC258zSOMHu5UCC+F6m+3XI/6cNlMCh3pwuqokDfMlwfdJjo
        SJNDzJMqNwAWfDd0GbP0YBWU
X-Google-Smtp-Source: ABdhPJzSPuanrHhafW6G+C+jAuI9ngdx9Zo1hE63VaewrCghmMqCLco3/d4PW3NetlraPsWZZhQXxw==
X-Received: by 2002:a17:902:a708:: with SMTP id w8mr25369217plq.128.1594574936077;
        Sun, 12 Jul 2020 10:28:56 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6c81:c187:70f5:3123:b5de:e77f])
        by smtp.gmail.com with ESMTPSA id j5sm12140400pfa.5.2020.07.12.10.28.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 10:28:55 -0700 (PDT)
Date:   Sun, 12 Jul 2020 22:58:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, robh+dt@kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 09/10] arm64: dts: actions: Add MMC controller support
 for S700
Message-ID: <20200712172850.GK6110@Mani-XPS-13-9360>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-10-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593701576-28580-10-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:22:55PM +0530, Amit Singh Tomar wrote:
> This commits adds support for MMC controllers present on Actions S700 SoC,
> there are 3 MMC controllers in this SoC which can be used for accessing
> SD/EMMC/SDIO cards.
> 
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
>         * Added SoC specific compatibe string.
> Changes since RFC:
>         * No change
> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 2c78caebf515..9ed88aafc2da 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -259,5 +259,38 @@
>  			clocks = <&cmu CLK_DMAC>;
>  			power-domains = <&sps S700_PD_DMA>;
>  		};
> +
> +		mmc0: mmc@e0210000 {
> +			compatible = "actions,s700-mmc", "actions,owl-mmc";
> +			reg = <0x0 0xe0210000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_SD0>;
> +			resets = <&cmu RESET_SD0>;
> +			dmas = <&dma 2>;
> +			dma-names = "mmc";
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@e0214000 {
> +			compatible = "actions,s700-mmc", "actions,owl-mmc";
> +			reg = <0x0 0xe0214000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_SD1>;
> +			resets = <&cmu RESET_SD1>;
> +			dmas = <&dma 3>;
> +			dma-names = "mmc";
> +			status = "disabled";
> +		};
> +
> +		mmc2: mmc@e0218000 {
> +			compatible = "actions,s700-mmc", "actions,owl-mmc";
> +			reg = <0x0 0xe0218000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_SD2>;
> +			resets = <&cmu RESET_SD2>;
> +			dmas = <&dma 4>;
> +			dma-names = "mmc";
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> 2.7.4
> 
