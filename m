Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69041C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39516214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+SbGLEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgAMSpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:45:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44058 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgAMSpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:45:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id az3so4141419plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 10:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ma2e5QYJYr2+A6y40/wWxo50e76HZ6NsW8KSbxEHjSo=;
        b=m+SbGLEhSGBwvvFJbDSHlMmJomNfrgDq8qjOcFCm8B7zoxv7EKK1gzWUONFYo8OX/W
         08rMpkBfroMiE4JGp9r/tJZFHnsARi8orZHss/E1RhdsKBycHTuxlVFZjDan7xfObqNU
         x3nw0x7PXDL2gS+qxOh2stpOLg5RJxAOIEQa+j4asWIm2VI/vkd/WW3hpIHNTP6twJPu
         iqL+bZ5fdfvoSfWJBQGGsSs+seYjYOJjA48qEmIrkeqXerbaevThP4alSG+cZroztMw6
         NwQ9ugcyRVRGvERYR+wgH7wLrrmUuJynpXa55IfKW93CwvPd5DlLIPw7B6vM6VpNlZIt
         IoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ma2e5QYJYr2+A6y40/wWxo50e76HZ6NsW8KSbxEHjSo=;
        b=JfLBjeOXc/zHf1nNQCN3oknTPeUEWZQLGgCn6ueXn4CT6hZ20IQh6MS9Z29pfVIZw7
         +DTBvDa/AXIN5iVnLVA/S9LsNWGDk6EHpKYcXM/fdBP5ACfVuUClIuyOhUfGcj3uwOlM
         6CbyNxgpL0ldm3vCforH9m8NhVq6VxZ1Arw4iTPgidYjHO4D4iiSVG2Eu9tpRPZZ29Z/
         nQg6f7gL375v84Ksbs266AbEWqEdnxpL2fW3HvRdIcktQA05h5PX0/NJ0RwKTzury9ei
         yt+1blcqiFXsFHZja4tw7T555OHVV88Di4MiRh8JuD+y0GnIr3I0Trg6Tdgn7/kU/G0U
         uD+g==
X-Gm-Message-State: APjAAAXYTK+HLBpMeefuPIRvXSX6/L9YPICwDAWoWK9UFPbNi5N2ri1E
        06OTTEGnb1LxOuPQ5oE0uwlXRA==
X-Google-Smtp-Source: APXvYqzHz76NihH7xSMfwYbiUU9+Ra4XYRiSYA8sn78I7UDiQzEwqFB/ZeMZpOI8LWIDNUUolUUMNw==
X-Received: by 2002:a17:90b:8ce:: with SMTP id ds14mr14763316pjb.57.1578941114957;
        Mon, 13 Jan 2020 10:45:14 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u18sm14254825pgn.9.2020.01.13.10.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 10:45:14 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:45:11 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: sdm845: move gpu zap nodes to
 per-device dts
Message-ID: <20200113184511.GB1511@yoga>
References: <20200112195405.1132288-1-robdclark@gmail.com>
 <20200112195405.1132288-5-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112195405.1132288-5-robdclark@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 12 Jan 11:54 PST 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> We want to specify per-device firmware-name, so move the zap node into
> the .dts file for individual boards/devices.  This lets us get rid of
> the /delete-node/ for cheza, which does not use zap.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> v2: use 'sdm845' for subdir for devices that use test-key signed fw
> 
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi           | 1 -
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts           | 7 +++++++
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts              | 7 +++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi                 | 6 +-----
>  arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 7 +++++++
>  5 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index 9a4ff57fc877..2db79c1ecdac 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -165,7 +165,6 @@ panel_in_edp: endpoint {
>  /delete-node/ &venus_mem;
>  /delete-node/ &cdsp_mem;
>  /delete-node/ &cdsp_pas;
> -/delete-node/ &zap_shader;
>  /delete-node/ &gpu_mem;
>  
>  /* Increase the size from 120 MB to 128 MB */
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index d100f46791a6..6cd9201ffbbd 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -352,6 +352,13 @@ &gcc {
>  			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
>  };
>  
> +&gpu {
> +	zap-shader {
> +		memory-region = <&gpu_mem>;
> +		firmware-name = "qcom/sdm845/a630_zap.mbn";
> +	};
> +};
> +
>  &pm8998_gpio {
>  	vol_up_pin_a: vol-up-active {
>  		pins = "gpio6";
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index c57548b7b250..09ad37b0dd71 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -360,6 +360,13 @@ &gcc {
>  			   <GCC_LPASS_SWAY_CLK>;
>  };
>  
> +&gpu {
> +	zap-shader {
> +		memory-region = <&gpu_mem>;
> +		firmware-name = "qcom/sdm845/a630_zap.mbn";
> +	};
> +};
> +
>  &i2c10 {
>  	status = "okay";
>  	clock-frequency = <400000>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index ddb1f23c936f..601c57cc9b6d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2804,7 +2804,7 @@ dsi1_phy: dsi-phy@ae96400 {
>  			};
>  		};
>  
> -		gpu@5000000 {
> +		gpu: gpu@5000000 {
>  			compatible = "qcom,adreno-630.2", "qcom,adreno";
>  			#stream-id-cells = <16>;
>  
> @@ -2824,10 +2824,6 @@ gpu@5000000 {
>  
>  			qcom,gmu = <&gmu>;
>  
> -			zap_shader: zap-shader {
> -				memory-region = <&gpu_mem>;
> -			};
> -
>  			gpu_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index 13dc619687f3..b255be3a4a0a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -245,6 +245,13 @@ &gcc {
>  			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
>  };
>  
> +&gpu {
> +	zap-shader {
> +		memory-region = <&gpu_mem>;
> +		firmware-name = "qcom/LENOVO/81JL/qcdxkmsuc850.mbn";
> +	};
> +};
> +
>  &i2c1 {
>  	status = "okay";
>  	clock-frequency = <400000>;
> -- 
> 2.24.1
> 
