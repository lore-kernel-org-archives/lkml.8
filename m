Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B5C3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AEA2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583468689;
	bh=XTbr7KlqNbwV2YhVNfxiPjrjjl5yMzT1EDmmNZjlgAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZJdz83gA5x/tY/fbyxiy1Kj8dnohm5rQfybUD7/fn2QG31nOFeRkrOm1L1F7ouPWL
	 S4va6AfAJx7kEjTMPSpntF78LdpfbhNX8bCm9ieRCBizjjx59s/uxcoNTWVgO/CQB2
	 rl8PC75mvR+wq/cY4Z/ZnwAoYAV4PvJWTBOOaNH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCFEYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:24:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgCFEYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:24:44 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86A52073D;
        Fri,  6 Mar 2020 04:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583468684;
        bh=XTbr7KlqNbwV2YhVNfxiPjrjjl5yMzT1EDmmNZjlgAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MbJqfxO3HaXuCRow/zTICEzxaKpC1iTuAyYHnaLVioPjsRLoOFOt7QpWqb4F2J1PJ
         c8D07qpGHb7aaACU2w8hT9k8hOEaULu2Ho3gFc9VqJFWcHy0pRD30TDttjARJ/TZkj
         /MOQDiJHpVDd8pt9JqWWJPTAcFMSYKZwZtN2Ntoc=
Date:   Thu, 5 Mar 2020 20:24:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     walken@google.com, bp@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
Subject: Re: [PATCH] mm: mmap: show vm_unmapped_area error log
Message-Id: <20200305202443.8de3598558336b1d75afbba7@linux-foundation.org>
In-Reply-To: <5E605749.9050509@samsung.com>
References: <CGME20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4@epcas1p4.samsung.com>
        <20200304030206.1706-1-jaewon31.kim@samsung.com>
        <5E605749.9050509@samsung.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 10:35:05 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:

> Hello
> 
> sorry for build warning.
> I've changed %d to %ld reported by kbuild.
> Let me attach full patch again below.
> --------------------------------------------------
> 
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
> <3>[  576.024088]  [6:  mmap_infinite:14251] mmap: vm_unmapped_area err:-12 total_vm:0xfee08 flags:0x1 len:0xa00000 low:0x8000 high:0xf3f63000
> 

hm, I suppose that could be useful.  Although the choice of which info
to display could be a source of dispute.  Why did you choose this info
and omit other things?  Perhaps a stack trace could also be useful?

> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2379,10 +2379,19 @@ extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
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
> +    if (IS_ERR_VALUE(addr) && printk_ratelimit()) {

Please avoid using printk_ratelimit().  See the comment at the
printk_ratelimit() definition site:

/*
 * Please don't use printk_ratelimit(), because it shares ratelimiting state
 * with all other unrelated printk_ratelimit() callsites.  Instead use
 * printk_ratelimited() or plain old __ratelimit().
 */

> +        pr_err("%s err:%ld total_vm:0x%lx flags:0x%lx len:0x%lx low:0x%lx high:0x%lx\n",
> +            __func__, addr, current->mm->total_vm, info->flags,
> +            info->length, info->low_limit, info->high_limit);
> +    }
> +    return addr;
>  }

