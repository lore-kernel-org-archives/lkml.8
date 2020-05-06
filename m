Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95576C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F332082E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQmDygjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgEFJfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728640AbgEFJfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:35:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B849C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 02:35:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so1353057wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hCCpyyCsOwf45inMt3o257A10/7eYZVNmL7O126puyY=;
        b=qQmDygjweLPcARZKtEeUbSr/HBXsPReN+4F8YbS6vvDa0tGq1EHXWrXA75PwpaRdjY
         mXiK+Z9ZeDkNeevpk4kqT3qKXBtxVsqTd0+msRTI9uCUkUr51sm73HUAZVDRr7C6OHBY
         vdEovuXdY87GlYoUTYozZ5pLMPDzr1vD4JSeHk8GGhmi9SWbc61tM5SHbcQPYjMeB1Bf
         9A6HoSI1Ck8eLfK6x8dOfo/L8/KpJJw3ITP42d6xcQyVuM46JE5qGEKHxJeGScrEg9by
         mk9TRYdKUIwdHujQ2wm11KE5z73mZ2TaE1PTlkPj3X+H+EG513sFepobGLXfwUyqe9BL
         zF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hCCpyyCsOwf45inMt3o257A10/7eYZVNmL7O126puyY=;
        b=jp0z142SivMjvL1LQUHfkFf5bMVYJkrg/CSdL5jzAtkx/JStJXnhKk+mRgqolewYIN
         QOhlJkqFviudb4pMS7m1Zt1rbyYtH8BioUuAkZ0GevMfOWPjf7zhGB95vkTREwxRDtbd
         CItoj9ijqq7vqSGFU1uUgH+qlUglVx0jLKdH2qSAtYOwSgV39awelVgmg+tIykGMbyJ8
         6Qk7ntIhKbtwa2D8m1a6T3pXwRbFqp4RYgSkbKZgljkRlKohHfwsX2eGVwW4xOM5H5dG
         Pfg3uDic7zHLAPc0fYdTtBK8nfKvq/UscovGHhrR3qkKC+Kk+pTA7e/rQEKGRcpOfFoQ
         UU3w==
X-Gm-Message-State: AGi0PuZ293jvlY4w7Uq7/n+975JSlndbcmBR9/3He4HA5+7Aizo9ke3w
        Smc9Qe4bRjvAoCl8UCSzjY4YmQ==
X-Google-Smtp-Source: APiQypLQJjy5vw34J6eJsUP2ihdRbCpbrZFEgYI/5478WTJrZUym62sqJpQzFvaN9hsw6iitUy55kA==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr8373863wrt.163.1588757734052;
        Wed, 06 May 2020 02:35:34 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id x7sm1677336wmi.17.2020.05.06.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 02:35:33 -0700 (PDT)
Date:   Wed, 6 May 2020 11:35:24 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        eugene.volanschi@inria.fr
Subject: Re: [PATCH] iommu/virtio: reverse arguments to list_add
Message-ID: <20200506093524.GA497896@myrica>
References: <1588704467-13431-1-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588704467-13431-1-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 08:47:47PM +0200, Julia Lawall wrote:
> Elsewhere in the file, there is a list_for_each_entry with
> &vdev->resv_regions as the second argument, suggesting that
> &vdev->resv_regions is the list head.  So exchange the
> arguments on the list_add call to put the list head in the
> second argument.
> 
> Fixes: 2a5a31487445 ("iommu/virtio: Add probe request")
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Thanks for the fix. The reason this hasn't blown up so far is
iommu_alloc_resv_region() initializes region->list, but adding more than
one item would break the list.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index d5cac4f46ca5..4e1d11af23c8 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -453,7 +453,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>  	if (!region)
>  		return -ENOMEM;
>  
> -	list_add(&vdev->resv_regions, &region->list);
> +	list_add(&region->list, &vdev->resv_regions);
>  	return 0;
>  }
>  
> 
