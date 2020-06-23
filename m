Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F57C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C345520780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nLhPkqBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgFWCrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbgFWCrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:47:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEF8C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:47:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k6so8471979pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HW9UZmnIeKRsydo19hBj6Mv14OBgXNqn665pFSfj4ok=;
        b=nLhPkqBRM79THEO2LMq70tOS1WvKazl+AuWuGMIqQZQX9jXSzFDdynDQBnZ3hbbV6H
         fm39JGAEL93wz6l3lHF0uaYQ4EmoZnkBPmymWsc/oagbZ4XfLIS1/Vl1T2Hds44PVtY6
         ueURrdQ5icu+ERjnAdYTaCJT8rMh8pzKhUcEnTL9buR1Z9++HNNVBCnYs6LOfo8WiqZa
         memwjCcsJV2TNtyWBWb8fvTXLgzyI2kSlWR6GQkBIr72nfXp5wQOO+NTf5crZCOTWjAx
         qlppT9bpdqh2XCa0ph4Ld9/yNDEu0KPCBZUj684gnh+1BsvJ3T+P9Rb7GdxYxYB43UrW
         RQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HW9UZmnIeKRsydo19hBj6Mv14OBgXNqn665pFSfj4ok=;
        b=q0sN6+Gk2W0WJBBhRDoktximisf77Ws35+bwUTAq1fNrzJkUskC1yLxCYpPF7GqzKY
         CHV1m4eIjiTrgtCRYt1Kc5U6Y3wmtrJmu7xLUw0k9xPio/JOmkAxwunMemJtAucazRm7
         E7qDYJqAl0Kli6iqYplwdOC2KISU/FJMIQCRsj6DmiJcLG/GdFJVc0P4ZvBaACF7g7X8
         E/ZfuSxtgMZztpCr1bw358YkxESa44MCIWEcigt8Ne2POwqfeY47dkRbTYBj6Qn7ac0M
         23lVvLrzudribtTunpakN81jXKsoWJDqmvo/V+8QBRigcIN8i+nVDKuZ09lDAgnQlz6O
         kRkA==
X-Gm-Message-State: AOAM532feptajrHGGsCVdoK7UClrOLdgZZ/VRR2SD6YmkJRCcXzKiVe9
        rapHJwZA2y5Zc5SmBhNKtvQL
X-Google-Smtp-Source: ABdhPJy1Yu8LxzqMo/6kXYwMwJ7Hp5ADmcmtmGWI55g8q8hUZ778zWWVzljRS2J4WGQkdaYhIqrQWw==
X-Received: by 2002:a17:902:eb13:: with SMTP id l19mr23026861plb.213.1592880429838;
        Mon, 22 Jun 2020 19:47:09 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:609d:7d26:e4ff:f0b0:edd6:2484])
        by smtp.gmail.com with ESMTPSA id j17sm761127pjy.22.2020.06.22.19.47.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 19:47:09 -0700 (PDT)
Date:   Tue, 23 Jun 2020 08:17:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sm8250: Add QMP AOSS node
Message-ID: <20200623024702.GC11093@Mani-XPS-13-9360>
References: <20200622222747.717306-1-bjorn.andersson@linaro.org>
 <20200622222747.717306-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622222747.717306-4-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:27:44PM -0700, Bjorn Andersson wrote:
> Add a node for the QMP AOSS.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 74a7ca96177e..246e6f279aa8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/clock/qcom,gcc-sm8250.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
> +#include <dt-bindings/power/qcom-aoss-qmp.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
> @@ -989,6 +990,19 @@ pdc: interrupt-controller@b220000 {
>  			interrupt-controller;
>  		};
>  
> +		aoss_qmp: qmp@c300000 {
> +			compatible = "qcom,sm8250-aoss-qmp";
> +			reg = <0 0x0c300000 0 0x100000>;
> +			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
> +						     IPCC_MPROC_SIGNAL_GLINK_QMP
> +						     IRQ_TYPE_EDGE_RISING>;
> +			mboxes = <&ipcc IPCC_CLIENT_AOP
> +					IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +			#clock-cells = <0>;
> +			#power-domain-cells = <1>;
> +		};
> +
>  		spmi_bus: spmi@c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0x0 0x0c440000 0x0 0x0001100>,
> -- 
> 2.26.2
> 
