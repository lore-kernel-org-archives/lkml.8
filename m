Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75EDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15E8207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cxXI8ZM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgETATP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgETATO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:19:14 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B05AC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:19:13 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 190so1968366qki.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n9JZJWROso+hIIbOh+CMhqw39lf86JMdF2gn9eh+UIg=;
        b=cxXI8ZM+8T9le0aatEoMGIohiGVbDAITFaJWkTHxe3g2ofpzbaO9x4T6fnmFbxG/cb
         NdEKIhHtK0tIYKs70+I/ZKc6qSI6ASf5rMn7f5DYCJc7CAGQ3JxhLPErSSzyoNJeqzQK
         qBOBIvPwrg5KEdYmZD1McXOeQFpYaECFemwsbSp8BkxkAAKCu2qu8L92/wAkNwMOLcIW
         Gbfpaq4t25k4uxdiETzWNQP1F3+v4zLWt+U6nNthcU6/k4ervgWeT3IoBERMb1mqAIqm
         dGSMky7SEpb6RbeWy6x7V4FBvZNzEhznlbLKVCug0r8MkL4pCPL637n44PvE5LY1UAlT
         Lm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n9JZJWROso+hIIbOh+CMhqw39lf86JMdF2gn9eh+UIg=;
        b=k9XO41JaakgNVgKT7WKE89Lt5P7NJqNgrQlybHNewv3MbCIelMyT0b2QnF9v4iC47d
         yl5VG0AeLSBv4F3nglQpFvlHGq+oeFWLGQGtNIQynhRIEYlwGmKty4xj3hk1QcZh1ahW
         CN/sSsV2jGTYXFb7ColVcpQlOgrEm8Xl4n/BhGuht4CwC9NobLOnKNUmxFJFMGfsQF2V
         fDuhS5tjGGBXah2OUH0Hr5HULn1L5zQVl2YJJM+8hP+RYFjjlN016pCCnC2qDtPkuxuH
         Vqrfq1lDOJjIqaRrfVTiUtRtDJKVuexel7XpebPnIVo8dRtnQ2YqrmVrj4LFh8Trr+0K
         wozg==
X-Gm-Message-State: AOAM530m9XQ6cDSz3jPPHLlp6EU+tzW63pHd5mNfIJ+S8x0X4uWPISWP
        8aGBPc/74vBtccYFroNUWycEGQ==
X-Google-Smtp-Source: ABdhPJykcLtUdmf7WILmMYLNeoLOKQpyRW8G8FAVJII8fSZoCGX0L7PdXcMd+AvHVtJOxkvhP5FhYA==
X-Received: by 2002:a37:8302:: with SMTP id f2mr2093454qkd.220.1589933952324;
        Tue, 19 May 2020 17:19:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s55sm1154161qtb.92.2020.05.19.17.19.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 17:19:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbCRz-0003QX-AW; Tue, 19 May 2020 21:19:11 -0300
Date:   Tue, 19 May 2020 21:19:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, peterx@redhat.com
Subject: Re: [PATCH 1/2] vfio: Introduce bus driver to IOMMU invalidation
 interface
Message-ID: <20200520001911.GB31189@ziepe.ca>
References: <158947414729.12590.4345248265094886807.stgit@gimli.home>
 <158947511830.12590.15083888449284990563.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158947511830.12590.15083888449284990563.stgit@gimli.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:51:58AM -0600, Alex Williamson wrote:
> @@ -1450,6 +1467,10 @@ static int vfio_pci_zap_and_vma_lock(struct vfio_pci_device *vdev, bool try)
>  
>  				zap_vma_ptes(vma, vma->vm_start,
>  					     vma->vm_end - vma->vm_start);
> +				mutex_unlock(&vdev->vma_lock);
> +				up_read(&mm->mmap_sem);
> +				vfio_invalidate_pfnmap_vma(vdev->group, vma);
> +				goto again;

The vma pointer can't leave the read side of the mmap_sem

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 4a4cb7cd86b2..62ba6bd8a486 100644
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -91,6 +91,7 @@ struct vfio_dma {
>  	bool			lock_cap;	/* capable(CAP_IPC_LOCK) */
>  	struct task_struct	*task;
>  	struct rb_root		pfn_list;	/* Ex-user pinned pfn list */
> +	struct vm_area_struct	*pfnmap_vma;

This is also confusing, how does it prevent pfnmap_vma from becoming
freed?

Jason
