Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9655CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAC220825
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgERLBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:01:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:44308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgERLBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:01:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9328ABBD;
        Mon, 18 May 2020 11:01:36 +0000 (UTC)
Subject: Re: [PATCH v5.5 09/10] mmap locking API: add mmap_assert_locked() and
 mmap_assert_write_locked()
To:     Michel Lespinasse <walken@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
 <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org>
 <20200424012612.GA158937@google.com> <20200424013858.GB158937@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <fcf53ca7-d3a0-93e2-47af-7dd9b32b081a@suse.cz>
Date:   Mon, 18 May 2020 13:01:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424013858.GB158937@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/20 3:38 AM, Michel Lespinasse wrote:
> Add new APIs to assert that mmap_sem is held.
> 
> Using this instead of rwsem_is_locked and lockdep_assert_held[_write]
> makes the assertions more tolerant of future changes to the lock type.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> ---
>  arch/x86/events/core.c    |  2 +-
>  fs/userfaultfd.c          |  6 +++---
>  include/linux/mmap_lock.h | 14 ++++++++++++++
>  mm/gup.c                  |  2 +-
>  mm/hmm.c                  |  2 +-
>  mm/memory.c               |  2 +-
>  mm/mmu_notifier.c         |  6 +++---
>  mm/pagewalk.c             |  6 +++---
>  mm/util.c                 |  2 +-
>  9 files changed, 28 insertions(+), 14 deletions(-)
> 

...

> @@ -73,4 +75,16 @@ static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
>  	up_read_non_owner(&mm->mmap_sem);
>  }
>  
> +static inline void mmap_assert_locked(struct mm_struct *mm)
> +{
> +	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_sem, -1), mm);
> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
> +}
> +
> +static inline void mmap_assert_write_locked(struct mm_struct *mm)
> +{
> +	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_sem, 0), mm);
> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
> +}

I would remove VM_BUG_ON_MM() from the lockdep part. If kernel has lockdep
enabled, it's already in heavy debugging mode enough so let's just use it and
not depend on DEBUG_VM. Many sites you convert don't require DEBUG_VM for the
lockdep checks.

With that you can also use the standard lockdep_assert_held() and
lockdep_assert_held_write() wrappers.

If user has both lockdep and DEBUG_VM enabled, should we run both variants?
Perhaps lockdep is enough as it's more comprehensive? Your initial v5 version
was doing that.
