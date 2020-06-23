Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87817C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6555C20720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbgFWAxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:53:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:54132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732331AbgFWAxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:53:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F20E0AD66;
        Tue, 23 Jun 2020 00:53:42 +0000 (UTC)
Subject: Re: [PATCH v4 3/3] arm64: dts: realtek: Add RTD1319 SoC and Realtek
 Pym Particles EVB
To:     James Tai <james.tai@realtek.com>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20200620233227.31585-1-afaerber@suse.de>
 <20200620233227.31585-4-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <e2d87fdf-8be5-3496-b10d-d43ba3486508@suse.de>
Date:   Tue, 23 Jun 2020 02:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200620233227.31585-4-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.06.20 um 01:32 schrieb Andreas Färber:
> diff --git a/arch/arm64/boot/dts/realtek/rtd13xx.dtsi b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
> new file mode 100644
> index 000000000000..8c5b6fc7b8eb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
[...]
> +&iso {
> +	uart0: serial0@800 {

Node name should be serial, not serial0.

> +		compatible = "snps,dw-apb-uart";
> +		reg = <0x800 0x400>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <432000000>;
> +		status = "disabled";
> +	};
> +};
> +
> +&misc {
> +	uart1: serial1@200 {

Ditto, serial.

> +		compatible = "snps,dw-apb-uart";
> +		reg = <0x200 0x400>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <432000000>;
> +		status = "disabled";
> +	};
> +
> +	uart2: serial2@400 {

Ditto.

> +		compatible = "snps,dw-apb-uart";
> +		reg = <0x400 0x400>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <432000000>;
> +		status = "disabled";
> +	};
> +};

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
