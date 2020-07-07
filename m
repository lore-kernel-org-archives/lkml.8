Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4721BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0E62065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGGJtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:49:18 -0400
Received: from foss.arm.com ([217.140.110.172]:35272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgGGJtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:49:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA528C0A;
        Tue,  7 Jul 2020 02:49:16 -0700 (PDT)
Received: from [10.163.86.118] (unknown [10.163.86.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA2B63F718;
        Tue,  7 Jul 2020 02:49:14 -0700 (PDT)
Subject: Re: [PATCH] vmalloc: Removing incorrect logs when vmalloc failed
To:     Tian Tao <tiantao6@hisilicon.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1594113232-32193-1-git-send-email-tiantao6@hisilicon.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5e7885ef-081e-0682-7be7-40eb7712d2c7@arm.com>
Date:   Tue, 7 Jul 2020 15:18:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1594113232-32193-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2020 02:43 PM, Tian Tao wrote:
> It is not possible to increase size with vmalloc=<size> in arm64
> architecture and it will mislead.however vmalloc return failure
> is a rare occurrence in 'many architectures including arm64'.

But there is a chance that vmalloc() might work on architectures
that support 'vmalloc=' command line i.e after a change and this
information here might be helpful in those cases.

> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  mm/vmalloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 89e83d3..c7b5a9a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1238,8 +1238,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	}
>  
>  	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
> -		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
> -			size);
> +		pr_warn("vmap allocation for size %lu failed\n", size);
>  
>  	kmem_cache_free(vmap_area_cachep, va);
>  	return ERR_PTR(-EBUSY);
> 
