Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58859C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 01:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3480F2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 01:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgG0B3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 21:29:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45464 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbgG0B3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 21:29:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A2ABAA782959DE6ED086;
        Mon, 27 Jul 2020 09:29:47 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 27 Jul
 2020 09:29:47 +0800
Subject: Re: [PATCH 3/5] f2fs: inherit mtime of original block during GC
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200707112128.89136-1-yuchao0@huawei.com>
 <20200707112128.89136-4-yuchao0@huawei.com>
 <20200726160532.GB2233572@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fce56974-44eb-0b4f-23e5-f3babe1c59bb@huawei.com>
Date:   Mon, 27 Jul 2020 09:29:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200726160532.GB2233572@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/27 0:05, Jaegeuk Kim wrote:
> On 07/07, Chao Yu wrote:
>> Don't let f2fs inner GC ruins original aging degree of segment.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/data.c    |  2 +-
>>   fs/f2fs/f2fs.h    |  5 +++--
>>   fs/f2fs/gc.c      |  4 ++--
>>   fs/f2fs/segment.c | 55 ++++++++++++++++++++++++++++++++++++-----------
>>   4 files changed, 49 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 44645f4f914b..7f108684de1d 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1368,7 +1368,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
>>   	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
>>   	old_blkaddr = dn->data_blkaddr;
>>   	f2fs_allocate_data_block(sbi, NULL, old_blkaddr, &dn->data_blkaddr,
>> -					&sum, seg_type, NULL);
>> +				&sum, seg_type, NULL, false);
>>   	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
>>   		invalidate_mapping_pages(META_MAPPING(sbi),
>>   					old_blkaddr, old_blkaddr);
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index ce4305ac42dd..dcf99f1bdfe1 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -3383,7 +3383,8 @@ void f2fs_outplace_write_data(struct dnode_of_data *dn,
>>   int f2fs_inplace_write_data(struct f2fs_io_info *fio);
>>   void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>   			block_t old_blkaddr, block_t new_blkaddr,
>> -			bool recover_curseg, bool recover_newaddr);
>> +			bool recover_curseg, bool recover_newaddr,
>> +			bool from_gc);
>>   void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
>>   			block_t old_addr, block_t new_addr,
>>   			unsigned char version, bool recover_curseg,
>> @@ -3391,7 +3392,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
>>   void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>>   			block_t old_blkaddr, block_t *new_blkaddr,
>>   			struct f2fs_summary *sum, int type,
>> -			struct f2fs_io_info *fio);
>> +			struct f2fs_io_info *fio, bool from_gc);
>>   void f2fs_wait_on_page_writeback(struct page *page,
>>   			enum page_type type, bool ordered, bool locked);
>>   void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 755641047978..da187aec988f 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -877,7 +877,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
>>   	}
>>   
>>   	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
>> -					&sum, CURSEG_COLD_DATA, NULL);
>> +				&sum, CURSEG_COLD_DATA, NULL, true);
>>   
>>   	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
>>   				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
>> @@ -927,7 +927,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
>>   recover_block:
>>   	if (err)
>>   		f2fs_do_replace_block(fio.sbi, &sum, newaddr, fio.old_blkaddr,
>> -								true, true);
>> +							true, true, true);
>>   up_out:
>>   	if (lfs_mode)
>>   		up_write(&fio.sbi->io_order_lock);
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 9d10285932f9..222d28c44e4f 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2149,12 +2149,28 @@ static void __set_sit_entry_type(struct f2fs_sb_info *sbi, int type,
>>   	if (modified)
>>   		__mark_sit_entry_dirty(sbi, segno);
>>   }
> 
> Need a new line?

Oh, will revise this in next version.

Thanks,

