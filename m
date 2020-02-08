Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BC7C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 23:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3779C22522
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 23:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H65l2JSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgBHXnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 18:43:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46833 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgBHXnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 18:43:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so1259106pll.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 15:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9bKVTe4EPYnW80XaiR29zvqneXX7nsNtUaMWPb/m8U4=;
        b=H65l2JSE2PhRMpq539YzAsWekK8mIqeqNmO7OJi+INifLQvdbictHYzSq6La0KAsAg
         KYvRHLMEMh8vtZnjlh5ekiiTcdvRtGnMX4wKfrSVw3f8NtcqHx1d08u/c0XVaMImUPfx
         9dkUNwVR8yXtOH2QIBAO7N4cnfrftY9+hJ7evyTRbT5pJKtW/H41WP4lpuQBCWbQqZWp
         4dgjm92BFvAxt3B1a0N9K5yxhfpFDlBeKhtcN6tSwXJVetg3lbHHavEA9/bFmvYYkQh4
         wqsGBLwSPt0OqWI8YejGmuMrFuosbOCelh5RPGJFRrEJsB3eKSWRbh80Dp6MgY9Au5da
         hLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9bKVTe4EPYnW80XaiR29zvqneXX7nsNtUaMWPb/m8U4=;
        b=CJ3p4httdTt86277fXlpF6kvzAcj5mqesd7EXnX2Rrn+mVooq/+Pw0aKHiZGW4sfg5
         k67Xt4fu2nQxWDbuJbUQA8SZZE6s6sjyrlcof8OtwVSpneFk0sOq6vCT0IyzzYtTkBTT
         s/SQjl16CFi6eKYrgSsUeUz+37R051vhnSR0i61d+p1+igTNVKNsqmFQQHkoUHi8CE2I
         3d+TkB27/Cchd4OGgSlMdjW0wGMS0o7vVn2EtV8AMLJP332/6eijzhfrprtxCJUpdUQO
         AOf+ugPi8IcUElxdXoAIkNmqkJZ55ms0nhOdTVcMswGg4R7Oc/XAOqbb49NgHQ2H46Tw
         ZTWQ==
X-Gm-Message-State: APjAAAW+n0HHefBohWp3khFsApsL9q8s/MUFcbyLwdv8oQTa6IRQEr6X
        LM5vXnbCGq6Yrp/kJXjjC4koBA==
X-Google-Smtp-Source: APXvYqx9pjT5j7DUNhwxkTjw7w84EEDDUh3Nr8lSK05teJZ5U+eZqSgNA0oM5emcrOYXM8dUe+ESdA==
X-Received: by 2002:a17:902:5ace:: with SMTP id g14mr5735961plm.311.1581205387061;
        Sat, 08 Feb 2020 15:43:07 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r17sm7535567pgn.36.2020.02.08.15.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 15:43:06 -0800 (PST)
Date:   Sat, 8 Feb 2020 15:42:20 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Adam Serbinski <adam@serbinski.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] dts: msm8996/db820c: enable primary pcm and
 quaternary i2s
Message-ID: <20200208234220.GC955802@ripper>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200207205013.12274-8-adam@serbinski.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207205013.12274-8-adam@serbinski.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07 Feb 12:50 PST 2020, Adam Serbinski wrote:

Please make subject

"arm64: dts: qcom: db820c: Enable primary PCM and quaternary I2S"

Regards,
Bjorn

