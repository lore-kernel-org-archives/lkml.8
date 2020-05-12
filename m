Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71238C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F92206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1GpKQFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgELBpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 21:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgELBpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 21:45:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD2C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 18:45:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id u35so2419786pgk.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 18:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EzSvlPNDgC8QL7k10YiJ3iEGWBUqaT/TcSlvZ5anIbI=;
        b=Z1GpKQFF7AJRwxu45DBLZusPUf9VrAZH9t36YQCR9/bdtM/LwWvR0hmpxb5eChwkxr
         ZYPpknWrHs4x0/fy/4PVbHVu12DzYD8T0uT6V7WT6w+nvKNM1MFUgKiBJ/Il4FkqjlCX
         9vHCpt6s1AFL5sEcyRKUONVy8e4zPif8so9I5Y2YSsVKojAOlhM4maBJvqvSy3ZUR5t5
         2jPEFETY8XL3FR6C+5gG01ynTgmOSLxKlzO9B0s8PcKEm+s9ZS69yY+VN6DytgTF01NA
         fCmovQ5o9DCOOJGJl8r7+EGAGOhFtKmdk/yWM3TqrgMUm+yRyAPsqmUWgrjKJgMAlGfW
         Rweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EzSvlPNDgC8QL7k10YiJ3iEGWBUqaT/TcSlvZ5anIbI=;
        b=E7+0M0pReHSriOhxnIgZFw3zQIRDDkG1deAdI/8LtSP4tO0RxwryEVuKLYc/nlQ2Lf
         hKi43NoYyiNqJMn/kExEGPQEQ0hrEY549kSJGuMluf9mO5BRJDYEEpyXEXWCuRVnq2tl
         yYL53BEPEQk/s8RPh8OzSECKIqFf9vRuQSWNaHTGUigyONTVkYDHOtP3/rDG+NarX+Pw
         Cz3nnykS7TlSfsEAX/5OlHU8gbhaF2V3B3QvyLPRS1Kok1EkVjNTfBKHqX60rLo3Pd2l
         4xZKZBmMybdDJ4VwkkpebIgtzxekqKPTj5nwX2r0v8HTVYCQHPw6xZiXCq8uPGX38rII
         K3lw==
X-Gm-Message-State: AGi0PubMhZ8HjiT4neuOtrm/On93u1Lp2VsqmJ3u2gDRWg5sg54CHpjI
        I6l0PHoyIlpbM70DTiE++KB5/w==
X-Google-Smtp-Source: APiQypJsZ7ZIXhfW5xJ/S5w9zLmhRM6eJ1H7SWozJ4hVlmFcnAYBLrV/n7xK+cO90AVmYEBQp8f+Mw==
X-Received: by 2002:aa7:9802:: with SMTP id e2mr18728502pfl.213.1589247913730;
        Mon, 11 May 2020 18:45:13 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z66sm520869pfz.141.2020.05.11.18.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 18:45:13 -0700 (PDT)
Date:   Mon, 11 May 2020 18:43:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     agross@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, nishakumari@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        rnayak@codeaurora.org
Subject: Re: [v2 1/4] dt-bindings: regulator: Add labibb regulator
Message-ID: <20200512014339.GE57962@builder.lan>
References: <20200508204200.13481-1-sumit.semwal@linaro.org>
 <20200508204200.13481-2-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508204200.13481-2-sumit.semwal@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 May 13:41 PDT 2020, Sumit Semwal wrote:

> From: Nisha Kumari <nishakumari@codeaurora.org>
> 
> Adding the devicetree binding for labibb regulator.
> 
> Signed-off-by: Nisha Kumari <nishakumari@codeaurora.org>
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

Sorry, I missed this when we talked about it. But please rewrite this in
yaml.

> 
> --
> v2: updated for better compatible string and names.
> ---
>  .../regulator/qcom-labibb-regulator.txt       | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt
> new file mode 100644
> index 000000000000..6e639d69f780
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt
> @@ -0,0 +1,47 @@
> +Qualcomm's LAB(LCD AMOLED Boost)/IBB(Inverting Buck Boost) Regulator
> +
> +LAB can be used as a positive boost power supply and IBB can be used as a negative
> +boost power supply for display panels. Currently implemented for pmi8998.
> +
> +Main node required properties:
> +
> +- compatible:			Must be:
> +				"qcom,pmi8998-lab-ibb"
> +- #address-cells:		Must be 1
> +- #size-cells:			Must be 0

But the children doesn't have reg properties...

> +
> +LAB subnode required properties:
> +
> +- interrupts:			Specify the interrupts as per the interrupt
> +				encoding.
> +- interrupt-names:		Interrupt names to match up 1-to-1 with
> +				the interrupts specified in 'interrupts'
> +				property.

Do specify the expected string (and given that you already have the
lab & ibb subnodes, you don't need to include this in the string).

Regards,
Bjorn

> +
> +IBB subnode required properties:
> +
> +- interrupts:			Specify the interrupts as per the interrupt
> +				encoding.
> +- interrupt-names:		Interrupt names to match up 1-to-1 with
> +				the interrupts specified in 'interrupts'
> +				property.
> +
> +Example:
> +	pmi8998_lsid1: pmic@3 {
> +		labibb {
> +			compatible = "qcom,pmi8998-lab-ibb";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			lab: lab {
> +				interrupts = <0x3 0xde 0x0 IRQ_TYPE_EDGE_RISING>;
> +				interrupt-names = "lab-sc-err";
> +			};
> +
> +			ibb: ibb {
> +				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>;
> +				interrupt-names = "ibb-sc-err";
> +			};
> +
> +		};
> +	};
> -- 
> 2.26.2
> 
