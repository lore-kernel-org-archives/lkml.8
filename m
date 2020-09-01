Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CA8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529C3206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJHiAw/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbgIAQ6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgIAQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:57:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A3DC061244;
        Tue,  1 Sep 2020 09:57:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id r13so2425655ljm.0;
        Tue, 01 Sep 2020 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fLX5J20+fA4410d7uA+LwglBCTxFJG7EYBTgn15oCgQ=;
        b=lJHiAw/ipnb9qghfOnZr7yNwUUoq5LxZ9Kbk8xp5SQ7UyP2mBuTCNUaDjcpV0cX3jc
         hDDcYQpqUtb6H+p7z93EWF9by0zOFnAT99VMnubt6SixxOLDzjKizqBlmeXEi16XO6wt
         FlnmJ3gdOuGNI4l+QWmPTQgzhWR43Rm8jghVHciIOB6E4VXDvqTYhRNyVEfNff+gf34m
         9TQIvbLO5XkuDFwAjjwCpGxH3GYJxGoLR7gjDVXZpr28f8tnkVF8txcdrHMgmDfOPnPt
         X7xrjc92zbKpLtv8802fOv6XUnBwAZ4X6zxwyks4ERzjLsD1TnbttHua0NQBB2IP9u1F
         Tv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fLX5J20+fA4410d7uA+LwglBCTxFJG7EYBTgn15oCgQ=;
        b=RqrG8yBCvsLyZYgwUj0dfLXwgYeqy1Yg6OxQguxtW1lT90i9RBrslFis9wgFU9bAox
         wiza/GLPDP0XpFVgVQZgzp/+tGsMcEFf9dh9f/Oaj/0tfAEu3rNblpkO7QQXfgBE6tPx
         6akUdVybXYrQDKXFzF4HCrF+ydbd+cLvK49v+brups1pahom98vbnq8UoJgVvAa3QjZh
         J863y6EG3C442VJTDTj2RNagrooUJ8Z79nj//V9+jt7QKWHSRT8c4+WeQjgWSrpjf4Gi
         deXM6QUaHY2PfOam7pG1af/fAcDGqHv5eGRPpt6RShojIIlzzgaeigRrHH1JmltVUH5E
         Fo1g==
X-Gm-Message-State: AOAM532W7vaqggTk480Ji2uJF3K0VoCNQOWH+puaxwqZy/9um1EHEcoA
        vnE80zguZhPc+XVm/iJHPKk=
X-Google-Smtp-Source: ABdhPJxZJE2aBF4ceMoFtqVOqM6n27rzp7Z3S4vNx4JoTv4gqCZKDM7k4RmbSy+BkC9WeotC0mHyUg==
X-Received: by 2002:a2e:9e43:: with SMTP id g3mr1046893ljk.122.1598979474275;
        Tue, 01 Sep 2020 09:57:54 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id t5sm378771ljg.111.2020.09.01.09.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 09:57:53 -0700 (PDT)
Subject: Re: [PATCH] memory: tegra: Remove GPU from DRM IOMMU group
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matias Zuniga <matias.nicolas.zc@gmail.com>
References: <20200901153248.1831263-1-thierry.reding@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <09d7d396-fcb6-634c-f9d4-9c8ac34c7e71@gmail.com>
Date:   Tue, 1 Sep 2020 19:57:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901153248.1831263-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.09.2020 18:32, Thierry Reding пишет:
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
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
> index 493b5dc3a4b3..0cede24479bf 100644
> --- a/drivers/memory/tegra/tegra124.c
> +++ b/drivers/memory/tegra/tegra124.c
> @@ -957,7 +957,6 @@ static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
>  static const unsigned int tegra124_group_drm[] = {
>  	TEGRA_SWGROUP_DC,
>  	TEGRA_SWGROUP_DCB,
> -	TEGRA_SWGROUP_GPU,
>  	TEGRA_SWGROUP_VIC,
>  };
>  
> 

Technically a stable tag is needed for this patch, but I guess the bot
will recognize that this patch is useful for older kernels.

Otherwise looks good!

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
