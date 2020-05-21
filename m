Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17494C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D833320826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgEUQsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:48:21 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:53398 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726938AbgEUQsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:48:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TzDN7ee_1590079693;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TzDN7ee_1590079693)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 May 2020 00:48:15 +0800
Subject: Re: [RFC linux-next PATCH] mm: khugepaged: remove error message when
 checking external pins
To:     Qian Cai <cai@lca.pw>
Cc:     kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1589317383-9595-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200521145644.GA6367@ovpn-112-192.phx2.redhat.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <67808455-39ed-9fae-014b-c022304a2a32@linux.alibaba.com>
Date:   Thu, 21 May 2020 09:48:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200521145644.GA6367@ovpn-112-192.phx2.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/20 7:56 AM, Qian Cai wrote:
> On Wed, May 13, 2020 at 05:03:03AM +0800, Yang Shi wrote:
> []
>>   mm/khugepaged.c | 24 +++++++++++++++++-------
>>   1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 1fdd677..048f5d4 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -602,12 +602,6 @@ static bool is_refcount_suitable(struct page *page)
>>   	if (PageSwapCache(page))
>>   		expected_refcount += compound_nr(page);
>>   
>> -	if (IS_ENABLED(CONFIG_DEBUG_VM) && expected_refcount > refcount) {
>> -		pr_err("expected_refcount (%d) > refcount (%d)\n",
>> -				expected_refcount, refcount);
>> -		dump_page(page, "Unexpected refcount");
>> -	}
>> -
>>   	return page_count(page) == expected_refcount;
>>   }
> mm/khugepaged.c: In function 'is_refcount_suitable':
> mm/khugepaged.c:575:25: warning: variable 'refcount set but not used [-Wunused-but-set-variable]
>    int expected_refcount, refcount;
>                           ^~~~~~~~
>
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -572,9 +572,8 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>   
>   static bool is_refcount_suitable(struct page *page)
>   {
> -	int expected_refcount, refcount;
> +	int expected_refcount;
>   
> -	refcount = page_count(page);
>   	expected_refcount = total_mapcount(page);
>   	if (PageSwapCache(page))
>   		expected_refcount += compound_nr(page);

Thanks for catching this.


