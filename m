Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4BDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E252078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdFfuEeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbgFWXWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387713AbgFWXWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:22:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13422C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:22:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g12so136201pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CuB8LyKWU3gQTO8KTHP4chGB4nHsVZRexxd8DJQlhT4=;
        b=RdFfuEeBS/PDR2M6Vg8ybL7SXg24nMU7l0WJ9uLHmp+KqG8z51R72UWFRIZNk4J0gs
         f8ko8Zir2Wai94W3DHoFg9LiKrKzWpqC07baNkPSxTXV17wW1Jcqf4E/dJ2x+lqPAEEa
         SiPQhg2ZTI5r3jjpJsH/aQyLLsLMydKItNVxpNoigHSu/oeqGAtd2p7WxxXGb7KzTgGo
         QbTL+yEu2CeEGnmet0gGQO7rCFWnf8UcRoQtCTTBKL4gCFoS9K74THN26JtRRvlBRCpm
         A11gWfspW9Z49mLEnHJCOR5k+YWBYSPdxn5N2j8zuIvLJFakw0WlbF4XvZUUgfiiqYju
         jZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CuB8LyKWU3gQTO8KTHP4chGB4nHsVZRexxd8DJQlhT4=;
        b=JAqFtVCpS+pTj01hcEf6sF/LpXEv65NcxrydHygLCWeTifGDf+YvwFMkuVGMUjcvpd
         WkW/AfdtRi2am20WTCCRcY15lJdBgf/F/XYP57YHY7a5cFzdYq+WaCDKLm+JbvWIOPYB
         RMHYbcKvuGXs/P5rIX3BgHkV9Av3VEp+BWfxxxmHav/a1H/LtEfcrAn8tCw9jkreXiFR
         wNdA+TQ5wu/MQgEI72Lv4cxf528ztwaDQ1az3TSUAyr994nHWVvnj6Nb1ia1M+5KQsv3
         x248n0tlz3oOZ2SeUioLCVFUzoJi25XT7q0cpmdesArXs3yd01duDo2GXBZeMxDeuIiW
         f7Nw==
X-Gm-Message-State: AOAM533BglhTOVzAqmxd/rsfB3T7DUwEfm5y4zaZbeH8K+Q3gpALih8v
        3llVrHthRwIVwvyDFh7LJx73zg==
X-Google-Smtp-Source: ABdhPJx3gGUWnUZGIMU7UpWpvBUlSg0qBFeDf43EeDNUB7n4gVumN6S9IsR3biHWhJK/YAd1aX1H0w==
X-Received: by 2002:a17:90a:1d46:: with SMTP id u6mr26949001pju.146.1592954522548;
        Tue, 23 Jun 2020 16:22:02 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s23sm3357374pju.35.2020.06.23.16.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:22:01 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:19:19 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/12] arm64: dts: qcom: msm8994: Add SCM node
Message-ID: <20200623231919.GL128451@builder.lan>
References: <20200623224813.297077-1-konradybcio@gmail.com>
 <20200623224813.297077-7-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623224813.297077-7-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23 Jun 15:48 PDT 2020, Konrad Dybcio wrote:

> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8994.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> index f989530ffa90..838ffc0d9c16 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> @@ -142,6 +142,12 @@ core3 {
>  		};
>  	};
>  
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-msm8992";

Shouldn't this be "qcom,scm-msm8992", "qcom,scm" ?

(Or rather "qcom,scm-msm8994", "qcom,scm")

Regards,
Bjorn

> +		};
> +	};
> +
>  	memory {
>  		device_type = "memory";
>  		/* We expect the bootloader to fill in the reg */
> -- 
> 2.27.0
> 
