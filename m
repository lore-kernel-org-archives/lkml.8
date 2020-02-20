Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336D1C11D20
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8F420801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaF//ckA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgBTUrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:47:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42688 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgBTUrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:47:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so2493398pfz.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 12:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hkv6DOXu5fdybyXIzjRo7+04GtF2evxAJc5xRrDjbJ8=;
        b=jaF//ckA9Yq4Vh+ca/r+NhybKNWW6ze+2UlwRWigULuox+Ken8q1+KvZPDzCv6iHYG
         xcShEnwM2BcKYi+TQWEU69o9JK/JeCXbNDNyc/KdTYhEc3SnwM48KnmXNz/zn3AkxwV9
         qy5YupuRRpb/l28O7x2Matqm96xTgKDJ6uC9rzBBvLXd3YgIRy6LRTxgr8qsSXhAZ/dx
         mqZHEVQAlsGYqF81UiUIuStZv49XGPVq5qbyaiXM7Zg1IKUey4oXTzfGOX6nWxjsll0N
         7xX7KbkE7wNZ3z8/BcETr7Sd+yEgyvtbgU3VrwRukkfdN06SUSjp7DEaHQzffZCoWVaD
         KMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hkv6DOXu5fdybyXIzjRo7+04GtF2evxAJc5xRrDjbJ8=;
        b=V5CNh5fIKa/48/1B0SQoqEiou9rYuw7a58cunj25q68TpGTovxofaW/OhyRwKdYLXm
         vZqttro9jNio61zZl80NOC30/5dp5+nyYjiTQbzx5Nt9Pmu9K13iJy9NkzA7y3CqhQGH
         6+AI2m9PCFtHocHwo2aIT5n4AYjiaSBIhRtS5a/Cr1cUyFG4RRyVUsL2qpmcOmyHS6gy
         BeQJ0eNMQCC1uJDm0xcqiyD5E7PM6CyJDaj61KkB9nHsGTA3I15yGM2URaSA01YpktjJ
         oMDpbbVaOdOhcD6yDaxHAX8f2o33yu/gy7gDraLl+XwdgXuIn04MePwLjowM++Em0oU5
         AAmA==
X-Gm-Message-State: APjAAAUa/9AnsRGbt0xv5ncebae4yu81PvxIEXlf0e7WpPiCP/2zAyqN
        wW3xZXmKsUyYyThktREOfHEj3g==
X-Google-Smtp-Source: APXvYqx+aKyiXRkNTfl5Aq1gcOsCwd61wYCFHeHE3bYX5050kK3HcQXro3BICKybNa6XOZ4aygdYhw==
X-Received: by 2002:a63:a741:: with SMTP id w1mr35769659pgo.131.1582231669323;
        Thu, 20 Feb 2020 12:47:49 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u23sm479779pfm.29.2020.02.20.12.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:47:48 -0800 (PST)
Date:   Thu, 20 Feb 2020 13:47:46 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH v3 4/8] arm64: dts: qcom: qcs404: Add IMEM and PIL info
 region
Message-ID: <20200220204746.GD19352@xps15>
References: <20200211005059.1377279-1-bjorn.andersson@linaro.org>
 <20200211005059.1377279-5-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211005059.1377279-5-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:50:55PM -0800, Bjorn Andersson wrote:
> Add a simple-mfd representing IMEM on QCS404 and define the PIL
> relocation info region, so that post mortem tools will be able to locate
> the loaded remoteprocs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v2:
> - Replace offset with reg
> 
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 4ee1e3d5f123..f539293b875c 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -997,6 +997,19 @@ blsp2_spi0: spi@7af5000 {
>  			status = "disabled";
>  		};
>  
> +		imem@8600000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x08600000 0x1000>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			pil-reloc@94c {
> +				compatible ="qcom,pil-reloc-info";

s/="/= "

> +				reg = <0x94c 200>;
> +			};
> +		};
> +
>  		intc: interrupt-controller@b000000 {
>  			compatible = "qcom,msm-qgic2";
>  			interrupt-controller;
> -- 
> 2.24.0
> 
