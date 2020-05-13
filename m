Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6960EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE755206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="EFTQt8g0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390635AbgEMT2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:28:06 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:35000 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390291AbgEMT2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:28:06 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 077462E152B;
        Wed, 13 May 2020 22:28:03 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id i4BcqtDHk9-S1pOG51g;
        Wed, 13 May 2020 22:28:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1589398082; bh=cJi+YKhtTW0lmQ8DVzDb4gU8JozSoYxkOvuTMg1aLOM=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=EFTQt8g02sOjiShkvplXhQAnbLHvu+FwRSFw3N7JvhAHJ8htGGT6jzHQ58eiGRDIy
         /a6FN69X1eol0F5aD2k2cebN+FYSlUc7fXrWvlcK5WndT2X7h/hTP3TYbAxExVPCME
         1fMsx5UwJ76J3whY246zHZ78CI8o5m7PCBdzhdec=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:407::1:3])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id XzeIGzjjyK-S1Xu46ha;
        Wed, 13 May 2020 22:28:01 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm/compaction: avoid VM_BUG_ON(PageSlab()) in
 page_mapcount()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <158937872515.474360.5066096871639561424.stgit@buzz>
 <20200513113256.44ac9ce4c51a7ec1a5c5ba40@linux-foundation.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <9420f90c-e423-475c-4b79-8287b76149d9@yandex-team.ru>
Date:   Wed, 13 May 2020 22:28:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513113256.44ac9ce4c51a7ec1a5c5ba40@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2020 21.32, Andrew Morton wrote:
> On Wed, 13 May 2020 17:05:25 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
> 
>> Function isolate_migratepages_block() runs some checks out of lru_lock
>> when choose pages for migration. After checking PageLRU() it checks extra
>> page references by comparing page_count() and page_mapcount(). Between
>> these two checks page could be removed from lru, freed and taken by slab.
>>
>> As a result this race triggers VM_BUG_ON(PageSlab()) in page_mapcount().
>> Race window is tiny. For certain workload this happens around once a year.
>>
>>
>>   page:ffffea0105ca9380 count:1 mapcount:0 mapping:ffff88ff7712c180 index:0x0 compound_mapcount: 0
>>   flags: 0x500000000008100(slab|head)
>>   raw: 0500000000008100 dead000000000100 dead000000000200 ffff88ff7712c180
>>   raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
>>   page dumped because: VM_BUG_ON_PAGE(PageSlab(page))
>>   ------------[ cut here ]------------
>>   kernel BUG at ./include/linux/mm.h:628!
>>   invalid opcode: 0000 [#1] SMP NOPTI
>>   CPU: 77 PID: 504 Comm: kcompactd1 Tainted: G        W         4.19.109-27 #1
>>   Hardware name: Yandex T175-N41-Y3N/MY81-EX0-Y3N, BIOS R05 06/20/2019
>>   RIP: 0010:isolate_migratepages_block+0x986/0x9b0
>>
>>
>> To fix just opencode page_mapcount() in racy check for 0-order case and
>> recheck carefully under lru_lock when page cannot escape from lru.
>>
>> Also add checking extra references for file pages and swap cache.
> 
> It sounds like a cc:stable is appropriate?

Yep, but probably I'm missing something.

It seems bug is there for a long time and nobody seen it.
Am I the only one using COONFIG_DEBUG_VM=y everywhere? =)

> 
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -935,12 +935,16 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   		}
>>   
>>   		/*
>> -		 * Migration will fail if an anonymous page is pinned in memory,
>> +		 * Migration will fail if an page is pinned in memory,
>>   		 * so avoid taking lru_lock and isolating it unnecessarily in an
>> -		 * admittedly racy check.
>> +		 * admittedly racy check simplest case for 0-order pages.
>> +		 *
>> +		 * Open code page_mapcount() to avoid VM_BUG_ON(PageSlab(page)).
>> +		 * Page could have extra reference from mapping or swap cache.
>>   		 */
>> -		if (!page_mapping(page) &&
>> -		    page_count(page) > page_mapcount(page))
>> +		if (!PageCompound(page) &&
>> +		    page_count(page) > atomic_read(&page->_mapcount) + 1 +
>> +				(!PageAnon(page) || PageSwapCache(page)))
>>   			goto isolate_fail;
>>   
>>   		/*
>> @@ -975,6 +979,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   				low_pfn += compound_nr(page) - 1;
>>   				goto isolate_fail;
>>   			}
>> +
>> +			/* Recheck page extra references under lock */
>> +			if (page_count(page) > page_mapcount(page) +
>> +				    (!PageAnon(page) || PageSwapCache(page)))
>> +				goto isolate_fail;
>>   		}
>>   
>>   		lruvec = mem_cgroup_page_lruvec(page, pgdat);
