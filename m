Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C2BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD622207E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGCCNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:13:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbgGCCNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:13:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ABB822F59E07BC97FD66;
        Fri,  3 Jul 2020 10:13:20 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 3 Jul 2020
 10:13:17 +0800
Subject: Re: [PATCH RFC 2/5] f2fs: record average update time of segment
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200630100428.19105-1-yuchao0@huawei.com>
 <20200630100428.19105-2-yuchao0@huawei.com>
 <20200701161927.GD1724572@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <70776961-0430-0a9f-cf26-09a2cc192b07@huawei.com>
Date:   Fri, 3 Jul 2020 10:13:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200701161927.GD1724572@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/2 0:19, Jaegeuk Kim wrote:
> On 06/30, Chao Yu wrote:
>> Previously, once we update one block in segment, we will update mtime of
>> segment to last time, making aged segment becoming freshest, result in
>> that GC with cost benefit algorithm missing such segment, So this patch
>> changes to record mtime as average block updating time instead of last
>> updating time.
>>
>> It's not needed to reset mtime for prefree segment, as se->valid_blocks
>> is zero, then old se->mtime won't take any weight with below calculation:
>>
>> 	se->mtime = (se->mtime * se->valid_blocks + mtime) /
>> 				(se->valid_blocks + 1);
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/segment.c | 21 ++++++++++++++++++---
>>  1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 863ec6f1fb87..906c313835ad 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2150,6 +2150,22 @@ static void __set_sit_entry_type(struct f2fs_sb_info *sbi, int type,
>>  		__mark_sit_entry_dirty(sbi, segno);
>>  }
>>  
>> +static void update_segment_mtime(struct f2fs_sb_info *sbi, block_t blkaddr)
>> +{
>> +	unsigned int segno = GET_SEGNO(sbi, blkaddr);
>> +	struct seg_entry *se = get_seg_entry(sbi, segno);
>> +	unsigned long long mtime = get_mtime(sbi, false);
>> +
>> +	if (!se->mtime) {
> 
> Don't need {}.

Updated,

BTW, have fixed below compile error:

   m68k-linux-ld: fs/f2fs/segment.o: in function `update_segment_mtime':
   fs/f2fs/segment.c:2162: undefined reference to `__udivdi3'

Thanks,

> 
>> +		se->mtime = mtime;
>> +	} else {
>> +		se->mtime = (se->mtime * se->valid_blocks + mtime) /
>> +						(se->valid_blocks + 1);
>> +	}
>> +	if (mtime > SIT_I(sbi)->max_mtime)
>> +		SIT_I(sbi)->max_mtime = mtime;
>> +}
>> +
>>  static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>>  {
>>  	struct seg_entry *se;
>> @@ -2169,10 +2185,9 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>>  	f2fs_bug_on(sbi, (new_vblocks >> (sizeof(unsigned short) << 3) ||
>>  				(new_vblocks > sbi->blocks_per_seg)));
>>  
>> +	update_segment_mtime(sbi, blkaddr);
>> +
>>  	se->valid_blocks = new_vblocks;
>> -	se->mtime = get_mtime(sbi, false);
>> -	if (se->mtime > SIT_I(sbi)->max_mtime)
>> -		SIT_I(sbi)->max_mtime = se->mtime;
>>  
>>  	/* Update valid block bitmap */
>>  	if (del > 0) {
>> -- 
>> 2.26.2
> .
> 
