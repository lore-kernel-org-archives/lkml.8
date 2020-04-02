Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0490C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0602072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgDBJOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:14:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729033AbgDBJOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:14:31 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DD45955660C927AEE8D0;
        Thu,  2 Apr 2020 17:14:24 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 17:14:15 +0800
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: remove set but not used variable
 'params'
To:     Chao Yu <yuchao0@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20200402061545.23208-1-yanaijie@huawei.com>
 <6170e88e-5242-30dd-f624-1171aaa994de@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <ab642c5a-9b43-cad2-27d2-f98d3dca9529@huawei.com>
Date:   Thu, 2 Apr 2020 17:14:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <6170e88e-5242-30dd-f624-1171aaa994de@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

在 2020/4/2 16:37, Chao Yu 写道:
> Hi Jason,
> 
> On 2020/4/2 14:15, Jason Yan wrote:
>> Fix the following gcc warning:
>>
>> fs/f2fs/compress.c:375:18: warning: variable 'params' set but not used [-Wunused-but-set-variable]
>>    ZSTD_parameters params;
>>                    ^~~~~~
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> Thanks for the patch, would you mind that just merge this fix into
> original path which is still in f2fs private git tree?
> 

It's ok to merge this into the original patch.

> Thanks,
> 
>> ---
>>   fs/f2fs/compress.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index f05ecf4cb899..df7b2d15eacd 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -372,12 +372,10 @@ static int zstd_compress_pages(struct compress_ctx *cc)
>>   
>>   static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
>>   {
>> -	ZSTD_parameters params;
>>   	ZSTD_DStream *stream;
>>   	void *workspace;
>>   	unsigned int workspace_size;
>>   
>> -	params = ZSTD_getParams(F2FS_ZSTD_DEFAULT_CLEVEL, dic->clen, 0);
>>   	workspace_size = ZSTD_DStreamWorkspaceBound(MAX_COMPRESS_WINDOW_SIZE);
>>   
>>   	workspace = f2fs_kvmalloc(F2FS_I_SB(dic->inode),
>>
> 
> .
> 

