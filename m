Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A43C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BD220716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgC1Ii5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:38:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51390 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbgC1Ii5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:38:57 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5A3213A18FC3287734DC;
        Sat, 28 Mar 2020 16:38:30 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 28 Mar
 2020 16:38:28 +0800
Subject: Re: [PATCH 3/3] f2fs: fix to check f2fs_compressed_file() in
 f2fs_bmap()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200327102953.104035-1-yuchao0@huawei.com>
 <20200327102953.104035-3-yuchao0@huawei.com>
 <20200327193233.GB186975@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a363b4e4-0f41-6608-b27f-ad26b8f78555@huawei.com>
Date:   Sat, 28 Mar 2020 16:38:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200327193233.GB186975@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/28 3:32, Jaegeuk Kim wrote:
> On 03/27, Chao Yu wrote:
>> Otherwise, for compressed inode, returned physical block address
>> may be wrong.
> 
> We can use bmap to check the allocated (non)compressed blocks.

Sure, I've updated it in v2.

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/data.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 24643680489b..f22f3ba10a48 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -3591,6 +3591,8 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
>>  
>>  	if (f2fs_has_inline_data(inode))
>>  		return 0;
>> +	if (f2fs_compressed_file(inode))
>> +		return 0;
>>  
>>  	/* make sure allocating whole blocks */
>>  	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
>> -- 
>> 2.18.0.rc1
> .
> 
