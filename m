Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCC9C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9F020714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgCZJai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:30:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbgCZJah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:30:37 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0D07C7169ACE85BE893B;
        Thu, 26 Mar 2020 17:30:35 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 26 Mar
 2020 17:30:30 +0800
Subject: Re: [PATCH v2 3/5] f2fs: fix to avoid NULL pointer dereference
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200325091811.60725-1-yuchao0@huawei.com>
 <20200325155014.GB65658@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b20a846a-6035-6f5e-72a9-adb1b5399bbd@huawei.com>
Date:   Thu, 26 Mar 2020 17:30:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200325155014.GB65658@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

I've made that diff as a patch and changed title and commit message a
bit, let's merge the new one.

Thanks,

On 2020/3/25 23:50, Jaegeuk Kim wrote:
> Hi Chao,
> 
> I don't want to rebase old commit at this moment, so applied on top of the tree.
> 
> Thanks,
> 
> On 03/25, Chao Yu wrote:
>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> PC is at f2fs_free_dic+0x60/0x2c8
>> LR is at f2fs_decompress_pages+0x3c4/0x3e8
>> f2fs_free_dic+0x60/0x2c8
>> f2fs_decompress_pages+0x3c4/0x3e8
>> __read_end_io+0x78/0x19c
>> f2fs_post_read_work+0x6c/0x94
>> process_one_work+0x210/0x48c
>> worker_thread+0x2e8/0x44c
>> kthread+0x110/0x120
>> ret_from_fork+0x10/0x18
>>
>> In f2fs_free_dic(), we can not use f2fs_put_page(,1) to release dic->tpages[i],
>> as the page's mapping is NULL.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2:
>> - fix to skip release tpages[i] if it is NULL in error path.
>>  fs/f2fs/compress.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index ef7dd04312fe..6e10800729b6 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -1137,7 +1137,10 @@ void f2fs_free_dic(struct decompress_io_ctx *dic)
>>  		for (i = 0; i < dic->cluster_size; i++) {
>>  			if (dic->rpages[i])
>>  				continue;
>> -			f2fs_put_page(dic->tpages[i], 1);
>> +			if (!dic->tpages[i])
>> +				continue;
>> +			unlock_page(dic->tpages[i]);
>> +			put_page(dic->tpages[i]);
>>  		}
>>  		kfree(dic->tpages);
>>  	}
>> -- 
>> 2.18.0.rc1
> .
> 
