Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1538AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC2CC207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGJOKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:10:30 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:37785 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbgGJOK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:10:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U2IjCvH_1594390221;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2IjCvH_1594390221)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 22:10:22 +0800
Subject: Re: [PATCH v14 07/20] mm/thp: narrow lru locking
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
 <1593752873-4493-8-git-send-email-alex.shi@linux.alibaba.com>
 <124eeef1-ff2b-609e-3bf6-a118100c3f2a@linux.alibaba.com>
 <20200706113513.GY25523@casper.infradead.org>
 <alpine.LSU.2.11.2007062059420.2793@eggly.anvils>
 <20200709154816.wieg5thfejyv2h2l@box>
 <e87f7dd1-41c4-3392-f1df-982dd28c0617@linux.alibaba.com>
 <20200710112831.jrv4hzjzjqtxtc7u@box>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <d4d8bbba-12af-45c2-a35d-58f962ca5f9a@linux.alibaba.com>
Date:   Fri, 10 Jul 2020 22:09:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200710112831.jrv4hzjzjqtxtc7u@box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/7/10 下午7:28, Kirill A. Shutemov 写道:
>>   *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
>>   *           anon_vma->rwsem
>>   *             mm->page_table_lock or pte_lock
>> - *               pgdat->lru_lock (in mark_page_accessed, isolate_lru_page)
>>   *               swap_lock (in swap_duplicate, swap_info_get)
>>   *                 mmlist_lock (in mmput, drain_mmlist and others)
>>   *                 mapping->private_lock (in __set_page_dirty_buffers)
>> - *                   mem_cgroup_{begin,end}_page_stat (memcg->move_lock)
>> + *                   lock_page_memcg move_lock (in __set_page_dirty_buffers)
>>   *                     i_pages lock (widely used)
>> + *                       lock_page_lruvec_irq lruvec->lru_lock
> I think it has to be
> 			    lruvec->lru_lock (in lock_page_lruvec_irq)

Good catch! I will update it in next version.
Thanks!

> 
> No?

> 
>>   *                 inode->i_lock (in set_page_dirty's __mark_inode_dirty)
>>   *                 bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
>>   *                   sb_lock (within inode_lock in fs/fs-writeback.c)
>>
>>> local_irq_disable() also deserves a comment.
>>>
>> yes, I will add a comment for this. Do you mind give reviewed-by for this patch?
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks a lot! :)

