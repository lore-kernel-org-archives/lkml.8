Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101AFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACFE206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tac+073G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbgGAPGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbgGAPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:06:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F33C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 08:06:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x8so9127925plm.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dLJbOj3weGuPoGEm8Q6BpPocRqtRJNsyr2+B1hO3Q2k=;
        b=Tac+073Gs4Yz9fnZoHmNM/3l3vwjU4nRfnBMpJcyd4ZxtlpOFBqM54IEqy6jgljJQh
         1CM4An+UyXRPAMlFTPKmFSKV0SW84bNHt/vl81NZJboRBuROaByH5MU/DUKePPjkFsF0
         jNUwWp4j+pigGNxsz2Va7Jf/P7TIrVOVBN5Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dLJbOj3weGuPoGEm8Q6BpPocRqtRJNsyr2+B1hO3Q2k=;
        b=hceRzS1WE8U0WCjwtwehbz/0EKvi8+Cl7c3pRUtDSBxy1KhkLXZt07sLuX/tmcJVU6
         +YA6NOgQf68cJyfRBzE8MQ7xjDo25Qjqzg2QDsuwfb8flW3G1MV3S4z13ff84qUSbvTc
         31O+XeWD3HG2oBgS8TFnkhrn6nAGyxFJrDz+U7zR4oOF81921TLZ7Dgm5guOXJqBvh2d
         7SeWedkBLuuxsKQfRT/pHrrNWcnlAENppCgB2qyepDxBbbgdiSLqztbuYek+9imvgpHU
         D+YsOK+MUJGbtOFNt7PY/zAMHc0QCEtKCZdAtqJl3JTjokryguFnQwk2G5vOgB/YoSzB
         zk4Q==
X-Gm-Message-State: AOAM531J/wvrPoOFQx4TYgVMGy478kxE6g75iGKYtpGoTmhfw6PJvJhq
        iASAem755sfS9NjCl1FiTE9ufg==
X-Google-Smtp-Source: ABdhPJytwmuQKVsDHcQnD/m9ZVn64MGAI0QRRqQ5h+0IfFzfY/v+88L6j6n9J5wCQwK19xbs052i6A==
X-Received: by 2002:a17:902:7b85:: with SMTP id w5mr11843135pll.22.1593615982469;
        Wed, 01 Jul 2020 08:06:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id n19sm6211028pgb.0.2020.07.01.08.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:06:21 -0700 (PDT)
Date:   Wed, 1 Jul 2020 08:06:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     robdclark@gmail.com, sean@poorly.run, agross@kernel.org,
        bjorn.andersson@linaro.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: sdm845: Add DSI and MDP OPP tables and
 power-domains
Message-ID: <20200701150619.GM39073@google.com>
References: <1593518176-24450-1-git-send-email-rnayak@codeaurora.org>
 <1593518176-24450-4-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593518176-24450-4-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 05:26:15PM +0530, Rajendra Nayak wrote:
> Add the OPP tables for DSI and MDP based on the perf state/clk
> requirements, and add the power-domains property to specify the
> scalable power domain.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 59 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 8eb5a31..b6afeb2 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3296,6 +3296,35 @@
>  			#power-domain-cells = <1>;
>  		};
>  
> +		dsi_opp_table: dsi-opp-table {
> +			compatible = "operating-points-v2";
> +
> +			opp-19200000 {
> +				opp-hz = /bits/ 64 <19200000>;
> +				required-opps = <&rpmhpd_opp_min_svs>;
> +			};
> +
> +			opp-180000000 {
> +				opp-hz = /bits/ 64 <180000000>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
> +			};
> +
> +			opp-275000000 {
> +				opp-hz = /bits/ 64 <275000000>;
> +				required-opps = <&rpmhpd_opp_svs>;
> +			};
> +
> +			opp-328580000 {
> +				opp-hz = /bits/ 64 <328580000>;
> +				required-opps = <&rpmhpd_opp_svs_l1>;
> +			};
> +
> +			opp-358000000 {
> +				opp-hz = /bits/ 64 <358000000>;
> +				required-opps = <&rpmhpd_opp_nom>;
> +			};
> +		};
> +

I still don't like the shared OPP tables to be positioned inmidst of the
device nodes, but it seems we currently don't have a better convention.

>  		mdss: mdss@ae00000 {
>  			compatible = "qcom,sdm845-mdss";
>  			reg = <0 0x0ae00000 0 0x1000>;
> @@ -3340,6 +3369,8 @@
>  						  <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
>  				assigned-clock-rates = <300000000>,
>  						       <19200000>;
> +				operating-points-v2 = <&mdp_opp_table>;
> +				power-domains = <&rpmhpd SDM845_CX>;
>  
>  				interrupt-parent = <&mdss>;
>  				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> @@ -3364,6 +3395,30 @@
>  						};
>  					};
>  				};
> +
> +				mdp_opp_table: mdp-opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-19200000 {
> +						opp-hz = /bits/ 64 <19200000>;
> +						required-opps = <&rpmhpd_opp_min_svs>;
> +					};
> +
> +					opp-171428571 {
> +						opp-hz = /bits/ 64 <171428571>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-344000000 {
> +						opp-hz = /bits/ 64 <344000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-430000000 {
> +						opp-hz = /bits/ 64 <430000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
>  			};
>  
>  			dsi0: dsi@ae94000 {
> @@ -3386,6 +3441,8 @@
>  					      "core",
>  					      "iface",
>  					      "bus";
> +				operating-points-v2 = <&dsi_opp_table>;
> +				power-domains = <&rpmhpd SDM845_CX>;
>  
>  				phys = <&dsi0_phy>;
>  				phy-names = "dsi";
> @@ -3450,6 +3507,8 @@
>  					      "core",
>  					      "iface",
>  					      "bus";
> +				operating-points-v2 = <&dsi_opp_table>;
> +				power-domains = <&rpmhpd SDM845_CX>;
>  
>  				phys = <&dsi1_phy>;
>  				phy-names = "dsi";

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
