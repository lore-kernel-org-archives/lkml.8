Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C87C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F4E20888
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRORO8o+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387735AbgFWXSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbgFWXSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:18:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D9BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:18:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g12so131874pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0v96ac/leez1FdRm3ShEMVPeysWT8iB1v45wX2mCpIM=;
        b=aRORO8o+nqm0mE17Kc1Nc9GsbcGXWmVGCFNn9ZXXMn821qjSFWp7c8OnDP1jwDLgMH
         E13wrKo8PCLQp2Xsb8cluhdrpDe/FwwUqvkJ9sXF4hK7da04PDrd7mgWkieFE+3oteP6
         f7oFZaCoy91XPcUkhQLRzDFDM+vwCC1KRi91+e80brRRQpQAtmUTYQWvaXrNp/IEDvhN
         NKimV3EH/8GO2Gxy0gvmnhigASjTQcfqy5JkjtPS2IYLskBqHlZliyVC/B54hY+dLmzz
         BaIEtpzCQIfj05ZFL1tCbdab078xleDKh8yQkvWLFdul3nXpx+5DMXA9SaIT97hZJs4Q
         xNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0v96ac/leez1FdRm3ShEMVPeysWT8iB1v45wX2mCpIM=;
        b=ZMeiSzRxRgIy/B/DYdid+xiy1eXUfoHjqFOFfwt5VK19mb0HDUjOUEMi15Kc/URH0S
         O6TzHhBsMUc9zLBf7W4lDRXVvrUfZb6WF0xV1aicLti5braPndlCfm4qmmUkQFE2eU5i
         ESi+Wt0ZE3N5tmukoX2MOU8v3ujSlZTJnEwgNfvpjWGc0xxrbGwVUMbVxeEH3msLefZP
         Bpxm5WP2sLjmtsLvwTQgleRPI6yYRwEbgr5C+cIXMDRy0RIuYN2G1tLIfr2KZhru2OzN
         sjIgfBC5kXQfEkrx1eG4NsQfWLDlduUTcaBaNteG5Y9cVXnUX9NAKg5qcuBX9Jsj5VEP
         ZIKw==
X-Gm-Message-State: AOAM533oFWCYeE6A3HbleARlHR6JotZHvlaV2qujIy8TYQ2hcFRRDihu
        OHg8+eb2AGEz2LA5fvkyvwpDoQ==
X-Google-Smtp-Source: ABdhPJwqwUenAMlMsZ6tp1FrBJrXVkaOur2qDdhej0ImlRcHJrseQcotofWyOJamvq1ST5/QPq+YCg==
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr25300027plt.243.1592954319500;
        Tue, 23 Jun 2020 16:18:39 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r9sm18816543pfq.31.2020.06.23.16.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:18:38 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:15:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] arm64: dts: qcom: msm8994: Add SPMI PMIC
 arbiter device
Message-ID: <20200623231556.GI128451@builder.lan>
References: <20200623224813.297077-1-konradybcio@gmail.com>
 <20200623224813.297077-3-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623224813.297077-3-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23 Jun 15:48 PDT 2020, Konrad Dybcio wrote:

> Add SPMI PMIC arbiter device to communicate with PMICs
> attached to SPMI bus.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Applied, thanks

> ---
>  arch/arm64/boot/dts/qcom/msm8994.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> index 79e6e46798c8..23e50c30669b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> @@ -169,6 +169,22 @@ restart@fc4ab000 {
>  			reg = <0xfc4ab000 0x4>;
>  		};
>  
> +		spmi_bus: spmi@fc4c0000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg = <0xfc4cf000 0x1000>,
> +			      <0xfc4cb000 0x1000>,
> +			      <0xfc4ca000 0x1000>;
> +			reg-names = "core", "intr", "cnfg";
> +			interrupt-names = "periph_irq";
> +			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,ee = <0>;
> +			qcom,channel = <0>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			interrupt-controller;
> +			#interrupt-cells = <4>;
> +		};
> +
>  		tcsr_mutex_regs: syscon@fd484000 {
>  			compatible = "syscon";
>  			reg = <0xfd484000 0x2000>;
> -- 
> 2.27.0
> 
