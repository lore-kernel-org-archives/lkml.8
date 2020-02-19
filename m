Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5880C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6F62176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgBSDNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:13:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728219AbgBSDNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:13:00 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B6A5C55E6B2C8D28D29B;
        Wed, 19 Feb 2020 11:12:58 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Feb
 2020 11:12:53 +0800
Subject: Re: [PATCH 1/3] f2fs: avoid __GFP_NOFAIL in f2fs_bio_alloc
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200218102136.32150-1-yuchao0@huawei.com>
 <20200219024928.GA96609@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <52705a9b-306b-c6b0-0f48-c12149e7b915@huawei.com>
Date:   Wed, 19 Feb 2020 11:12:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200219024928.GA96609@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/19 10:49, Jaegeuk Kim wrote:
> On 02/18, Chao Yu wrote:
>> __f2fs_bio_alloc() won't fail due to memory pool backend, remove unneeded
>> __GFP_NOFAIL flag in __f2fs_bio_alloc().
> 
> It it safe for old kernels as well when thinking backports?

^1da177e4c3f4 (Linus Torvalds     2005-04-16 15:20:36 -0700  134)       struct bio *bio = mempool_alloc(bs->bio_pool, gfp_mask);

It looks if we have a backend mempool, we will never fail to allocate bio
for very long time, we don't need to backport to 2.6.x kernel, right?

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/data.c | 12 ++++--------
>>  fs/f2fs/f2fs.h |  2 +-
>>  2 files changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index baf12318ec64..3a4ece26928c 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -54,17 +54,13 @@ static inline struct bio *__f2fs_bio_alloc(gfp_t gfp_mask,
>>  	return bio_alloc_bioset(gfp_mask, nr_iovecs, &f2fs_bioset);
>>  }
>>  
>> -struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool no_fail)
>> +struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool noio)
>>  {
>> -	struct bio *bio;
>> -
>> -	if (no_fail) {
>> +	if (noio) {
>>  		/* No failure on bio allocation */
>> -		bio = __f2fs_bio_alloc(GFP_NOIO, npages);
>> -		if (!bio)
>> -			bio = __f2fs_bio_alloc(GFP_NOIO | __GFP_NOFAIL, npages);
>> -		return bio;
>> +		return __f2fs_bio_alloc(GFP_NOIO, npages);
>>  	}
>> +
>>  	if (time_to_inject(sbi, FAULT_ALLOC_BIO)) {
>>  		f2fs_show_injection_info(sbi, FAULT_ALLOC_BIO);
>>  		return NULL;
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 5316ac3eacdf..65f569949d42 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -3343,7 +3343,7 @@ void f2fs_destroy_checkpoint_caches(void);
>>   */
>>  int __init f2fs_init_bioset(void);
>>  void f2fs_destroy_bioset(void);
>> -struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool no_fail);
>> +struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool noio);
>>  int f2fs_init_bio_entry_cache(void);
>>  void f2fs_destroy_bio_entry_cache(void);
>>  void f2fs_submit_bio(struct f2fs_sb_info *sbi,
>> -- 
>> 2.18.0.rc1
> .
> 
