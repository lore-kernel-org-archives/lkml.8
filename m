Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777E6C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516E82467E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbgANKHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:07:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:52696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbgANKHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:07:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E44BEAFAE;
        Tue, 14 Jan 2020 10:07:06 +0000 (UTC)
Subject: Re: [PATCH] arm64: dts: realtek: rtd16xx: Add memory reservations
To:     linux-realtek-soc@lists.infradead.org,
        James Tai <james.tai@realtek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200103060441.1109-1-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <5c2a472c-39f7-f8e0-6df8-0d02d07990df@suse.de>
Date:   Tue, 14 Jan 2020 11:07:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200103060441.1109-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.01.20 um 07:04 schrieb Andreas Färber:
> Reserve memory regions for RPC and TEE.
> 
> Fixes: e5a9e237608d ("arm64: dts: realtek: Add RTD1619 SoC and Realtek Mjolnir EVB")
> Cc: James Tai <james.tai@realtek.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>   arch/arm64/boot/dts/realtek/rtd16xx.dtsi | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)

Ping! @Realtek: Please check the numbers.

Thanks,
Andreas

> diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
> index 3c70a0da329e..4dc6c9f13c43 100644
> --- a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
> +++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
> @@ -14,6 +14,25 @@
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>   
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		rpc_comm: rpc@2f000 {
> +			reg = <0x2f000 0x1000>;
> +		};
> +
> +		rpc_ringbuf: rpc@1ffe000 {
> +			reg = <0x1ffe000 0x4000>;
> +		};
> +
> +		tee: tee@10100000 {
> +			reg = <0x10100000 0xf00000>;
> +			no-map;
> +		};
> +	};
> +
>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
