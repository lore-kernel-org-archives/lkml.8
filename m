Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E432C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714BE206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgGJOY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:24:57 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:59150 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727941AbgGJOY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:24:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U2Io76-_1594391084;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2Io76-_1594391084)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 22:24:45 +0800
Subject: Re: a question of split_huge_page
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
 <20200709155002.GF12769@casper.infradead.org>
 <20200709160750.utl46xvavceuvnom@box>
 <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com>
 <20200710103318.bm2gp743lagiajao@box>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <f6ce8cbe-9645-4b33-d699-663e68118bcd@linux.alibaba.com>
Date:   Fri, 10 Jul 2020 22:23:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200710103318.bm2gp743lagiajao@box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/7/10 下午6:33, Kirill A. Shutemov 写道:
> On Fri, Jul 10, 2020 at 12:51:58PM +0800, Alex Shi wrote:
>>
>>
>> 在 2020/7/10 上午12:07, Kirill A. Shutemov 写道:
>>> Right, and it's never got removed from LRU during the split. The tail
>>> pages have to be added to LRU because they now separate from the tail
>>> page.
>>>
>> According to the explaination, looks like we could remove the code path,
>> since it's never got into. (base on my v15 patchset). Any comments?
> 
> Yes. But why? It's reasonable failsafe that gives chance to recover if
> something goes wrong.
> 

Hi Kirill,

Sorry, I didn't get your points. IMHO, this fallback cann't work well,
since the head page isn't and shouldn't be added to lru. like the iommu issue
if a dma page added into lru list, it may be reclaim and lost. So, sorry, I
still don't know how this path could fix some wrong.

Thanks
Alex
