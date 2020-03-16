Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B087EC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EA02071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbgCPQh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:37:28 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:40816 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732122AbgCPQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:37:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TsoL6qx_1584376608;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TsoL6qx_1584376608)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Mar 2020 00:36:51 +0800
Subject: Re: [PATCH 1/2] mm: swap: make page_evictable() inline
To:     Matthew Wilcox <willy@infradead.org>
Cc:     shakeelb@google.com, vbabka@suse.cz, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1584124476-76534-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200314160157.GR22433@bombadil.infradead.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <245aab40-ea54-eadc-ca9e-e85ef78b7cc7@linux.alibaba.com>
Date:   Mon, 16 Mar 2020 09:36:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200314160157.GR22433@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/20 9:01 AM, Matthew Wilcox wrote:
> On Sat, Mar 14, 2020 at 02:34:35AM +0800, Yang Shi wrote:
>> -extern int page_evictable(struct page *page);
>> +/*
> This seems to be in kernel-doc format already; could you add the extra
> '*' so it is added to the fine documentation?

Yes, sure.

>
>> + * page_evictable - test whether a page is evictable
>> + * @page: the page to test
>> + *
>> + * Test whether page is evictable--i.e., should be placed on active/inactive
>> + * lists vs unevictable list.
>> + *
>> + * Reasons page might not be evictable:
>> + * (1) page's mapping marked unevictable
>> + * (2) page is part of an mlocked VMA
>> + *
>> + */
>> +static inline int page_evictable(struct page *page)
>> +{
>> +	int ret;
>> +
>> +	/* Prevent address_space of inode and swap cache from being freed */
>> +	rcu_read_lock();
>> +	ret = !mapping_unevictable(page_mapping(page)) && !PageMlocked(page);
>> +	rcu_read_unlock();
>> +	return ret;
>> +}
> This seems like it should return bool ... that might even lead to code
> generation improvement.

Thanks for catching this. It looks mapping_unevictable() needs to be 
converted to bool as well.


