Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4024AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2525421D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgDQDAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:00:11 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35203 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbgDQDAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:00:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tvl54ED_1587092406;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tvl54ED_1587092406)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Apr 2020 11:00:07 +0800
Subject: Re: [PATCH] shmem: fix possible deadlocks on shmlock_user_lock
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <alpine.LSU.2.11.2004161707410.16322@eggly.anvils>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a8382e58-76e0-7b38-1805-ba38e3434367@linux.alibaba.com>
Date:   Thu, 16 Apr 2020 20:00:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2004161707410.16322@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/20 5:11 PM, Hugh Dickins wrote:
> Recent commit 71725ed10c40 ("mm: huge tmpfs: try to split_huge_page()
> when punching hole") has allowed syzkaller to probe deeper, uncovering
> a long-standing lockdep issue between the irq-unsafe shmlock_user_lock,
> the irq-safe xa_lock on mapping->i_pages, and shmem inode's info->lock
> which nests inside xa_lock (or tree_lock) since 4.8's shmem_uncharge().
>
> user_shm_lock(), servicing SysV shmctl(SHM_LOCK), wants shmlock_user_lock
> while its caller shmem_lock() holds info->lock with interrupts disabled;
> but hugetlbfs_file_setup() calls user_shm_lock() with interrupts enabled,
> and might be interrupted by a writeback endio wanting xa_lock on i_pages.
> This may not risk an actual deadlock, since shmem inodes do not take part
> in writeback accounting, but there are several easy ways to avoid it.
>
> Requiring interrupts disabled for shmlock_user_lock would be easy,
> but it's a high-level global lock for which that seems inappropriate.
> Instead, recall that the use of info->lock to guard info->flags in
> shmem_lock() dates from pre-3.1 days, when races with SHMEM_PAGEIN and
> SHMEM_TRUNCATE could occur: nowadays it serves no purpose, the only flag
> added or removed is VM_LOCKED itself, and calls to shmem_lock() an inode
> are already serialized by the caller.  Take info->lock out of the chain
> and the possibility of deadlock or lockdep warning goes away.
>
> Reported-by: syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/lkml/000000000000e5838c05a3152f53@google.com/
> Reported-by: syzbot+40b71e145e73f78f81ad@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/lkml/0000000000003712b305a331d3b1@google.com/
> Fixes: 4595ef88d136 ("shmem: make shmem_inode_info::lock irq-safe")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>
>   mm/shmem.c |    7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

>
> --- 5.7-rc1/mm/shmem.c	2020-04-11 12:58:26.415524805 -0700
> +++ linux/mm/shmem.c	2020-04-16 11:04:06.729738730 -0700
> @@ -2179,7 +2179,11 @@ int shmem_lock(struct file *file, int lo
>   	struct shmem_inode_info *info = SHMEM_I(inode);
>   	int retval = -ENOMEM;
>   
> -	spin_lock_irq(&info->lock);
> +	/*
> +	 * What serializes the accesses to info->flags?
> +	 * ipc_lock_object() when called from shmctl_do_lock(),
> +	 * no serialization needed when called from shm_destroy().
> +	 */
>   	if (lock && !(info->flags & VM_LOCKED)) {
>   		if (!user_shm_lock(inode->i_size, user))
>   			goto out_nomem;
> @@ -2194,7 +2198,6 @@ int shmem_lock(struct file *file, int lo
>   	retval = 0;
>   
>   out_nomem:
> -	spin_unlock_irq(&info->lock);
>   	return retval;
>   }
>   

