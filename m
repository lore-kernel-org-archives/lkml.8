Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF4FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71AEC2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6yn0s+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbgIDO4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbgIDO4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:56:11 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D01C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 07:56:11 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id y5so6109916otg.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vpKrUehbWkjhPrh2kJL3X4EVOaqPrDgkRZZZ122pDdg=;
        b=B6yn0s+mws5yiJzwUUdi885QZASFwaiPFQ4rw178/C+vYsxKsD6OlCOQ8UusjKl5nC
         O71NudexpsbPHvDy4sOCqwfRv85Lmq7SoKLP7nbqBY7hWMbPYYCBgOd5tnipoxJ8k8xR
         +2ifRFPJpDL8t0Qamvrya8MEmtSeQq6xsha0fJn2qq1S47aR9uWZ25hYEvC5NMg33Ici
         MyBBSqMBy0egea5fj14vVnPMan1YkXWnLMqyUjHcx8OgRxx4rkAfkRnSdiPQoRPXKAh9
         F0i4miDyQu+Ub91wJctr7EeT/cikmNeHYmZQ7pet1w9Ej8ZzDuWYdwG0KwYhzSil6lfB
         J+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vpKrUehbWkjhPrh2kJL3X4EVOaqPrDgkRZZZ122pDdg=;
        b=TkRtMgfAXhwQzQrfRUAGuxsjXaN8NJvN/bOXaoAAZxvxyPiWQDJ5xWL6JsnEUfJ07m
         I5vpUtFUTtobig/AbO9vOgm2OzflaCfWlBYdwfORzI1gb9tTd4DUaEcWt8ROF02wxtd8
         7g7z52G8p3FigWA1Mfuie3mgT9XpZ1Ej95KoRx82dBaGa1XF9U5UTL/Z7XR4n8Zgq045
         nHp2F6kDe8CnSozg5Msh7xY9z3F1CVVwW2J1KW597H91gapqY9Hp9Lla9qDtE2zcoen+
         eWbst3OfwaJVh9//MyR2k88XDClS4PJviuf1Vm4zunZuVOGzH1+eWzF7QV9V0GPUv+1T
         nubQ==
X-Gm-Message-State: AOAM532hCLkA52FrgET3vED7NbLA2VJJlSgluA2GGbYwZklAse9RXNMg
        bS18lhruycHUcWUE4e43J8+vgQ==
X-Google-Smtp-Source: ABdhPJypgpCZE8ik17Yt/cCswx06ecF47ejD0yq+nJtCASFxNBLNc1X2qdkI+lwn+VrKOkbHiWi1JQ==
X-Received: by 2002:a9d:7a96:: with SMTP id l22mr5682951otn.220.1599231370498;
        Fri, 04 Sep 2020 07:56:10 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id o7sm1262068otl.63.2020.09.04.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 07:56:09 -0700 (PDT)
Date:   Fri, 4 Sep 2020 09:56:03 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Andy Gross <agross@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu: qcom: Drop of_match_ptr to fix
 -Wunused-const-variable
Message-ID: <20200904145603.GE3715@yoga>
References: <20200728170859.28143-1-krzk@kernel.org>
 <20200728170859.28143-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728170859.28143-3-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Jul 12:08 CDT 2020, Krzysztof Kozlowski wrote:

> The of_device_id is included unconditionally by of.h header and used
> in the driver as well.  Remove of_match_ptr to fix W=1 compile test
> warning with !CONFIG_OF:
> 
>     drivers/iommu/qcom_iommu.c:910:34: warning: 'qcom_iommu_of_match' defined but not used [-Wunused-const-variable=]
>       910 | static const struct of_device_id qcom_iommu_of_match[] = {
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iommu/qcom_iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index af6bec3ace00..9535a6af7553 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -752,7 +752,7 @@ static const struct of_device_id ctx_of_match[] = {
>  static struct platform_driver qcom_iommu_ctx_driver = {
>  	.driver	= {
>  		.name		= "qcom-iommu-ctx",
> -		.of_match_table	= of_match_ptr(ctx_of_match),
> +		.of_match_table	= ctx_of_match,
>  	},
>  	.probe	= qcom_iommu_ctx_probe,
>  	.remove = qcom_iommu_ctx_remove,
> @@ -915,7 +915,7 @@ static const struct of_device_id qcom_iommu_of_match[] = {
>  static struct platform_driver qcom_iommu_driver = {
>  	.driver	= {
>  		.name		= "qcom-iommu",
> -		.of_match_table	= of_match_ptr(qcom_iommu_of_match),
> +		.of_match_table	= qcom_iommu_of_match,
>  		.pm		= &qcom_iommu_pm_ops,
>  	},
>  	.probe	= qcom_iommu_device_probe,
> -- 
> 2.17.1
> 
