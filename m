Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F309C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BEE206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588069566;
	bh=rru8l4Bm6wpCte8jUr7SS5h+I8zMs5cQo4003bnToGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zqo0/GIA+o1hq1Mfg2Gd6/su3yBaXOolPWFftanqH+eZB2xgzb4bCZs9YbkwJtomw
	 Gwau8xaY+v73MreDqSXkj0bRltfXhfmgZtrufr4JJbQrc2KI+M8UtTV/KbAPOnp9ev
	 cQAusu/oyahG6bbBV8IKp7/y2nTTCR08aDaShPgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgD1K0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:26:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42611 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgD1K0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:26:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10so15966806edy.9;
        Tue, 28 Apr 2020 03:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D19EgHm/8BStTYYiX33bzJpL0gjuVR6x68nTLwLkEok=;
        b=X6mbEkqjLIqruphdEYhNrzj2fdT7f6lFvf5WIfA1yWTwELNKfv24oFgMK1il20S9+S
         f6UKqZ/1mnmVGkK98an0EeWtjVQOHmB9Slo79gpKPYYrZvCY+trCLL+omgIyYQayOPLW
         aXN1Ng7Cy1qynBGCEiSvVqJ+VdS7i9Az3+vKqjLAxLXpob9jWS76AdBtdeFAyf4w0BY2
         mjU+6fgOrZRb0r5lusoMhS4zOstzHe+l7cyQoBSA7Yhpcv4hI5D11c/n6DPck4uCaBsx
         uKU6y/kTk2OU0t+Aq52JhiwayXfgxYgHhJ7ww4vmc0yt0jt8HDv1Xsu8i6xKMAlhiCrj
         mdrg==
X-Gm-Message-State: AGi0PubfwtJZqLuH8j+Wb24T9t6KaaZHI6iKaj+qOAzQZUqvRFAgM9uo
        46qfx7DLL+vD+e42v5uVB18=
X-Google-Smtp-Source: APiQypIySyRRLgxTsKOJvhiqPdeQHDwTqC6HW2bn+FZyDWntLyruBapInnwMX7MdEj+FvFYclV5ZOg==
X-Received: by 2002:a50:ec0c:: with SMTP id g12mr22967324edr.140.1588069562934;
        Tue, 28 Apr 2020 03:26:02 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id r4sm407418ejz.28.2020.04.28.03.26.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 03:26:02 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:26:00 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] arm: dts: s5pv210: Add an ADC node
Message-ID: <20200428102600.GC23963@kozik-lap>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <BN6PR04MB0660AAB00F5D36E2FEE22DE8A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660AAB00F5D36E2FEE22DE8A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 11:36:00AM -0700, Jonathan Bakker wrote:
> The exynos-adc driver now supports the S5PV210, so add the DT
> node so that devices can use it.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
> index 2ad642f51fd9..b3b6ad2889f9 100644
> --- a/arch/arm/boot/dts/s5pv210.dtsi
> +++ b/arch/arm/boot/dts/s5pv210.dtsi
> @@ -159,6 +159,18 @@
>  			};
>  		};
>  
> +		adc: adc@126c0000 {
> +			compatible = "samsung,s5pv210-adc";
> +			reg = <0xe1700000 0x1000>;

reg does not match the node address.

Run "make dtbs W=1" and be sure there are no new warnings.

Best regards,
Krzysztof


> +			interrupt-parent = <&vic2>;
> +			interrupts = <23>, <24>;
> +			clocks = <&clocks CLK_TSADC>;
> +			clock-names = "adc";
> +			#io-channel-cells = <1>;
> +			io-channel-ranges;
> +			status = "disabled";
> +		};
> +
>  		spi0: spi@e1300000 {
>  			compatible = "samsung,s5pv210-spi";
>  			reg = <0xe1300000 0x1000>;
> -- 
> 2.20.1
> 
