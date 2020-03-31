Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6420CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1230D2137B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="MXXwnLXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgCaJvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:51:43 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:49642 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729425AbgCaJvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:51:43 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id EF3742E1504;
        Tue, 31 Mar 2020 12:51:39 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id CArQVUGqzG-pcNi0fcP;
        Tue, 31 Mar 2020 12:51:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585648299; bh=oQkYYgeZuBMfjooZ7ZSd3wvvQTi+KvnVK/NOemBxCwA=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=MXXwnLXnb75v33k0O/la3APncH+bRvt2dzRV0xbhvhENmtABpKlgMr4LcFFvTM0hw
         lu7DO2cpVh9Hxj2T5IJn6c/6FWA4MDAyQycB3abfRhNe8r3d1EffQiIkV/pD08l3gN
         55H4wqSt7ELTkA1JbZ97sdLSdBrRoGpx9aSUChcQ=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8005::1:5])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id FhzmPsKgcX-pcY4Zcb2;
        Tue, 31 Mar 2020 12:51:38 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] /proc/PID/smaps: Add PMD migration entry parsing
To:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <20200331085604.1260162-1-ying.huang@intel.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <49386753-5984-f708-4153-e9c6de632439@yandex-team.ru>
Date:   Tue, 31 Mar 2020 12:51:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331085604.1260162-1-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2020 11.56, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
> is added.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>   fs/proc/task_mmu.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 8d382d4ec067..b5b3aef8cb3b 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -548,8 +548,17 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>   	bool locked = !!(vma->vm_flags & VM_LOCKED);
>   	struct page *page;

         struct page *page = NULL;

>   
> -	/* FOLL_DUMP will return -EFAULT on huge zero page */
> -	page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> +	if (pmd_present(*pmd)) {
> +		/* FOLL_DUMP will return -EFAULT on huge zero page */
> +		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> +	} else if (unlikely(is_swap_pmd(*pmd))) {
> +		swp_entry_t entry = pmd_to_swp_entry(*pmd);
> +
> +		VM_BUG_ON(!is_migration_entry(entry));
> +		page = migration_entry_to_page(entry);

                 if (is_migration_entry(entry))
                         page = migration_entry_to_page(entry);

Seems safer and doesn't add much code.

> +	} else {
> +		return;
> +	}
>   	if (IS_ERR_OR_NULL(page))
>   		return;
>   	if (PageAnon(page))
> @@ -578,8 +587,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>   
>   	ptl = pmd_trans_huge_lock(pmd, vma);
>   	if (ptl) {
> -		if (pmd_present(*pmd))
> -			smaps_pmd_entry(pmd, addr, walk);
> +		smaps_pmd_entry(pmd, addr, walk);
>   		spin_unlock(ptl);
>   		goto out;
>   	}
> 
