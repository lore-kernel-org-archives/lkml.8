Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E80C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B403120780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgGABNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:13:05 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:51876 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbgGABNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:13:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U1DHztl_1593565978;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0U1DHztl_1593565978)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Jul 2020 09:13:00 +0800
Subject: Re: [RFC][PATCH 8/8] mm/numa: new reclaim mode to enable
 reclaim-based migration
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rientjes@google.com, dan.j.williams@intel.com
References: <20200629234503.749E5340@viggo.jf.intel.com>
 <20200629234517.A7EC4BD3@viggo.jf.intel.com>
 <87v9j9ow3a.fsf@yhuang-dev.intel.com>
 <29c67873-3cb9-e121-382c-9b81491016bc@linux.alibaba.com>
 <87mu4knjq8.fsf@yhuang-dev.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <cdcdc19a-0dde-8392-6f3b-2480c2d740d0@linux.alibaba.com>
Date:   Tue, 30 Jun 2020 18:12:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87mu4knjq8.fsf@yhuang-dev.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/20 5:48 PM, Huang, Ying wrote:
> Hi, Yang,
>
> Yang Shi <yang.shi@linux.alibaba.com> writes:
>
>>>> diff -puN mm/vmscan.c~enable-numa-demotion mm/vmscan.c
>>>> --- a/mm/vmscan.c~enable-numa-demotion	2020-06-29 16:35:01.017312549 -0700
>>>> +++ b/mm/vmscan.c	2020-06-29 16:35:01.023312549 -0700
>>>> @@ -4165,9 +4165,10 @@ int node_reclaim_mode __read_mostly;
>>>>     * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
>>>>     * ABI.  New bits are OK, but existing bits can never change.
>>>>     */
>>>> -#define RECLAIM_RSVD  (1<<0)	/* (currently ignored/unused) */
>>>> -#define RECLAIM_WRITE (1<<1)	/* Writeout pages during reclaim */
>>>> -#define RECLAIM_UNMAP (1<<2)	/* Unmap pages during reclaim */
>>>> +#define RECLAIM_RSVD	(1<<0)	/* (currently ignored/unused) */
>>>> +#define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
>>>> +#define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
>>>> +#define RECLAIM_MIGRATE	(1<<3)	/* Migrate pages during reclaim */
>>>>      /*
>>>>     * Priority for NODE_RECLAIM. This determines the fraction of pages
>>> I found that RECLAIM_MIGRATE is defined but never referenced in the
>>> patch.
>>>
>>> If my understanding of the code were correct, shrink_do_demote_mapping()
>>> is called by shrink_page_list(), which is used by kswapd and direct
>>> reclaim.  So as long as the persistent memory node is onlined,
>>> reclaim-based migration will be enabled regardless of node reclaim mode.
>> It looks so according to the code. But the intention of a new node
>> reclaim mode is to do migration on reclaim *only when* the
>> RECLAIM_MODE is enabled by the users.
>>
>> It looks the patch just clear the migration target node masks if the
>> memory is offlined.
>>
>> So, I'm supposed you need check if node_reclaim is enabled before
>> doing migration in shrink_page_list() and also need make node reclaim
>> to adopt the new mode.
> But why shouldn't we migrate in kswapd and direct reclaim?  I think that
> we may need a way to control it, but shouldn't disable it
> unconditionally.

Let me share some background. In the past discussions on LKML and last 
year's LSFMM the opt-in approach was preferred since the new feature 
might be not stable and mature.  So the new node reclaim mode was 
suggested by both Mel and Michal. I'm supposed this is still a valid 
point now.

Once it is mature and stable enough we definitely could make it 
universally preferred and default behavior.

>
>> Please refer to
>> https://lore.kernel.org/linux-mm/1560468577-101178-6-git-send-email-yang.shi@linux.alibaba.com/
>>
> Best Regards,
> Huang, Ying

