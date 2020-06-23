Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13689C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16D520724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nrQC4w3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbgFWLgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732443AbgFWLev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:34:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D51DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 04:34:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a127so9948045pfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PkzrLJ8GQCeqvePUouDtyFlaPA55kJZCSe1ntjETQw4=;
        b=nrQC4w3A1v0pfWioLgCVpCk7IFobcxPOzAB8rnpV50jIQn7WEYPuG+Ct2b/lsLccAO
         Y/E+65Y+oCT70dsfdryHawG0zTIt8CImRu2p66n82EbutffVH0/JqEmQzSdepymPXtPV
         /SiHFMfPcmRr2dtvpUI7eUUK2J2eooXYFcNeAbpCaqwV2ttevXk6fuDzVAKAaUsnYkEg
         EokKiBopklKMnv9ml+h441QAOmfdnQr/EG5JQPFucdzCilPPY10ZaS6tQJQt0Y+9Ql3q
         F2eWGmR0rumqwqA22JI+JQngr3Nd8+rzLXW9TS/CcuE3ipWdT5jXxjaC83v2i9DE7KP8
         KMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PkzrLJ8GQCeqvePUouDtyFlaPA55kJZCSe1ntjETQw4=;
        b=r3wW3z+agCmsPqnXWYs89OrWew1gmt5YG98JDeU7OQLzO7NPrgRIlyZATiRQ4nwC96
         dVY8x3oty+04WnB7NVigs23PAAEdbd1/sJCTS7HLALfxpro5Fr/RFN0dZptYoW96I50/
         RMNFzXL4srPRDLSoUQFcfErUd+FuqCf91ZHyfzrzzjqA+A+FQjEQl+IdqJ/eXmHisrgX
         mx0ylnYiXadux7UNbZioVme02a3qenpQrOVFlAXb/teeYbALH4YZ1OP8Qbz3B+1lp542
         yUMMAwrx56zWXRUv9H53gGnESVgiaSoAenybXWfx6nl3wOW+1AWqqb64BJrtLd7xbLRU
         vzbQ==
X-Gm-Message-State: AOAM532b773uzZJFIdDOnVbBvJFcDbZGoe3gZhZcMEaBDyqjuXx3Gobc
        /AJJ39rH6sRSV6WPnfLJGe7k
X-Google-Smtp-Source: ABdhPJzoDy3xwrO38WKLoUceaihufyrOPObFSwULxYG51nVgdbmuMFL70euQsI1xMUNsz6xO5O7k5g==
X-Received: by 2002:a62:7e8d:: with SMTP id z135mr23497708pfc.251.1592912088852;
        Tue, 23 Jun 2020 04:34:48 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:609d:7d26:e4ff:f0b0:edd6:2484])
        by smtp.gmail.com with ESMTPSA id m9sm16636166pfo.200.2020.06.23.04.34.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 04:34:48 -0700 (PDT)
Date:   Tue, 23 Jun 2020 17:04:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sm8250-mtp: Drop PM8150 ldo11
Message-ID: <20200623113440.GB13669@Mani-XPS-13-9360>
References: <20200622222747.717306-1-bjorn.andersson@linaro.org>
 <20200622222747.717306-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622222747.717306-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:27:42PM -0700, Bjorn Andersson wrote:
> PM8150 ldo11 on the MTP is wired to VDD_SSC_CX and controlled in levels,
> rather than as a regulator. As such it's available from the rpmhpd as
> the SM8250_LCX power domain.
> 
> Fixes: ec13d5c23a33 ("arm64: dts: qcom: sm8250-mtp: Add pm8150, pm8150l and pm8009")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> index 2fc9e7ff0060..63d259931c4d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> @@ -140,13 +140,6 @@ vreg_l10a_1p8: ldo10 {
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> -		vreg_l11a_0p75: ldo11 {
> -			regulator-name = "vreg_l11a_0p75";
> -			regulator-min-microvolt = <800000>;
> -			regulator-max-microvolt = <800000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -		};
> -
>  		vreg_l12a_1p8: ldo12 {
>  			regulator-name = "vreg_l12a_1p8";
>  			regulator-min-microvolt = <1800000>;
> -- 
> 2.26.2
> 
