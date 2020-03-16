Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13C4C10F29
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 00:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C312206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 00:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgCPAwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 20:52:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729303AbgCPAwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 20:52:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 25AF7FB1864F123E307B;
        Mon, 16 Mar 2020 08:52:31 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 16 Mar
 2020 08:52:26 +0800
Subject: Re: [PATCH] f2fs: fix long latency due to discard during umount
To:     Sahitya Tummala <stummala@codeaurora.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1584011671-20939-1-git-send-email-stummala@codeaurora.org>
 <fa7d88ee-01e2-e82c-6c79-f24b90fbd472@huawei.com>
 <20200313033912.GJ20234@codeaurora.org>
 <a8f01157-0b1b-d83a-488d-bb48cf8954ab@huawei.com>
 <20200313110846.GL20234@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <20d3b7ef-b216-6e46-58fd-7f1c96d4a8d3@huawei.com>
Date:   Mon, 16 Mar 2020 08:52:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200313110846.GL20234@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/13 19:08, Sahitya Tummala wrote:
> On Fri, Mar 13, 2020 at 02:30:55PM +0800, Chao Yu wrote:
>> On 2020/3/13 11:39, Sahitya Tummala wrote:
>>> On Fri, Mar 13, 2020 at 10:20:04AM +0800, Chao Yu wrote:
>>>> On 2020/3/12 19:14, Sahitya Tummala wrote:
>>>>> F2FS already has a default timeout of 5 secs for discards that
>>>>> can be issued during umount, but it can take more than the 5 sec
>>>>> timeout if the underlying UFS device queue is already full and there
>>>>> are no more available free tags to be used. In that case, submit_bio()
>>>>> will wait for the already queued discard requests to complete to get
>>>>> a free tag, which can potentially take way more than 5 sec.
>>>>>
>>>>> Fix this by submitting the discard requests with REQ_NOWAIT
>>>>> flags during umount. This will return -EAGAIN for UFS queue/tag full
>>>>> scenario without waiting in the context of submit_bio(). The FS can
>>>>> then handle these requests by retrying again within the stipulated
>>>>> discard timeout period to avoid long latencies.
>>>>>
>>>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>>>> ---
>>>>>  fs/f2fs/segment.c | 14 +++++++++++++-
>>>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index fb3e531..a06bbac 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -1124,10 +1124,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>>>>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>>>>  	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
>>>>>  					&(dcc->fstrim_list) : &(dcc->wait_list);
>>>>> -	int flag = dpolicy->sync ? REQ_SYNC : 0;
>>>>> +	int flag;
>>>>>  	block_t lstart, start, len, total_len;
>>>>>  	int err = 0;
>>>>>  
>>>>> +	flag = dpolicy->sync ? REQ_SYNC : 0;
>>>>> +	flag |= dpolicy->type == DPOLICY_UMOUNT ? REQ_NOWAIT : 0;
>>>>> +
>>>>>  	if (dc->state != D_PREP)
>>>>>  		return 0;
>>>>>  
>>>>> @@ -1203,6 +1206,11 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>>>>  		bio->bi_end_io = f2fs_submit_discard_endio;
>>>>>  		bio->bi_opf |= flag;
>>>>>  		submit_bio(bio);
>>>>> +		if ((flag & REQ_NOWAIT) && (dc->error == -EAGAIN)) {
>>>>
>>>> If we want to update dc->state, we need to cover it with dc->lock.
>>>
>>> Sure, will update it.
>>>
>>>>
>>>>> +			dc->state = D_PREP;
>>>>
>>>> BTW, one dc can be referenced by multiple bios, so dc->state could be updated to
>>>> D_DONE later by f2fs_submit_discard_endio(), however we just relocate it to
>>>> pending list... which is inconsistent status.
>>>
>>> In that case dc->bio_ref will reflect it and until it becomes 0, the dc->state
>>> will not be updated to D_DONE in f2fs_submit_discard_endio()?
>>
>> __submit_discard_cmd()
>>  lock()
>>  dc->state = D_SUBMIT;
>>  dc->bio_ref++;
>>  unlock()
>> ...
>>  submit_bio()
>> 				f2fs_submit_discard_endio()
>> 				 dc->error = -EAGAIN;
>> 				 lock()
>> 				 dc->bio_ref--;
>>
>>  dc->state = D_PREP;
>>
>> 				 dc->state = D_DONE;
>> 				 unlock()
>>
>> So finally, dc's state is D_DONE, and it's in wait list, then will be relocated
>> to pending list.
> 
> In case of queue full, f2fs_submit_discard_endio() will not be called

I guess the case is there are multiple bios related to one dc and partially callback
of bio is called asynchronously and the other is called synchronously, so the race
condition could happen.

Thanks,

> asynchronously. It will be called in the context of submit_bio() itself.
> So by the time, submit_bio returns dc->error will be -EAGAIN and dc->state
> will be D_DONE. 
> 
> submit_bio()
> ->blk_mq_make_request
> ->blk_mq_get_request()
>   ->bio_wouldblock_error() (called due to queue full)
>     ->bio_endio()
>     
> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Thanks,
>>>>
>>>>> +			err = dc->error;
>>>>> +			break;
>>>>> +		}
>>>>>  
>>>>>  		atomic_inc(&dcc->issued_discard);
>>>>>  
>>>>> @@ -1510,6 +1518,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>>  			}
>>>>>  
>>>>>  			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
>>>>> +			if (dc->error == -EAGAIN) {
>>>>> +				congestion_wait(BLK_RW_ASYNC, HZ/50);
>>>>> +				__relocate_discard_cmd(dcc, dc);
>>>>> +			}
>>>>>  
>>>>>  			if (issued >= dpolicy->max_requests)
>>>>>  				break;
>>>>>
>>>
> 