> 
>> +static inline unsigned long long get_segment_mtime(struct f2fs_sb_info *sbi,
>> +								block_t blkaddr)
>> +{
>> +	unsigned int segno = GET_SEGNO(sbi, blkaddr);
>> +
>> +	if (segno == NULL_SEGNO)
>> +		return 0;
>> +	return get_seg_entry(sbi, segno)->mtime;
>> +}
>>   
>> -static void update_segment_mtime(struct f2fs_sb_info *sbi, block_t blkaddr)
>> +static void update_segment_mtime(struct f2fs_sb_info *sbi, block_t blkaddr,
>> +						unsigned long long old_mtime)
>>   {
>> +	struct seg_entry *se;
>>   	unsigned int segno = GET_SEGNO(sbi, blkaddr);
>> -	struct seg_entry *se = get_seg_entry(sbi, segno);
>> -	unsigned long long mtime = get_mtime(sbi, false);
>> +	unsigned long long ctime = get_mtime(sbi, false);
>> +	unsigned long long mtime = old_mtime ? old_mtime : ctime;
>> +
>> +	if (segno == NULL_SEGNO)
>> +		return;
>> +
>> +	se = get_seg_entry(sbi, segno);
>>   
>>   	if (!se->mtime)
>>   		se->mtime = mtime;
>> @@ -2162,8 +2178,8 @@ static void update_segment_mtime(struct f2fs_sb_info *sbi, block_t blkaddr)
>>   		se->mtime = div_u64(se->mtime * se->valid_blocks + mtime,
>>   						se->valid_blocks + 1);
>>   
>> -	if (mtime > SIT_I(sbi)->max_mtime)
>> -		SIT_I(sbi)->max_mtime = mtime;
>> +	if (ctime > SIT_I(sbi)->max_mtime)
>> +		SIT_I(sbi)->max_mtime = ctime;
>>   }
>>   
>>   static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>> @@ -2185,8 +2201,6 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>>   	f2fs_bug_on(sbi, (new_vblocks >> (sizeof(unsigned short) << 3) ||
>>   				(new_vblocks > sbi->blocks_per_seg)));
>>   
>> -	update_segment_mtime(sbi, blkaddr);
>> -
>>   	se->valid_blocks = new_vblocks;
>>   
>>   	/* Update valid block bitmap */
>> @@ -2280,6 +2294,7 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
>>   	/* add it into sit main buffer */
>>   	down_write(&sit_i->sentry_lock);
>>   
>> +	update_segment_mtime(sbi, addr, 0);
>>   	update_sit_entry(sbi, addr, -1);
>>   
>>   	/* add it into dirty seglist */
>> @@ -3188,10 +3203,11 @@ static int __get_segment_type(struct f2fs_io_info *fio)
>>   void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>>   		block_t old_blkaddr, block_t *new_blkaddr,
>>   		struct f2fs_summary *sum, int type,
>> -		struct f2fs_io_info *fio)
>> +		struct f2fs_io_info *fio, bool from_gc)
>>   {
>>   	struct sit_info *sit_i = SIT_I(sbi);
>>   	struct curseg_info *curseg = CURSEG_I(sbi, type);
>> +	unsigned long long old_mtime;
>>   
>>   	down_read(&SM_I(sbi)->curseg_lock);
>>   
>> @@ -3213,6 +3229,14 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>>   
>>   	stat_inc_block_count(sbi, curseg);
>>   
>> +	if (from_gc) {
>> +		old_mtime = get_segment_mtime(sbi, old_blkaddr);
>> +	} else {
>> +		update_segment_mtime(sbi, old_blkaddr, 0);
>> +		old_mtime = 0;
>> +	}
>> +	update_segment_mtime(sbi, *new_blkaddr, old_mtime);
>> +
>>   	/*
>>   	 * SIT information should be updated before segment allocation,
>>   	 * since SSR needs latest valid block information.
>> @@ -3289,7 +3313,8 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
>>   		down_read(&fio->sbi->io_order_lock);
>>   reallocate:
>>   	f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
>> -			&fio->new_blkaddr, sum, type, fio);
>> +			&fio->new_blkaddr, sum, type, fio,
>> +			is_cold_data(fio->page));
>>   	if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO)
>>   		invalidate_mapping_pages(META_MAPPING(fio->sbi),
>>   					fio->old_blkaddr, fio->old_blkaddr);
>> @@ -3405,7 +3430,8 @@ static inline int __f2fs_get_curseg(struct f2fs_sb_info *sbi,
>>   
>>   void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>   				block_t old_blkaddr, block_t new_blkaddr,
>> -				bool recover_curseg, bool recover_newaddr)
>> +				bool recover_curseg, bool recover_newaddr,
>> +				bool from_gc)
>>   {
>>   	struct sit_info *sit_i = SIT_I(sbi);
>>   	struct curseg_info *curseg;
>> @@ -3456,11 +3482,16 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>   	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
>>   	__add_sum_entry(sbi, type, sum);
>>   
>> -	if (!recover_curseg || recover_newaddr)
>> +	if (!recover_curseg || recover_newaddr) {
>> +		if (!from_gc)
>> +			update_segment_mtime(sbi, new_blkaddr, 0);
>>   		update_sit_entry(sbi, new_blkaddr, 1);
>> +	}
>>   	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO) {
>>   		invalidate_mapping_pages(META_MAPPING(sbi),
>>   					old_blkaddr, old_blkaddr);
>> +		if (!from_gc)
>> +			update_segment_mtime(sbi, old_blkaddr, 0);
>>   		update_sit_entry(sbi, old_blkaddr, -1);
>>   	}
>>   
>> @@ -3492,7 +3523,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
>>   	set_summary(&sum, dn->nid, dn->ofs_in_node, version);
>>   
>>   	f2fs_do_replace_block(sbi, &sum, old_addr, new_addr,
>> -					recover_curseg, recover_newaddr);
>> +					recover_curseg, recover_newaddr, false);
>>   
>>   	f2fs_update_data_blkaddr(dn, new_addr);
>>   }
>> -- 
>> 2.26.2
> .
> 
