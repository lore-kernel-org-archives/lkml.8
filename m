Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E57C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A209D21734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RH32kiQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgBKRd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:33:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33848 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgBKRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:33:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so5832942pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lH4EbrzVbu3CvaS8sns78JlEG0bpnC0mv7bE+liJ2nA=;
        b=RH32kiQsCKo1Gs+FkFdDvj1Kq3PKeLTjbRXjVS542Tg6Gb8IzEOXCl8KrAydPkosHL
         SYGwlAdLYd5do6FGm6AtvSvYjLsBhTB3Zd2J02IAI1lWNxUZQ/5+ah4appWH9FO9tCfN
         4dmS1PhdaopzWfZZudmSODT/lwSAYlGW8ZyJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lH4EbrzVbu3CvaS8sns78JlEG0bpnC0mv7bE+liJ2nA=;
        b=sAuHlFtdh08ExvKgzG64L0DRND452w5AfSnYDXX8ViZVBLTnpAME7qdXBuDLraryho
         FFCgQw8TbwN0Ca/yZg7udyU19CE0r6h8Nnfiwq+LruBR4jR8F3rN5j/IVcNV/QQgYbGy
         N34t73HPd7Uzd3rHZUd9DE70Yq+Q9jrG2aomee2juVtenuM9jbrKxqBO3Ws7/lG6hc35
         VaC0y6OzO1378sYglojq8KVSybV/k04p/jIrxMV1mYSuOmvYXN/ZWiOaubZY45GPHmUP
         EMkK3EMYu18B4KEz+EQyKeXNqJc88N+dYKxXhj+hAw7AGKJFEfojcKSr8ZmQwjC++0M3
         8XIA==
X-Gm-Message-State: APjAAAUw1U6kSkyuwpMfq9URFwV61cKSGgCO25ocROkwrRzVc1VCA32J
        x9agdJ7yXbKYA1lsjv7fpD0fkg==
X-Google-Smtp-Source: APXvYqxk99B0t8EHkrjFPb34havVNfFdZ7CHuqxMGO1VQir/2llQ9LuL+WBmfTO4aiFx3jXiqWC3cg==
X-Received: by 2002:a63:6c82:: with SMTP id h124mr7923471pgc.328.1581442405558;
        Tue, 11 Feb 2020 09:33:25 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id c26sm5104896pfj.8.2020.02.11.09.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 09:33:25 -0800 (PST)
Date:   Tue, 11 Feb 2020 09:33:23 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, hemantg@codeaurora.org,
        robh+dt@kernel.org, mark.rutland@arm.com, gubbaven@codeaurora.org
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7180: Add node for bluetooth soc
 wcn3990
Message-ID: <20200211173323.GE18972@google.com>
References: <20200211121612.29075-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211121612.29075-1-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:46:12PM +0530, Balakrishna Godavarthi wrote:

> subject: arm64: dts: qcom: sc7180: Add node for bluetooth soc wcn3990

Preferably say in the subjct that the node is added for the IDP board.

> Add node for bluetooth soc wcn3990.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 388f50ad4fde..19f82ddc1f09 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -19,6 +19,7 @@
>  	aliases {
>  		hsuart0 = &uart3;
>  		serial0 = &uart8;
> +		bluetooth0 = &bluetooth;
>  	};
>  
>  	chosen {
> @@ -256,6 +257,16 @@
>  
>  &uart3 {
>  	status = "okay";

nit: add a blank line

> +	bluetooth: wcn3990-bt {
> +		compatible = "qcom,wcn3990-bt";
> +		vddio-supply = <&vreg_l10a_1p8>;
> +		vddxo-supply = <&vreg_l1c_1p8>;
> +		vddrf-supply = <&vreg_l2c_1p3>;
> +		vddch0-supply = <&vreg_l10c_3p3>;
> +		max-speed = <3200000>;
> +		clocks = <&rpmhcc RPMH_RF_CLK2>;
> +		status = "okay";

status is not needed here AFAIK.
