Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7D3C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32C1222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgGNMO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:14:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48540 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727886AbgGNMOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:14:52 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 58425836413EE0F587DD;
        Tue, 14 Jul 2020 20:14:49 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 14 Jul
 2020 20:14:47 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't skip writeback of quota data
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200709053027.351974-1-jaegeuk@kernel.org>
 <2f4207db-57d1-5b66-f1ee-3532feba5d1f@huawei.com>
 <20200709190545.GA3001066@google.com>
 <ae1a3e8a-6209-8d4b-7235-5c8897076501@huawei.com>
 <20200710032616.GC545837@google.com>
 <01d0db54-eee1-f6cd-76c3-ebe59a7abae4@huawei.com>
 <20200710035053.GH545837@google.com>
 <77041117-f615-e6e6-591c-b02bf99e58c2@huawei.com>
 <20200713175926.GB2910046@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d8645371-f1d6-f5a2-01a9-19708fe3861b@huawei.com>
Date:   Tue, 14 Jul 2020 20:14:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200713175926.GB2910046@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/14 1:59, Jaegeuk Kim wrote:
> On 07/10, Chao Yu wrote:
>> On 2020/7/10 11:50, Jaegeuk Kim wrote:
>>> On 07/10, Chao Yu wrote:
>>>> On 2020/7/10 11:26, Jaegeuk Kim wrote:
>>>>> On 07/10, Chao Yu wrote:
>>>>>> On 2020/7/10 3:05, Jaegeuk Kim wrote:
>>>>>>> On 07/09, Chao Yu wrote:
>>>>>>>> On 2020/7/9 13:30, Jaegeuk Kim wrote:
>>>>>>>>> It doesn't need to bypass flushing quota data in background.
>>>>>>>>
>>>>>>>> The condition is used to flush quota data in batch to avoid random
>>>>>>>> small-sized udpate, did you hit any problem here?
>>>>>>>
>>>>>>> I suspect this causes fault injection test being stuck by waiting for inode
>>>>>>> writeback completion. With this patch, it has been running w/o any issue so far.
>>>>>>> I keep an eye on this.
>>>>>>
>>>>>> Hmmm.. so that this patch may not fix the root cause, and it may hiding the
>>>>>> issue deeper.
>>>>>>
>>>>>> How about just keeping this patch in our private branch to let fault injection
>>>>>> test not be stuck? until we find the root cause in upstream codes.
>>>>>
>>>>> Well, I don't think this hides something. When the issue happens, I saw inodes
>>>>> being stuck due to writeback while only quota has some dirty data. At that time,
>>>>> there was no dirty data page from other inodes.
>>>>
>>>> Okay,
>>>>
>>>>>
>>>>> More specifically, I suspect __writeback_inodes_sb_nr() gives WB_SYNC_NONE and
>>>>> waits for wb_wait_for_completion().
>>>>
>>>> Did you record any callstack after the issue happened?
>>>
>>> I found this.
>>>
>>> [213389.297642]  __schedule+0x2dd/0x780^M
>>> [213389.299224]  schedule+0x55/0xc0^M
>>> [213389.300745]  wb_wait_for_completion+0x56/0x90^M
>>> [213389.302469]  ? wait_woken+0x80/0x80^M
>>> [213389.303997]  __writeback_inodes_sb_nr+0xa8/0xd0^M
>>> [213389.305760]  writeback_inodes_sb+0x4b/0x60^M
>>> [213389.307439]  sync_filesystem+0x2e/0xa0^M
>>> [213389.308999]  generic_shutdown_super+0x27/0x110^M
>>> [213389.310738]  kill_block_super+0x27/0x50^M
>>> [213389.312327]  kill_f2fs_super+0x76/0xe0 [f2fs]^M
>>> [213389.314014]  deactivate_locked_super+0x3b/0x80^M
>>> [213389.315692]  deactivate_super+0x3e/0x50^M
>>> [213389.317226]  cleanup_mnt+0x109/0x160^M
>>> [213389.318718]  __cleanup_mnt+0x12/0x20^M
>>> [213389.320177]  task_work_run+0x70/0xb0^M
>>> [213389.321609]  exit_to_usermode_loop+0x131/0x160^M
>>> [213389.323306]  do_syscall_64+0x170/0x1b0^M
>>> [213389.324762]  entry_SYSCALL_64_after_hwframe+0x44/0xa9^M
>>> [213389.326477] RIP: 0033:0x7fc4b5e6a35b^M
>>
>> Does this only happen during umount? If so, will below change help?
>>
>> 	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
>> +			!is_sbi_flag_set(sbi, SBI_IS_CLOSE) &&
>> 			wbc->sync_mode == WB_SYNC_NONE &&
>> 			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
>> 			f2fs_available_free_memory(sbi, DIRTY_DENTS))
>> 		goto skip_write;
> 
> Hmm, this doesn't work. The writeback was called before put_super?

Oops, still be confused about this issue. :(

Thanks,

> I'll try the original patch one more time.
> 
>>
>>>
>>>>
>>>> Still I'm confused that why directory's data written could be skipped, but
>>>> quota's data couldn't, what's the difference?
>>>
>>> I suspect different blocking timing from cp_error between quota and dentry.
>>> e.g., we block dir operations right after cp_error, while quota can make
>>
>> No guarantee that there is no dirty dentry being created after
>> cp_error, right?
>>
>> e.g.
>>
>> Thread A				Thread B
>> - f2fs_create
>> - bypass f2fs_cp_error
>> 					- set cp_error
>> - create dirty dentry
>>
>> BTW, do you know what __writeback_inodes_sb_nr is waiting for?
>>
>>> dirty pages in more fine granularity.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>>>> ---
>>>>>>>>>  fs/f2fs/data.c | 2 +-
>>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>>>>>> index 44645f4f914b6..72e8b50e588c1 100644
>>>>>>>>> --- a/fs/f2fs/data.c
>>>>>>>>> +++ b/fs/f2fs/data.c
>>>>>>>>> @@ -3148,7 +3148,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>>>>>>>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>>>>>>>>>  		goto skip_write;
>>>>>>>>>  
>>>>>>>>> -	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
>>>>>>>>> +	if (S_ISDIR(inode->i_mode) &&
>>>>>>>>>  			wbc->sync_mode == WB_SYNC_NONE &&
>>>>>>>>>  			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
>>>>>>>>>  			f2fs_available_free_memory(sbi, DIRTY_DENTS))
>>>>>>>>>
>>>>>>> .
>>>>>>>
>>>>> .
>>>>>
>>> .
>>>
> .
> 
