Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C7EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CC8207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lGOS3DQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405877AbgFYPha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405159AbgFYPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:37:29 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F4C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 08:37:29 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id g11so2976263qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M1cqSae7hNdYiqu+8k8gfItdpEDoX+sntlR/dwIK8h4=;
        b=lGOS3DQQ3dYsGxX5k6MlJyG0pAimjSFQZB1QmrFink0pbh6Xswfk9L8lV8cOs0RHKk
         +UF3pQffKHrTqtKWnZnlAllzISwdXv2nka21K3BDPku0gDkmfXEDYX+s6eDosHZUWSJt
         ME00OvnosHt+mNuFPMs0cFvYUbNreW0H1egdo4IIZBdBik0BIFGifcrlL2xj/zqh1wFU
         1SSPCZSd6jvIskLmbvQYlALJNRtQYU5K+w0rYR58iXyUJFB7+7cuQMiPpkmTo45IldMm
         btoVaoJSJXGAu5zOMmtUJoYm0uoDBHjqbOlLnHdhkDV2VPa2grdqOG/IbLeg+7ZVetHB
         XMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M1cqSae7hNdYiqu+8k8gfItdpEDoX+sntlR/dwIK8h4=;
        b=EUzCeW+kIcFntZzipz6Qh7JNicVXh79rWJEPZB9J1Cu5kc5iRtKnSY4Nxgj+R3JFUL
         Cu3L4Ofts3KVI258cbpAirHoiUBIFwz/5vVY/pWK/jdOChOgjhCIqWBWiDLWicPqWLGU
         R6+GNNyysCWfTAV1CrETZ8J3KuwrC2LcKEQ+BNDvCreQvRDU6mGtFOfYobR0tfxjswAN
         wNZl025VpUxBzkRWfS5w1AWLVGJxa5ijXN/LF4l3Vdu86G/2JST6WXycYdKmu6v69GzM
         20zBQwuJxjBv4R1rAo7gtUOU5GSQtb39BlVDI3+v20Nw/xldRt9w2o5o4FV98jG6zQzD
         x2Qw==
X-Gm-Message-State: AOAM533YP5tARvAsqAXviMumDwf4Kqq/3upSg65gtiPdYDHUr3Ww2h/+
        JrbMYnF+q2Z5E0aNR33KQRRZbtxl40MUDw==
X-Google-Smtp-Source: ABdhPJwO/z3GqRdyLg4iaSC+qFfkcj7Jq1dkbV+B31fWZ2JKLNRWKszSnyC3Ab7uyP1yeR9AoP4b3A==
X-Received: by 2002:a0c:b5d8:: with SMTP id o24mr1205025qvf.214.1593099449041;
        Thu, 25 Jun 2020 08:37:29 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l127sm5920459qkc.117.2020.06.25.08.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 08:37:28 -0700 (PDT)
Date:   Thu, 25 Jun 2020 11:37:20 -0400
From:   Qian Cai <cai@lca.pw>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 2/2] iommu/amd: Use 'unsigned long' for domain->pt_root
Message-ID: <20200625153720.GA1127@lca.pw>
References: <20200625145227.4159-1-joro@8bytes.org>
 <20200625145227.4159-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625145227.4159-3-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 04:52:27PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Using atomic64_t can be quite expensive, so use unsigned long instead.
> This is safe because the write becomes visible atomically.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  2 +-
>  drivers/iommu/amd/iommu.c           | 10 ++++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 30a5d412255a..f6f102282dda 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -468,7 +468,7 @@ struct protection_domain {
>  				       iommu core code */
>  	spinlock_t lock;	/* mostly used to lock the page table*/
>  	u16 id;			/* the domain id written to the device table */
> -	atomic64_t pt_root;	/* pgtable root and pgtable mode */
> +	unsigned long pt_root;	/* pgtable root and pgtable mode */
>  	int glx;		/* Number of levels for GCR3 table */
>  	u64 *gcr3_tbl;		/* Guest CR3 table */
>  	unsigned long flags;	/* flags to find out type of domain */
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5286ddcfc2f9..b0e1dc58244e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -156,7 +156,7 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
>  static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
>  					 struct domain_pgtable *pgtable)
>  {
> -	u64 pt_root = atomic64_read(&domain->pt_root);
> +	unsigned long pt_root = domain->pt_root;

The pt_root might be reload later in case of register pressure where the
compiler decides to not store it as a stack variable, so it needs
smp_rmb() here to match to the smp_wmb() in
amd_iommu_domain_set_pt_root() to make the load visiable to all CPUs.

Then, smp_rmb/wmb() wouldn't be able to deal with data races, so it
needs,

unsigned long pt_root = READ_ONCE(domain->pt_root);

>  
>  	pgtable->root = (u64 *)(pt_root & PAGE_MASK);
>  	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
> @@ -164,7 +164,13 @@ static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
>  
>  static void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
>  {
> -	atomic64_set(&domain->pt_root, root);
> +	domain->pt_root = root;

WRITE_ONCE(domain->pt_root, root);

> +
> +	/*
> +	 * The new value needs to be gobally visible in case pt_root gets
> +	 * cleared, so that the page-table can be safely freed.
> +	 */
> +	smp_wmb();
>  }
>  
>  static void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
> -- 
> 2.27.0
> 
