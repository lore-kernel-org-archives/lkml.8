Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB60C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D87D207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgERJaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:30:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:44758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgERJaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:30:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 89C39AF57;
        Mon, 18 May 2020 09:30:03 +0000 (UTC)
Subject: Re: [PATCH v5 03/10] DMA reservations: use the new mmap locking API
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
 <20200422001422.232330-4-walken@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <89b3eddb-76c3-ca00-b49b-3f9d4076cd07@suse.cz>
Date:   Mon, 18 May 2020 11:30:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422001422.232330-4-walken@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 2:14 AM, Michel Lespinasse wrote:
> This use is converted manually ahead of the next patch in the series,
> as it requires including a new header which the automated conversion
> would miss.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

---
>  drivers/dma-buf/dma-resv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
> index 4264e64788c4..b45f8514dc82 100644
> --- a/drivers/dma-buf/dma-resv.c
> +++ b/drivers/dma-buf/dma-resv.c
> @@ -34,6 +34,7 @@
>  
>  #include <linux/dma-resv.h>
>  #include <linux/export.h>
> +#include <linux/mm.h>
>  #include <linux/sched/mm.h>
>  
>  /**
> @@ -109,7 +110,7 @@ static int __init dma_resv_lockdep(void)
>  
>  	dma_resv_init(&obj);
>  
> -	down_read(&mm->mmap_sem);
> +	mmap_read_lock(mm);
>  	ww_acquire_init(&ctx, &reservation_ww_class);
>  	ret = dma_resv_lock(&obj, &ctx);
>  	if (ret == -EDEADLK)
> @@ -118,7 +119,7 @@ static int __init dma_resv_lockdep(void)
>  	fs_reclaim_release(GFP_KERNEL);
>  	ww_mutex_unlock(&obj.lock);
>  	ww_acquire_fini(&ctx);
> -	up_read(&mm->mmap_sem);
> +	mmap_read_unlock(mm);
>  	
>  	mmput(mm);
>  
> 

