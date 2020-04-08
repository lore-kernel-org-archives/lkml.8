Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AD6C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6898D2072F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GShUeMzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgDHQ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:59:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40819 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbgDHQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:59:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id c5so3581358pgi.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iazuwtOmYpAvBrdVj8TEytSBmpAo+XIqBVbhsQf9qWM=;
        b=GShUeMzLckvv1Tmg/eAf8t2/jmGL2cG48LI9uDJAFRP21EjcCDQiSiVBJ+ufSQw2X+
         zL3weCklxHnyTNA/snfQcDCUMSk26gYSWAy6MWK2OB5pnBbGPUaXkSO8yZD5WO11PdF2
         7SNL4pPJ+c1FzVG0s72ZaI3wsEdVbtmkhh8eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iazuwtOmYpAvBrdVj8TEytSBmpAo+XIqBVbhsQf9qWM=;
        b=QmvlugzoZTygcnQQLti+DcCftVtIYR06jBfNBzsVOOVuar7URvrJoUs1p7Bd7j7EPv
         otZfa82fQvGuWrA+2CkVMSIzzP9pMlzUV0WWs+D8Hh7EpiUyk3OZypZrhYGkFJThHmtb
         tWLdRsejnWzGpyb/iJccPIos6Q/ocdWkHVbRNnSTd56+ToUlrrkX3epzr59X3x8IJm2W
         T5yC6I/bPW3VpXKZamfxAehzZNEZ4h92THlyXVUMjEHIZ1X+Uzso5m9NuIXcQ0pfP2sk
         uUDO4wkb2IRp8Ba5J+zGRmv55vHGoOxqiudp+lzYByGQgrlGKX7zw98zMZwVzt7Bp4BL
         wAXg==
X-Gm-Message-State: AGi0PuZPjNN0vUncoVLDOIR3nh7ejJp6yFX077UJmmjACxm2rADWtw0P
        z6VXDCqxynWVM0CSiPY2ms7zPg==
X-Google-Smtp-Source: APiQypLbXC98cOz1Gk+AUmoZ9LfVbVf3dMcxa3rqqbc4bIsPb4a7998lvJd5neuYRjqaKOSq7JvUbQ==
X-Received: by 2002:a63:f658:: with SMTP id u24mr836796pgj.357.1586365186839;
        Wed, 08 Apr 2020 09:59:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h34sm60200pjb.47.2020.04.08.09.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 09:59:45 -0700 (PDT)
Date:   Wed, 8 Apr 2020 09:59:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     alex.williamson@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: checking of validity of user vaddr in vfio_dma_rw
Message-ID: <202004080959.8C71F8DF7@keescook>
References: <20200408071121.25645-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408071121.25645-1-yan.y.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 03:11:21AM -0400, Yan Zhao wrote:
> instead of calling __copy_to/from_user(), use copy_to_from_user() to
> ensure vaddr range is a valid user address range before accessing them.
> 
> Cc: Kees Cook <keescook@chromium.org>
> 
> Fixes: 8d46c0cca5f4 ("vfio: introduce vfio_dma_rw to read/write a range of IOVAs")
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

Thanks!

Reported-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/vfio/vfio_iommu_type1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 3aefcc8e2933..fbc58284b333 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2345,10 +2345,10 @@ static int vfio_iommu_type1_dma_rw_chunk(struct vfio_iommu *iommu,
>  	vaddr = dma->vaddr + offset;
>  
>  	if (write)
> -		*copied = __copy_to_user((void __user *)vaddr, data,
> +		*copied = copy_to_user((void __user *)vaddr, data,
>  					 count) ? 0 : count;
>  	else
> -		*copied = __copy_from_user(data, (void __user *)vaddr,
> +		*copied = copy_from_user(data, (void __user *)vaddr,
>  					   count) ? 0 : count;
>  	if (kthread)
>  		unuse_mm(mm);
> -- 
> 2.17.1
> 

-- 
Kees Cook
