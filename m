Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932FFC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD0820787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PuxOgWKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgDKBiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:38:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36473 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgDKBiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:38:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2so1227423plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 18:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=swcitsqOrp58FORQR6T5KNfMtaqgZ3ciuAXDoS3Hbqo=;
        b=PuxOgWKDl1hgeYSMVpjOVmwtTETL3LXwNZADwUOqPmnBYuhipAD2GY8W6C5ReWqEvx
         Z+W6Bv+9WKGL2PfJo9IAtujh9iieBrSf+U8mM+/b3D0o66miYllbwPB4YqmUq9+U8HQF
         JbbWx5lC91J/G7oZPDRfMXNopsd4hcagAyzq6zGujyq4Hh639JIDkI+/9e27Q6iG++HA
         I1NqSwaE51xW6YOWuHftsR0L15rIjCxdKQBEAVuJl7f0XDNXF3m7CDx4Y+Cm/+GnsNeC
         JJXmqIhc53suaJYWR+7c9SvSd3IGDHwzzEu1Pdx8mh06pwZd+rZON9qkbM970HOnUShP
         DOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=swcitsqOrp58FORQR6T5KNfMtaqgZ3ciuAXDoS3Hbqo=;
        b=nvEqA1y+4CCAUDQTdprVSYuiV/roDeX08BUucYcvEdqSs6Eac6Gt80D3sNzs2Qv3P/
         WWujnsRzdJJRRF1XV6AivdlnZNBvSTPlWUzgYmPMcnkpP5ndvLeCrrAPgBnzdOQNo58o
         wF3qzRCbwkql8v94WSHs3xrDB/uQ4YelBcg8dxdmgC3Qb6z1WgJXmQREDyzgJDnRQpXy
         OrnbehUW9gli5A/RuzOfEk6M5jU9Lrput24GizeHIK1/Vxya6wpQSgg4ZOObbSdQE9Ks
         VJvUeC4CH6hGCIsN2kMOaMNolCT54XBE5C9IkrNp+BKsJVcHvfU3DtxyIFMwwRWfjkij
         CPKw==
X-Gm-Message-State: AGi0PuaHnAKG7VXAnCqqed2x2ZJzMmD7yxX666/oQ1BCysPekMsF4uh3
        FlbK/Cn41avQRUm2Hd0FBlYeBQ==
X-Google-Smtp-Source: APiQypJ0hK8rOYfRRiqeUhwUyZ3mwi2rgoHu5r2CQteEA4e2TZZYQ4yTZm1FMIjHH84L6jDIce6XwA==
X-Received: by 2002:a17:90a:c708:: with SMTP id o8mr7232843pjt.190.1586569103585;
        Fri, 10 Apr 2020 18:38:23 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u10sm2825089pjd.13.2020.04.10.18.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:38:23 -0700 (PDT)
Date:   Fri, 10 Apr 2020 18:38:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Daniele Debernardi <drebrez@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 5/6] ARM: dts: qcom: msm8974-klte: Remove inherited
 vreg_boost node
Message-ID: <20200411013833.GI576963@builder.lan>
References: <20200410023203.192048-1-iskren.chernev@gmail.com>
 <20200410023203.192048-6-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410023203.192048-6-iskren.chernev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09 Apr 19:32 PDT 2020, Iskren Chernev wrote:

> From: Daniele Debernardi <drebrez@gmail.com>
> 
> The Samsung klte does not have a vreg_boost node. vreg_boost also
> depends on pm8941-gpio which are not present on the klte.
> 

May I ask what PMICs this device actually has, if it doesn't have a
PM8941 GPIO?

Regards,
Bjorn

> Signed-off-by: Daniele Debernardi <drebrez@gmail.com>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
> index de0bf6b7e732..ad26c83fee81 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "qcom-msm8974pro.dtsi"
> -#include "qcom-pm8841.dtsi"
> -#include "qcom-pm8941.dtsi"
>  #include "qcom-pma8084.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> @@ -196,6 +194,8 @@ l27 {
>  			};
>  		};
>  	};
> +
> +	/delete-node/ vreg-boost;
>  };
>  
>  &soc {
> -- 
> 2.26.0
> 
