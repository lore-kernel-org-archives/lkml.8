Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16F1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 03:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A812720738
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 03:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgGIDq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 23:46:27 -0400
Received: from foss.arm.com ([217.140.110.172]:57298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGIDq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 23:46:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8108331B;
        Wed,  8 Jul 2020 20:46:26 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A84053F71E;
        Wed,  8 Jul 2020 20:46:24 -0700 (PDT)
Subject: Re: [PATCH v2] vmalloc: Removing incorrect logs when vmalloc failed
To:     Tian Tao <tiantao6@hisilicon.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1594257288-58269-1-git-send-email-tiantao6@hisilicon.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9799596a-ac03-2300-dbfb-2244ea706ffd@arm.com>
Date:   Thu, 9 Jul 2020 09:15:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1594257288-58269-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/2020 06:44 AM, Tian Tao wrote:
> It is not possible to increase size with vmalloc=<size> in arm64

Small nit. s/in arm64/on arm64/

In fact "vmalloc=<size>" cmdline option is not available on many
platforms. Hence it is not something arm64 specific here, it is
a general problem.

> architecture and it will mislead.however vmalloc return failure

Small nit. s/.however/. However/

> is a rare occurrence in 'many architectures including arm64'.

Please reword the commit message here to describe the problem which
is a generic one, affecting multiple platforms that dont support
"vmalloc=<size>" cmdline option.

> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> 
> v2:
> Add appropriate hints and let users decide if they can increase
> the size of the vmalloc by vmalloc=<size> depending on their platform
> ---
>  mm/vmalloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 89e83d3..c6ae7e6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1238,8 +1238,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	}
>  
>  	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
> -		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
> -			size);
> +		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size,
> +			if your ARCH supports it\n", size);

This looks better.
