Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F355C38A2B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A21D22209
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkmM8Grt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDRJPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 05:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgDRJPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 05:15:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F4EC061A0C;
        Sat, 18 Apr 2020 02:15:30 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u127so4305940wmg.1;
        Sat, 18 Apr 2020 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bhjKQUnbVfHMUqcN6C3pNEvI0BmRCXrqJn+ILoBLgNE=;
        b=XkmM8GrtAWmq88n7v4WYH6fYf+5ZAxXJw/ew3C3zLCtrrrXnrsQmkd2jAdRGBp/7Cx
         RRm80J2pNErUhL/gsnwUPiJDq8a+qN0wz/LCvzM92JjQcz0KXmYeXfxgQB5h8e/rxenA
         MifVfVQ6wmYplReoa9RCT08vHBEu3tcbcwRcx9iB9vMpig8K/N/iEvSshglaqwYnLDmg
         +0ttbfmHuizmX3+MIDngAm2pkHvLDxq37KTK6Ft/HHzoQs4Y+Kpj2z6wGkpKjMzgqxLZ
         V7Y8Is0oukpKZ+2JXZjYMrdtnOHzqtt18HvvGxb1fc0FvqMoaSPMbJniEDfqge1fV9YS
         xI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bhjKQUnbVfHMUqcN6C3pNEvI0BmRCXrqJn+ILoBLgNE=;
        b=Ru3dzY/QzOMQBdko9cWh9INrBCmeZflzF/2BI0soxbGpYkWma94wnNIbI3DCUcAjcH
         JMJfaXsRJOTl2WOO5PzYu44gA8GOpNkbVLJY9aLiMizTAuWRsQOkvwX3683PJe8zY/ri
         YRLK4ZusLgIfQ3ruvmXcaQ4300rripfq2AxibZFf/kl94HsUFlq0hUY6NSwqjU5002HW
         4jyoVUla+PjZvA+fF/z1bEOPuRySRLUXVU2N6Gio8PNExVfF9U/WbkEYJalg+JZpE6qs
         7/MqW0U0M1C/oxe2fWDfGKhO53CBVywsg0uUNfz7IRm3ZI6J3HqK9V9VHjjR3NNFpXEa
         ++BA==
X-Gm-Message-State: AGi0PuYwa1ViKPZveDNHsXXnL+RZvFmSpjCCP8ZHy8Pk39AP0jZ8QJN8
        mPUHCCIxnacJK9akYDZz9fa/gZjv
X-Google-Smtp-Source: APiQypL+lEVsy+IjxBz7XNE27DJExvB6yoFZDOdt3iHp4l3KsnmgBJLkmn7TarbBva1+K29KE7xiVQ==
X-Received: by 2002:a1c:ac44:: with SMTP id v65mr7447837wme.33.1587201329312;
        Sat, 18 Apr 2020 02:15:29 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k23sm11359188wmi.46.2020.04.18.02.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 02:15:28 -0700 (PDT)
To:     justin.swartz@risingedge.co.za
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org
References: <be4f2c802a64562cbab629abc82dd7d228a1a747.1580768038.git.justin.swartz@risingedge.co.za>
Subject: Re: [PATCH v4 2/3] ARM: dts: rockchip: add rga node for rk322x
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <bf3a2b97-4a24-e9f0-599b-4731cc94a067@gmail.com>
Date:   Sat, 18 Apr 2020 11:15:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <be4f2c802a64562cbab629abc82dd7d228a1a747.1580768038.git.justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin, Heiko,

In the discussion about "rockchip,px30-rga" it was mentioned that:
"no status for soc internal components without any board-specifics".
The binding is in mainline, but the dts node is missing I think.
Should this also be changed?

Johan

+&rga {
+	status = "okay";
+};
+

> Add a node to define the presence of RGA, a 2D raster
> graphic acceleration unit.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  arch/arm/boot/dts/rk322x.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
> index 340ed6ccb..29d50bebc 100644
> --- a/arch/arm/boot/dts/rk322x.dtsi
> +++ b/arch/arm/boot/dts/rk322x.dtsi
> @@ -621,6 +621,17 @@
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

remove?

> +	};
> +
>  	iep_mmu: iommu@20070800 {
>  		compatible = "rockchip,iommu";
>  		reg = <0x20070800 0x100>;
> -- 
> 2.11.0

