Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9BDC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63645206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDVIAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:00:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbgDVIAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:00:03 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7467612D12D69904D6A9;
        Wed, 22 Apr 2020 15:59:58 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.100) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:59:50 +0800
Subject: Re: [PATCH] fs:ocfs2:remove unneeded variable 'o2dlm_flags'
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, <mark@fasheh.com>,
        <jlbec@evilplan.org>
CC:     <linux-kernel@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <1587539521-461177-1-git-send-email-wubo40@huawei.com>
 <7214599d-3bd2-96b7-59f9-d731bb27f744@linux.alibaba.com>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <9bf0798a-7dd5-4328-68f5-8bc2cd2ffa99@huawei.com>
Date:   Wed, 22 Apr 2020 15:59:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7214599d-3bd2-96b7-59f9-d731bb27f744@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.100]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/22 15:52, Joseph Qi wrote:
> 
> 
> On 2020/4/22 15:12, Wu Bo wrote:
>> Fix the following coccicheck warning:
>> fs/ocfs2/stack_o2cb.c:69:5-16: Unneeded variable: "o2dlm_flags".
>> Return "0" on line 84
>>
> Umm... This is not right, NAK.
> Something tricky is in map_flag() so that coccicheck doesn't recognize.
> 
> Thanks,
> Joseph

You are right. Did not notice that map_flag is a macro, Please ignore 
this patch.

Thanks,
Wu Bo

> 
>> Signed-off-by: Wu Bo <wubo40@huawei.com>
>> ---
>>   fs/ocfs2/stack_o2cb.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/fs/ocfs2/stack_o2cb.c b/fs/ocfs2/stack_o2cb.c
>> index dbf8b57..2da9633 100644
>> --- a/fs/ocfs2/stack_o2cb.c
>> +++ b/fs/ocfs2/stack_o2cb.c
>> @@ -66,8 +66,6 @@ static inline int mode_to_o2dlm(int mode)
>>   	}
>>   static int flags_to_o2dlm(u32 flags)
>>   {
>> -	int o2dlm_flags = 0;
>> -
>>   	map_flag(DLM_LKF_NOQUEUE, LKM_NOQUEUE);
>>   	map_flag(DLM_LKF_CANCEL, LKM_CANCEL);
>>   	map_flag(DLM_LKF_CONVERT, LKM_CONVERT);
>> @@ -81,7 +79,7 @@ static int flags_to_o2dlm(u32 flags)
>>   	/* map_flag() should have cleared every flag passed in */
>>   	BUG_ON(flags != 0);
>>   
>> -	return o2dlm_flags;
>> +	return 0;
>>   }
>>   #undef map_flag
>>   
>>
> 
> .
> 


