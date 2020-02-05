Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CE5C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 01:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566D6217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 01:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBEBjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 20:39:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:53032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727674AbgBEBjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 20:39:53 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E418031958F4B04BFA3;
        Wed,  5 Feb 2020 09:39:50 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 5 Feb 2020
 09:39:48 +0800
Subject: Re: [PATCH] f2fs: fix to force keeping write barrier for strict fsync
 mode
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200120100045.70210-1-yuchao0@huawei.com>
 <20200123221855.GA7917@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0d3f284a-5b98-3d6f-cc9f-47431053f42c@huawei.com>
Date:   Wed, 5 Feb 2020 09:39:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200123221855.GA7917@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/24 6:18, Jaegeuk Kim wrote:
> On 01/20, Chao Yu wrote:
>> If barrier is enabled, for strict fsync mode, we should force to
>> use atomic write semantics to avoid data corruption due to no
>> barrier support in lower device.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/file.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 86ddbb55d2b1..c9dd45f82fbd 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -241,6 +241,13 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>  	};
>>  	unsigned int seq_id = 0;
>>  
>> +	/*
>> +	 * for strict fsync mode, force to keep atomic write sematics to avoid
>> +	 * data corruption if lower device doesn't support write barrier.
>> +	 */
>> +	if (!atomic && F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
>> +		atomic = true;
> 
> This allows to relax IO ordering and cache flush. I'm not sure that's what you
> want to do here for strict mode.

I intend to solve potential data corruption mentioned in below report:

https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15126.html

It occurs in this scenario:

- write page #0; persist
- overwrite page #0
- fsync
 - write data page #0 OPU into device's cache
 - write inode page into device's cache
 - issue flush

If SPO is triggered during flush command, inode page can be persisted before data
page #0, so that after recovery, inode page can be recovered with new physical block
address of data page #0, however there may contains dummy data in new physical block
address.

So what user see is after overwrite & fsync + SPO, old data in file was corrupted, if
any user do care about such case, we can enhance to avoid the corruption in strict mode
and suggest user to use fsync's strict mode.

Thoughts?

Thanks,

> 
>> +
>>  	if (unlikely(f2fs_readonly(inode->i_sb) ||
>>  				is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>>  		return 0;
>> -- 
>> 2.18.0.rc1
> .
> 
