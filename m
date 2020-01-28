Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2636C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEAF24681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="glPmxTzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgA1TUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:20:30 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54192 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgA1TU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:20:29 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so1492192pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 11:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LYew2jkDUlCfpmqi8UqP0MWvgK08mQLJ5QipcXk94Nw=;
        b=glPmxTzfm4zSXwo1RsCFH9zx4U29Qc+s6KSPIHJMi2jbjXSMEVSOjw0/UqU4VnHzPM
         eohNZW//0zQfzufKpO9a95QWtX13bd8YVoMKRF0gJwmWRB051bfN23hlNI0paEW/h/AG
         eOHU3WiH0S/gbabgW+QPPE8OkyF1OiL7OokTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LYew2jkDUlCfpmqi8UqP0MWvgK08mQLJ5QipcXk94Nw=;
        b=RgEnz+DuTXBFgaTifD/C6MbAG3Ow9moQTbXK3ro+Wh+MTPkHEc5V+OT7EpYyrBpZt+
         pQmLMWiy5GYZhOzF425B+ivzkKGgLdN12lalBheZWmuap0QSZf/IdxSjzmMxmx4jmVhl
         uacWdaO5EJLeAvM0KOwBverTFIy1zWLtMEPjZTn+QcKF8KSYhZBiW4/CHjhDMJF0Ha9R
         MnMgzb+ex6yZlTEzXR27bXZjLjL04ET+s0vcemea3oPVoQNxD4iIz24PJ51iAqEKObTW
         +739lplqta7vZ0YOxBm2Kh8ZpeG88FsZyBcyAYIozdXDCH5sS4aFamye5jfFQEhFzhHV
         E0Iw==
X-Gm-Message-State: APjAAAWdz2W9pGs/vfISDusCBqTJgh2MCf3agUZQfnOBqcGgDWzcIUVW
        j/jxKukYaT6kgShp1M+IFJc+oNupLJI=
X-Google-Smtp-Source: APXvYqxkt5ByEhDoG7VUZvlRrj1lUICrxMnGZlHApMda1UlKyNQiei8yE1/b5ej/6G+z0l1bn2aQzA==
X-Received: by 2002:a17:90a:191:: with SMTP id 17mr6579887pjc.88.1580239229274;
        Tue, 28 Jan 2020 11:20:29 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id l37sm3886086pjb.15.2020.01.28.11.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 11:20:28 -0800 (PST)
Date:   Tue, 28 Jan 2020 11:20:27 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module
 device node
Message-ID: <20200128192027.GB46072@google.com>
References: <1580207617-818-1-git-send-email-pillair@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1580207617-818-1-git-send-email-pillair@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rakesh,

On Tue, Jan 28, 2020 at 04:03:37PM +0530, Rakesh Pillai wrote:
> Add device node for the ath10k SNOC platform driver probe
> and add resources required for WCN3990 on sc7180 soc.
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts |  5 +++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 28 ++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 189254f..151b489 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -248,6 +248,11 @@
>  	status = "okay";
>  };
>  
> +&wifi {
> +	status = "okay";
> +	qcom,msa-fixed-perm;
> +};
> +
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
>  
>  &qup_i2c2_default {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 666e9b9..7efb97f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -42,6 +42,12 @@
>  			compatible = "qcom,cmd-db";
>  			no-map;
>  		};
> +
> +		wlan_fw_mem: memory@93900000 {
> +			compatible = "removed-dma-pool";
> +			no-map;
> +			reg = <0 0x93900000 0 0x200000>;
> +		};
>  	};

This part doesn't apply cleanly on qcom/for-next, looks like you have to
rebase.

>  	cpus {
> @@ -1119,6 +1125,28 @@
>  				#clock-cells = <1>;
>  			};
>  		};
> +
> +		wifi: wifi@18800000 {

You added this node at the end of the file, outside of the 'soc' node.
It should be inside the 'soc' node, the sub-nodes are ordered by address,
so (currently) this node should be inserted after 'cpufreq@18323000'.

> +			compatible = "qcom,wcn3990-wifi";
> +			reg = <0 0x18800000 0 0x800000>;
> +			reg-names = "membase";
> +			iommus = <&apps_smmu 0xC0 0x1>;

nit: the convention is to use lowercase characters for hex adresses.

> +			interrupts =
> +				<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH /* CE0 */ >,
> +				<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH /* CE1 */ >,
> +				<GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH /* CE2 */ >,
> +				<GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH /* CE3 */ >,
> +				<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH /* CE4 */ >,
> +				<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH /* CE5 */ >,
> +				<GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH /* CE6 */ >,
> +				<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH /* CE7 */ >,
> +				<GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH /* CE8 */ >,
> +				<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH /* CE9 */ >,
> +				<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH /* CE10 */>,
> +				<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH /* CE11 */>;

not sure these 'CEx' comments after each interrupt add much value. What does
'CE' stand for in the first place?

Thanks

Matthias
