Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB33C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C24207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgERKpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:45:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgERKpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:45:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE449AF98;
        Mon, 18 May 2020 10:45:09 +0000 (UTC)
Subject: Re: [PATCH v5 08/10] mmap locking API: add MMAP_LOCK_INITIALIZER
To:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-9-walken@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <90cfe0e5-2ec9-3a10-0ce6-245bb456a120@suse.cz>
Date:   Mon, 18 May 2020 12:45:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422001422.232330-9-walken@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 2:14 AM, Michel Lespinasse wrote:
> Define a new initializer for the mmap locking api.
> Initially this just evaluates to __RWSEM_INITIALIZER as the API
> is defined as wrappers around rwsem.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>


Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


Nit below.

> ---
>  arch/x86/kernel/tboot.c    | 2 +-
>  drivers/firmware/efi/efi.c | 2 +-
>  include/linux/mmap_lock.h  | 3 +++
>  mm/init-mm.c               | 2 +-
>  4 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index b89f6ac6a0c0..885058325c20 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -90,7 +90,7 @@ static struct mm_struct tboot_mm = {
>  	.pgd            = swapper_pg_dir,
>  	.mm_users       = ATOMIC_INIT(2),
>  	.mm_count       = ATOMIC_INIT(1),
> -	.mmap_sem       = __RWSEM_INITIALIZER(init_mm.mmap_sem),
> +	MMAP_LOCK_INITIALIZER(init_mm)
>  	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
>  	.mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
>  };
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 911a2bd0f6b7..916313ec8acb 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -54,7 +54,7 @@ struct mm_struct efi_mm = {
>  	.mm_rb			= RB_ROOT,
>  	.mm_users		= ATOMIC_INIT(2),
>  	.mm_count		= ATOMIC_INIT(1),
> -	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
> +	MMAP_LOCK_INITIALIZER(efi_mm)
>  	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
>  	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
>  	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index d1826ce42f00..9e104835a0d1 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -1,6 +1,9 @@
>  #ifndef _LINUX_MMAP_LOCK_H
>  #define _LINUX_MMAP_LOCK_H
>  
> +#define MMAP_LOCK_INITIALIZER(name) \
> +	.mmap_sem = __RWSEM_INITIALIZER(name.mmap_sem),

"(name).mmap_sem" is safer in a macro?

> +
>  static inline void mmap_init_lock(struct mm_struct *mm)
>  {
>  	init_rwsem(&mm->mmap_sem);
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index 19603302a77f..fe9c03d8e07b 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -31,7 +31,7 @@ struct mm_struct init_mm = {
>  	.pgd		= swapper_pg_dir,
>  	.mm_users	= ATOMIC_INIT(2),
>  	.mm_count	= ATOMIC_INIT(1),
> -	.mmap_sem	= __RWSEM_INITIALIZER(init_mm.mmap_sem),
> +	MMAP_LOCK_INITIALIZER(init_mm)
>  	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
>  	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
>  	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
> 

