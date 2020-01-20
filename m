Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B68C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E8A24125
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgATNAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:00:06 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:48280 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbgATNAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:00:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0ToETcqo_1579525195;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToETcqo_1579525195)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Jan 2020 20:59:57 +0800
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <9ee80b68-a78f-714a-c727-1f6d2b4f87ea@linux.alibaba.com>
Date:   Mon, 20 Jan 2020 20:58:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116215222.GA64230@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/1/17 ÉÏÎç5:52, Johannes Weiner Ð´µÀ:

> You simply cannot serialize on page->mem_cgroup->lruvec when
> page->mem_cgroup isn't stable. You need to serialize on the page
> itself, one way or another, to make this work.
> 
> 
> So here is a crazy idea that may be worth exploring:
> 
> Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
> linked list.
> 
> Can we make PageLRU atomic and use it to stabilize the lru_lock
> instead, and then use the lru_lock only serialize list operations?
> 

Hi Johannes,

I am trying to figure out the solution of atomic PageLRU, but is 
blocked by the following sitations, when PageLRU and lru list was protected
together under lru_lock, the PageLRU could be a indicator if page on lru list
But now seems it can't be the indicator anymore.
Could you give more clues of stabilization usage of PageLRU?
  

__page_cache_release/release_pages/compaction            __pagevec_lru_add
if (TestClearPageLRU(page))                              if (!PageLRU())
                                                                lruvec_lock();
                                                                list_add();
        			                                lruvec_unlock();
        			                                SetPageLRU() //position 1
        lock_page_lruvec_irqsave(page, &flags);
        del_page_from_lru_list(page, lruvec, ..);
        unlock_page_lruvec_irqrestore(lruvec, flags);
                                                                SetPageLRU() //position 2
Thanks a lot!
Alex

> I.e. in compaction, you'd do
> 
> 	if (!TestClearPageLRU(page))
> 		goto isolate_fail;
> 	/*
> 	 * We isolated the page's LRU state and thereby locked out all
> 	 * other isolators, including cgroup page moving, page reclaim,
> 	 * page freeing etc. That means page->mem_cgroup is now stable
> 	 * and we can safely look up the correct lruvec and take the
> 	 * page off its physical LRU list.
> 	 */
> 	lruvec = mem_cgroup_page_lruvec(page);
> 	spin_lock_irq(&lruvec->lru_lock);
> 	del_page_from_lru_list(page, lruvec, page_lru(page));
> 
> Putback would mostly remain the same (although you could take the
> PageLRU setting out of the list update locked section, as long as it's
> set after the page is physically linked):
> 
> 	/* LRU isolation pins page->mem_cgroup */
> 	lruvec = mem_cgroup_page_lruvec(page)
> 	spin_lock_irq(&lruvec->lru_lock);
> 	add_page_to_lru_list(...);
> 	spin_unlock_irq(&lruvec->lru_lock);
> 
> 	SetPageLRU(page);
> 
> And you'd have to carefully review and rework other sites that rely on
> PageLRU: reclaim, __page_cache_release(), __activate_page() etc.
> 
> Especially things like activate_page(), which used to only check
> PageLRU to shuffle the page on the LRU list would now have to briefly
> clear PageLRU and then set it again afterwards.
> 
> However, aside from a bit more churn in those cases, and the
> unfortunate additional atomic operations, I currently can't think of a
> fundamental reason why this wouldn't work.
> 
> Hugh, what do you think?
> 
