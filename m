Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB625C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B122077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEtA31kC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389095AbgDBRUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:20:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44323 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389042AbgDBRUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:20:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id m17so5139519wrw.11;
        Thu, 02 Apr 2020 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UNJ1uaTiNqIRTE+G4swZEf2hRjorhqOonJ08sUIRMO8=;
        b=jEtA31kCYdON/FahHCcg+UBAPDTy+pA+0phOgPakqyDAcWizWXyX2voqe6wOOShhz+
         lad+2Y+Y76Nug9dGKGO4MM6Q2ZQKJ9czz0E/xBDjQE9N7mG0M95Try7/j0B2rbQceGCY
         4QG77bLGCkcn1eVcULRpr8BblLziRJEpSpsEADs3Ej1K29FH53U02Nrmnniz/6ugULeu
         awM1dc0I4KYlvz2i210q6CiLt8W/7umpXeK1yi+U7B2WZJ8JF6mYeWRqD4Ftfi6PtGBw
         JrXmtfnWOWSF88o9sP1cP/5Vxh0+0uzDr2Ku8qDONJcFTLIcEompanRTmp0Engu85CIO
         PG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UNJ1uaTiNqIRTE+G4swZEf2hRjorhqOonJ08sUIRMO8=;
        b=pVugqHFn5a2eWamFg4vGI6EylC4/GxpPsJB3px9vx+gxjWlUESy+nZmyFPGB7PdC4a
         XwNUqosxvZpLZ6D0PMgv1MWpfR8ovIfA1Rp39AYeAvJs1Z2fnplenORTHhPPjrAIu2yW
         IEec32UWmWRnCHQpEycgStOoZkaYXRumKU9yVVCGoR1nw3vPb1TdVeI6fE2uoEL1v798
         1oy3pUdZ888BWuOmI8CQE6O839+Q+QEFH8KlNAyuaoXeRJ4Gtg5+vwQF6/aKXx+K2G7P
         4qDuKQvmGVKfdqm1eg3/6xwICuKHzXUPYABbcHtokkEXM7coogypFKo3U13N8iQsW16S
         lu8Q==
X-Gm-Message-State: AGi0PuY4O8IqmbUpDeniCJ+QOKeu3t+h66Jj2sDJtN0OZlMf/RIuYU8j
        vrnvjyADiGphfbsJzDRKpi4=
X-Google-Smtp-Source: APiQypKmwTbIEdvuK9WraXHHv2M4yWUIWm+FRJNIs5z6cWkO9BgGTzdDqqMxZD0Qzr89n/zfC45I+A==
X-Received: by 2002:adf:9168:: with SMTP id j95mr4319844wrj.145.1585848023290;
        Thu, 02 Apr 2020 10:20:23 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b199sm8670886wme.23.2020.04.02.10.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 10:20:22 -0700 (PDT)
To:     helen.koike@collabora.com
Cc:     dafna.hirschfeld@collabora.com, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, ezequiel@collabora.com,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        karthik.poduval@gmail.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org
References: <20200402000234.226466-5-helen.koike@collabora.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: add isp0 node for rk3399
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <1187d28a-6fb9-fd12-a422-8a4220a11e79@gmail.com>
Date:   Thu, 2 Apr 2020 19:20:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402000234.226466-5-helen.koike@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helen,

> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index fc0295d2a65a1..815099a0cd0dd 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1718,6 +1718,33 @@ vopb_mmu: iommu@ff903f00 {
>  		status = "disabled";
>  	};
>  
> +	isp0: isp0@ff910000 {
> +		compatible = "rockchip,rk3399-cif-isp";
> +		reg = <0x0 0xff910000 0x0 0x4000>;
> +		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru SCLK_ISP0>,
> +			 <&cru ACLK_ISP0>, <&cru ACLK_ISP0_WRAPPER>,
> +			 <&cru HCLK_ISP0>, <&cru HCLK_ISP0_WRAPPER>;
> +		clock-names = "clk_isp",
> +			      "aclk_isp", "aclk_isp_wrap",
> +			      "hclk_isp", "hclk_isp_wrap";

> +		power-domains = <&power RK3399_PD_ISP0>;
> +		iommus = <&isp0_mmu>;
> +		phys = <&mipi_dphy_rx0>;
> +		phy-names = "dphy";

Maybe a little sort? But keep rest as it is. Also in example.

		iommus = <&isp0_mmu>;
		phys = <&mipi_dphy_rx0>;
		phy-names = "dphy";
		power-domains = <&power RK3399_PD_ISP0>;

> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {

> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0>;

Move reg above #address-cells. Change that in example as well.

				reg = <0>;
				#address-cells = <1>;
				#size-cells = <0>;

> +			};
> +		};
> +	};
> +
>  	isp0_mmu: iommu@ff914000 {
>  		compatible = "rockchip,iommu";
>  		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
> -- 
> 2.26.0

