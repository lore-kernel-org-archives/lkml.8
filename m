Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18004C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 01:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51C22082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 01:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgC0Bvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 21:51:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbgC0Bvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 21:51:50 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 20219DCF16047037E5AE;
        Fri, 27 Mar 2020 09:51:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 27 Mar
 2020 09:51:44 +0800
Subject: Re: [PATCH] f2fs: fix long latency due to discard during umount
To:     Sahitya Tummala <stummala@codeaurora.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1584506689-5041-1-git-send-email-stummala@codeaurora.org>
 <29d4adc4-482d-3d92-1470-3405989ea231@huawei.com>
 <20200326133700.GR20234@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2b0d8d4c-a981-4edc-d8ca-fe199a63ea79@huawei.com>
Date:   Fri, 27 Mar 2020 09:51:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200326133700.GR20234@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/26 21:37, Sahitya Tummala wrote:
> Hi Chao,
> 
> On Thu, Mar 26, 2020 at 05:00:18PM +0800, Chao Yu wrote:
>> Hi Sahitya,
>>
>> On 2020/3/18 12:44, Sahitya Tummala wrote:
>>> F2FS already has a default timeout of 5 secs for discards that
>>> can be issued during umount, but it can take more than the 5 sec
>>> timeout if the underlying UFS device queue is already full and there
>>> are no more available free tags to be used. In that case, submit_bio()
>>> will wait for the already queued discard requests to complete to get
>>> a free tag, which can potentially take way more than 5 sec.
>>>
>>> Fix this by submitting the discard requests with REQ_NOWAIT
>>> flags during umount. This will return -EAGAIN for UFS queue/tag full
>>> scenario without waiting in the context of submit_bio(). The FS can
>>> then handle these requests by retrying again within the stipulated
>>> discard timeout period to avoid long latencies.
>>>
>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>> ---
>>> v2:
>>> - Handle the case where a dc can have multiple bios associated with it
>>>
>>>  fs/f2fs/f2fs.h    |  1 +
>>>  fs/f2fs/segment.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++-------
>>>  2 files changed, 74 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 12a197e..67b8dcc 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -340,6 +340,7 @@ struct discard_cmd_control {
>>>  	struct list_head pend_list[MAX_PLIST_NUM];/* store pending entries */
>>>  	struct list_head wait_list;		/* store on-flushing entries */
>>>  	struct list_head fstrim_list;		/* in-flight discard from fstrim */
>>> +	struct list_head retry_list;		/* list of cmds to retry */
>>>  	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
>>>  	unsigned int discard_wake;		/* to wake up discard thread */
>>>  	struct mutex cmd_lock;
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index fb3e531..4162c76 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1029,13 +1029,16 @@ static void f2fs_submit_discard_endio(struct bio *bio)
>>>  	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
>>>  	unsigned long flags;
>>>  
>>> -	dc->error = blk_status_to_errno(bio->bi_status);
>>> -
>>>  	spin_lock_irqsave(&dc->lock, flags);
>>> +	if (!dc->error)
>>> +		dc->error = blk_status_to_errno(bio->bi_status);
>>> +
>>>  	dc->bio_ref--;
>>> -	if (!dc->bio_ref && dc->state == D_SUBMIT) {
>>> -		dc->state = D_DONE;
>>> -		complete_all(&dc->wait);
>>> +	if (!dc->bio_ref) {
>>> +		if (dc->error || dc->state == D_SUBMIT) {
>>> +			dc->state = D_DONE;
>>> +			complete_all(&dc->wait);
>>> +		}
>>>  	}
>>>  	spin_unlock_irqrestore(&dc->lock, flags);
>>>  	bio_put(bio);
>>> @@ -1124,10 +1127,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>>  	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
>>>  					&(dcc->fstrim_list) : &(dcc->wait_list);
>>> -	int flag = dpolicy->sync ? REQ_SYNC : 0;
>>> -	block_t lstart, start, len, total_len;
>>> +	int flag;
>>> +	block_t lstart, start, len, total_len, orig_len;
>>>  	int err = 0;
>>>  
>>> +	flag = dpolicy->sync ? REQ_SYNC : 0;
>>> +	flag |= dpolicy->type == DPOLICY_UMOUNT ? REQ_NOWAIT : 0;
>>> +
>>>  	if (dc->state != D_PREP)
>>>  		return 0;
>>>  
>>> @@ -1139,7 +1145,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>>  	lstart = dc->lstart;
>>>  	start = dc->start;
>>>  	len = dc->len;
>>> -	total_len = len;
>>> +	orig_len = total_len = len;
>>>  
>>>  	dc->len = 0;
>>>  
>>> @@ -1203,6 +1209,14 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>>  		bio->bi_end_io = f2fs_submit_discard_endio;
>>>  		bio->bi_opf |= flag;
>>>  		submit_bio(bio);
>>> +		if (flag & REQ_NOWAIT) {
>>> +			if (dc->error == -EAGAIN) {
>>> +				dc->len = orig_len;
>>> +				list_move(&dc->list, &dcc->retry_list);
>>> +				err = dc->error;
>>
>> I encounter lots of dmesg, which should be printed by __remove_discard_cmd()
>>
>> F2FS-fs (dm-0): Issue discard(23552, 23552, 2) failed, ret: -11
>>
>> This should happen only if we didn't handle all discard in 5 seconds during
>> umount.
>>
>> So I doubt we failed to move dc to retry_list, because after submit_bio(),
>> end_io() is not called synchronously as the bio was just pluged?
>>
> This can happen if a discard cmd has multiple bios and at least 1 bio is 
> already submitted and when submitting other bios, we encounter -EAGAIN.
> In this case, this dc will be moved to retry_list and will be moved back
> to dcc->pend_list only if the dc->bio_ref becomes 0 within 5 sec timeout.
> If it doesn't become zero, then it will be left in retry_list itself, which
> will be later removed from retry_list. Before removing from retry_list we 
> will however ensure that submitted bio is done i.e., dc->bio_ref is 0, but
> dc->error will be -EAGAIN as this dc could not be requeued/retried.
> 
> So this is expected, where it only means that this dc could not be
> submitted/retried again within timeout. I think we can ignore
> this -EAGAIN error in __remove_discard_cmd().

With this patch, most of xfstest cases cost 5 * n second longer than before.

E.g. generic/003, during umount(), we looped into retrying one bio
submission.

[61279.829724] F2FS-fs (zram1): Found nat_bits in checkpoint
[61279.885337] F2FS-fs (zram1): Mounted with checkpoint version = 5cf3cb8e
[61281.912832] submit discard bio start [23555,1]
[61281.912835] f2fs_submit_discard_endio [23555,1] err:-11
[61281.912836] submit discard bio end [23555,1]
[61281.912836] move dc to retry list [23555,1]

...

[61286.881212] submit discard bio start [23555,1]
[61286.881217] f2fs_submit_discard_endio [23555,1] err:-11
[61286.881223] submit discard bio end [23555,1]
[61286.881224] move dc to retry list [23555,1]
[61286.905198] submit discard bio start [23555,1]
[61286.905203] f2fs_submit_discard_endio [23555,1] err:-11
[61286.905205] submit discard bio end [23555,1]
[61286.905206] move dc to retry list [23555,1]
[61286.929157] F2FS-fs (zram1): Issue discard(23555, 23555, 1) failed, ret: -11

Could you take a look at this issue?

Thanks,

> 
> Thanks,
> 
>> Thanks,
>>
>>> +				break;
>>> +			}
>>> +		}
>>>  
>>>  		atomic_inc(&dcc->issued_discard);
>>>  
>>> @@ -1463,6 +1477,40 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>>>  	return issued;
>>>  }
>>>  
>>> +static bool __should_discard_retry(struct f2fs_sb_info *sbi,
> s> > +		struct discard_policy *dpolicy)
>>> +{
>>> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>> +	struct discard_cmd *dc, *tmp;
>>> +	bool retry = false;
>>> +	unsigned long flags;
>>> +
>>> +	if (dpolicy->type != DPOLICY_UMOUNT)
>>> +		f2fs_bug_on(sbi, 1);
>>> +
>>> +	mutex_lock(&dcc->cmd_lock);
>>> +	list_for_each_entry_safe(dc, tmp, &(dcc->retry_list), list) {
>>> +		if (dpolicy->timeout != 0 &&
>>> +			f2fs_time_over(sbi, dpolicy->timeout)) {
>>> +			retry = false;
>>> +			break;
>>> +		}
>>> +
>>> +		spin_lock_irqsave(&dc->lock, flags);
>>> +		if (!dc->bio_ref) {
>>> +			dc->state = D_PREP;
>>> +			dc->error = 0;
>>> +			reinit_completion(&dc->wait);
>>> +			__relocate_discard_cmd(dcc, dc);
>>> +			retry = true;
>>> +		}
>>> +		spin_unlock_irqrestore(&dc->lock, flags);
>>> +	}
>>> +	mutex_unlock(&dcc->cmd_lock);
>>> +
>>> +	return retry;
>>> +}
>>> +
>>>  static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>  					struct discard_policy *dpolicy)
>>>  {
>>> @@ -1470,12 +1518,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>  	struct list_head *pend_list;
>>>  	struct discard_cmd *dc, *tmp;
>>>  	struct blk_plug plug;
>>> -	int i, issued = 0;
>>> +	int i, err, issued = 0;
>>>  	bool io_interrupted = false;
>>>  
>>>  	if (dpolicy->timeout != 0)
>>>  		f2fs_update_time(sbi, dpolicy->timeout);
>>>  
>>> +retry:
>>>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>>>  		if (dpolicy->timeout != 0 &&
>>>  				f2fs_time_over(sbi, dpolicy->timeout))
>>> @@ -1509,7 +1558,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>  				break;
>>>  			}
>>>  
>>> -			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
>>> +			err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
>>> +			if (err == -EAGAIN)
>>> +				congestion_wait(BLK_RW_ASYNC,
>>> +						DEFAULT_IO_TIMEOUT);
>>>  
>>>  			if (issued >= dpolicy->max_requests)
>>>  				break;
>>> @@ -1522,6 +1574,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>  			break;
>>>  	}
>>>  
>>> +	if (!list_empty(&dcc->retry_list) &&
>>> +		__should_discard_retry(sbi, dpolicy))
>>> +		goto retry;
>>> +
>>>  	if (!issued && io_interrupted)
>>>  		issued = -1;
>>>  
>>> @@ -1613,6 +1669,12 @@ static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
>>>  		goto next;
>>>  	}
>>>  
>>> +	if (dpolicy->type == DPOLICY_UMOUNT &&
>>> +		!list_empty(&dcc->retry_list)) {
>>> +		wait_list = &dcc->retry_list;
>>> +		goto next;
>>> +	}
>>> +
>>>  	return trimmed;
>>>  }
>>>  
>>> @@ -2051,6 +2113,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>>>  	for (i = 0; i < MAX_PLIST_NUM; i++)
>>>  		INIT_LIST_HEAD(&dcc->pend_list[i]);
>>>  	INIT_LIST_HEAD(&dcc->wait_list);
>>> +	INIT_LIST_HEAD(&dcc->retry_list);
>>>  	INIT_LIST_HEAD(&dcc->fstrim_list);
>>>  	mutex_init(&dcc->cmd_lock);
>>>  	atomic_set(&dcc->issued_discard, 0);
>>>
> 
