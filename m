Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EF420874
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axVFq7kE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbgFWXS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387749AbgFWXSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:18:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9EAC0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:18:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f3so358480pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=owfnTjDg726NQtD8/qpHi9DHMAEWYAz9K7YSNYTVBdM=;
        b=axVFq7kEpzc0dZ9A34HiMdj61yFalJrUM23DWP9yRZk52sePC29vY9KXZguGt9UnTd
         R2lP2oCjUYJ47auAhoIl0cnMZJbnuAJwOWA7cSJD/huM4YhUJhxli5Jsoh71Ps9iwuvU
         9al7bH1MI24TstseeTj6WwVU0wdOxix/wnF74p7kDjODXvt4Z15HXASEAotwmUvU+pKU
         pnMo6iAvksTVm97jtBuWQdAsxxAHAQwOBSaiYb6ihu90IFOnjDHHONcQM3zGfrikE0kI
         gaDWaALK7PEAJFMt8OclbWgTODw1MCGX36h1hDU3aFHU2NtlhBiRLxE/rLUAdVp0qF7r
         Ylhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=owfnTjDg726NQtD8/qpHi9DHMAEWYAz9K7YSNYTVBdM=;
        b=auKOuAQPAVtxgJzQiL/+6rtc4+Q2p8GbafqvLS/TLGmZRbP29HgrArsCFzkeXCc5Qm
         2vi8gtqlbynDv+x+6oHsluCMNpzWXTdEOhhryBeYsDez5yB731APsy/Nb1qLF28JVy25
         /QMWbchVRf5jjNQb82NyHTBjmXzsfcwcAFAhmzPE5VQAta2zlHGYDqizvmQglOT1a9xE
         0B57kcbUt8GWH9WRich0P+ix+pa8qaRZqxuh54S4aJPwNgFjwO2Bp7HRoeaz6aty9Q3c
         vx6xePh4XlY9WbYwyzAIXXxn8DR0K1giTQ3BeSSBvYicdj5GteumajeA/kaDa1cgWQbe
         R+tA==
X-Gm-Message-State: AOAM533xE05cN0RCJ+SGtL5Opx92BWt8B/NwcW1TF4+a3dZXhRl6WOrM
        S5hPMMUYxGXfrnccI75Olee79g==
X-Google-Smtp-Source: ABdhPJx06TX5OOHzlhkijzzldNPalHmTdguWii291hg2tgJdJvb1x61rBEowix+fbi8F4IW1FhWEXg==
X-Received: by 2002:a62:ee1a:: with SMTP id e26mr26388637pfi.228.1592954334821;
        Tue, 23 Jun 2020 16:18:54 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 2sm3375297pfa.110.2020.06.23.16.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:18:54 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:16:11 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/12] arm64: dts: qcom: msm8994: Add a proper CPU map
Message-ID: <20200623231611.GJ128451@builder.lan>
References: <20200623224813.297077-1-konradybcio@gmail.com>
 <20200623224813.297077-4-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623224813.297077-4-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23 Jun 15:48 PDT 2020, Konrad Dybcio wrote:

> Add a proper CPU map to enable the use of all 8 cores.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Applied, thanks

> ---
>  arch/arm64/boot/dts/qcom/msm8994.dtsi | 112 +++++++++++++++++++++++---
>  1 file changed, 102 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> index 23e50c30669b..e7f4b06eb12c 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> @@ -28,24 +28,116 @@ sleep_clk: sleep_clk {
>  	};
>  
>  	cpus {
> -		#address-cells = <1>;
> +		#address-cells = <2>;
>  		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +			L2_0: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +			};
> +		};
> +
> +		CPU1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU4: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a57";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_1>;
> +			L2_1: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +			};
> +		};
> +
> +		CPU5: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a57";
> +			reg = <0x0 0x101>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_1>;
> +		};
> +
> +		CPU6: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a57";
> +			reg = <0x0 0x101>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_1>;
> +		};
> +
> +		CPU7: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a57";
> +			reg = <0x0 0x101>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_1>;
> +		};
> +
>  		cpu-map {
>  			cluster0 {
>  				core0 {
>  					cpu = <&CPU0>;
>  				};
> +
> +				core1 {
> +					cpu = <&CPU1>;
> +				};
> +
> +				core2 {
> +					cpu = <&CPU2>;
> +				};
> +
> +				core3 {
> +					cpu = <&CPU3>;
> +				};
>  			};
> -		};
>  
> -		CPU0: cpu@0 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0x0>;
> -			next-level-cache = <&L2_0>;
> -			L2_0: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> +			cluster1 {
> +				core0 {
> +					cpu = <&CPU4>;
> +				};
> +
> +				core1 {
> +					cpu = <&CPU5>;
> +				};
> +
> +				core2 {
> +					cpu = <&CPU6>;
> +				};
> +
> +				core3 {
> +					cpu = <&CPU7>;
> +				};
>  			};
>  		};
>  	};
> -- 
> 2.27.0
> 
