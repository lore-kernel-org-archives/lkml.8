Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056B5C3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB5F246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCBMHMF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgB0WiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:38:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38690 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbgB0WiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:38:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id e25so1003328edq.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ldqtdzQg0IDkeY1Xbv0KzAGe+suBcmk9fLvcp/p3NQ=;
        b=vCBMHMF2V3rD3aEGpqLE6IGPiunwvNx4n++lWFnfdUbfrdni6eNWVPcqzZri2/Raeg
         wTj06zoRmfzelvt6glWNRK9rWNdSS8S2XuoWzJ9nui7EkRcVZiFItixEhlmUXRH/O/c3
         mszevfyxXbq4Pm+lq4vZ+EIddisuYNQTHeI6SrjsaZS+zg5gHtsJVW3PiNdM6nxYmW7S
         LW99kUP00dpHDtXWXqa4i9FG5dAK4yc/RiYJY/ZK+F3G9U7+VCIh1COun9kK6QJr0J79
         t02y1ebCORNCNWM11ZBOl5ufZF7+Tzyd3pYA05WJv88cbAfUPYuLTXX0DA9uVLSD/Hgm
         +Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ldqtdzQg0IDkeY1Xbv0KzAGe+suBcmk9fLvcp/p3NQ=;
        b=C4MFge2qOUveIlZxCLp95FsrPgnXdK9/L8I099Ra94itAjlhZAfEPC5nG4Cb05XS/M
         BX1EXVhiQKRUle3hSK/wE9wBKLPpSkoHzipQqSHEcyerts3uSrF2Abph4DUZk1zIFV5k
         SX1qnEdnF8hAYYJ/8ynOtjWlZWUWHQPDmAVraX4/A6ARhpRfhPH2GH2TIOEfvWMRP7Ib
         rRKnMG1zQkEJxeKvLLVk2drfVP48yo9H0+PfkDWuBABlqO+BnT16DLnTHsFszZnwVFFJ
         L69SYjmwYZOMppkXkewWqMmOjw2n1zCQ9LyVY7dpZgyiKXdggKWRNRpXAt17/4gSZY4g
         FVow==
X-Gm-Message-State: APjAAAWZKFJY6Xi8Kf4C4cnyL9HvVHDGcGRGdfZ4FPpNNkV4lOk+qEQ4
        iOkeULsDJZf9AJn86RbtHnR7Ew==
X-Google-Smtp-Source: APXvYqxxloI5041lk1b15OcyCz5cCF9wex2YQPothjIN2SiN+YwNMxhIRod4razDzQIdZ4bi3X7m4Q==
X-Received: by 2002:a17:906:4bc8:: with SMTP id x8mr1060538ejv.339.1582843095559;
        Thu, 27 Feb 2020 14:38:15 -0800 (PST)
Received: from [192.168.1.9] (hst-221-24.medicom.bg. [84.238.221.24])
        by smtp.googlemail.com with ESMTPSA id j24sm441940edr.57.2020.02.27.14.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 14:38:14 -0800 (PST)
Subject: Re: [PATCH v4 11/12] arm64: dts: sdm845: follow venus-sdm845v2 DT
 binding
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org
References: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
 <20200106154929.4331-12-stanimir.varbanov@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <13ea7221-5253-37fc-595d-e650b2d474c6@linaro.org>
Date:   Fri, 28 Feb 2020 00:38:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200106154929.4331-12-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Could you take this for v5.7.

On 1/6/20 5:49 PM, Stanimir Varbanov wrote:
> Move all pmdomain and clock resources to Venus DT node. And make
> possible to support dynamic core assignment on v4.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index ddb1f23c936f..c5784951d408 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2568,32 +2568,33 @@
>  		};
>  
>  		video-codec@aa00000 {
> -			compatible = "qcom,sdm845-venus";
> +			compatible = "qcom,sdm845-venus-v2";
>  			reg = <0 0x0aa00000 0 0xff000>;
>  			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> -			power-domains = <&videocc VENUS_GDSC>;
> +			power-domains = <&videocc VENUS_GDSC>,
> +					<&videocc VCODEC0_GDSC>,
> +					<&videocc VCODEC1_GDSC>;
> +			power-domain-names = "venus", "vcodec0", "vcodec1";
>  			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
>  				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
> -				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
> -			clock-names = "core", "iface", "bus";
> +				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
> +				 <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
> +				 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>,
> +				 <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
> +				 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
> +			clock-names = "core", "iface", "bus",
> +				      "vcodec0_core", "vcodec0_bus",
> +				      "vcodec1_core", "vcodec1_bus";
>  			iommus = <&apps_smmu 0x10a0 0x8>,
>  				 <&apps_smmu 0x10b0 0x0>;
>  			memory-region = <&venus_mem>;
>  
>  			video-core0 {
>  				compatible = "venus-decoder";
> -				clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
> -					 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
> -				clock-names = "core", "bus";
> -				power-domains = <&videocc VCODEC0_GDSC>;
>  			};
>  
>  			video-core1 {
>  				compatible = "venus-encoder";
> -				clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
> -					 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
> -				clock-names = "core", "bus";
> -				power-domains = <&videocc VCODEC1_GDSC>;
>  			};
>  		};
>  
> 

-- 
regards,
Stan
