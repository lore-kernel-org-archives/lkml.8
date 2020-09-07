Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B02BC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325A1207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOj4oOeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgIGQaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbgIGOZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:25:50 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5273C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 07:25:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u4so15463537ljd.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hVM3Bwa+7CBJ1tm/Y8nBpr8saRwPz4svplyjBBrsC0U=;
        b=uOj4oOeWuxxaOC3HiEmLRokBFD2dg7nD1Pl4YXtz7g4VAxKf1FMy8miJkKwkZe9LAT
         xzxye6K/Bk5OHtZ98rqpxm/YaCQhrhfulRoJoealMpHCYsSDKPrIjL782JpI792BfNJH
         Z1bxAJ9YP/+aZEbgwAV2/NM2D0sewEHFqEn1d5hL15DZyck5+AH5kuNPqDFtqobndW4q
         kqcRMHkAMintNj6zTEb+qQKL1supzKdRvXIYPA64AJL+dKfCvgfdARuLodImftyU/JcB
         d+u9lJqZiw8hXMILJNLkpJ/kAPeTFBR37LGdQA16PFdzc6KrD5Rft9Z6D8+Oj6Ja/5uS
         TIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hVM3Bwa+7CBJ1tm/Y8nBpr8saRwPz4svplyjBBrsC0U=;
        b=Fy5po9oGwHOGzmMlgTW8aiQO5Qm1jgU/+9VGR4LItRsYkBDrUFmrQM6imsHk9pRMK4
         hTSy2VevjoxTUXHHqKK/eIFyna/vGkOjh/GQ/FBsaKrXaH+ObISuC76hKKgSoPahonDG
         7Rkx/RCkBelcK3R/FZHxOulgdkoicRJqir1YDPfM1seemY3EjTWD/xCjkw4R7z++idN5
         LTUtKoyDrvH46vHmi+TJGIz8eRQkvcfJIyPsdShai++VstbBSDIrzI7x3zJepkdcXKry
         WL0D2H6r+Bp1oHJEXA2GdWPnuP0u3YcprFjA8lHcikMc1h4job9bzJLZ9QhombCWb2jB
         UYJQ==
X-Gm-Message-State: AOAM532feprlO4pu9T5/GgV9l0oxIVfndbPHqsXAhhpvvpcK4K6cl6+P
        p5woz9+3CB4xuijUHJNALqpO7A==
X-Google-Smtp-Source: ABdhPJygP+SYAnnRaMnSoWu4qiJ84OSHZbWcft2WovB1SA5iKRJc85ubCtTQ2w1xI5K+uszGHMBeCg==
X-Received: by 2002:a2e:7e12:: with SMTP id z18mr9706298ljc.388.1599488748047;
        Mon, 07 Sep 2020 07:25:48 -0700 (PDT)
Received: from [192.168.1.211] ([188.162.64.144])
        by smtp.gmail.com with ESMTPSA id f25sm5577940ljn.29.2020.09.07.07.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 07:25:47 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] SM8150 and SM8250 dispcc drivers
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
References: <20200903222620.27448-1-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <fd5fbe73-e2a5-d877-743c-ad7cc6110483@linaro.org>
Date:   Mon, 7 Sep 2020 17:25:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903222620.27448-1-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2020 01:26, Jonathan Marek wrote:
> Add display clock drivers required to get DSI and DP displays working on
> SM8150 and SM8250 SoCs.
> 
> Derived from downstream drivers. Notable changes compared to downstream:
>   - EDP clks removed (nothing uses these even in downstream it seems)
>   - freq_tbl values for dp_link clk is in Hz and not kHz


On SM8250:
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> v2:
>   - updated dts example to reflect the change (first patch)
>   - updated config_ctl_hi1_val in sm8250 dispcc to latest downstream
> 
> Jonathan Marek (7):
>    dt-bindings: clock: sdm845-dispcc: same name for dp_phy clocks as
>      sc7180
>    arm64: dts: qcom: sdm845-dispcc: same name for dp_phy clocks as sc7180
>    dt-bindings: clock: combine qcom,sdm845-dispcc and qcom,sc7180-dispcc
>    dt-bindings: clock: Introduce QCOM SM8150 display clock bindings
>    dt-bindings: clock: Introduce QCOM SM8250 display clock bindings
>    clk: qcom: Add display clock controller driver for SM8150
>    clk: qcom: Add display clock controller driver for SM8250
> 
>   ...om,sdm845-dispcc.yaml => qcom,dispcc.yaml} |   30 +-
>   .../bindings/clock/qcom,sc7180-dispcc.yaml    |   86 --
>   arch/arm64/boot/dts/qcom/sdm845.dtsi          |    4 +-
>   drivers/clk/qcom/Kconfig                      |   18 +
>   drivers/clk/qcom/Makefile                     |    2 +
>   drivers/clk/qcom/dispcc-sm8150.c              | 1152 +++++++++++++++++
>   drivers/clk/qcom/dispcc-sm8250.c              | 1100 ++++++++++++++++
>   .../dt-bindings/clock/qcom,dispcc-sm8150.h    |   69 +
>   .../dt-bindings/clock/qcom,dispcc-sm8250.h    |   66 +
>   9 files changed, 2428 insertions(+), 99 deletions(-)
>   rename Documentation/devicetree/bindings/clock/{qcom,sdm845-dispcc.yaml => qcom,dispcc.yaml} (75%)
>   delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
>   create mode 100644 drivers/clk/qcom/dispcc-sm8150.c
>   create mode 100644 drivers/clk/qcom/dispcc-sm8250.c
>   create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm8150.h
>   create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm8250.h
> 


-- 
With best wishes
Dmitry
