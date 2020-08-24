Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF36C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056DF20FC3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgHXIjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:39:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:58058 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726825AbgHXIjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:39:03 -0400
Received: from [192.168.15.190]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kA7zr-000xMS-Oh; Mon, 24 Aug 2020 11:38:31 +0300
Subject: Re: [PATCH 0/4] mm: Simplfy cow handling
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200821234958.7896-1-peterx@redhat.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6ebc0bfa-5afe-1114-876e-39e89143eb6d@virtuozzo.com>
Date:   Mon, 24 Aug 2020 11:38:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821234958.7896-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.2020 02:49, Peter Xu wrote:
> This is a small series that I picked up from Linus's suggestion [0] to simplify
> cow handling (and also more strict) by checking against page refcounts rather
> than mapcounts.
> 
> I'm CCing the author and reviewer of commit 52d1e606ee73 on ksm ("mm: reuse
> only-pte-mapped KSM page in do_wp_page()", 2019-03-05).  Please shoot if
> there's any reason to keep the logic, or it'll be removed in this series.  For
> more information, please refer to [3,4].

I'm not sure I understand the reasons to remove that. But the reason to add was
to avoid excess page copying, when it is not needed in real.
 
> The new mm counter in the last patch can be seen as RFC, depending on whether
> anyone dislikes it... I used it majorly for observing the page reuses, so it is
> kind of optional.
> 
> Two tests I did:
> 
>   - Run a busy loop dirty program [1] that uses 6G of memory, restrict to 1G
>     RAM + 5G swap (cgroup).  A few hours later, all things still look good.
>     Make sure to observe (still massive) correct page reuses using the new
>     counter using the last patch, probably when swapping in.
> 
>   - Run umapsort [2] to make sure uffd-wp will work again after applying this
>     series upon master 5.9-rc1 (5.9-rc1 is broken).
> 
> In all cases, I must confess it's quite pleased to post a series with diffstat
> like this...  Hopefully this won't break anyone but only to make everything
> better.
> 
> Please review, thanks.
> 
> [0] https://lore.kernel.org/lkml/CAHk-=wjn90-=s6MBerxTuP=-FVEZtR-LpoH9eenEQ3A-QfKTZw@mail.gmail.com
> [1] https://github.com/xzpeter/clibs/blob/master/bsd/mig_mon/mig_mon.c
> [2] https://github.com/LLNL/umap-apps/blob/develop/src/umapsort/umapsort.cpp
> [3] https://lore.kernel.org/lkml/CAHk-=wh0syDtNzt9jGyHRV0r1pVX5gkdJWdenwmvy=dq0AL5mA@mail.gmail.com
> [4] https://lore.kernel.org/lkml/CAHk-=wj5Oyg0LeAxSw_vizerm=sLd=sHfcVecZMKPZn6kNbbXA@mail.gmail.com
> 
> Linus Torvalds (1):
>   mm: Trial do_wp_page() simplification
> 
> Peter Xu (3):
>   mm/ksm: Remove reuse_ksm_page()
>   mm/gup: Remove enfornced COW mechanism
>   mm: Add PGREUSE counter
> 
>  drivers/gpu/drm/i915/gem/i915_gem_userptr.c |  8 ---
>  include/linux/ksm.h                         |  7 ---
>  include/linux/vm_event_item.h               |  1 +
>  mm/gup.c                                    | 40 ++------------
>  mm/huge_memory.c                            |  7 +--
>  mm/ksm.c                                    | 25 ---------
>  mm/memory.c                                 | 60 +++++++--------------
>  mm/vmstat.c                                 |  1 +
>  8 files changed, 29 insertions(+), 120 deletions(-)
> 

