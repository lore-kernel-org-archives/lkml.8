Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36021C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D6F20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599060580;
	bh=2DSRstD75qvOuRzlBbnht6LhxzBkk+h4izYXaQ2CFcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nFf1MppD7Apn9XYBLLfQ10XCgS4mqpcQBUQvQKYtHt/2dr6RKHyTYhT/EyrJI89Be
	 /UTxKP0vaAvnJ78d5lI6M8h2hIlTREPFTLCi28eqKn2k+1aINOqNifcnyvR+D+Y1hb
	 Rd/5kjpEIDOnbQ7U3qznHsZ25pIWgQFgIEy7yd6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgIBP3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:29:25 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:38019 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgIBPZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:25:01 -0400
Received: by mail-ej1-f65.google.com with SMTP id i22so7224882eja.5;
        Wed, 02 Sep 2020 08:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UJ9n3qNyQuhj+fGUbdBaOi3y34ToqX2Hqy8tvCxMKDc=;
        b=aayEh8vHYH20+ZN3NOKRxM2dZV6ssb7c3Svw9X2XWJWQdvkp+/nFtwyYr/TiKho8Fq
         5iHvKw3wKHrXC6M0eunkOMSYFqkme8UYdfbEu2AsQUHPcbDDe8gxwYHpjNKnQo9HyqPY
         uMmx2B2THSFlZVhne5ievMn3DvmbmKV9A9BC3j6lK+iMINgwMdVnblJa0XQrRR5Gn/RM
         nLnCpXgsawmkjJOO/iTTQRxcjwseSca8reVChYFrt80Q1NuyLj5QfIwUT8IcXaCd4mqE
         4Y7eEyiOLVIYBlORw+0dC2QiozoS1DoGQRUHHv1JwfxycVVPCw/szNsfNcLQSrehVwFF
         +n/Q==
X-Gm-Message-State: AOAM530AD0R+NBlIdJ/0lTP+bULPIqfMvL27NoW6mxZyIJJYBD1lasn0
        t2UNyvdbdwielsQvE5+ox8o=
X-Google-Smtp-Source: ABdhPJzjhRcIR1+NH6ZKBA2pU0EGtyRmfrLlAfcMCCO9MAZmByfyWzB2zLsG84k0q9hqBs2oA8ECLg==
X-Received: by 2002:a17:906:26d9:: with SMTP id u25mr569271ejc.318.1599060298987;
        Wed, 02 Sep 2020 08:24:58 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id bc18sm4270609edb.66.2020.09.02.08.24.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 08:24:58 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:24:55 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matias Zuniga <matias.nicolas.zc@gmail.com>
Subject: Re: [PATCH] memory: tegra: Remove GPU from DRM IOMMU group
Message-ID: <20200902152455.GC19659@kozik-lap>
References: <20200901153248.1831263-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901153248.1831263-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 05:32:48PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Commit 63a613fdb16c ("memory: tegra: Add gr2d and gr3d to DRM IOMMU
> group") added the GPU to the DRM IOMMU group, which doesn't make any
> sense. This causes problems when Nouveau tries to attach to the SMMU
> and causes it to fall back to using the DMA API.
> 
> Remove the GPU from the DRM groups to restore the old behaviour. The
> GPU should always have its own IOMMU domain to make sure it can map
> buffers into contiguous chunks (for big page support) without getting
> in the way of mappings from the DRM group.
> 
> Fixes: 63a613fdb16c ("memory: tegra: Add gr2d and gr3d to DRM IOMMU group")
> Reported-by: Matias Zuniga <matias.nicolas.zc@gmail.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/memory/tegra/tegra124.c | 1 -

Thanks, applied.

Best regards,
Krzysztof

