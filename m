Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FC9C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583A52168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgBMDTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:19:04 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54284 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729404AbgBMDTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:19:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TprKK6x_1581563940;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TprKK6x_1581563940)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Feb 2020 11:19:02 +0800
Subject: Re: [PATCH 2/2] mm: vmpressure: use mem_cgroup_is_root API
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com>
 <1581398649-125989-2-git-send-email-yang.shi@linux.alibaba.com>
 <20200212082346.GB11353@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <94323469-c9d5-33ab-318b-2677dd966a92@linux.alibaba.com>
Date:   Wed, 12 Feb 2020 19:18:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200212082346.GB11353@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/20 12:23 AM, Michal Hocko wrote:
> On Tue 11-02-20 13:24:09, Yang Shi wrote:
>> Use mem_cgroup_is_root() API to check if memcg is root memcg instead of
>> open coding.
> Yes, the direct use outside of memcontrol.c should be really an
> exception. The only other similar case is cgwb_bdi_init and there is no
> easy way to replace - except for adding a helper which is not worth it.

Yes, it seems so. cgwb_bdi_init just deferences root_mem_cgroup to 
access its css. It is the only user outside memcontrol.c, so I agree a 
helper for it might be overkilling. Once we have more users, it should 
be considered.

>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

>
> Thanks!
>
>> ---
>>   mm/vmpressure.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
>> index 0590f00..d69019f 100644
>> --- a/mm/vmpressure.c
>> +++ b/mm/vmpressure.c
>> @@ -280,7 +280,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>>   		enum vmpressure_levels level;
>>   
>>   		/* For now, no users for root-level efficiency */
>> -		if (!memcg || memcg == root_mem_cgroup)
>> +		if (!memcg || mem_cgroup_is_root(memcg))
>>   			return;
>>   
>>   		spin_lock(&vmpr->sr_lock);
>> -- 
>> 1.8.3.1
>>

