Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A436AC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F822145D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSVmDTNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgIJKyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730245AbgIJKvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:51:48 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9518BC061757;
        Thu, 10 Sep 2020 03:51:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so5177524wmj.2;
        Thu, 10 Sep 2020 03:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ot8jLrMGoKI52DFvpwNiXxm1aPXePUwKu6AER+w1zcA=;
        b=OSVmDTNce3UfD6pLMp92sJYy7LtVaFsAUNTTq3z3WcBkr1iDsczZ5VKWsZtSs+fpm7
         Q11hAKIHC12W7xWiyKUq6pll4rGVaiuE/d0GxjJ1E+fhYLIN82QcOjQvZ/2x6psxTDqY
         RhvofhMrT37rJvvmxlgmD/VkS28WoLGFz/SqCe8o+Er6ILlmPogxtYp2fG0gElOv5VjJ
         GPcRB1e/kugyqd5l1wNLdjsvrKT2tnugRbITg1gyFGzE6Uo3cd/QImRfsdm8/YKemdOR
         Ce5fHpuMjBGnE6dft/WV0U28keX5cVX1ctbb5Qp5F5KhFOrxpqVMXNioQKDaaWwqVRKE
         iI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ot8jLrMGoKI52DFvpwNiXxm1aPXePUwKu6AER+w1zcA=;
        b=sbfReBXeTyis1RYumxfqVCjx+WHKCa1gLoPM3MBXuQNlgigGWBf9ViOGTUH+NtBKNp
         apf9jPbj0fxb/cEdfck759Fwin3bngs9NZDsoVlH02HFHf/of9edVz2gMumgnTxeLxH1
         JbVTTLKBLq+hmOjCJ1xNb4vbEksgBIcFNdYjM1GSyjKJbLR8wHoMHEXbVUMGnDxF/yRr
         N3PclR5pwymWuTBDLK7R4No4tQVyDmmk4ZfXOY40+sYCAGk5k3nupokIEerPMeMekmRy
         jouwUUle6DtPy6ah7SlbXm2s/YWopxQqerQNh6beNqXV/YnZtoAEYwpVozJzZW8ug8MZ
         wZpQ==
X-Gm-Message-State: AOAM53256jgQiEMxGLdCYec5M8HNg8Ga37rsX6NSSzZFsftn1ca3vLfX
        GCtO0vxlzUSq69EDmIrp0BkM005gejQ=
X-Google-Smtp-Source: ABdhPJwUp9n39OfdocNAzLEpVjdh2cJbTXLst76QyqtMocve1sQWinFB2t0gtuOCrJhfTEb8XehRig==
X-Received: by 2002:a1c:5a87:: with SMTP id o129mr8184635wmb.145.1599735107055;
        Thu, 10 Sep 2020 03:51:47 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id q12sm8287954wrp.17.2020.09.10.03.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 03:51:46 -0700 (PDT)
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
        open list <linux-kernel@vger.kernel.org>
References: <20191112110330.179649-1-pihsun@chromium.org>
 <20191112110330.179649-5-pihsun@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <74669282-bb02-d753-e117-666fea5d7a9a@gmail.com>
Date:   Thu, 10 Sep 2020 12:51:45 +0200
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

Applied again to v5.9-next/dts64
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
