Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156FAC38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 01:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBCC2192A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 01:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgEIB4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 21:56:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34426 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbgEIB4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 21:56:39 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 198A688844991705F75E;
        Sat,  9 May 2020 09:56:37 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 9 May 2020
 09:56:33 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: allow lz4 to compress data
 partially
To:     Gao Xiang <hsiangkao@aol.com>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <chao@kernel.org>
References: <20200508094709.40048-1-yuchao0@huawei.com>
 <20200508102306.GA18849@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4db0121c-5555-b33d-d727-627ef1640f8d@huawei.com>
Date:   Sat, 9 May 2020 09:56:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200508102306.GA18849@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On 2020/5/8 18:23, Gao Xiang wrote:
> Hi Chao,
> 
> On Fri, May 08, 2020 at 05:47:09PM +0800, Chao Yu wrote:
>> For lz4 worst compress case, caller should allocate buffer with size
>> of LZ4_compressBound(inputsize) for target compressed data storing.
>>
>> However lz4 supports partial data compression, so we can get rid of
>> output buffer size limitation now, then we can avoid 2 * 4KB size
>> intermediate buffer allocation when log_cluster_size is 2, and avoid
>> unnecessary compressing work of compressor if we can not save at
>> least 4KB space.
>>
>> Suggested-by: Daeho Jeong <daehojeong@google.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/compress.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index 5e4947250262..23825f559bcf 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -228,7 +228,12 @@ static int lz4_init_compress_ctx(struct compress_ctx *cc)
>>  	if (!cc->private)
>>  		return -ENOMEM;
>>  
>> -	cc->clen = LZ4_compressBound(PAGE_SIZE << cc->log_cluster_size);
>> +	/*
>> +	 * we do not change cc->clen to LZ4_compressBound(inputsize) to
>> +	 * adapt worst compress case, because lz4 algorithm supports partial
>> +	 * compression.
> 
> Actually, in this case the lz4 compressed block is not valid (at least not ended
> in a valid lz4 EOF), and AFAIK the current public lz4 API cannot keep on
> compressing this block. so IMO "partial compression" for an invalid lz4
> block may be confusing.

Yes, comments could be improved to avoid confusing.

> 
> I think some words like "because lz4 implementation can handle output buffer
> budget properly" or similar stuff could be better.

It's better, let me change to use this, thanks for the advice.

Thanks,

> 
> The same to the patch title and the commit message.
> 
> Thanks,
> Gao Xiang
> 
> 
>> +	 */
>> +	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
>>  	return 0;
>>  }
>>  
>> @@ -244,11 +249,9 @@ static int lz4_compress_pages(struct compress_ctx *cc)
>>  
>>  	len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
>>  						cc->clen, cc->private);
>> -	if (!len) {
>> -		printk_ratelimited("%sF2FS-fs (%s): lz4 compress failed\n",
>> -				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id);
>> -		return -EIO;
>> -	}
>> +	if (!len)
>> +		return -EAGAIN;
>> +
>>  	cc->clen = len;
>>  	return 0;
>>  }
>> -- 
>> 2.18.0.rc1
> .
> 
