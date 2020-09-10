Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE54BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D0F206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtLuCefB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgIJKZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730865AbgIJKZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:25:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD79C061573;
        Thu, 10 Sep 2020 03:25:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so5236879wmj.5;
        Thu, 10 Sep 2020 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uDGopvs8aEy5CLN9XFvGzNsaYZBkoKWrQofytwNxzDI=;
        b=TtLuCefBkaK7TlKv/Sk2EuMm6ot39a7QJqRt/iyU/N/NhshX+ZQAp9ewNvpTs+0Z72
         8KF8R1rSgMj2lrRVEtQs7czdrs+vh7uMxahg7wcCNOCTeuhnnwrSWxkKefP8zzMlz8fr
         d+hjZlUbxc3sSiCsaeL/0LSEK5HD/coEmRMSUD99K6bySVOliMuw67g1DHV2G65QWMcM
         Awf7VI/yhh1E4RSovGaeLdgUdL8cZSyUB1aHo8KsNAE2Kvx1isaqgWevpgqpHKh5m6ux
         9jZli4FVifj/fryrULBwtCJrFAQI+fI1nGfp1Vw1RyITZmyJEnxUULbMPtd87vHxZjMB
         8spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uDGopvs8aEy5CLN9XFvGzNsaYZBkoKWrQofytwNxzDI=;
        b=BotKYZxBCqHe0nh5HEfLI2FfqjMYFyf7Gm9rbUZIDovZnDDGIq/MYualKc4J8VGLSg
         627OciUUuWLOqAGeX33aBNh0l8+GKr6CLOiFQvZxQ73mO6NmyKkBMXOsWRueWRmUHzB9
         8CMwKd63kRLa/kz0EyQ96t10kH7I4fbca+Vi9zNbgBi1fk/7HbtUpveW37BM8sQI1GIE
         ulQ05ZRSUd4QKUjUtQizFJjmCCOiXzarUdflNwCdLGHmKUNKW0dOgRcLGNhrCKMDM9Mj
         GJbSWrwDCgzj5tUeTnMY/ZPCN7X17/lOXNughsrWcnmuaBp2HenRXqQkjv2Vn7RT/YeS
         YKGg==
X-Gm-Message-State: AOAM533p/tB6P42QVSXNy2BQj/+oqDxtYynRr4/DuKeue2XyvaVPyaZT
        VhuHTM1nXTqJV9ekNdV35+w=
X-Google-Smtp-Source: ABdhPJwEntZMPev9H0+UabGQF6k7v0hipNAbHGksKxQPqTzKVMcHb27HZfswdjmY9yMhPtph54h6PA==
X-Received: by 2002:a1c:5a87:: with SMTP id o129mr8077545wmb.145.1599733522852;
        Thu, 10 Sep 2020 03:25:22 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id g143sm2937249wme.0.2020.09.10.03.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 03:25:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] arm64: dts: mt8173: Set uart to mmio32 iotype
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eddie Huang <eddie.huang@mediatek.com>
References: <20200910084304.3429494-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9ca1b7c0-9fec-27b7-ae08-c00613c3004c@gmail.com>
Date:   Thu, 10 Sep 2020 12:25:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910084304.3429494-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/09/2020 10:43, Hsin-Yi Wang wrote:
> Set uart iotype to mmio32 to make earlycon work with stdout-path.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 5e046f9d48ce9..ca6ea71f5f435 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -613,6 +613,8 @@ uart0: serial@11002000 {
>   			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
>   			clocks = <&pericfg CLK_PERI_UART0_SEL>, <&pericfg CLK_PERI_UART0>;
>   			clock-names = "baud", "bus";
> +			reg-io-width = <4>;

Why do we need that, we have
device->port.iotype = UPIO_MEM32;
in early_mtk8250_setup(). That should do the job already.


> +			reg-shift = <2>;

Can't we just add
device->port.regshift = 2;
to early_mtk8250_setup()? I think that would be a cleaner solution. As the 
serial device is the same for all SoCs, I don't expect any regression here.

CCing Eddie to correct me, if I'm wrong :)

Regards,
Matthias

>   			status = "disabled";
>   		};
>   
> @@ -623,6 +625,8 @@ uart1: serial@11003000 {
>   			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
>   			clocks = <&pericfg CLK_PERI_UART1_SEL>, <&pericfg CLK_PERI_UART1>;
>   			clock-names = "baud", "bus";
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
>   			status = "disabled";
>   		};
>   
> @@ -633,6 +637,8 @@ uart2: serial@11004000 {
>   			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
>   			clocks = <&pericfg CLK_PERI_UART2_SEL>, <&pericfg CLK_PERI_UART2>;
>   			clock-names = "baud", "bus";
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
>   			status = "disabled";
>   		};
>   
> @@ -643,6 +649,8 @@ uart3: serial@11005000 {
>   			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
>   			clocks = <&pericfg CLK_PERI_UART3_SEL>, <&pericfg CLK_PERI_UART3>;
>   			clock-names = "baud", "bus";
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
>   			status = "disabled";
>   		};
>   
> 
