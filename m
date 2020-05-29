Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A46C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75A0206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHHeolFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391725AbgE2DGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391662AbgE2DGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:06:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB4FC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:06:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so459440plt.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bRzfSDD2gaLEL9NamArGGrWpz6V8R9/pVHTMUKrxQJE=;
        b=DHHeolFjNU7cZaU+lwwzEyqj5gapFR2dFMlkMSgH8vHBkxMTM95f1rHu6ULM5nTFUJ
         tuo1lbyIY7yvtZ2x6xe7DFQdzhxpUaGV75thnsnTfCEyuZcInhpWnN1LRFUWqhRaseWZ
         zhJUkfvbeNqv1NCXnUTeJf3NzcpVpxIDXBg2BSw7Bg3EvA1Ns+tOrsdGHLnz52gEIrXs
         HJIx17Z2RgZkqwWTDi02xuJ4iJt2reyD+VVbsmQdi0M4vkjktTzmNCGQiGxIt2Lo3lQb
         rS+nesSim3GW1TGB8tNmA5zjI1sPuGDRpybmOcTRNAUkrg4YL56/OIqEEmmh1Ex6KeK7
         8dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bRzfSDD2gaLEL9NamArGGrWpz6V8R9/pVHTMUKrxQJE=;
        b=Z5oNw+ir6eowlS0pLQCKoa/zeKwZa97mOg1O5S4am1u+BFk7PTzOI5pRC9m2IPiuTh
         yoCDu5O3UarA8lTQrD/9uchksTU4ogyJwXAOSh9brzmANcGTaMl1pgEvzHoygXPIU85z
         MqUtY35OawdG8NvhFwyF++Z7QMt/4yuNwe9ltxKfIDqTtVtlw3R9T/aZpaiXqr9N89E2
         xkGAInJ0ge46yy1kp9gMnLu9x7L7E0kyHz4womxJGcAs9gBO2vXwDSbKpSoSE3G05Yum
         e/4Cd4gXQG9mFmKSM4yjiEgdziA5wdGc2DJ9OoOybvTl0JT4fLvOEYh5yHv7OexoHi8K
         0ROg==
X-Gm-Message-State: AOAM531KC2ajkZJsaIWA2L/zNaJhMwBdX7xqEBmZXiihuWT1E+2FptEI
        jGtkOIBH1jKIaUiN6y90VRaOSg==
X-Google-Smtp-Source: ABdhPJyJLX0xumL3rRiNlPe2G72WD6ImRxaUkIb2ZjUungccspNLe+5a7wm8x2T/r2NpdM1NjjIbrw==
X-Received: by 2002:a17:90b:ec4:: with SMTP id gz4mr7444586pjb.36.1590721570961;
        Thu, 28 May 2020 20:06:10 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f18sm5241435pga.75.2020.05.28.20.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 20:06:10 -0700 (PDT)
Date:   Thu, 28 May 2020 20:05:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/6] arm64: dts: qcom: smmu/USB nodes and HDK855/HDK865
 dts
Message-ID: <20200529030505.GY279327@builder.lan>
References: <20200524023815.21789-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524023815.21789-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 23 May 19:38 PDT 2020, Jonathan Marek wrote:

> Add dts nodes for apps_smmu and USB for both sm8150 and sm8250.
> 
> Also add initial dts files for HDK855 and HDK865, based on mtp dts, with a
> few changes. Notably, the HDK865 dts has regulator config changed a bit based
> on downstream (I think sm8250-mtp.dts is wrong and copied too much from sm8150).

Can you please elaborate on this discrepancy? I do remember seeing
something odd when looking at this, but it seems like I didn't document
it anywhere...

Thanks,
Bjorn

> 
> Jonathan Marek (6):
>   arm64: dts: qcom: sm8150: add apps_smmu node
>   arm64: dts: qcom: sm8250: add apps_smmu node
>   arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes
>   arm64: dts: qcom: sm8250: Add USB and PHY device nodes
>   arm64: dts: qcom: add sm8150 hdk dts
>   arm64: dts: qcom: add sm8250 hdk dts
> 
>  arch/arm64/boot/dts/qcom/Makefile       |   2 +
>  arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 461 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8150.dtsi    | 180 +++++++++
>  arch/arm64/boot/dts/qcom/sm8250-hdk.dts | 454 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8250.dtsi    | 287 +++++++++++++++
>  5 files changed, 1384 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8150-hdk.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8250-hdk.dts
> 
> -- 
> 2.26.1
> 
