Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D737BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67D620772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPBIKgZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgFDNw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgFDNw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:52:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8981FC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 06:52:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ga6so1162629pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jr8wZhb4pJx8qPThUyDrXbZlabia3tw2g3YFZ6NyZow=;
        b=jPBIKgZSirOHvo7kMZ0JfAaDehKwnWbELDWidWKWB5maI6NK6rhB2zMh53/7rBREOu
         s/zaHev2o0vRWlK3IOjAmysDxCqk9E5uFAleswG4QlT9Ue/FYDa1kZYaqMFsl4iMSY0o
         STdElnXYJmLrmCqd/S7cdFT3vpW5cYGf+/JRB8Ob3TqJ0TMWmU8UnXcQ+CH1C76oHyzG
         Bbp526YQCO0aen0iL99tdv2LBgB6oK9RALZrPXCSFuFOXzVACHIfFS6vCXAjuepwrTM5
         4Fci5DqEvzcZCnmBH2bbzzffJkrMjpLJta4pILt5wxPNpwVEKNcRDyPcDd3iIax9lMWS
         TDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jr8wZhb4pJx8qPThUyDrXbZlabia3tw2g3YFZ6NyZow=;
        b=oupLhKRfREoXGbl1ff4eoQ+3GMKa9l1bsjbIaEexnbIoA0l75tvgUBy20GnopOC8Q9
         xfRiDo9p8of/qftpL63pZIaj2f/TXQPwYURRH1wLmVubi5zO4f9Wqka93lU2KdVUs8Xd
         DLG6eTOEARVxEenZZ82IeDCJNGDy6uZTDO1H2/3DrzdWPpT1TFn1++508T79LV3mOWaY
         2WnwHWnSjtU0SwG1kIcuIii/zVPnWHdERGxIDG6/cnO/n2bB+jxMzKIgIWxaFo79xB9M
         xUZIhZzJnA2mULDi3ZhXq1bw+RWRxoBmIYwzVOHwHh4o2+BS5klrbc7hDXVNsrVQ6X9G
         ZNTg==
X-Gm-Message-State: AOAM532/UnyduSkpPPd2iYxB+u9/H40zcYW8ZrkQ34xH4N3D3oF+5yCW
        4HgN1Vr1Sd/xmh9lTrRObog8
X-Google-Smtp-Source: ABdhPJx5jGzTevHPTJSqrq4bsJ72Yh4odpGq73L+WtB0R5X8do+vglg5O1igVJiUAcqCO9OuAPuPtA==
X-Received: by 2002:a17:90a:6344:: with SMTP id v4mr5731999pjs.27.1591278747907;
        Thu, 04 Jun 2020 06:52:27 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6211:4cea:c404:4d38:8396:d1ee])
        by smtp.gmail.com with ESMTPSA id b29sm4745683pff.176.2020.06.04.06.52.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jun 2020 06:52:26 -0700 (PDT)
Date:   Thu, 4 Jun 2020 19:22:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/6] arm64: dts: qcom: smmu/USB nodes and HDK855/HDK865
 dts
Message-ID: <20200604135221.GH16719@Mani-XPS-13-9360>
References: <20200524023815.21789-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524023815.21789-1-jonathan@marek.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 23, 2020 at 10:38:06PM -0400, Jonathan Marek wrote:
> Add dts nodes for apps_smmu and USB for both sm8150 and sm8250.
> 

I've tested this series on an SM8250 based board and able to get Type C (USB0)
working. There are also couple of Type A ports (USB1) on that board behind a
USB hub. It is probing fine but I don't see any activity while connecting a
USB device. Will continue to debug and once I get them working, I'll add my
Tested-by tag.

Thanks,
Mani

> Also add initial dts files for HDK855 and HDK865, based on mtp dts, with a
> few changes. Notably, the HDK865 dts has regulator config changed a bit based
> on downstream (I think sm8250-mtp.dts is wrong and copied too much from sm8150).
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
