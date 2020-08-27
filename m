Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F341C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32CA207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8XIF+kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgH0KOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgH0KOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:14:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DCCC061264;
        Thu, 27 Aug 2020 03:14:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so4824874wrw.1;
        Thu, 27 Aug 2020 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tJ2qBYy1J9smz6qD4q0DxxYWxBNZOLm22YIjuTjWy58=;
        b=T8XIF+khS4jpM77nipAtN+a/XOqeLm8xxGRePhStxNqWXy8Gu4z4Zb1CfJOCXvI7en
         qWVVlK5OZtOsctcmy5ojT08hByjmpmKQ3PbiuCXftsjw4oUEQmJ5oM+Dity207FYBjbl
         1ZmoVCpQ7/mK6ocozChiIBfAluWAUwssRcKDO/eGvb6dmK0FRssyLyeMs3Y0SXiKhz0+
         SzG+d5dYoBNxNuomF0+q9ZnuINlQXZFEWOMrGh1TjF0kfJFgu0XGTcb4mtiXQusMIKJu
         UcRNJxNXbnGHfl+Ei631aBDn0Oj1oKLj64V6DAkELJ5TbWutoqWIjVjcQgoVF2Y2Rj35
         cPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tJ2qBYy1J9smz6qD4q0DxxYWxBNZOLm22YIjuTjWy58=;
        b=GCbZJs83+Yk5JXXHMh9JR9Kk6daxJjMQZhLzOTgwQUp5BsJvggNsNZOKQf75NQUytv
         KA+XgKOcF5QEJRjOQBDsSAYv0b6Q++a+K/NkdMJ3loPQIqmnqvKAQ0ZrJkCTIgTjR7cG
         X8okxKQvGupsGl0LG/cxxXk4gRmzDBq5YCTHS3V5drKU9p8IEjhjMLFkNEXggm5DpDyo
         UTZDcLAgc83/yg9qrlEoygxPywqZtfbrEbe1SrJdk7uNGi/Neajlw5QaTBs05DspLeRj
         oVFU2Jfou8FmrxCjzVUZlvAzNaLW95KgSRmbjpHM7FJOpV2uUz7beu2mm9RbWZvx1R+6
         qDSg==
X-Gm-Message-State: AOAM531LTucqoRpQAILn5zT/Ssw5VCFnn7JP4p1j0ccuza4VE7Ku+MpC
        jOsdVKNRX64m+Phj2yWEJE0=
X-Google-Smtp-Source: ABdhPJzoaFIsQ+ZYOs5pL6W9QlfgL20KwUOQGWj00SwcVaCQQLHNo9AfR5mkWRaX9EBKsqRQguNZmg==
X-Received: by 2002:adf:8401:: with SMTP id 1mr19272710wrf.274.1598523253871;
        Thu, 27 Aug 2020 03:14:13 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.187])
        by smtp.gmail.com with ESMTPSA id b204sm4736840wmd.34.2020.08.27.03.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:13 -0700 (PDT)
Subject: Re: [PATCH v21 4/4] arm64: dts: mt8183: add scp node
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Eddie Huang <eddie.huang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20191112110330.179649-1-pihsun@chromium.org>
 <20191112110330.179649-5-pihsun@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <2abf8fdd-7b7c-73b0-beea-9c9ac56869dc@gmail.com>
Date:   Thu, 27 Aug 2020 12:14:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20191112110330.179649-5-pihsun@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2019 12:03, Pi-Hsun Shih wrote:
> From: Eddie Huang <eddie.huang@mediatek.com>
> 
> Add scp node to mt8183 and mt8183-evb
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>

Sorry I somehow oversaw this. Next time please don't doubt to ping me.

Bjorn, do I understand correctly that you don't send emails to the list 
informing of the inclusion of a patch/series in your tree?

Anyway applied now to v5.9-next/dts64 :)

Thanks!

> ---
> Changes from v20 ... v14:
>   - No change.
> 
> Changes from v13:
>   - Change the size of the cfg register region.
> 
> Changes from v12 ... v10:
>   - No change.
> 
> Changes from v9:
>   - Remove extra reserve-memory-vpu_share node.
> 
> Changes from v8:
>   - New patch.
> ---
>   arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 11 +++++++++++
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 12 ++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> index 1fb195c683c3..ddb7a7ac9655 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> @@ -24,6 +24,17 @@ memory@40000000 {
>   	chosen {
>   		stdout-path = "serial0:921600n8";
>   	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		scp_mem_reserved: scp_mem_region {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x50000000 0 0x2900000>;
> +			no-map;
> +		};
> +	};
>   };
>   
>   &auxadc {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 10b32471bc7b..e582f5e6691d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -269,6 +269,18 @@ pwrap: pwrap@1000d000 {
>   			clock-names = "spi", "wrap";
>   		};
>   
> +		scp: scp@10500000 {
> +			compatible = "mediatek,mt8183-scp";
> +			reg = <0 0x10500000 0 0x80000>,
> +			      <0 0x105c0000 0 0x19080>;
> +			reg-names = "sram", "cfg";
> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&infracfg CLK_INFRA_SCPSYS>;
> +			clock-names = "main";
> +			memory-region = <&scp_mem_reserved>;
> +			status = "disabled";
> +		};
> +
>   		systimer: timer@10017000 {
>   			compatible = "mediatek,mt8183-timer",
>   				     "mediatek,mt6765-timer";
> 
