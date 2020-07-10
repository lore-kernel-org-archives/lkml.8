Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04A7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6E9206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGJHBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:01:21 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45152 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbgGJHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:01:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U2GmRJK_1594364477;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2GmRJK_1594364477)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 15:01:18 +0800
Subject: Re: a question of split_huge_page
To:     =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
 <20200709155002.GF12769@casper.infradead.org>
 <20200709160750.utl46xvavceuvnom@box>
 <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com>
 <441ebbeb-0408-e22e-20f4-1be571c4a18e@nextfour.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <b6faa876-4c20-e99f-2e41-770871a5403d@linux.alibaba.com>
Date:   Fri, 10 Jul 2020 15:00:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <441ebbeb-0408-e22e-20f4-1be571c4a18e@nextfour.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/7/10 下午1:28, Mika Penttilä 写道:
>> Thanks a lot for quick reply!
>> What I am confusing is the call chain: __iommu_dma_alloc_pages()
>> to split_huge_page(), in the func, splited page,
>> 	page = alloc_pages_node(nid, alloc_flags, order);
>> And if the pages were added into lru, they maybe reclaimed and lost,
>> that would be a panic bug. But in fact, this never happened for long time.
>> Also I put a BUG() at the line, it's nevre triggered in ltp, and run_vmtests
> 
> In  __iommu_dma_alloc_pages, after split_huge_page(),  who is taking a
> reference on tail pages? Seems tail pages are freed and the function
> errornously returns them in pages[] array for use?
> 

Why you say so? It looks like the tail page returned and be used
	pages = __iommu_dma_alloc_pages() in iommu_dma_alloc_remap()
and still on node's lru. Is this right?

thanks!
