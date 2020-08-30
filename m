Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B993C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746D3206CD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HanuPX9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgH3Szk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 14:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgH3Sz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 14:55:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33B7C061239
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:55:26 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so3363161qtp.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jXrSKvfqB4+Buys69P+bVAXzX+bSR1lG5u67Zo5PRtY=;
        b=HanuPX9hVfAaMBoIfhMzUGtXvCQIwGuqg/HblZb3DrJni5pvpRIa3CRkw4jG2r8bHO
         hsqbcu2htVUmpJgjv/+fI0Z8Q/8l+eaSGKv3cZChM2I7NcBXuleldlMZXuMGMHjxHbYF
         2hDfSeHNE6kSxhWCtRhVkuOpIil+/+6wN9u86iRw4S59y5q9AQo8zy6rlWy0X7wWdZkB
         mNV6Okhmg32GafV37F7sdpOrBSjpnTK7wDe9fyvjbp4L/+powrCCQma6RPFkaYuN+v5o
         wVxvZwVq8fsuX7U+jPTejQXc++1sEE4Yf1OYwwmgHonIgdSAQn57yKX3ombFN4kTpLGh
         aXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jXrSKvfqB4+Buys69P+bVAXzX+bSR1lG5u67Zo5PRtY=;
        b=c2YFm16TRiFuFTuuxBR7GW2nff7jbKJ+tlab6uT1W/GlCNWjjTefhMYlZjrcg5PDaj
         Pyuu4Wxm0PWWE57uQX2OmnD3Cmkf0gs1PlkaUBP/8Cs5g8T02Ry0bDxP2lOTLT0F7297
         XkFZyXkUy3z9iPFclGDulfsU6IcCCddeAnyaAk/ec636WfOvldVwg2Zst4V3Z+UEGkte
         Vk1SFCn4fKVNDDF/PAChI+Uyt18BVlFGx2Dlm+9Ne34qT4LIwVMqPWUBDjQNFgXQ42kI
         aZU9FP0DcJHems/uewTYNYwhyI4esEdNuslQI/k24gOsL9ysqcT25z/vgWgiHSVcsMY6
         aTVw==
X-Gm-Message-State: AOAM533nTuSl/zjoLQDS4jAcIvkvT+e10a2IVDwTuOUNEMS4RfhaJGSb
        lvTMhRYzeIJ79+lAkMpc4UnMzQ==
X-Google-Smtp-Source: ABdhPJy/ocA9TsLg/Ih3oR4Qq4aGqIWbqqqZHo0pVWvRyYt7k/l2EHjr6jEpGm4Wn1jbuQIKEgf/6g==
X-Received: by 2002:aed:2352:: with SMTP id i18mr10442115qtc.167.1598813723414;
        Sun, 30 Aug 2020 11:55:23 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id d16sm7632575qte.19.2020.08.30.11.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 11:55:22 -0700 (PDT)
Date:   Sun, 30 Aug 2020 18:55:21 +0000
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     sboyd@kernel.org, heikki.krogerus@linux.intel.com,
        agross@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v8 3/4] arm64: boot: dts: qcom: pm8150b: Add node for USB
 type C block
Message-ID: <20200830185521.GC1947@uller>
References: <20200812071925.315-1-wcheng@codeaurora.org>
 <20200812071925.315-4-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812071925.315-4-wcheng@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Aug 07:19 UTC 2020, Wesley Cheng wrote:

> The PM8150B has a dedicated USB type C block, which can be used for type C
> orientation and role detection.  Create the reference node to this type C
> block for further use.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> index e112e8876db6..053c659734a7 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> @@ -53,6 +53,13 @@ power-on@800 {
>  			status = "disabled";
>  		};
>  
> +		pm8150b_typec: typec@1500 {
> +			compatible = "qcom,pm8150b-usb-typec";
> +			status = "disabled";
> +			reg = <0x1500>;
> +			interrupts = <0x2 0x15 0x5 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
>  		pm8150b_temp: temp-alarm@2400 {
>  			compatible = "qcom,spmi-temp-alarm";
>  			reg = <0x2400>;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
