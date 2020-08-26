Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11E7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5EB2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598425188;
	bh=ICKq0wW6o5ic4A0NjPYFnu9wDeQFyvOhYXTZgEqE8uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ycT0Q2rkErbzc/v9hbtiO7VR6Km4+umgCt8Qyq5MMDq/E/0WRI8xDGhwPo4onwGSs
	 SbDrvAc2ptKFq16+MTqsjjDYTParT/n53KMQsIrMoqo/hQ2SNG/Wt1rXVEUw2Jkgqi
	 g7+dLvwSPSM64B7LlyMxE8dNhhlj8P8yFDbH/vJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHZG7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:59:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40316 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgHZG7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:59:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id b18so630413wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 23:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ENOsjhbbxKoeM0u7sxFhovClTCYdz/d5wJeIuEs7Zt4=;
        b=bu2E3Y6wzbFE3H5T2NCxUNmqg08IwpndjAl4SXZ85e227bXss+SDteFzcaOvopuWGp
         5oAiQmpWR4VntK0AY1kM50+lHPm52VLc7dzlSJvKnD/wydsPFvYmUhQbd/ZQQ3wk/hvs
         1llmWvgWqTPf+q0RljXRt5m239HNYegsh0W6ioRE0htyeCjYDrGqPLCOCwUJWFWWNFYG
         2QqTkbKBdJPh/fpd79+WfoPpSufoPdajwHIZtrA7rRyHPAPqEl8LMu949ylj55ldaP3q
         xN12tEuYJTNVZAXhh7o1eEU4wjPFces/9uDGBomY8FvVlQupst08/pDIe48LgfpXg02e
         UjDw==
X-Gm-Message-State: AOAM5315BLLQ2gQstssPDdJcdRDydWci0CmscAShBSMESfdrkE2Oii48
        Eb72C+lo5Vma+RLSdNcNV6b9NZMPzGw=
X-Google-Smtp-Source: ABdhPJzkscer9VjYy2OQu2/FbPVbE8oBtkcvLlTiXlMkbfBETJdY3ymeA/+ynDK4neu8bDU3jG2E3A==
X-Received: by 2002:adf:f98a:: with SMTP id f10mr13693229wrr.420.1598425184851;
        Tue, 25 Aug 2020 23:59:44 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id m6sm3487152wrw.20.2020.08.25.23.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 23:59:44 -0700 (PDT)
Date:   Wed, 26 Aug 2020 08:59:42 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, andriy.shevchenko@intel.com,
        thomas.langer@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v1 3/9] extcon: extcon-ptn5150: Switch to BIT() macro for
 cable attach
Message-ID: <20200826065942.GC12271@pi3>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818065727.50520-4-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818065727.50520-4-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:57:21PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Switch to BIT() macro for the cable attach.

Squash it.

> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/extcon/extcon-ptn5150.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index c816a6c1e05c..fab862d9aad8 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -44,9 +44,7 @@ enum ptn5150_reg {
>  
>  #define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
>  
> -#define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
> -#define PTN5150_REG_INT_CABLE_ATTACH_MASK	\
> -	(0x1 << PTN5150_REG_INT_CABLE_ATTACH_SHIFT)
> +#define PTN5150_REG_INT_CABLE_ATTACH_MASK	BIT(0)
>  
>  #define PTN5150_REG_INT_CABLE_DETACH_SHIFT	1
>  #define PTN5150_REG_INT_CABLE_DETACH_MASK	\
> -- 
> 2.11.0
> 
