Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2292C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AC820731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEHCsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:48:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbgEHCsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:48:47 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BB8E9EE6DD3E7ED40AE4;
        Fri,  8 May 2020 10:48:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 8 May 2020
 10:48:40 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix zstd data corruption
To:     Daeho Jeong <daeho43@gmail.com>
CC:     <jaegeuk@kernel.org>, Daeho Jeong <daehojeong@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200508011603.54553-1-yuchao0@huawei.com>
 <CACOAw_xxS_Wf==KnD31f9AOMu+QUs3WacowsfcD6w4A9n2AkTg@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0d41e29e-c601-e016-e471-aed184ca4a6a@huawei.com>
Date:   Fri, 8 May 2020 10:48:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_xxS_Wf==KnD31f9AOMu+QUs3WacowsfcD6w4A9n2AkTg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daeho,

On 2020/5/8 9:28, Daeho Jeong wrote:
> Hi Chao,
> 
> IIUC, you are trying not to use ZSTD_compressBound() to save the memory
> space. Am I right?
> 
> Then, how about LZ4_compressBound() for LZ4 and lzo1x_worst_compress() for
> LZO?

Oops, it looks those limits were wrongly used...

#define LZ4_COMPRESSBOUND(isize)	(\
	(unsigned int)(isize) > (unsigned int)LZ4_MAX_INPUT_SIZE \
	? 0 \
	: (isize) + ((isize)/255) + 16)

#define lzo1x_worst_compress(x) ((x) + ((x) / 16) + 64 + 3 + 2)

Newly calculated boundary size is larger than target buffer size.

However comments on LZ4_compress_default() said:

...
 * @maxOutputSize: full or partial size of buffer 'dest'
 *	which must be already allocated
...
int LZ4_compress_default(const char *source, char *dest, int inputSize,
	int maxOutputSize, void *wrkmem);

And @out_len in lzo1x_1_compress() was passed as an output parameter to
pass length of data that compressor compressed into @out buffer.

Let me know if I missed sth.

Thannks,

> Could we save more memory space for these two cases like ZSTD?
> As you know, we are using 5 pages compression buffer for LZ4 and LZO in
> compress_log_size=2,
> and if the compressed data doesn't fit in 3 pages, it returns -EAGAIN to
> give up compressing that one.
> 
> Thanks,
> 
> 2020년 5월 8일 (금) 오전 10:17, Chao Yu <yuchao0@huawei.com>님이 작성:
> 
>> During zstd compression, ZSTD_endStream() may return non-zero value
>> because distination buffer is full, but there is still compressed data
>> remained in intermediate buffer, it means that zstd algorithm can not
>> save at last one block space, let's just writeback raw data instead of
>> compressed one, this can fix data corruption when decompressing
>> incomplete stored compression data.
>>
>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/compress.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index c22cc0d37369..5e4947250262 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -358,6 +358,13 @@ static int zstd_compress_pages(struct compress_ctx
>> *cc)
>>                 return -EIO;
>>         }
>>
>> +       /*
>> +        * there is compressed data remained in intermediate buffer due to
>> +        * no more space in cbuf.cdata
>> +        */
>> +       if (ret)
>> +               return -EAGAIN;
>> +
>>         cc->clen = outbuf.pos;
>>         return 0;
>>  }
>> --
>> 2.18.0.rc1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>
> 
