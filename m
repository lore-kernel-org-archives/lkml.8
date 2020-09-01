Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E61DC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDFF20707
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgIAC24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:28:56 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33049 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbgIAC24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:28:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U7ULzwe_1598927332;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7ULzwe_1598927332)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Sep 2020 10:28:53 +0800
Subject: Re: [PATCH 0/5] mm: fixes to past from future testing
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <9fa34576-92ec-37db-0b9c-b29d28aa8775@linux.alibaba.com>
Date:   Tue, 1 Sep 2020 10:28:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/8/31 ÉÏÎç4:57, Hugh Dickins Ð´µÀ:
> Here's a set of independent fixes against 5.9-rc2: prompted by
> testing Alex Shi's "warning on !memcg" and lru_lock series, but
> I think fit for 5.9 - though maybe only the first for stable.
> 
> [PATCH 1/5] ksm: reinstate memcg charge on copied pages
> [PATCH 2/5] mm: migration of hugetlbfs page skip memcg
> [PATCH 3/5] shmem: shmem_writepage() split unlikely i915 THP
> [PATCH 4/5] mm: fix check_move_unevictable_pages() on THP
> [PATCH 5/5] mlock: fix unevictable_pgs event counts on THP

Hi Hugh,

Thanks a lot for reporting and fix! All fixed looks fine for me.

BTW,
I assume you already rebased lru_lock patchset on this. So I don't 
need to redo rebase again, do I? :)

Thanks
Alex

> 
>  mm/ksm.c     |    4 ++++
>  mm/migrate.c |    3 ++-
>  mm/mlock.c   |   24 +++++++++++++++---------
>  mm/shmem.c   |   10 +++++++++-
>  mm/swap.c    |    6 +++---
>  mm/vmscan.c  |   10 ++++++++--
>  6 files changed, 41 insertions(+), 16 deletions(-)
> 
