Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86981C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606932073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgC3IiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:38:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44048 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbgC3IiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:38:20 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 98C441D36927062BC959;
        Mon, 30 Mar 2020 16:38:15 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 30 Mar
 2020 16:38:11 +0800
Subject: Re: [PATCH] f2fs: fix long latency due to discard during umount
To:     Sahitya Tummala <stummala@codeaurora.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1584506689-5041-1-git-send-email-stummala@codeaurora.org>
 <29d4adc4-482d-3d92-1470-3405989ea231@huawei.com>
 <20200326133700.GR20234@codeaurora.org>
 <2b0d8d4c-a981-4edc-d8ca-fe199a63ea79@huawei.com>
 <20200327030542.GS20234@codeaurora.org>
 <20200330065335.GT20234@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9adc5c7e-7936-bac7-58b1-50631f8ac5eb@huawei.com>
Date:   Mon, 30 Mar 2020 16:38:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200330065335.GT20234@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

Bad news, :( I guess we didn't catch the root cause, as after applying v3,
I still can reproduce this issue:

generic/003 10s ...  30s

Thanks,

On 2020/3/30 14:53, Sahitya Tummala wrote:
> Hi Chao,
> 
> On Fri, Mar 27, 2020 at 08:35:42AM +0530, Sahitya Tummala wrote:
>> On Fri, Mar 27, 2020 at 09:51:43AM +0800, Chao Yu wrote:
>>>
>>> With this patch, most of xfstest cases cost 5 * n second longer than before.
>>>
>>> E.g. generic/003, during umount(), we looped into retrying one bio
>>> submission.
>>>
>>> [61279.829724] F2FS-fs (zram1): Found nat_bits in checkpoint
>>> [61279.885337] F2FS-fs (zram1): Mounted with checkpoint version = 5cf3cb8e
>>> [61281.912832] submit discard bio start [23555,1]
>>> [61281.912835] f2fs_submit_discard_endio [23555,1] err:-11
>>> [61281.912836] submit discard bio end [23555,1]
>>> [61281.912836] move dc to retry list [23555,1]
>>>
>>> ...
>>>
>>> [61286.881212] submit discard bio start [23555,1]
>>> [61286.881217] f2fs_submit_discard_endio [23555,1] err:-11
>>> [61286.881223] submit discard bio end [23555,1]
>>> [61286.881224] move dc to retry list [23555,1]
>>> [61286.905198] submit discard bio start [23555,1]
>>> [61286.905203] f2fs_submit_discard_endio [23555,1] err:-11
>>> [61286.905205] submit discard bio end [23555,1]
>>> [61286.905206] move dc to retry list [23555,1]
>>> [61286.929157] F2FS-fs (zram1): Issue discard(23555, 23555, 1) failed, ret: -11
>>>
>>> Could you take a look at this issue?
>>
>> Let me check and get back on this.
> 
> I found the issue. The dc with multiple bios is getting requeued again and
> again in case if one of its bio gets -EAGAIN error. Even the successfully
> completed bios are getting requeued again resulting into long latency.
> I have fixed it by splitting the dc in such case so that we can requeue only
> the leftover bios into a new dc and retry that later within the 5 sec timeout.
> 
> Please help to review v3 posted and if it looks good, I would like to request
> you to test the earlier regression scenario with it to check the result again?
> 
> thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Thanks,
>>>>
>>>>> Thanks,
>>>>>
>>>>>> +				break;
>>>>>> +			}
>>>>>> +		}
>>>>>>  
>>>>>>  		atomic_inc(&dcc->issued_discard);
>>>>>>  
>>>>>> @@ -1463,6 +1477,40 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>>>>>>  	return issued;
>>>>>>  }
>>>>>>  
>>>>>> +static bool __should_discard_retry(struct f2fs_sb_info *sbi,
>>>> s> > +		struct discard_policy *dpolicy)
>>>>>> +{
>>>>>> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>>>>> +	struct discard_cmd *dc, *tmp;
>>>>>> +	bool retry = false;
>>>>>> +	unsigned long flags;
>>>>>> +
>>>>>> +	if (dpolicy->type != DPOLICY_UMOUNT)
>>>>>> +		f2fs_bug_on(sbi, 1);
>>>>>> +
>>>>>> +	mutex_lock(&dcc->cmd_lock);
>>>>>> +	list_for_each_entry_safe(dc, tmp, &(dcc->retry_list), list) {
>>>>>> +		if (dpolicy->timeout != 0 &&
>>>>>> +			f2fs_time_over(sbi, dpolicy->timeout)) {
>>>>>> +			retry = false;
>>>>>> +			break;
>>>>>> +		}
>>>>>> +
>>>>>> +		spin_lock_irqsave(&dc->lock, flags);
>>>>>> +		if (!dc->bio_ref) {
>>>>>> +			dc->state = D_PREP;
>>>>>> +			dc->error = 0;
>>>>>> +			reinit_completion(&dc->wait);
>>>>>> +			__relocate_discard_cmd(dcc, dc);
>>>>>> +			retry = true;
>>>>>> +		}
>>>>>> +		spin_unlock_irqrestore(&dc->lock, flags);
>>>>>> +	}
>>>>>> +	mutex_unlock(&dcc->cmd_lock);
>>>>>> +
>>>>>> +	return retry;
>>>>>> +}
>>>>>> +
>>>>>>  static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>>>  					struct discard_policy *dpolicy)
>>>>>>  {
>>>>>> @@ -1470,12 +1518,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>>>  	struct list_head *pend_list;
>>>>>>  	struct discard_cmd *dc, *tmp;
>>>>>>  	struct blk_plug plug;
>>>>>> -	int i, issued = 0;
>>>>>> +	int i, err, issued = 0;
>>>>>>  	bool io_interrupted = false;
>>>>>>  
>>>>>>  	if (dpolicy->timeout != 0)
>>>>>>  		f2fs_update_time(sbi, dpolicy->timeout);
>>>>>>  
>>>>>> +retry:
>>>>>>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>>>>>>  		if (dpolicy->timeout != 0 &&
>>>>>>  				f2fs_time_over(sbi, dpolicy->timeout))
>>>>>> @@ -1509,7 +1558,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>>>  				break;
>>>>>>  			}
>>>>>>  
>>>>>> -			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
>>>>>> +			err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
>>>>>> +			if (err == -EAGAIN)
>>>>>> +				congestion_wait(BLK_RW_ASYNC,
>>>>>> +						DEFAULT_IO_TIMEOUT);
>>>>>>  
>>>>>>  			if (issued >= dpolicy->max_requests)
>>>>>>  				break;
>>>>>> @@ -1522,6 +1574,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>>>  			break;
>>>>>>  	}
>>>>>>  
>>>>>> +	if (!list_empty(&dcc->retry_list) &&
>>>>>> +		__should_discard_retry(sbi, dpolicy))
>>>>>> +		goto retry;
>>>>>> +
>>>>>>  	if (!issued && io_interrupted)
>>>>>>  		issued = -1;
>>>>>>  
>>>>>> @@ -1613,6 +1669,12 @@ static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
>>>>>>  		goto next;
>>>>>>  	}
>>>>>>  
>>>>>> +	if (dpolicy->type == DPOLICY_UMOUNT &&
>>>>>> +		!list_empty(&dcc->retry_list)) {
>>>>>> +		wait_list = &dcc->retry_list;
>>>>>> +		goto next;
>>>>>> +	}
>>>>>> +
>>>>>>  	return trimmed;
>>>>>>  }
>>>>>>  
>>>>>> @@ -2051,6 +2113,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>>>>>>  	for (i = 0; i < MAX_PLIST_NUM; i++)
>>>>>>  		INIT_LIST_HEAD(&dcc->pend_list[i]);
>>>>>>  	INIT_LIST_HEAD(&dcc->wait_list);
>>>>>> +	INIT_LIST_HEAD(&dcc->retry_list);
>>>>>>  	INIT_LIST_HEAD(&dcc->fstrim_list);
>>>>>>  	mutex_init(&dcc->cmd_lock);
>>>>>>  	atomic_set(&dcc->issued_discard, 0);
>>>>>>
>>>>
>>
>> -- 
>> --
>> Sent by a consultant of the Qualcomm Innovation Center, Inc.
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> 
