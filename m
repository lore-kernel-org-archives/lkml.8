Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9131C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D2B20739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="aCnNa8qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGETvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:51:40 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.155]:41616 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728192AbgGETvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:51:39 -0400
X-Greylist: delayed 1445 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Jul 2020 15:51:38 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 9C38E40101C20
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 14:27:33 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id sAIXjWm4LhmVTsAIXjDFvi; Sun, 05 Jul 2020 14:27:33 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vrjr1nj8KOe3zMr+d74rhqHv+pmipDyhk9OOQDkG6PI=; b=aCnNa8qtRFecnacf/0d8erolWb
        PeicM4hfCmDNxbhwShy2xbLAHTN1/eA5zBxWWd5u5OILpDsTbGLgMvxDqwZVj49AayAZXabcyOhny
        VmbDQjg55BZQ2QA2Uwg/6T58TP8XpA2VEmwXl1njtWb2FXO3nWo8C9RAV8BWBxHAlW97Xmwb7Vb+j
        UiczfePJDJfe0xYZ1h2qV3Ih6hftSs4xGc8yBCSOHdzPuloVV6ijN/GFFwUPSqucVU2Ms+lODk8y9
        frGaoGhjwdzhCAvoralcTYrU75zdZfhqqV5+BIE6HZhlOd6wjxWDpjA8/W0O6qc2fIY+XEUZswsEX
        nEdNXpVA==;
Received: from [189.59.31.158] (port=55228 helo=[192.168.15.5])
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1jsAIX-004CGN-7r; Sun, 05 Jul 2020 16:27:33 -0300
Subject: Re: [PATCH v6 3/3] ARM: dts: Add Caninos Loucos Labrador
To:     afaerber@suse.de
Cc:     manivannan.sadhasivam@linaro.org, mark.rutland@arm.com,
        robh+dt@kernel.org, edgar.righi@lsitec.org.br,
        igor.lima@lsitec.org.br, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org
References: <20200525132218.190841-1-matheus@castello.eng.br>
 <20200525132218.190841-4-matheus@castello.eng.br>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <755962b7-c66b-a27f-c0ec-2eec416f1528@castello.eng.br>
Date:   Sun, 5 Jul 2020 16:27:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200525132218.190841-4-matheus@castello.eng.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: pt-BR
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 189.59.31.158
X-Source-L: No
X-Exim-ID: 1jsAIX-004CGN-7r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [189.59.31.158]:55228
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 18
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

let me know if there are any more concerns about this series.

BR,
Matheus Castello

Em 5/25/20 10:22 AM, Matheus Castello escreveu:
> Add Device Trees for Caninos Loucos Labrador CoM and base board.
> Based on the work of Andreas Färber on Lemaker Guitar device tree.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Andreas Färber <afaerber@suse.de>
> ---
>   arch/arm/boot/dts/Makefile                    |  1 +
>   .../arm/boot/dts/owl-s500-labrador-base-m.dts | 34 +++++++++++++++++++
>   arch/arm/boot/dts/owl-s500-labrador-v2.dtsi   | 22 ++++++++++++
>   3 files changed, 57 insertions(+)
>   create mode 100644 arch/arm/boot/dts/owl-s500-labrador-base-m.dts
>   create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e8dd99201397..0f8c1f255574 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -856,6 +856,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
>   dtb-$(CONFIG_ARCH_ACTIONS) += \
>   	owl-s500-cubieboard6.dtb \
>   	owl-s500-guitar-bb-rev-b.dtb \
> +	owl-s500-labrador-base-m.dtb \
>   	owl-s500-sparky.dtb
>   dtb-$(CONFIG_ARCH_PRIMA2) += \
>   	prima2-evb.dtb
> diff --git a/arch/arm/boot/dts/owl-s500-labrador-base-m.dts b/arch/arm/boot/dts/owl-s500-labrador-base-m.dts
> new file mode 100644
> index 000000000000..044568fec25e
> --- /dev/null
> +++ b/arch/arm/boot/dts/owl-s500-labrador-base-m.dts
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Caninos Labrador Base Board
> + *
> + * Copyright (c) 2019-2020 Matheus Castello
> + */
> +
> +/dts-v1/;
> +
> +#include "owl-s500-labrador-v2.dtsi"
> +
> +/ {
> +	model = "Caninos Labrador Base-M v1.0a";
> +	compatible = "caninos,labrador-base-m", "actions,s500";
> +
> +	aliases {
> +		serial3 = &uart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial3:115200n8";
> +	};
> +
> +	uart3_clk: uart3-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <921600>;
> +		#clock-cells = <0>;
> +	};
> +};
> +
> +&uart3 {
> +	status = "okay";
> +	clocks = <&uart3_clk>;
> +};
> diff --git a/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
> new file mode 100644
> index 000000000000..883ff2f9886d
> --- /dev/null
> +++ b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Caninos Labrador SoM V2
> + *
> + * Copyright (c) 2019-2020 Matheus Castello
> + */
> +
> +#include "owl-s500.dtsi"
> +
> +/ {
> +	model = "Caninos Labrador Core V2.1";
> +	compatible = "caninos,labrador-v2", "actions,s500";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000>;
> +	};
> +};
> +
> +&timer {
> +	clocks = <&hosc>;
> +};
> --
> 2.26.2
> 
