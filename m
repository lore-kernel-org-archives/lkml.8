Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C1EC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFD320716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgC1IiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:38:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51008 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbgC1IiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:38:17 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 02B6B1F41F22422873C7;
        Sat, 28 Mar 2020 16:38:05 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 28 Mar
 2020 16:38:01 +0800
Subject: Re: [PATCH] f2fs: prevent meta updates while checkpoint is in
 progress
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Sahitya Tummala <stummala@codeaurora.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1585219019-24831-1-git-send-email-stummala@codeaurora.org>
 <20200327192412.GA186975@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <397da8a6-fdb4-9637-c6ea-803492c408a2@huawei.com>
Date:   Sat, 28 Mar 2020 16:38:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200327192412.GA186975@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 2020/3/28 3:24, Jaegeuk Kim wrote:
> Hi Sahitya,
> 
> On 03/26, Sahitya Tummala wrote:
>> allocate_segment_for_resize() can cause metapage updates if
>> it requires to change the current node/data segments for resizing.
>> Stop these meta updates when there is a checkpoint already
>> in progress to prevent inconsistent CP data.
> 
> Doesn't freeze|thaw_bdev(sbi->sb->s_bdev); work for you?

That can avoid foreground ops racing? rather than background ops like
balance_fs() from kworker?

BTW, I found that {freeze,thaw}_bdev is not enough to freeze all
foreground fs ops, it needs to use {freeze,thaw}_super instead.

---
 fs/f2fs/gc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 26248c8936db..acdc8b99b543 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1538,7 +1538,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		return -EINVAL;
 	}

-	freeze_bdev(sbi->sb->s_bdev);
+	freeze_super(sbi->sb);

 	shrunk_blocks = old_block_count - block_count;
 	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
@@ -1551,7 +1551,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		sbi->user_block_count -= shrunk_blocks;
 	spin_unlock(&sbi->stat_lock);
 	if (err) {
-		thaw_bdev(sbi->sb->s_bdev, sbi->sb);
+		thaw_super(sbi->sb);
 		return err;
 	}

@@ -1613,6 +1613,6 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 	}
 	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
 	mutex_unlock(&sbi->resize_mutex);
-	thaw_bdev(sbi->sb->s_bdev, sbi->sb);
+	thaw_super(sbi->sb);
 	return err;
 }
-- 
2.18.0.rc1

> 
>>
>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>> ---
>>  fs/f2fs/gc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 5bca560..6122bad 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -1399,8 +1399,10 @@ static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
>>  	int err = 0;
>>  
>>  	/* Move out cursegs from the target range */
>> +	f2fs_lock_op(sbi);
>>  	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++)
>>  		allocate_segment_for_resize(sbi, type, start, end);
>> +	f2fs_unlock_op(sbi);
>>  
>>  	/* do GC to move out valid blocks in the range */
>>  	for (segno = start; segno <= end; segno += sbi->segs_per_sec) {
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> .
> 
