Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C95EC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 493732068E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgEGDDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:03:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbgEGDDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:03:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0FB04998E81665E6A654;
        Thu,  7 May 2020 11:03:30 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 7 May 2020
 11:03:28 +0800
Subject: Re: [PATCH v2] f2fs: shrink spinlock coverage
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200506104542.123575-1-yuchao0@huawei.com>
 <20200506150521.GE107238@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f577a7a8-298f-cdda-7627-1273f83c261c@huawei.com>
Date:   Thu, 7 May 2020 11:03:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200506150521.GE107238@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/6 23:05, Jaegeuk Kim wrote:
> On 05/06, Chao Yu wrote:
>> In f2fs_try_to_free_nids(), .nid_list_lock spinlock critical region will
>> increase as expected shrink number increase, to avoid spining other CPUs
>> for long time, it's better to implement like extent cache and nats
>> shrinker.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2:
>> - fix unlock wrong spinlock.
>>  fs/f2fs/node.c | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 4da0d8713df5..ad0b14f4dab8 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -2488,7 +2488,6 @@ void f2fs_alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
>>  int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
>>  {
>>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>> -	struct free_nid *i, *next;
>>  	int nr = nr_shrink;
>>  
>>  	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
>> @@ -2498,14 +2497,22 @@ int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
>>  		return 0;
>>  
>>  	spin_lock(&nm_i->nid_list_lock);
>> -	list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
>> -		if (nr_shrink <= 0 ||
>> -				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
>> +	while (nr_shrink) {
>> +		struct free_nid *i;
>> +
>> +		if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
>>  			break;
>>  
>> +		i = list_first_entry(&nm_i->free_nid_list,
>> +					struct free_nid, list);
>> +		list_del(&i->list);
>> +		spin_unlock(&nm_i->nid_list_lock);
>> +
>>  		__remove_free_nid(sbi, i, FREE_NID);
> 
> __remove_free_nid() will do list_del again. btw, how about just splitting out

Oh, my bad.

How about moving __remove_free_nid into .nid_list_lock coverage?

> given nr_shrink into multiple trials?

Like this?

	while (shrink) {
		batch = DEFAULT_BATCH_NUMBER; // 16
		spinlock();
		list_for_each_entry_safe() {
			if (!shrink || !batch)
				break;
			remove_item_from_list;
			shrink--;
			batch--;
		}
		spin_unlock();
	}

Thanks,

> 
>>  		kmem_cache_free(free_nid_slab, i);
>>  		nr_shrink--;
>> +
>> +		spin_lock(&nm_i->nid_list_lock);
>>  	}
>>  	spin_unlock(&nm_i->nid_list_lock);
>>  	mutex_unlock(&nm_i->build_lock);
>> -- 
>> 2.18.0.rc1
> .
> 
