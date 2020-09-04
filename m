Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD11C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E54B207EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgIDICf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgIDICa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:02:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D794C061244;
        Fri,  4 Sep 2020 01:02:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 149A22958A0
Subject: Re: [PATCH] arm64: dts: mt8173-elm: fix supported values for
 regulator-allowed-modes of da9211
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     kernel@collabora.com, dafna3@gmail.com
References: <20200903142819.24487-1-dafna.hirschfeld@collabora.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5d504bea-0934-91a9-c052-e463ad6c6d95@collabora.com>
Date:   Fri, 4 Sep 2020 10:02:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903142819.24487-1-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

Thank you to work on this.

On 3/9/20 16:28, Dafna Hirschfeld wrote:
> According to the datasheet the allowed modes for the da9211
> regulator are sync and auto mode. This should be changed in the
> devicetree. This also fix an error message
> 'BUCKA: invalid regulator-allowed-modes element 0'
> since value 0 is invalid.
> 
> Fixes: 689b937beddeb ("arm64: dts: mediatek: add mt8173 elm and hana board")
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Double checked the regulator supported modes and I can confirm that this patch
gets rid of the error message, so:

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index 1fe5dac24ba1..1a51879d5c6f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -5,6 +5,7 @@
>  
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/regulator/dlg,da9211-regulator.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include "mt8173.dtsi"
>  
> @@ -293,7 +294,8 @@
>  				regulator-max-microamp  = <4400000>;
>  				regulator-ramp-delay = <10000>;
>  				regulator-always-on;
> -				regulator-allowed-modes = <0 1>;
> +				regulator-allowed-modes = <DA9211_BUCK_MODE_SYNC
> +							   DA9211_BUCK_MODE_AUTO>;
>  			};
>  
>  			da9211_vgpu_reg: BUCKB {
> 
