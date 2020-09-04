Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56314C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D2F20791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgIDJhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDJhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:37:39 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4B7C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 02:37:34 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 92BC3A6D; Fri,  4 Sep 2020 11:37:33 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:37:32 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Yuqi Jin <jinyuqi@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/iova: Replace cmpxchg with xchg in queue_iova
Message-ID: <20200904093732.GN6714@8bytes.org>
References: <1598517834-30275-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598517834-30275-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Robin.

On Thu, Aug 27, 2020 at 04:43:54PM +0800, Shaokun Zhang wrote:
> From: Yuqi Jin <jinyuqi@huawei.com>
> 
> The performance of the atomic_xchg is better than atomic_cmpxchg because
> no comparison is required. While the value of @fq_timer_on can only be 0
> or 1. Let's use atomic_xchg instead of atomic_cmpxchg here because we
> only need to check that the value changes from 0 to 1 or from 1 to 1.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Yuqi Jin <jinyuqi@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/iommu/iova.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 45a251da5453..30d969a4c5fd 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -579,7 +579,7 @@ void queue_iova(struct iova_domain *iovad,
>  
>  	/* Avoid false sharing as much as possible. */
>  	if (!atomic_read(&iovad->fq_timer_on) &&
> -	    !atomic_cmpxchg(&iovad->fq_timer_on, 0, 1))
> +	    !atomic_xchg(&iovad->fq_timer_on, 1))
>  		mod_timer(&iovad->fq_timer,
>  			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
>  }
> -- 
> 2.7.4
