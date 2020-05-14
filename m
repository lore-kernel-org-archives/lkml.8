Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C543C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E0B20760
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jw3JoqZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgENRY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbgENRY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:24:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1DEC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 10:24:57 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q9so1050453pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LHBsucMd2sTr3HvWbUbdv7RFH1xfljlHMp94He6hhIA=;
        b=jw3JoqZcR+JkpSIRFVF6bzCezMt2ET2v0lnfG4lEuwXpjsAC//cobs0yPbOlb/wEmD
         R2247f4DjnI796d5bBmtgO51BUOwEB/UIblYzqfETbfyf5kdcqSwulnO/KoXXQAs9Fht
         wMuwYjYO/UH8CxTVs5CRx8Hts6qyWazW4DdC6vYV5FqGxK7kG+ingJovqls06Hm9MhCX
         LXIpu0bhRm0+N7WLxcCPO+9oKzTwKWXNpgub58PgRUEE8z34W4Jp7XBIIdy1ssAb0Fjj
         unayclz4Cyu6FEkrJw1MTaxnj4IIRpNvBq/NIqtPjjT50QVB3rTiKDSRaKItdfkCDrrg
         N13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LHBsucMd2sTr3HvWbUbdv7RFH1xfljlHMp94He6hhIA=;
        b=jWfa+NmIarF7Yb1QRfdeu4VT+tUkaRscIh1QVnhGDyuoCrNxbWgMLvWJq4QkqZ5Pm/
         4sVzmaxDGLsFerFL79X5kdKKs97fpfCR2YNK7ni6omd+IWNzRPy7mC3BJjR54mxOn5KM
         4PfcaTGbYHPZDR57Gk+wGf/+63wJ4nCVHBT7YXNZzLuZrvBqUuA0oXTC0Mvh4dQ8hxrZ
         0wUOQ1RNJU7BUxCIVD8DlRAMzIx8DdSIWbhnKoEGibBzZoX4IlD6WhZTbvIFh8eFSMKV
         JRh4eEigBK5K3ppJXAXfgMDGgkaiyNV90W8L/L9KPUSrPvyd45ACn4F44O66TxKfS9CP
         CSvA==
X-Gm-Message-State: AGi0PuZYs0isbMPVLJNMtyKb2k5LBNqVxNwD4zyaCjzA1P7r8EEZeWht
        av8sCtbZP72/pDIhoO0z5DXlUMAlxRs=
X-Google-Smtp-Source: APiQypJtsZHdqMh3QbEvlnEnAPVD9kLl8H9v3APnId1I2aEM7HIPo4p7CBOJ4YY+WlIh4C4yplr/PQ==
X-Received: by 2002:a17:90b:888:: with SMTP id bj8mr40059263pjb.91.1589477096443;
        Thu, 14 May 2020 10:24:56 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e11sm2753242pfl.85.2020.05.14.10.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 10:24:55 -0700 (PDT)
Date:   Thu, 14 May 2020 10:23:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     michael.srba@seznam.cz
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-samsung-a3u: add nodes for
 display panel
Message-ID: <20200514172326.GC279327@builder.lan>
References: <20200514170129.10902-1-michael.srba@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514170129.10902-1-michael.srba@seznam.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14 May 10:01 PDT 2020, michael.srba@seznam.cz wrote:

> From: Michael Srba <michael.srba@seznam.cz>
> 
> This patch wires up display support on Samsung Galaxy A3 2015.
> 
> Signed-off-by: Michael Srba <michael.srba@seznam.cz>
> 
> ---
>  .../qcom/msm8916-samsung-a2015-common.dtsi    | 44 +++++++++++++++
>  .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts | 54 +++++++++++++++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> index af812f76e8be..2a64aa269f52 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> @@ -72,6 +72,24 @@ phy {
>  			};
>  		};
>  
> +		mdss@1a00000 {
> +			dsi@1a98000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				vdda-supply = <&pm8916_l2>;
> +				vddio-supply = <&pm8916_l6>;
> +
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&mdss_default>;
> +				pinctrl-1 = <&mdss_sleep>;
> +			};
> +
> +			dsi-phy@1a98300 {
> +				vddio-supply = <&pm8916_l6>;
> +			};
> +		};
> +
>  		wcnss@a21b000 {
>  			status = "okay";
>  		};
> @@ -172,6 +190,32 @@ pinconf {
>  			bias-disable;
>  		};
>  	};
> +
> +	pmx-mdss {
> +		mdss_default: mdss-default {
> +			pinmux {
> +				function = "gpio";
> +				pins = "gpio25";
> +			};
> +			pinconf {
> +				pins = "gpio25";
> +				drive-strength = <8>;
> +				bias-disable;
> +			};
> +		};

Fyi, when you have a state with a single set of properties you don't
need the pinmux/pinconf level here, you can directly do:

		mdss_default: mdss-default {
			pins = "gpio25";
			function = "gpio";

			drive-strength = <8>;
			bias-disable;
		};


But this looks good, applied towards v5.8.

Regards,
Bjorn
