Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE61C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 03:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7BE20714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 03:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zB2iU0yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbgGVDoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 23:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbgGVDob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 23:44:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F54C0619DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 20:44:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so466021pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 20:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k2fq/wKunbTQtbzxcjBzbGBCQHEpu9nN54onX0ypqsk=;
        b=zB2iU0yhHVsIhc9sLkETqFqT64wFAAmTr9FJaI4TY2wjlC1gXDdEC9JHN77r0d+3G0
         IqvsyYyem4cI8PUKDz5xhSKjssYiFvUn2vdIrWqZg+f/BSbXdmPVL1GRuPpeer90z4RC
         CF5xPurma3D2HuEC/lhnQW32yhWdCKfOAFkQvREwXzSHK6boGivVzxtJq+m7Q+ZAk2hN
         QvljAzI1DDHm6iwhNcBaFdJVhyeASUsiVL3xdNxNeDWLDBusEGANTq00tEfMaoYoA4N2
         vXMrcJk3xlt76dL1HhBsKSEsLAvJjuhixSmGHUhVogb4AB5Q/GIK0uX5+0fkN7tu+sgQ
         o8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k2fq/wKunbTQtbzxcjBzbGBCQHEpu9nN54onX0ypqsk=;
        b=UajWAN5/sTFMPdPm+etMNurTfcWZbPI1VmpS1NG0Ok4FEJc2R09CbJ+DLyUx8v8Z+v
         9fWJR1vl1y5XAECekBS3RLfTno3tZSwYaNAS+/L6r8AGued0kC/lpjFSBU5YZ6pni0ek
         BM4R7cOwjiPSS51IhwlDviLgI5GyziWywUBxF5rWsDHcw5EnQGcvO6NyIhBWUGKiFhgk
         hstcjLd6t557xAhBwlh0g/8YRHM//AWT5x98RjBB9WUUuV3Bwaq7dyvJstVbZkhbg4cr
         zFYsweFIT4HyQHQGfSaQZblKsb0f7KRCtfhS6yUb02frbmvTmtedNfYvXbYR2g5j2pYw
         pkBw==
X-Gm-Message-State: AOAM533i5RD33J1A6f10zZN9THwuySJwnKQf4BDOeZSZvAYhQ1nNUegb
        VVw9wyBoG/NOoK5/Zr+fMho+iA==
X-Google-Smtp-Source: ABdhPJzBM2aYSCdVc4QOXQOyCvsU/uDe0OrcBNBWaNPtGtrsnL22/ZqJPVGLM4aPMfe/ux8lJoOPtA==
X-Received: by 2002:a17:90b:4b84:: with SMTP id lr4mr6555524pjb.111.1595389470800;
        Tue, 21 Jul 2020 20:44:30 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z2sm22098713pff.36.2020.07.21.20.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 20:44:30 -0700 (PDT)
Date:   Tue, 21 Jul 2020 20:42:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mka@chromium.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7180: SD-card GPIO pin set
 bias-pull up
Message-ID: <20200722034237.GO388985@builder.lan>
References: <1595328245-29328-1-git-send-email-sbhanu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595328245-29328-1-git-send-email-sbhanu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 Jul 03:44 PDT 2020, Shaik Sajida Bhanu wrote:

> From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> 
> On some sc7180 based platforms where external pull is not present on cd-gpio,
> this gpio state is getting read as HIGH when sleep config is applied on it.
> This is resulting in SDcard rescan after suspend-resume even though SDcard
> is not present.
> 

This is exactly why pinconf properties (such as bias, drive-strength)
should be defined in the board specific file.

Please move the "pinconf-sd-cd" node to sc7180-idp.dts.

Regards,
Bjorn

> Update cd-gpio sleep config with bais-pull to fix this issue.
> 
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> ---
> 
> Changes since V1:
> 	- Incorporated review comments by Bjorn Andersson.
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index d78a066..a3527c3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1819,7 +1819,7 @@
>  
>  				pinconf-sd-cd {
>  					pins = "gpio69";
> -					bias-disable;
> +					bias-pull-up;
>  					drive-strength = <2>;
>  				};
>  			};
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
