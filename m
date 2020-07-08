Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC35C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13CA2063A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hop4Z7+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGHUgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHUgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:36:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E88FC061A0B;
        Wed,  8 Jul 2020 13:36:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so9389915pls.4;
        Wed, 08 Jul 2020 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9rLMHF7RPOkdP8XBfKv5DeFSqMtc69/zKxIruSrtRkg=;
        b=hop4Z7+hPacoKF2K2a9kPOSfxgM5ZnlHngC8TvhdAUSh0hP5SaGebffZ8vCftXZPLf
         VNoTIeuMbvbIQfxnN4LajYTG79nIHpHVuyL+Iqp16e9O7fyWJ50vBL9O4wO6g36rpXkC
         RYhn7fR1ldEaFEiNiOUpwwte+C9dsoCJPtnJQSZ7ffDVyU13JBqY5gDVSkIghL7eDaJq
         necJ+UXPglOcc9LfjN1bGxdmjjlXrSFLQHkZWsrGSbuOlDQuwA/Tr6k+FrReKtpyAXif
         yMXzD1y3pyvrESCxLD7Jc1Z2K8H3Lr34VZZHLIKd4SMDTS9qFupaDM+4F4ItAYl5OCaA
         H7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9rLMHF7RPOkdP8XBfKv5DeFSqMtc69/zKxIruSrtRkg=;
        b=HfCdZ9Z379t7b2Guq4ZrXtZK72RVrXvb3jVBRQShjuC9yaaY2mXhEVWts20zxAJ4p1
         lGzu7HSPTk+H/z00B0LJ0oU9x29xk63U2HfmZW7YR68cQJ/oSjloDukXfE7zk76nq/lf
         U3Dp0v/oofsKwJ9CJhH+kP9Tiu/k3ZH+qigcW0MVQvIfgy1W1rAFD5VgPAAKM2EmCxIl
         3k6mB1Rsew5TR+xdFC7raO+JqT6YC0AQ4GWl+wCkeuPYsZ0WEVpAdh1xRy3Fk7wKX6LO
         ngHmW0luB/09yOwFssEVJMX1wA6Db6VuwPhq62wJPxEiPIGtQjXMli4nSqoArFIF8oIs
         atVw==
X-Gm-Message-State: AOAM533R1ZY3a3okp3dCnE3FqNA/mI3To6vNt/LWL09Ho4yu0+RCZ8vU
        rf9coq9GpKRTuHx2JJTVNBQ=
X-Google-Smtp-Source: ABdhPJzemCEI2WFYj68dmrOodtuH49vvXwwDiDf/1BJQPvSdsAAuf3s/BfJtg+3GTR292+GXPwPmXQ==
X-Received: by 2002:a17:902:c38b:: with SMTP id g11mr5179940plg.340.1594240592678;
        Wed, 08 Jul 2020 13:36:32 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id e8sm535878pff.185.2020.07.08.13.36.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jul 2020 13:36:32 -0700 (PDT)
Date:   Wed, 8 Jul 2020 13:36:17 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        robh+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, snikam@nvidia.com,
        praithatha@nvidia.com, talho@nvidia.com, bbiswas@nvidia.com,
        mperttunen@nvidia.com, nicolinc@nvidia.com, bhuntsman@nvidia.com
Subject: Re: [PATCH v10 5/5] iommu/arm-smmu: Add global/context fault
 implementation hooks
Message-ID: <20200708203616.GA28080@Asurada-Nvidia>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-6-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708050017.31563-6-vdumpa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:00:17PM -0700, Krishna Reddy wrote:
> Add global/context fault hooks to allow vendor specific implementations
> override default fault interrupt handlers.
> 
> Update NVIDIA implementation to override the default global/context fault
> interrupt handlers and handle interrupts across the two ARM MMU-500s that
> are programmed identically.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
