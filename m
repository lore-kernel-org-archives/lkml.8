Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47349C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7D3206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgGIPLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:11:54 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44696 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgGIPLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:11:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U2DJH.9_1594307508;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2DJH.9_1594307508)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Jul 2020 23:11:49 +0800
To:     Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Subject: a question of split_huge_page
Message-ID: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
Date:   Thu, 9 Jul 2020 23:11:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill & Matthew,

In the func call chain, from split_huge_page() to lru_add_page_tail(),
Seems tail pages are added to lru list at line 963, but in this scenario
the head page has no lru bit and isn't set the bit later. Why we do this?
or do I miss sth?

Many Thanks
Alex


938 void lru_add_page_tail(struct page *page, struct page *page_tail,
 939                        struct lruvec *lruvec, struct list_head *list)
 940 {
 941         VM_BUG_ON_PAGE(!PageHead(page), page);
 942         VM_BUG_ON_PAGE(PageCompound(page_tail), page);
 943         VM_BUG_ON_PAGE(PageLRU(page_tail), page);
 944         lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
 945
 946         if (!list)
 947                 SetPageLRU(page_tail);
 948
 949         if (likely(PageLRU(page)))
 950                 list_add_tail(&page_tail->lru, &page->lru);
 951         else if (list) {
 952                 /* page reclaim is reclaiming a huge page */
 953                 get_page(page_tail);
 954                 list_add_tail(&page_tail->lru, list);
 955         } else {
 956                 /*
 957                  * Head page has not yet been counted, as an hpage,
 958                  * so we must account for each subpage individually.
 959                  *
 960                  * Put page_tail on the list at the correct position
 961                  * so they all end up in order.
 962                  */
 963                 add_page_to_lru_list_tail(page_tail, lruvec,
 964                                           page_lru(page_tail));
 965         }
 966 }
