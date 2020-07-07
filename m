Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22510C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0037620720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bCRBoKrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgGGSNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGGSNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:13:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63BFC08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 11:13:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so83542wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v3SJG/oKrNkhQPAH5DvCsSZIxftjRT3Cf/rO54lasVQ=;
        b=bCRBoKrbpz2rdJ2nV9KaHR11LkMNbRQZQEVMoGlk92r+cnRoIKV0xwny5KmjnouEw2
         PGjjYvz0cp3e4NPnqvT2tAUoOV3Naj9K1Bd7pMl4clrjmtJMAhJxBsb4OagAywJxhw0O
         vIc+B7bV6kYwba5VmkvKBqZXiZQCl4gWoOjho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3SJG/oKrNkhQPAH5DvCsSZIxftjRT3Cf/rO54lasVQ=;
        b=SrpazINc80yOQe55M7igGFKsgpuogcyFIc06Raatp+C8Y1EVvFW5xleegGy+qj6DgT
         MgblpDaqnOoQrZX+0RYFI/5WQz6sDdZ6m3JDUqqDXz/GeNt0eg9cl5BPSM+3a/SCTT48
         zCrCQDyFwQJ0paflclAT5KVCmB2E/llyDkT9eiPlZ42V4UsRR5ySHN4vSvziDcMQZZV8
         9q1Ar6Wah+ngvzorODzMKXcop7OgugTpQcoSml2TZwHbVv6SRo0KCpWEeL4E14oVxnpF
         uO7/y6Al7ytAq4l3edAx53iym0I+RVJ4Njz3gadCtB1JuQ206ZsXRUZd0oPLSxHVGTbw
         3wdw==
X-Gm-Message-State: AOAM530gGBjmk75iZXwcHf3ZlPw9CRRBbQkHvSWOvkBHuF4Tbti8UCeW
        LKpid0kdL8aDvexHDCFQptSDpw==
X-Google-Smtp-Source: ABdhPJyY4ArGzU3O1VyBKhNP66gJlaXeKhOfIGNgIYcjZ8G2lNPTEGosc7euLKL3vZCGs4EG+Vg8/Q==
X-Received: by 2002:a1c:1d04:: with SMTP id d4mr5754189wmd.156.1594145592650;
        Tue, 07 Jul 2020 11:13:12 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id q3sm1942110wmq.22.2020.07.07.11.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 11:13:12 -0700 (PDT)
Date:   Tue, 7 Jul 2020 18:13:10 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kyungmin.park@samsung.com, s.nawrocki@samsung.com,
        mchehab@kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] media: exynos4-is: Improve support for sensors
 with multiple pads
Message-ID: <20200707181310.GE2621465@chromium.org>
References: <20200426022650.10355-1-xc-racer2@live.ca>
 <BN6PR04MB06604D29C9F66EB53FB17581A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB06604D29C9F66EB53FB17581A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Apr 25, 2020 at 07:26:44PM -0700, Jonathan Bakker wrote:
> Commit 1c9f5bd7cb8a ("[media] s5p-fimc: Add support for sensors with
> multiple pads") caught the case where a sensor with multiple pads was
> connected via CSIS, but missed the case where the sensor was directly
> connected to the FIMC.
> 
> This still assumes that the last pad of a sensor is the source.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  drivers/media/platform/exynos4-is/media-dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thank you for the patch. Please see my comments inline.

> diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
> index 5c32abc7251b..b38445219c72 100644
> --- a/drivers/media/platform/exynos4-is/media-dev.c
> +++ b/drivers/media/platform/exynos4-is/media-dev.c
> @@ -991,7 +991,8 @@ static int fimc_md_create_links(struct fimc_md *fmd)
>  
>  		case FIMC_BUS_TYPE_ITU_601...FIMC_BUS_TYPE_ITU_656:
>  			source = &sensor->entity;
> -			pad = 0;
> +			/* Assume the last pad is the source */
> +			pad = sensor->entity.num_pads - 1;

Is 0 really any worse than num_pads - 1? This sounds like quite an ugly
hack.

Could you iterate over the pads of the sensor entity and explicitly find
a source pad instead?

Best regards,
Tomasz
