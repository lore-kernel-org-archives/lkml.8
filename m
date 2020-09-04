Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305E4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FC520772
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fztru+Ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbgIDO5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbgIDO5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:57:21 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA51C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 07:57:21 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d189so6729986oig.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qwFik1VzdKihmwo9cBFiJu4/LHOZM7jcNFKIFxCkxKI=;
        b=Fztru+AcSdmnH4CC8rxLvREYY+3FnzSn/ADUlvE9QHLdsNufk+8airPBlRopYAXGZi
         WCWOp+fAniCaCE9hnf4aHgTv4nxT3TalwNn/was1jOdR4nMkqkj7JPDUw2oyjJVvVIZF
         OWez32qjH0GG49gsNb2e3JfUKu3s5t/t4LYTcdecijZ5TU/gEN/3Sl3LV7QRzlr+vUO6
         OEQ7lmcX2ZS8UR0zTom9PODEWA5BYGsdR0quvf6xHlRjQeRh0IH8Zv8Da2nW70zXxphz
         DSAnBe7FBH+aaAIXpSkGvQDzUh8cseeGaUhyo4fm0SkedJjh0eAgLE2XLKp3BTcbqdXW
         0tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qwFik1VzdKihmwo9cBFiJu4/LHOZM7jcNFKIFxCkxKI=;
        b=Ok1odVN7cKP4MuMaarEHG2TbAK+Lurq1AxCw+EObkcz4RobTJu6qx+wg1JE1ExgZis
         rvaJ/EJ/lNKMh/WAF+z9EW8VwO+yCbr+bgG7vNCvaCtT4An517xk5LpYk2NwV8QGfrzH
         ybNAEfKwRrNPRoMNylFDeZemEh+GSoquoVA7CCJ0ZcoebgNjh5fxo0RYVW9AyGL7/znb
         v8qrLVcZV9qBzVf5k4Jao1Ak6zFmvMk0uBybK+yNkhSQh9NgSbN96NOdvY8iPDlMy+c0
         Bk6N5aYHDmVx+ZefOk9hbwe+AP/JM+c6fh64ZkyublR+HmOTISQe4hmn3yqKgqllJRbA
         m8Cw==
X-Gm-Message-State: AOAM530i/VngXswmWnasgLNcO2miPkXGRAs8mtvLExkLMlaYpD0losqS
        bqmef4nxExqbV2qo9kTUiXv4JQ==
X-Google-Smtp-Source: ABdhPJzzr7V6Q+NFlUzi14ObzhGd5ZRKlNLTeyLYhw4G1XLnZ9tYm6XUMbNPBt9t8yqwGyX7v7ttqQ==
X-Received: by 2002:aca:5e82:: with SMTP id s124mr5266539oib.168.1599231440721;
        Fri, 04 Sep 2020 07:57:20 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id n61sm1227108otn.34.2020.09.04.07.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 07:57:20 -0700 (PDT)
Date:   Fri, 4 Sep 2020 09:57:17 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Andy Gross <agross@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] iommu: amd: Fix kerneldoc
Message-ID: <20200904145717.GG3715@yoga>
References: <20200728170859.28143-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728170859.28143-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Jul 12:08 CDT 2020, Krzysztof Kozlowski wrote:

> Fix W=1 compile warnings (invalid kerneldoc):
> 
>     drivers/iommu/amd/init.c:1586: warning: Function parameter or member 'ivrs' not described in 'get_highest_supported_ivhd_type'
>     drivers/iommu/amd/init.c:1938: warning: Function parameter or member 'iommu' not described in 'iommu_update_intcapxt'
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iommu/amd/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 958050c213f9..4a37169b1b1b 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1578,7 +1578,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>  
>  /**
>   * get_highest_supported_ivhd_type - Look up the appropriate IVHD type
> - * @ivrs          Pointer to the IVRS header
> + * @ivrs: Pointer to the IVRS header
>   *
>   * This function search through all IVDB of the maximum supported IVHD
>   */
> @@ -1929,7 +1929,7 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
>  #define XT_INT_VEC(x)		(((x) & 0xFFULL) << 32)
>  #define XT_INT_DEST_HI(x)	((((x) >> 24) & 0xFFULL) << 56)
>  
> -/**
> +/*
>   * Setup the IntCapXT registers with interrupt routing information
>   * based on the PCI MSI capability block registers, accessed via
>   * MMIO MSI address low/hi and MSI data registers.
> -- 
> 2.17.1
> 
