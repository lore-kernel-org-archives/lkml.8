Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6628BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F98120659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgEMVfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:35:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:34796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbgEMVfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:35:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B85F9AC22;
        Wed, 13 May 2020 21:35:31 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction: avoid VM_BUG_ON(PageSlab()) in
 page_mapcount()
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <158937872515.474360.5066096871639561424.stgit@buzz>
 <20200513113256.44ac9ce4c51a7ec1a5c5ba40@linux-foundation.org>
 <9420f90c-e423-475c-4b79-8287b76149d9@yandex-team.ru>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <88698909-22b8-79fa-c11f-3931c41cb20b@suse.cz>
Date:   Wed, 13 May 2020 23:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9420f90c-e423-475c-4b79-8287b76149d9@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/20 9:28 PM, Konstantin Khlebnikov wrote:
> On 13/05/2020 21.32, Andrew Morton wrote:
>> On Wed, 13 May 2020 17:05:25 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
>> 
>>> Function isolate_migratepages_block() runs some checks out of lru_lock
>>> when choose pages for migration. After checking PageLRU() it checks extra
>>> page references by comparing page_count() and page_mapcount(). Between
>>> these two checks page could be removed from lru, freed and taken by slab.
>>>
>>> As a result this race triggers VM_BUG_ON(PageSlab()) in page_mapcount().
>>> Race window is tiny. For certain workload this happens around once a year.
>>>
>>>
>>>   page:ffffea0105ca9380 count:1 mapcount:0 mapping:ffff88ff7712c180 index:0x0 compound_mapcount: 0
>>>   flags: 0x500000000008100(slab|head)
>>>   raw: 0500000000008100 dead000000000100 dead000000000200 ffff88ff7712c180
>>>   raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
>>>   page dumped because: VM_BUG_ON_PAGE(PageSlab(page))
>>>   ------------[ cut here ]------------
>>>   kernel BUG at ./include/linux/mm.h:628!
>>>   invalid opcode: 0000 [#1] SMP NOPTI
>>>   CPU: 77 PID: 504 Comm: kcompactd1 Tainted: G        W         4.19.109-27 #1
>>>   Hardware name: Yandex T175-N41-Y3N/MY81-EX0-Y3N, BIOS R05 06/20/2019
>>>   RIP: 0010:isolate_migratepages_block+0x986/0x9b0
>>>
>>>
>>> To fix just opencode page_mapcount() in racy check for 0-order case and
>>> recheck carefully under lru_lock when page cannot escape from lru.
>>>
>>> Also add checking extra references for file pages and swap cache.
>> 
>> It sounds like a cc:stable is appropriate?
> 
> Yep, but probably I'm missing something.
> 
> It seems bug is there for a long time and nobody seen it.
> Am I the only one using COONFIG_DEBUG_VM=y everywhere? =)

Unless things changed, Fedora kernels had it enabled, AFAIK
