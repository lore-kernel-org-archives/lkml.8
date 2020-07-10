Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017FFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24FC2065D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGJDPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:15:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7285 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbgGJDPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:15:18 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 599847F8CC46ECA42E9A;
        Fri, 10 Jul 2020 11:15:14 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 10 Jul
 2020 11:15:13 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't skip writeback of quota data
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200709053027.351974-1-jaegeuk@kernel.org>
 <2f4207db-57d1-5b66-f1ee-3532feba5d1f@huawei.com>
 <20200709190545.GA3001066@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ae1a3e8a-6209-8d4b-7235-5c8897076501@huawei.com>
Date:   Fri, 10 Jul 2020 11:15:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200709190545.GA3001066@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/10 3:05, Jaegeuk Kim wrote:
> On 07/09, Chao Yu wrote:
>> On 2020/7/9 13:30, Jaegeuk Kim wrote:
>>> It doesn't need to bypass flushing quota data in background.
>>
>> The condition is used to flush quota data in batch to avoid random
>> small-sized udpate, did you hit any problem here?
> 
> I suspect this causes fault injection test being stuck by waiting for inode
> writeback completion. With this patch, it has been running w/o any issue so far.
> I keep an eye on this.

Hmmm.. so that this patch may not fix the root cause, and it may hiding the
issue deeper.

How about just keeping this patch in our private branch to let fault injection
test not be stuck? until we find the root cause in upstream codes.

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/data.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 44645f4f914b6..72e8b50e588c1 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -3148,7 +3148,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>>>  		goto skip_write;
>>>  
>>> -	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
>>> +	if (S_ISDIR(inode->i_mode) &&
>>>  			wbc->sync_mode == WB_SYNC_NONE &&
>>>  			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
>>>  			f2fs_available_free_memory(sbi, DIRTY_DENTS))
>>>
> .
> 
