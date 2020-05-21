Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A19EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6D12065F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgEUHmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:42:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:35472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgEUHmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:42:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DF51FAD78;
        Thu, 21 May 2020 07:42:06 +0000 (UTC)
Subject: Re: [PATCH v6 12/12] mmap locking API: convert mmap_sem comments
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
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20200520052908.204642-1-walken@google.com>
 <20200520052908.204642-13-walken@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e01060e9-6f00-7fa8-5da0-c9250c951d10@suse.cz>
Date:   Thu, 21 May 2020 09:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520052908.204642-13-walken@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 7:29 AM, Michel Lespinasse wrote:
> Convert comments that reference mmap_sem to reference mmap_lock instead.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

But:

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index a1247d3553da..1bf46e2e0cec 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -224,7 +224,7 @@ static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
>   * handle an empty nodemask with MPOL_PREFERRED here.
>   *
>   * Must be called holding task's alloc_lock to protect task's mems_allowed
> - * and mempolicy.  May also be called holding the mmap_semaphore for write.
> + * and mempolicy.  May also be called holding the mmap_lockaphore for write.
>   */
>  static int mpol_set_nodemask(struct mempolicy *pol,
>  		     const nodemask_t *nodes, struct nodemask_scratch *nsc)

:)
