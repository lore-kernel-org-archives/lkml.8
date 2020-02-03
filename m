Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB0FC35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2579D2087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3/dlEbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgBCRfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:35:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45667 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgBCRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:35:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so7910228pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 09:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/2GnHgYEod44KNh5O907qr0Dr3tZt31Xm1Pio0+BUtU=;
        b=T3/dlEbss69QCdMNMPoph/AGjrLOJywnCDQUDC2crHYwLXIj8gbLjE1Mhh/0AS4Q5i
         1AN7ohRk8xc5mWmOgUpM/XP9ETNjwFHjATcQYoN/y6IcTcbeIIKbLoOOtplCNuIlIw6C
         lt1Al/0QHs4pwiYD+e5S5S6DGygimX8cRV8E3qtmVn0c98qAteldebnd1oAOpSZWRLfg
         X4hvg2OAdCgQIqlJrR5SZ3IxW3t0aZSQGeM7PWTCFvoCLYqq0Cq4KzyCL5katLBoLA+4
         hc+utViSzEbgLYkXa9iZmRJ+ZawjFNhlcJ0L48IDNx6YU3dp1OVy3uPvyrzXLMKfamqU
         h+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2GnHgYEod44KNh5O907qr0Dr3tZt31Xm1Pio0+BUtU=;
        b=MPHQ17kqZTAL67WHYSyiWL1LgBZp72+nJxSk+vX4kYLAV0uEUl9uRbM90/vkYYO8xx
         7PlYWN6nGe0azhKSpa9WFqnXnkMVO/gNZzyvfDCoIOmCI4EmWcFgdA5FEngbxNfjiDE5
         kjf7h9aOMVMi5ihCsKDb/+X6N/ysMpPvwdlilsVgWEfJYNLuh7x9/iDeJ3tkr3210izI
         G1gQqnW6eh48BVLTkCVOjNgO280lGZaKgLPOtqqpu44jOT76ZD0kaqxzA2NY2GnP4YOs
         gp4yqPG15BUXtm8i5BbYhHC4hfiz+89OJsUOPJAeZdpKcGZwQZMSJjywB9OtoMN/8VwM
         4UXA==
X-Gm-Message-State: APjAAAX/IAp5cyX8NnaW+WEZqLMrOY+4E8i55VKYXIBGSoUoF8ercAPx
        fr5JzZe7NQIx7f0j/8gOSfGY0A==
X-Google-Smtp-Source: APXvYqwHjAZO5+aiba+vTO0oc2CApTMEtmAA4xfo4oGHCw/dpaiKyNl42GAFhoYlHtXUvoagPsmxZg==
X-Received: by 2002:a63:7e58:: with SMTP id o24mr25705879pgn.214.1580751302915;
        Mon, 03 Feb 2020 09:35:02 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s18sm700055pgn.34.2020.02.03.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 09:35:02 -0800 (PST)
Date:   Mon, 3 Feb 2020 09:35:00 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module
 device node
Message-ID: <20200203173500.GB3948@builder>
References: <1580281223-2759-1-git-send-email-pillair@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580281223-2759-1-git-send-email-pillair@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Jan 23:00 PST 2020, Rakesh Pillai wrote:

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
> index 388f50a..167f68ac 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -287,6 +287,11 @@
>  	vdda-pll-supply = <&vreg_l4a_0p8>;
>  };
>  
> +&wifi {
> +	status = "okay";
> +	qcom,msa-fixed-perm;
> +};
> +
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
>  
>  &qspi_clk {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 8011c5f..0a00c94 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -75,6 +75,12 @@
>  			reg = <0x0 0x80900000 0x0 0x200000>;
>  			no-map;
>  		};
> +
> +		wlan_fw_mem: memory@93900000 {
> +			compatible = "removed-dma-pool";

Sorry for not spotting this earlier, the "removed-dma-pool" compatible
is a downstream thing and isn't defined upstream.

> +                     no-map;
> +                     reg = <0 0x93900000 0 0x200000>;

If you swap the order of no-map and reg in this node it will look like
all the others.


Apart from that the patch looks good.

Regards,
Bjorn

> +		};
>  	};
>  
>  	cpus {
> @@ -1490,6 +1496,28 @@
>  
>  			#freq-domain-cells = <1>;
>  		};
> +
> +		wifi: wifi@18800000 {
> +			compatible = "qcom,wcn3990-wifi";
> +			reg = <0 0x18800000 0 0x800000>;
> +			reg-names = "membase";
> +			iommus = <&apps_smmu 0xc0 0x1>;
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
> +			memory-region = <&wlan_fw_mem>;
> +			status = "disabled";
> +		};
>  	};
>  
>  	thermal-zones {
> -- 
> 2.7.4
> 
