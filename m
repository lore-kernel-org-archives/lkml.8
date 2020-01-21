Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28175C33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F186720882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbrEasHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgAUVen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:34:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39714 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgAUVem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 16:34:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so4860592wmj.4;
        Tue, 21 Jan 2020 13:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QFH+//39kLcoKOXngfJAlgHhrZQMBT4NmggY27rdTyU=;
        b=fbrEasHoDjvPf4cA4L0MXUjPMeps2Tmyr8xvgIceVWSNiBOfTtn0nIuyQTHoPCtXJw
         hKqfTEhssZJVp5fhLfQo2YUF1TyTW4WgH+WvixzRc1sUff5cpMdJPHP05eCpORSD+dwa
         AF8yCjwqEbL7+MBPiGYHfehU/Cvc0sPxntoT0e68t9zp+tKAioe2nBcWYtRDVJq6ZJ40
         QmLOzmIMw4FV4MhZxQaeribnqbyiLydAX+cRwBXhB4NV9uXffpqcgqu6SiIevq9N4cp0
         fEFisw4lce/nWoEeLLqnLVwSiKZa5cSe693QvgrK1xwvkwcWAgBTKwZNGYJjoI9G+x3f
         VNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QFH+//39kLcoKOXngfJAlgHhrZQMBT4NmggY27rdTyU=;
        b=b9ATOF5yvIJuSQrNMGBuwG9JqzBplAozmGo1KLxQ6GahbQzbeML0+YaJ9EZv2E2xr6
         XTniqfSR3Adi2uySt12UL01rllZD26GPUl4xKDEEvDuHu9+xoHTn6y66u3y2McL8lnIU
         Komu19k8VXUwkqP/xA0GYA367TvmXG1trHdPUGuUzLz/t1Jc882ipWOPcwH3oc08BeUj
         ZyXxsZSWj3SLhiOs0qyclOgnwGwRuQM1+woGA47/ZDAz6A0/4m7PDU6tD4dyTkaMYkvp
         KpxOVaM18zHUETzHEJn9hnSAzz3E884IKghhE11+qHwaAOU/to5smYRX3uME2lsr+K+y
         2bIg==
X-Gm-Message-State: APjAAAUmbTOFTOpqnhLaXQPU2Nqwdm/12Kepx/CZRA/jF98Y114+QMho
        kvpxdYJ74vrR9D8tbcQG2HQ=
X-Google-Smtp-Source: APXvYqwkXwtjqW26Qcpp7Hc7ja9Peywxh2VKCHRM058jDHvPrCPmq+NCtFnrfyEZR0PUI5IV4EMZtA==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr372114wmg.20.1579642480490;
        Tue, 21 Jan 2020 13:34:40 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p5sm51848659wrt.79.2020.01.21.13.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 13:34:40 -0800 (PST)
To:     justin.swartz@risingedge.co.za
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org
References: <20200121201146.18038-2-justin.swartz@risingedge.co.za>
Subject: Re: [PATCH v2 1/2] ARM: dts: rockchip: add rga node for rk322x
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <7d85210b-e554-d875-0615-c2e93a264b5b@gmail.com>
Date:   Tue, 21 Jan 2020 22:34:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200121201146.18038-2-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

rga is now inserted above vpu_mmu.
Please check the address.

rga:       rga@20060000 {
vpu_mmu: iommu@20020800 {

Should go between vop_mmu and iep_mmu.

vop_mmu: iommu@20053f00 {
rga:       rga@20060000 {
iep_mmu: iommu@20070800 {

> Add a node to define the presence of RGA, a 2D raster graphic
> acceleration unit.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  arch/arm/boot/dts/rk322x.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
> index 340ed6ccb..efa733207 100644
> --- a/arch/arm/boot/dts/rk322x.dtsi
> +++ b/arch/arm/boot/dts/rk322x.dtsi
> @@ -566,6 +566,17 @@
>  		status = "disabled";
>  	};
>  
> +	rga: rga@20060000 {
> +		compatible = "rockchip,rk3228-rga", "rockchip,rk3288-rga";
> +		reg = <0x20060000 0x1000>;
> +		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA>;
> +		clock-names = "aclk", "hclk", "sclk";
> +		resets = <&cru SRST_RGA>, <&cru SRST_RGA_A>, <&cru SRST_RGA_H>;
> +		reset-names = "core", "axi", "ahb";
> +		status = "disabled";
> +	};
> +
>  	vpu_mmu: iommu@20020800 {
>  		compatible = "rockchip,iommu";
>  		reg = <0x20020800 0x100>;
> -- 
> 2.11.0

