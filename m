Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56F2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8FF204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1y9kEmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgETR7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgETR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:59:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5B1C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:59:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n15so1956729pfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/VG7JhWId2ggUAJ7+wRERmG2MSvueE8spDk60d1QW5U=;
        b=D1y9kEmRagg+MkBHOCCpJNJssjKuv6p598q1CaQZUkvgjc7ZIuzl7HfeoyDriDdpf5
         XUX858Macf+P23J0DBnD3K3EB6pZl+kLzAnY8pSEGszlAZStoppevWJKHyH8XI6c2Lkl
         pY4LoZaKUgpdyv+oCVW/B14KdWllVyhNSlepCCTInD1fVNR7ArOON/gw7sy5ysf5bxLD
         b7reSqM9I9C1mGAVsW2MCw2G9dZUYauaIZrLSRxO3fMtePQFyExDz+PQuO0YSNow7/zR
         jCvmO25bQ1LLB2IIq2c5jGl9vBpSF3Rw43syAAXdfTV6PHDvgZQYpGJ0+bp92eDgYzPQ
         JUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/VG7JhWId2ggUAJ7+wRERmG2MSvueE8spDk60d1QW5U=;
        b=ApoImBvfYYd9Ga9nGGqaxeUe5dGRs4izzKPIvtgE9EQvdCq/bnh0a2R+MTzG3fl9k1
         pSZdoVdMQGiYPfS26yTMVq8IbS6dChv8oiyVW5N+i6C/K0lny8TJA/cEtOCJcobzSmWr
         BqRFf0f00tViy4q3XsBy24RYIj1Q6U/75shNP7zpgHXdANg3lqBQ5wIvsh3Db3kODL9m
         gmmN2XoDgVPBnWe3EJiJm6uoPuuDqpKn3mUGMlIyYEZmKUtT2raRG4wwwCQWxeKTm2Iv
         Of4hu3StA/3zf5BlOPPV1dhz0TBtC4IRgERYB8uCksYvcNFuhNFBEBC7XWfrLK5aJbbX
         GvDA==
X-Gm-Message-State: AOAM530tOEKSOqFdsL8vFUZpD66lR0R75Ojc4szF3C1t5r38sTUHMsez
        iOYl0Yi7f2PWVfHXFSjkgW1zOw==
X-Google-Smtp-Source: ABdhPJyLR9x0/4C/6Bal2oDegmfghyP17zolTT91rytHhpCpeg3nWC8M+crqbk74jIh7xZWVPXTlPw==
X-Received: by 2002:a62:3642:: with SMTP id d63mr5499987pfa.222.1589997571579;
        Wed, 20 May 2020 10:59:31 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n14sm2520666pjh.45.2020.05.20.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:59:30 -0700 (PDT)
Date:   Wed, 20 May 2020 11:59:28 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: remoteproc: Add Qualcomm PIL info
 binding
Message-ID: <20200520175928.GA13884@xps15>
References: <20200513055641.1413100-1-bjorn.andersson@linaro.org>
 <20200513055641.1413100-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513055641.1413100-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:56:37PM -0700, Bjorn Andersson wrote:
> Add a devicetree binding for the Qualcomm peripheral image loader
> relocation information region found in the IMEM.
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v4:
> - Fixed reg in example to make it compile
> 
>  .../bindings/remoteproc/qcom,pil-info.yaml    | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> new file mode 100644
> index 000000000000..87c52316ddbd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,pil-info.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm peripheral image loader relocation info binding
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description:
> +  The Qualcomm peripheral image loader relocation memory region, in IMEM, is
> +  used for communicating remoteproc relocation information to post mortem
> +  debugging tools.
> +
> +properties:
> +  compatible:
> +    const: qcom,pil-reloc-info
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    imem@146bf000 {
> +      compatible = "syscon", "simple-mfd";
> +      reg = <0x146bf000 0x1000>;
> +
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      ranges = <0 0x146bf000 0x1000>;
> +
> +      pil-reloc@94c {
> +        compatible = "qcom,pil-reloc-info";
> +        reg = <0x94c 0xc8>;
> +      };
> +    };
> +...
> -- 
> 2.26.2
> 
