Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264DD2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yn+FjvQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgFWXZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387599AbgFWXZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:25:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08473C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:25:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y18so153830plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qE7vw0GVqcFQF+JDQggXEnkset3CAwUc/U76FmaYOOM=;
        b=Yn+FjvQ53K9wm8K3rbcmUUE3AJMdVgGfxmQohnQq8p6BxBUb1IQXw+Ens5oPzIQ4uS
         Ymar9ULBIVv4OoPeMYXOmNGBgN+636JA+zpMm+3L6nGBHuF+jyKFiMB/V8KZMZl4Xbuw
         MXyN2O+sFyszKi1v5tIh6Me5iOuMtEpv0CQoMjzCa2DqRfWP5GyoU61X/k1gHLHQ74Z2
         3hXAkEkYTCQuWo0zIV6YscQ5F5opIbvbOb4bYfRxEGUYwQQ52JmoqAzn66nQaVVgJW64
         /ZkJSCta8rvvB0KjaYfoJ7Y9+2HQQoY8falz29KTjnI+eJKhUtuUpcnTQEWjh8hY9oLA
         Mnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qE7vw0GVqcFQF+JDQggXEnkset3CAwUc/U76FmaYOOM=;
        b=C0l4pj2HW7i9If9a29SVsRvcDAJytpWxRhwwvw4e8HouNkRRR+ZILBvbo2b9JvcwJZ
         BIBDfDRAH+yxmp1XUlDrt0JQi8IrX0sf2xtAkTJ9p8lmNzKJu786IkLPbvE1+GcDS54q
         Te43dkRAtvtVmqGkEIuwFlmak/qkOwtjaPnzebYpZ6WBIfK+D1EaTuNtPXVwAKTfdx0B
         c3sahaHG7FCSaPk7ZS6AxNJVwrULH846P8ewuXTE5fQj+NYI87d4aSkuOFTefvGQxy7t
         nWqDabnKTZCMCovX4VL/YBYfWUHDA0k5+V4mUXtcYC6Z37BeCdzNp4LI1lb3mF3qvTDm
         GRmQ==
X-Gm-Message-State: AOAM530Z2FVneBTxFw39xSDo9nvI/peZTworJm3gAldejpQ+HquMyyZ/
        D/QJDFJH5JYoHOgSa/A+U3T3zA==
X-Google-Smtp-Source: ABdhPJwQ/Jau2NMJv+UPDND3zP/fjJqZ/f7DzjXlnas8zvrMilmF2OYPTT2JL0gVhGgG+3sNCPrMdg==
X-Received: by 2002:a17:90a:c003:: with SMTP id p3mr26633173pjt.178.1592954753537;
        Tue, 23 Jun 2020 16:25:53 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x1sm3465861pju.3.2020.06.23.16.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:25:52 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:23:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/12] arm64: dts: qcom: angler: Add qcom,msm-id and
 pmic-id
Message-ID: <20200623232310.GP128451@builder.lan>
References: <20200623224813.297077-1-konradybcio@gmail.com>
 <20200623224813.297077-11-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623224813.297077-11-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23 Jun 15:48 PDT 2020, Konrad Dybcio wrote:

> Add properties required for the bootloader to select
> the correct bootloader blob. They have been removed from
> the SoC device tree as they should be set on a per-device
> basis.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Applied, thanks.

> ---
>  arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
> index a5f9a6ab512c..baa55643b40f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
> @@ -11,6 +11,8 @@ / {
>  	model = "Huawei Nexus 6P";
>  	compatible = "huawei,angler", "qcom,msm8994";
>  	/* required for bootloader to select correct board */
> +	qcom,msm-id = <207 0x20000>;
> +	qcom,pmic-id = <0x10009 0x1000A 0x0 0x0>;
>  	qcom,board-id = <8026 0>;
>  
>  	aliases {
> -- 
> 2.27.0
> 
