Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6D7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2443E20719
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgIADZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:25:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgIADZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:25:05 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A96FA5A6C5AE8FD7E644;
        Tue,  1 Sep 2020 11:25:01 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 1 Sep 2020
 11:24:59 +0800
Subject: Re: [PATCH v2 5/5] f2fs: support age threshold based garbage
 collection
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200804131449.50517-1-yuchao0@huawei.com>
 <20200804131449.50517-6-yuchao0@huawei.com>
 <20200825193404.GA2614120@google.com>
 <7986af8c-1fe9-7140-f1c0-d8b4a58f702c@huawei.com>
 <20200831180143.GB3665231@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <33105d88-3e8d-b70a-f035-49dbc4a7a6f8@huawei.com>
Date:   Tue, 1 Sep 2020 11:24:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200831180143.GB3665231@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,  I missed one ')' in this diff, thanks for fixing in upstream.

Thanks,

On 2020/9/1 2:01, Jaegeuk Kim wrote:
> Hi Chao,
> 
> Applied. Thanks.
> 
> On 08/31, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> I've changed code a bit to fix some bugs, including:
>> - gc_idle = 3 (GC_IDLE_AT) description
>> - disallow set gc_idle to 3 if atgc is off
>> - keep compatibility with checkpoint disabling
>>
>> Could you please check and merge below diff?
>>
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   Documentation/ABI/testing/sysfs-fs-f2fs |  3 ++-
>>   fs/f2fs/gc.c                            | 12 +++++++++++-
>>   fs/f2fs/sysfs.c                         | 11 ++++++++---
>>   3 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>> index 7f730c4c8df2..834d0becae6d 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>> @@ -22,7 +22,8 @@ Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
>>   Description:	Controls the victim selection policy for garbage collection.
>>   		Setting gc_idle = 0(default) will disable this option. Setting
>>   		gc_idle = 1 will select the Cost Benefit approach & setting
>> -		gc_idle = 2 will select the greedy approach.
>> +		gc_idle = 2 will select the greedy approach & setting
>> +		gc_idle = 3 will select the age-threshold based approach.
>>
>>   What:		/sys/fs/f2fs/<disk>/reclaim_segments
>>   Date:		October 2013
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 6413886e52d4..3c0edb8b4cc5 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -388,6 +388,16 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
>>   	unsigned long long mtime = 0;
>>   	unsigned int i;
>>
>> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
>> +		if (p->gc_mode == GC_AT &&
>> +			get_valid_blocks(sbi, segno, true) == 0)
>> +			return;
>> +
>> +		if (p->alloc_mode == AT_SSR &&
>> +			get_seg_entry(sbi, segno)->ckpt_valid_blocks == 0)
>> +			return;
>> +	}
>> +
>>   	for (i = 0; i < sbi->segs_per_sec; i++)
>>   		mtime += get_seg_entry(sbi, start + i)->mtime;
>>   	mtime = div_u64(mtime, sbi->segs_per_sec);
>> @@ -721,7 +731,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>>   		/* Don't touch checkpointed data */
>>   		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
>>   					get_ckpt_valid_blocks(sbi, segno) &&
>> -					p.alloc_mode != SSR))
>> +					p.alloc_mode == LFS))
>>   			goto next;
>>   		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
>>   			goto next;
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index 88ed9969cc86..bacfa9c35e6b 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -375,12 +375,17 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>   		return count;
>>   	}
>>   	if (!strcmp(a->attr.name, "gc_idle")) {
>> -		if (t == GC_IDLE_CB)
>> +		if (t == GC_IDLE_CB) {
>>   			sbi->gc_mode = GC_IDLE_CB;
>> -		else if (t == GC_IDLE_GREEDY)
>> +		} else if (t == GC_IDLE_GREEDY) {
>>   			sbi->gc_mode = GC_IDLE_GREEDY;
>> -		else
>> +		} else if (t == GC_IDLE_AT) {
>> +			if (!sbi->am.atgc_enabled)
>> +				return -EINVAL;
>> +			sbi->gc_mode = GC_AT;
>> +		} else {
>>   			sbi->gc_mode = GC_NORMAL;
>> +		}
>>   		return count;
>>   	}
>>
>> -- 
>> 2.26.2
>>
> .
> 
