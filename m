Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A28C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0603E222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgCKDpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:45:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11625 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727685AbgCKDpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:45:43 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B66BC64527A1541740A0;
        Wed, 11 Mar 2020 11:45:41 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 11 Mar
 2020 11:45:37 +0800
Subject: Re: [PATCH 2/5] f2fs: force compressed data into warm area
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200310125009.12966-1-yuchao0@huawei.com>
 <20200310125009.12966-2-yuchao0@huawei.com>
 <20200310163239.GC240315@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <303612de-fa66-8e8a-0d02-dac322832e46@huawei.com>
Date:   Wed, 11 Mar 2020 11:45:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200310163239.GC240315@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/11 0:32, Jaegeuk Kim wrote:
> On 03/10, Chao Yu wrote:
>> Generally, data shows better continuity in warm data area as its
>> default allocation direction is right, in order to enhance
>> sequential read/write performance of compress inode, let's force
>> compress data into warm area.

It looks cold data's allocation direction is right as well, I missed
to notice that previously due to I tested in small-sized image, and
f2fs_tuning_parameters() enables ALLOC_MODE_REUSE, then cold data
allocation always searchs free segment from segno #0, it breaks
continuity of physical blocks.

> 
> Not quite sure tho, compressed blocks are logically cold, no?

Correct.

Please ignore this patch. :P

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/segment.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 601d67e72c50..ab1bc750712a 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3037,9 +3037,10 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>>  	if (fio->type == DATA) {
>>  		struct inode *inode = fio->page->mapping->host;
>>  
>> -		if (is_cold_data(fio->page) || file_is_cold(inode) ||
>> -				f2fs_compressed_file(inode))
>> +		if (is_cold_data(fio->page) || file_is_cold(inode))
>>  			return CURSEG_COLD_DATA;
>> +		if (f2fs_compressed_file(inode))
>> +			return CURSEG_WARM_DATA;
>>  		if (file_is_hot(inode) ||
>>  				is_inode_flag_set(inode, FI_HOT_DATA) ||
>>  				f2fs_is_atomic_file(inode) ||
>> -- 
>> 2.18.0.rc1
> .
> 
