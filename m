Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F2FC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1011E21D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kevpgpBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgIIJmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgIIJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:42:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB49C061573;
        Wed,  9 Sep 2020 02:42:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so2229941wrn.0;
        Wed, 09 Sep 2020 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z8RXnpnyBMjt2Rl+qFLfs99Rgx6FHbwDsstUMymIPBQ=;
        b=kevpgpBezl8qGbV7RG2kxXNWEHlnYbeaRmCOmICumPajZr750haas/HIHumLtfoXR7
         5LMTicH6uqLvsYFaD+KcKHT1vcw1oblYbClP7dRMaZHUQ2bSWj+8v3uy4TtjfyichXOD
         utx2VaZh6zLD6xYSXMhvcBl4ufAFx/i1sehZpNvq1sFN87WKO+HRtMe5qbH6vlCCQCVN
         FOfUeUPiuwpuRDFLs9fg71niN3SYxz6dPtHwUn0PM/1pA+x1Q8PgbACwbo2ViPSul9ho
         NYXW6JjPvcnTqJfQrr0CSR8wbilkQCwYwJaARAQ8PN31FkK0fBz/2r3/yP92ShtMeyJV
         nk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z8RXnpnyBMjt2Rl+qFLfs99Rgx6FHbwDsstUMymIPBQ=;
        b=qIpBylnfRSlfCgc2lP1V1o3yKMd8yUuKymd45MRIRdLH5FrA7GkVZ9p/LK+v/MoHGa
         TA5ocPu8XS4xEqNkcA75x7Q7fwRnvWmsANeqebZyWlBmnk9qEfRad/5N4RZb7jwj/Mm2
         5807qpVr2hk3ZhEQmOE4zc606iQ2SSgWzKm0sqibNMdvhJbs1ACgHE2JOJqDlRREKFKd
         m/IXmHRnqwmelETJgszwR2Xiw2fRN+CXR3W+0zVYN6I1lE15MzaQNX6FwLvXoOiE4L7G
         oFNJA/C1neu57UNfk7u4ooCC3MX7KZU0Szj/H1ElCqACkNXoLg0X7gTVyCo4NRN8sQex
         HxeA==
X-Gm-Message-State: AOAM531wPoBM/LdKqgFvVH4LUV7tOew99zZ6/2zehJSe0WjYOoL1AXGp
        +UUkZ2CdUVNNQk4MnOMswa0=
X-Google-Smtp-Source: ABdhPJyxx21J8UyPGAPaHM/8Ki6ecXPVaEM7uV8gatmLfxzs69Jo48V5cXIPhGqgMe+/DzTyxE7C+w==
X-Received: by 2002:adf:ba83:: with SMTP id p3mr3217999wrg.246.1599644565115;
        Wed, 09 Sep 2020 02:42:45 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id m185sm3201670wmf.5.2020.09.09.02.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:42:44 -0700 (PDT)
Subject: Re: [PATCH v6 4/4] arm: dts: mt7623: add lima related regulator
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alex Ryabchenko <d3adme4t@gmail.com>
References: <20200904110002.88966-1-linux@fw-web.de>
 <20200904110002.88966-5-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b893cbdb-2011-88a4-dd57-3ea82cde08d8@gmail.com>
Date:   Wed, 9 Sep 2020 11:42:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904110002.88966-5-linux@fw-web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/2020 13:00, Frank Wunderlich wrote:
> From: Alex Ryabchenko <d3adme4t@gmail.com>
> 
> GPU needs additional regulator, add it to devicetree of bpi-r2
> 
> Signed-off-by: Alex Ryabchenko <d3adme4t@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Applied to v5.9-next/dts32

Thanks!

> ---
>   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index f41f221e56ca..826912545ef1 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -79,6 +79,13 @@ reg_5v: regulator-5v {
>   		regulator-always-on;
>   	};
>   
> +	reg_vgpu: fixedregulator@0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_fixed_vgpu";
> +		regulator-min-microvolt = <1150000>;
> +		regulator-max-microvolt = <1150000>;
> +	};
> +
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   		pinctrl-names = "default";
> @@ -283,6 +290,11 @@ &i2c1 {
>   	status = "okay";
>   };
>   
> +&mali {
> +	mali-supply = <&reg_vgpu>;
> +	status = "okay";
> +};
> +
>   &mmc0 {
>   	pinctrl-names = "default", "state_uhs";
>   	pinctrl-0 = <&mmc0_pins_default>;
> @@ -402,4 +414,3 @@ &u3phy1 {
>   &u3phy2 {
>   	status = "okay";
>   };
> -
> 
