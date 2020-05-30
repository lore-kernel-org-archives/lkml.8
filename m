Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF11C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F8B20707
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgE3BaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 21:30:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727876AbgE3BaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 21:30:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 27B375CB4E9BE0AE5A1A;
        Sat, 30 May 2020 09:30:13 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 30 May
 2020 09:30:11 +0800
Subject: Re: [PATCH] Revert "f2fs: fix quota_sync failure due to f2fs_lock_op"
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200529092947.7890-1-yuchao0@huawei.com>
 <20200529223426.GA249109@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <96ba756e-a354-1ee8-689e-211f63c294e6@huawei.com>
Date:   Sat, 30 May 2020 09:30:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200529223426.GA249109@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/30 6:34, Jaegeuk Kim wrote:
> On 05/29, Chao Yu wrote:
>> Under heavy fsstress, we may triggle panic while issuing discard,
>> because __check_sit_bitmap() detects that discard command may earse
>> valid data blocks, the root cause is as below race stack described,
>> since we removed lock when flushing quota data, quota data writeback
>> may race with write_checkpoint(), so that it causes inconsistency in
>> between cached discard entry and segment bitmap.
>>
>> - f2fs_write_checkpoint
>>  - block_operations
>>   - set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH)
>>  - f2fs_flush_sit_entries
>>   - add_discard_addrs
>>    - __set_bit_le(i, (void *)de->discard_map);
>> 						- f2fs_write_data_pages
>> 						 - f2fs_write_single_data_page
>> 						   : inode is quota one, cp_rwsem won't be locked
>> 						  - f2fs_do_write_data_page
>> 						   - f2fs_allocate_data_block
>> 						    - f2fs_wait_discard_bio
>> 						      : discard entry has not been added yet.
>> 						    - update_sit_entry
>>  - f2fs_clear_prefree_segments
>>   - f2fs_issue_discard
>>   : add discard entry
>>
>> This patch fixes this issue by reverting 435cbab95e39 ("f2fs: fix quota_sync
>> failure due to f2fs_lock_op").
>>
>> Fixes: 435cbab95e39 ("f2fs: fix quota_sync failure due to f2fs_lock_op")
> 
> The previous patch fixes quota_sync gets EAGAIN all the time.
> How about this? It seems this works for fsstress test.
> 
> ---
>  fs/f2fs/segment.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ebbadde6cbced..f67cffc38975e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3095,6 +3095,14 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  	struct curseg_info *curseg = CURSEG_I(sbi, type);
>  	bool put_pin_sem = false;
>  
> +	/*
> +	 * We need to wait for node_write to avoid block allocation during
> +	 * checkpoint. This can only happen to quota writes which can cause
> +	 * the below discard race condition.
> +	 */
> +	if (IS_DATASEG(type))

type is CURSEG_COLD_DATA_PINNED, IS_DATASEG(CURSEG_COLD_DATA_PINNED) should be false,
then node_write lock will not be held, later type will be updated to CURSEG_COLD_DATA,
then we will try to release node_write.

Thanks,

> +		down_write(&sbi->node_write);
> +
>  	if (type == CURSEG_COLD_DATA) {
>  		/* GC during CURSEG_COLD_DATA_PINNED allocation */
>  		if (down_read_trylock(&sbi->pin_sem)) {
> @@ -3174,6 +3182,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  
>  	if (put_pin_sem)
>  		up_read(&sbi->pin_sem);
> +
> +	if (IS_DATASEG(type))
> +		up_write(&sbi->node_write);
>  }
>  
>  static void update_device_state(struct f2fs_io_info *fio)
> 
