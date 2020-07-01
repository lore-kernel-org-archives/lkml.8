Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A748C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0589C20780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgGACAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:00:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbgGACAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:00:05 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4681418191EF47DAEB71;
        Wed,  1 Jul 2020 10:00:01 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 1 Jul 2020
 09:59:55 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid readahead race condition
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
CC:     <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200624012148.180050-1-jaegeuk@kernel.org>
 <20200629150323.GA3293033@google.com> <20200629202720.GA230664@google.com>
 <20200630204348.GA2504307@ubuntu-s3-xlarge-x86>
 <20200630205635.GB1396584@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <285a4e16-2cbc-d1e9-8464-8a06bacbaaa0@huawei.com>
Date:   Wed, 1 Jul 2020 09:59:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200630205635.GB1396584@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/1 4:56, Jaegeuk Kim wrote:
> On 06/30, Nathan Chancellor wrote:
>> On Mon, Jun 29, 2020 at 01:27:20PM -0700, Jaegeuk Kim wrote:
>>> If two readahead threads having same offset enter in readpages, every read
>>> IOs are split and issued to the disk which giving lower bandwidth.
>>>
>>> This patch tries to avoid redundant readahead calls.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>> v3:
>>>  - use READ|WRITE_ONCE
>>> v2:
>>>   - add missing code to bypass read
>>>  
>>>  fs/f2fs/data.c  | 18 ++++++++++++++++++
>>>  fs/f2fs/f2fs.h  |  1 +
>>>  fs/f2fs/super.c |  2 ++
>>>  3 files changed, 21 insertions(+)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 995cf78b23c5e..360b4c9080d97 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -2296,6 +2296,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
>>>  	unsigned nr_pages = rac ? readahead_count(rac) : 1;
>>>  	unsigned max_nr_pages = nr_pages;
>>>  	int ret = 0;
>>> +	bool drop_ra = false;
>>>  
>>>  	map.m_pblk = 0;
>>>  	map.m_lblk = 0;
>>> @@ -2306,10 +2307,24 @@ static int f2fs_mpage_readpages(struct inode *inode,
>>>  	map.m_seg_type = NO_CHECK_TYPE;
>>>  	map.m_may_create = false;
>>>  
>>> +	/*
>>> +	 * Two readahead threads for same address range can cause race condition
>>> +	 * which fragments sequential read IOs. So let's avoid each other.
>>> +	 */
>>> +	if (rac && readahead_count(rac)) {
>>> +		if (READ_ONCE(F2FS_I(inode)->ra_offset) == readahead_index(rac))
>>> +			drop_ra = true;
>>> +		else
>>> +			WRITE_ONCE(F2FS_I(inode)->ra_offset,
>>> +						readahead_index(rac));
>>> +	}
>>> +
>>>  	for (; nr_pages; nr_pages--) {
>>>  		if (rac) {
>>>  			page = readahead_page(rac);
>>>  			prefetchw(&page->flags);
>>> +			if (drop_ra)
>>> +				goto next_page;
>>
>> When CONFIG_F2FS_FS_COMPRESSION is not set (i.e. x86_64 defconfig +
>> CONFIG_F2FS_FS=y):
>>
>> $ make -skj"$(nproc)" O=out distclean defconfig fs/f2fs/data.o
>> ../fs/f2fs/data.c: In function ‘f2fs_mpage_readpages’:
>> ../fs/f2fs/data.c:2327:5: error: label ‘next_page’ used but not defined
>>  2327 |     goto next_page;
>>       |     ^~~~
>> ...
> 
> Thanks. I pushed the fix for -next.
> https://lore.kernel.org/linux-f2fs-devel/1be18397-7fc6-703e-121b-e210e101357f@infradead.org/T/#t

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> 
>>
>> Cheers,
>> Nathan
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
