Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C153EC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 07:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C61A206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 07:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DezoiOjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgFUHKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 03:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbgFUHKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 03:10:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AB4C061796
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 00:10:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 35so6099465ple.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rs+iz42LSvcYliYWKpWehXdXE9m0Op+Opvo6UxzrDnQ=;
        b=DezoiOjJmL7+ebFZn4YT1oTa68LfsmJVgrBxHbWGPYSoOxG0cCRdWAzuO1JlUMekpd
         pDtiRrLT2XGOMrFiFtKBapTNkxTrU8WAWtOhPQfU34n8Rfp0VkHYGhsD39pN23qCTXN0
         MhRO20R1rz49e/fxoFBnKeRC6oWKSB58rPBs2H1AdCet0nmv3akYp4pIlVNh4rd+1dvD
         FoibRYG4SYSKvzyTCjlHYo9J3Z1ZRn5TwbpB03ymNIRGU2Nd66wKVX+L8d0FBd8tzqDM
         cH5QCqgwMcFivImdQN37uRq9IkdoyfEnabGKipFsFMcSPA5fd33A0CBbC2KJlALWdyJh
         Va8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rs+iz42LSvcYliYWKpWehXdXE9m0Op+Opvo6UxzrDnQ=;
        b=I1Yjql3FCY/f5tLsY9r/hZUlr9fdcSXpixMkgeF7+DZluzY/Ydzx1pBo14oheU1/gK
         cOKRb3L0sU11P7+S5U98qkYUZmUkSV6z3jvCPMOmZLZSHlMyZfiG/H4aOWfnOAhky3NQ
         MNx2+OlpOs1OT1di4/x7j2aqK+50UIU8qB4x+ALKpHciZ7n8bV30Yv1p5djEVsQytDJP
         jIUJ+M5b7fKbwqurs9tPEOWQZwNTx/loevFGPXEtQ6JA59syJxi0qx5nvOpsRWAyCPm/
         DDnEW8ZH76dRxMPgS3QUX/fMfh+jYfqKLObcYbYX3umtAmYzO6fhB5EeBqCN3BgWPX3l
         yafQ==
X-Gm-Message-State: AOAM532qOcwhjnrEouj8zxdS0E1/ej5N8rV0iI5dATOrIT1XPiLKL0bT
        CEXFQuTk+iQ8eAB+h6XrVurLBQ==
X-Google-Smtp-Source: ABdhPJyN8AIO8Bd5LSQg1Ad590akaG4bavXjvnOwY4R7NRVqJFKB22FbEbITvXHZhdzXRh9YuBk8EA==
X-Received: by 2002:a17:902:bd05:: with SMTP id p5mr14146762pls.187.1592723444391;
        Sun, 21 Jun 2020 00:10:44 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x2sm10427367pfr.186.2020.06.21.00.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 00:10:43 -0700 (PDT)
Date:   Sun, 21 Jun 2020 00:07:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     heikki.krogerus@linux.intel.com, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        lgirdwood@gmail.com, agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, rdunlap@infradead.org,
        bryan.odonoghue@linaro.org, lijun.kernel@gmail.com
Subject: Re: [PATCH v3 6/6] arm64: boot: dts: qcom: pm8150b: Add DTS node for
 PMIC VBUS booster
Message-ID: <20200621070756.GD128451@builder.lan>
References: <20200617180209.5636-1-wcheng@codeaurora.org>
 <20200617180209.5636-7-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617180209.5636-7-wcheng@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17 Jun 11:02 PDT 2020, Wesley Cheng wrote:

> Add the required DTS node for the USB VBUS output regulator, which is
> available on PM8150B.  This will provide the VBUS source to connected
> peripherals.
> 
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi   | 6 ++++++
>  arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 7 +++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> index ec44a8bc2f84..b7274d9d7341 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> @@ -22,6 +22,12 @@ power-on@800 {
>  			status = "disabled";
>  		};
>  
> +		qcom,dcdc@1100 {

You shouldn't use "qcom," in node names and whenever possible you should
try to use generic node names. It would also be good to have a label on
this, to allow the regulator to be referenced by a client.

So please make this something like:
		pm8150b_vbus: regulator@1100 {

> +			compatible = "qcom,pm8150b-vbus-reg";
> +			status = "disabled";
> +			reg = <0x1100>;
> +		};
> +
>  		qcom,typec@1500 {
>  			compatible = "qcom,pm8150b-usb-typec";
>  			status = "disabled";
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> index 6c6325c3af59..3845d19893eb 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> @@ -426,6 +426,13 @@ &usb_1 {
>  	status = "okay";
>  };
>  
> +&spmi_bus {
> +	pmic@2 {
> +		qcom,dcdc@1100 {
> +			status = "okay";
> +		};
> +};

And then you can enable &pm8150b_vbus here instead.

Regards,
Bjorn

> +
>  &usb_1_dwc3 {
>  	dr_mode = "peripheral";
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
