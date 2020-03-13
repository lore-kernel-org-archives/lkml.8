Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A8C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219A3206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCMKge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:36:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:44586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgCMKge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:36:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 425BEAC53;
        Fri, 13 Mar 2020 10:36:32 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] mmap: remove inline of vm_unmapped_area
To:     Jaewon Kim <jaewon31.kim@samsung.com>, willy@infradead.org,
        walken@google.com, bp@suse.de, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
References: <20200313011420.15995-1-jaewon31.kim@samsung.com>
 <CGME20200313011430epcas1p129e4033f12b9c02f71443e0b359a26e5@epcas1p1.samsung.com>
 <20200313011420.15995-2-jaewon31.kim@samsung.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <30e2d9c4-33fd-3e13-ce3d-de5099d48b18@suse.cz>
Date:   Fri, 13 Mar 2020 11:36:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313011420.15995-2-jaewon31.kim@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/20 2:14 AM, Jaewon Kim wrote:
> In prepration for next patch remove inline of vm_unmapped_area and move
> code to mmap.c. There is no logical change.
> 
> Also remove unmapped_area[_topdown] out of mm.h, there is no code
> calling to them.
> 
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>

Assuming the 'static' is added as Andrew pointed out,

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


> ---
>  include/linux/mm.h | 21 +--------------------
>  mm/mmap.c          | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 52269e56c514..1cb01f4a83c9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2364,26 +2364,7 @@ struct vm_unmapped_area_info {
>  	unsigned long align_offset;
>  };
>  
> -extern unsigned long unmapped_area(struct vm_unmapped_area_info *info);
> -extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
> -
> -/*
> - * Search for an unmapped address range.
> - *
> - * We are looking for a range that:
> - * - does not intersect with any VMA;
> - * - is contained within the [low_limit, high_limit) interval;
> - * - is at least the desired size.
> - * - satisfies (begin_addr & align_mask) == (align_offset & align_mask)
> - */
> -static inline unsigned long
> -vm_unmapped_area(struct vm_unmapped_area_info *info)
> -{
> -	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
> -		return unmapped_area_topdown(info);
> -	else
> -		return unmapped_area(info);
> -}
> +extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
>  
>  /* truncate.c */
>  extern void truncate_inode_pages(struct address_space *, loff_t);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d681a20eb4ea..eeaddb76286c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2050,6 +2050,22 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
>  	return gap_end;
>  }
>  
> +/*
> + * Search for an unmapped address range.
> + *
> + * We are looking for a range that:
> + * - does not intersect with any VMA;
> + * - is contained within the [low_limit, high_limit) interval;
> + * - is at least the desired size.
> + * - satisfies (begin_addr & align_mask) == (align_offset & align_mask)
> + */
> +unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
> +{
> +	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
> +		return unmapped_area_topdown(info);
> +	else
> +		return unmapped_area(info);
> +}
>  
>  #ifndef arch_get_mmap_end
>  #define arch_get_mmap_end(addr)	(TASK_SIZE)
> 

