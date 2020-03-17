Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8379C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D1D20752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgCQT24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:28:56 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:46884 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgCQT24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:28:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TsuFGLH_1584473331;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TsuFGLH_1584473331)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Mar 2020 03:28:53 +0800
Subject: Re: [v3 PATCH 1/2] mm: swap: make page_evictable() inline
To:     Matthew Wilcox <willy@infradead.org>
Cc:     shakeelb@google.com, vbabka@suse.cz, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1584466971-110029-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200317190411.GD22433@bombadil.infradead.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <03aa047b-4e52-d5fb-c212-b341df4ea07f@linux.alibaba.com>
Date:   Tue, 17 Mar 2020 12:28:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200317190411.GD22433@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/20 12:04 PM, Matthew Wilcox wrote:
> On Wed, Mar 18, 2020 at 01:42:50AM +0800, Yang Shi wrote:
>> v3: * Fixed the build error reported by lkp.
> I'm not terribly enthusiastic about including pagemap.h from swap.h.
> It's a discussion that reasonable people can disagree about, so let's
> set it up:
>
> This patch adds inline bool page_evictable(struct page *page) to swap.h.
> page_evictable() uses mapping_evictable() which is in pagemap.h.
> mapping_evictable() uses AS_UNEVICTABLE which is also in pagemap.h.
>
> We could move mapping_evictable() and friends to fs.h (already included
> by swap.h).  But how about just moving page_evictable() to pagemap.h?
> pagemap.h is already included by mm/mlock.c, mm/swap.c and mm/vmscan.c,
> which are the only three current callers of page_evictable().
>
> In fact, since it's only called by those three files, perhaps it should
> be in mm/internal.h?  I don't see it becoming a terribly popular function
> to call outside of the core mm code.
>
> I think I have a mild preference for it being in pagemap.h, since I don't
> have a hard time convincing myself that it's part of the page cache API,
> but I definitely prefer internal.h over swap.h.

Thanks for the suggestion. Will move it to pagemap.h


