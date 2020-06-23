Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F1CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5455C2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXmuk7eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387947AbgFWX3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387710AbgFWX3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:29:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876C1C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:29:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b92so173535pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3lh416h2e2kRb2/LsSBkohB356M1N+qOaKq6eORI8us=;
        b=uXmuk7ehxvRGsVHcL8khoLVr4fOZ234FwxAOIKq0i00gIufVBnljLcwkTf71j03Sws
         w4Box+7A1mgbNGYRvSnGSba1SBoDmmxbvB8Wp3RQErSOjMHJHffkZhL93sViBBQGgOs/
         7pTWUApqFWxLZ+4pfw96IfZE0YWWR8Jf4ZXqXbYFrwk86ApHfQGr4xO5YG9gxiOAe0ph
         XJPFllehb17BKtehRI19Vl04GuPoibrzb02ok3K3eIgIgr+vv3wWpkFeIjeTUqzjtZFi
         2iZ3qwRQ9vUSbOPiAULPC47O+7DxsfFbnl82x0ePTdu8FJlGJyUs5x3qqooFhSiZYkXG
         WIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3lh416h2e2kRb2/LsSBkohB356M1N+qOaKq6eORI8us=;
        b=fyPwYUhPuo7suuWu7c1+Cr9XX4lFTmu38bV2Ureuk9/q1Osz2pvJzdpFygI59U5uQL
         OC4hfgu4nBMY+SAYceq+z5DdEPQBcLtQwsuhIjFagraRSKydvaugB3jjAlC4eQ/Uua8f
         QTmd3ftII0iZvdLyXIggPNxibunSZi9JCDD73ioZ/rAnBnyO73ppU23RTJyMSe9BZzVL
         9BlyfNdYnuNuG2ID+8V4xyjmdOYR3dK823CjCG6sUUVQGHewf6IAzVHH5tta4EycxGOm
         Um6AEihZhlJCpvkdNg+TMBX1bfUzHGnp2udAqDA8j3vx4C44ny4IauKwDtvYjJhlvdvR
         M5iQ==
X-Gm-Message-State: AOAM533c0ofbgno1vRFcKNqaxwXnaWzerzrPocWbpH4EO9I4e7Ad+Z0E
        vdaUErd54wEU2lov+dnRammizg==
X-Google-Smtp-Source: ABdhPJw3mIyTGvmU4iMJz6YtqydnFmB4TE6mvoU592WVL56jB50WHwDXCBzDiEAPcEzosMiKF6Yt8Q==
X-Received: by 2002:a17:90a:4a6:: with SMTP id g35mr25710525pjg.155.1592954988826;
        Tue, 23 Jun 2020 16:29:48 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m14sm15058323pgn.83.2020.06.23.16.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:29:48 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:27:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] arm64: dts: qcom: Add support for Sony Xperia
 Z5 (SoMC Sumire-RoW)
Message-ID: <20200623232705.GR128451@builder.lan>
References: <20200623224813.297077-1-konradybcio@gmail.com>
 <20200623224813.297077-13-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623224813.297077-13-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23 Jun 15:48 PDT 2020, Konrad Dybcio wrote:
> diff --git a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dts b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dts
> new file mode 100644
> index 000000000000..e70d54ed7325
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dts
> @@ -0,0 +1,395 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2020, Konrad Dybcio
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8994.dtsi"
> +#include "pm8994.dtsi"
> +#include "pmi8994.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +
> +/ {
> +	model = "Sony Xperia Z5";
> +	compatible = "somc,sumire-row", "qcom,msm8994";
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <0xcf 0x20001>;
> +	qcom,pmic-id = <0x10009 0x1000a 0x00 0x00>;
> +	qcom,board-id = <8 0>;
> +
> +	/* Xperia Z5's firmware doesn't support PSCI */
> +	/delete-node/ psci;

This does worry me...

[..]
> +&pm8994_regulators {

Per earlier patches, please update the way regulators are described.

Regards,
Bjorn