> This patch adds support to primary pcm and quaternary i2s ports.
> 
> Signed-off-by: Adam Serbinski <adam@serbinski.com>
> CC: Andy Gross <agross@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Liam Girdwood <lgirdwood@gmail.com>
> CC: Patrick Lai <plai@codeaurora.org>
> CC: Banajit Goswami <bgoswami@codeaurora.org>
> CC: Jaroslav Kysela <perex@perex.cz>
> CC: Takashi Iwai <tiwai@suse.com>
> CC: alsa-devel@alsa-project.org
> CC: linux-arm-msm@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 113 +++++++++++++
>  arch/arm64/boot/dts/qcom/msm8996-pins.dtsi   | 162 +++++++++++++++++++
>  2 files changed, 275 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> index dba3488492f1..4149ac4147a0 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> @@ -683,8 +683,31 @@
>  	};
>  };
>  
> +/* PRI I2S on QCA6174 and QUAT I2S on LS each uses 2 I2S SD Lines for audio */
> +&q6afedai {
> +	pi2s@16 {
> +		reg = <16>;
> +		qcom,sd-lines = <1>;
> +	};
> +	pi2s@17 {
> +		reg = <17>;
> +		qcom,sd-lines = <0>;
> +	};
> +	qi2s@22 {
> +		reg = <22>;
> +		qcom,sd-lines = <0>;
> +	};
> +	qi2s@23 {
> +		reg = <23>;
> +		qcom,sd-lines = <1>;
> +	};
> +};
> +
>  &sound {
>  	compatible = "qcom,apq8096-sndcard";
> +	pinctrl-0 = <&quat_mi2s_active &quat_mi2s_sd0_active &quat_mi2s_sd1_active &pri_mi2s_active &pri_mi2s_sd0_active &pri_mi2s_sd1_active>;
> +	pinctrl-names = "default";
> +
>  	model = "DB820c";
>  	audio-routing =	"RX_BIAS", "MCLK";
>  
> @@ -709,6 +732,41 @@
>  		};
>  	};
>  
> +	mm4-dai-link {
> +		link-name = "MultiMedia4";
> +		cpu {
> +			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA4>;
> +		};
> +	};
> +
> +	mm5-dai-link {
> +		link-name = "MultiMedia5";
> +		cpu {
> +			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA5>;
> +		};
> +	};
> +
> +	mm6-dai-link {
> +		link-name = "MultiMedia6";
> +		cpu {
> +			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA6>;
> +		};
> +	};
> +
> +	mm7-dai-link {
> +		link-name = "MultiMedia7";
> +		cpu {
> +			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA7>;
> +		};
> +	};
> +
> +	mm8-dai-link {
> +		link-name = "MultiMedia8";
> +		cpu {
> +			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA8>;
> +		};
> +	};
> +
>  	hdmi-dai-link {
>  		link-name = "HDMI";
>  		cpu {
> @@ -753,4 +811,59 @@
>  			sound-dai = <&wcd9335 1>;
>  		};
>  	};
> +
> +	scoplay-dai-link {
> +		link-name = "SCO-PCM-Playback";
> +		cpu {
> +			sound-dai = <&q6afedai PRIMARY_PCM_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +	};
> +
> +	scocap-dai-link {
> +		link-name = "SCO-PCM-Capture";
> +		cpu {
> +			sound-dai = <&q6afedai PRIMARY_PCM_TX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +	};
> +
> +	mi2splay-dai-link {
> +		link-name = "QUAT-MI2S-Playback";
> +		cpu {
> +			sound-dai = <&q6afedai QUATERNARY_MI2S_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +
> +//		EXAMPLE: For adding real codecs
> +//		codec {
> +//			sound-dai = <&pcm5142_4c>, <&pcm5142_4d>;
> +//		};
> +
> +	};
> +
> +	mi2scap-dai-link {
> +		link-name = "QUAT-MI2S-Capture";
> +		cpu {
> +			sound-dai = <&q6afedai QUATERNARY_MI2S_TX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +
> +//		EXAMPLE: For adding real codecs
> +//		codec {
> +//			sound-dai = <&pcm1865>;
> +//		};
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
> index ac1ede579361..e8221c4d05f7 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
> @@ -288,6 +288,168 @@
>  		};
>  	};
>  
> +	pri_mi2s_active: pri_mi2s_active {
> +		mux {
> +			pins = "gpio65", "gpio66";
> +			function = "pri_mi2s";
> +		};
> +		config {
> +			pins = "gpio65", "gpio66";
> +			drive-strength = <8>;   /* 8 mA */
> +			bias-disable;           /* NO PULL */
> +			output-high;
> +		};
> +	};
> +
> +	pri_mi2s_sleep: pri_mi2s_sleep {
> +		mux {
> +			pins = "gpio65", "gpio66";
> +			function = "gpio";
> +		};
> +
> +		config {
> +			pins = "gpio65", "gpio66";
> +			drive-strength = <2>;   /* 2 mA */
> +			bias-pull-down;         /* PULL DOWN */
> +			input-enable;
> +		};
> +	};
> +
> +	pri_mi2s_sd0_sleep: pri_mi2s_sd0_sleep {
> +		mux {
> +			pins = "gpio67";
> +			function = "gpio";
> +		};
> +
> +		config {
> +			pins = "gpio67";
> +			drive-strength = <2>;   /* 2 mA */
> +			bias-pull-down;         /* PULL DOWN */
> +			input-enable;
> +		};
> +	};
> +
> +	pri_mi2s_sd0_active: pri_mi2s_sd0_active {
> +		mux {
> +			pins = "gpio67";
> +			function = "pri_mi2s";
> +		};
> +
> +		config {
> +			pins = "gpio67";
> +			drive-strength = <8>;   /* 8 mA */
> +			bias-disable;           /* NO PULL */
> +		};
> +	};
> +
> +	pri_mi2s_sd1_sleep: pri_mi2s_sd1_sleep {
> +		mux {
> +			pins = "gpio68";
> +			function = "gpio";
> +		};
> +
> +		config {
> +			pins = "gpio68";
> +			drive-strength = <2>;   /* 2 mA */
> +			bias-pull-down;         /* PULL DOWN */
> +			input-enable;
> +		};
> +	};
> +
> +	pri_mi2s_sd1_active: pri_mi2s_sd1_active {
> +		mux {
> +			pins = "gpio68";
> +			function = "pri_mi2s";
> +		};
> +
> +		config {
> +			pins = "gpio68";
> +			drive-strength = <8>;   /* 8 mA */
> +			bias-disable;           /* NO PULL */
> +		};
> +	};
> +
> +	quat_mi2s_active: quat_mi2s_active {
> +		mux {
> +			pins = "gpio58", "gpio59";
> +			function = "qua_mi2s";
> +		};
> +		config {
> +			pins = "gpio58", "gpio59";
> +			drive-strength = <8>;   /* 8 mA */
> +			bias-disable;           /* NO PULL */
> +			output-high;
> +		};
> +	};
> +
> +	quat_mi2s_sleep: quat_mi2s_sleep {
> +		mux {
> +			pins = "gpio58", "gpio59";
> +			function = "gpio";
> +		};
> +
> +		config {
> +			pins = "gpio58", "gpio59";
> +			drive-strength = <2>;   /* 2 mA */
> +			bias-pull-down;         /* PULL DOWN */
> +			input-enable;
> +		};
> +	};
> +
> +	quat_mi2s_sd0_sleep: quat_mi2s_sd0_sleep {
> +		mux {
> +			pins = "gpio60";
> +			function = "gpio";
> +		};
> +
> +		config {
> +			pins = "gpio60";
> +			drive-strength = <2>;   /* 2 mA */
> +			bias-pull-down;         /* PULL DOWN */
> +			input-enable;
> +		};
> +	};
> +
> +	quat_mi2s_sd0_active: quat_mi2s_sd0_active {
> +		mux {
> +			pins = "gpio60";
> +			function = "qua_mi2s";
> +		};
> +
> +		config {
> +			pins = "gpio60";
> +			drive-strength = <8>;   /* 8 mA */
> +			bias-disable;           /* NO PULL */
> +		};
> +	};
> +
> +	quat_mi2s_sd1_sleep: quat_mi2s_sd1_sleep {
> +		mux {
> +			pins = "gpio61";
> +			function = "gpio";
> +		};
> +
> +		config {
> +			pins = "gpio61";
> +			drive-strength = <2>;   /* 2 mA */
> +			bias-pull-down;         /* PULL DOWN */
> +			input-enable;
> +		};
> +	};
> +
> +	quat_mi2s_sd1_active: quat_mi2s_sd1_active {
> +		mux {
> +			pins = "gpio61";
> +			function = "qua_mi2s";
> +		};
> +
> +		config {
> +			pins = "gpio61";
> +			drive-strength = <8>;   /* 8 mA */
> +			bias-disable;           /* NO PULL */
> +		};
> +	};
> +
>  	sdc2_clk_on: sdc2_clk_on {
>  		config {
>  			pins = "sdc2_clk";
> -- 
> 2.21.1
> 
