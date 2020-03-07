Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED89C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 23:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACFA2075A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 23:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583624867;
	bh=sO2549TXeIeA/LiuWHdqg4t8QGOOV438IVO1eJHrkPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=T+F1HzC63DfXPJqN5vmbjXftlLaF9UsWvWdPxYT/gMrLcI+XCyuuJVmeOGwLNdmFl
	 hd1VRHbOSLzCPk1eE0oQBmZW5iuXyo/Q3CT5yDf0wxwmSLyIJIGU7FwlZHM+MC8q5E
	 oWUR4QYbX5i+zN8LUc2LtYOGu7cTz54MLFDyzymw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCGXrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 18:47:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgCGXrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 18:47:46 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15B582070A;
        Sat,  7 Mar 2020 23:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583624865;
        bh=sO2549TXeIeA/LiuWHdqg4t8QGOOV438IVO1eJHrkPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=retgJCHFk2bDFrUXZSlHH4zCjGooNSMmNg1dTKxvBs96tHWW3KF/zkp2bwFn5mIca
         8nqLP7nJFnULtVzV9JqCSH1p4kOIwZDSnaxEUPYFlHhlwNLZqwiIZlivrUVKyb6iVs
         G65ErDyoEdgzPQnwTjpN41sZ2GJddNk9wQ331gJs=
Date:   Sat, 7 Mar 2020 15:47:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     walken@google.com, bp@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
Subject: Re: [PATCH] mm: mmap: show vm_unmapped_area error log
Message-Id: <20200307154744.acd523831b45efa8d0fc1dfa@linux-foundation.org>
In-Reply-To: <5E61EAB6.5080609@samsung.com>
References: <CGME20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4@epcas1p4.samsung.com>
        <20200304030206.1706-1-jaewon31.kim@samsung.com>
        <5E605749.9050509@samsung.com>
        <20200305202443.8de3598558336b1d75afbba7@linux-foundation.org>
        <5E61EAB6.5080609@samsung.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020 15:16:22 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:

> 
> Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
> Virtual memory space shortage of a task on mmap is reported to userspace
> as -ENOMEM. It can be confused as physical memory shortage of overall
> system.
> 
> The vm_unmapped_area can be called to by some drivers or other kernel
> core system like filesystem. It can be hard to know which code layer
> returns the -ENOMEM.
> 
> Print error log of vm_unmapped_area with rate limited. Without rate
> limited, soft lockup ocurrs on infinite mmap sytem call.
> 
> i.e.)
> <4>[   68.556470]  [2:  mmap_infinite:12363] mmap: vm_unmapped_area err:-12 total_vm:0xf4c08 flags:0x1 len:0x100000 low:0x8000 high:0xf4583000 mask:0x0 offset:0x0
> 
> ...
>
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h

This patch was messed up by your email client (tabs expanded to spaces).

> @@ -27,6 +27,7 @@
>  #include <linux/memremap.h>
>  #include <linux/overflow.h>
>  #include <linux/sizes.h>
> +#include <linux/ratelimit.h>
>  
>  struct mempolicy;
>  struct anon_vma;
> @@ -2379,10 +2380,20 @@ extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
>  static inline unsigned long
>  vm_unmapped_area(struct vm_unmapped_area_info *info)
>  {
> +    unsigned long addr;
> +
>      if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
> -        return unmapped_area_topdown(info);
> +        addr = unmapped_area_topdown(info);
>      else
> -        return unmapped_area(info);
> +        addr = unmapped_area(info);
> +
> +    if (IS_ERR_VALUE(addr)) {
> +        pr_warn_ratelimited("%s err:%ld total_vm:0x%lx flags:0x%lx len:0x%lx low:0x%lx high:0x%lx mask:0x%lx offset:0x%lx\n",
> +            __func__, addr, current->mm->total_vm, info->flags,
> +            info->length, info->low_limit, info->high_limit,
> +            info->align_mask, info->align_offset);
> +    }
> +    return addr;
>  }

pr_warn_ratelimited() contains static state.  Using it in an inlined
function means that each callsite gets its own copy of that state, so
we're ratelimiting the vm_unmapped_area() output on a per-callsite
basis, not on a kernelwide basis.

Maybe that's what we want, maybe it's not.  But I think
vm_unmapped_area() has become too large to be inlined anyway, so I
suggest making it a regular out-of-line function in mmap.c.  I don't
believe that function needs to be exported to modules.

