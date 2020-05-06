Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7275C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA119206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgEFHpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:45:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3813 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728301AbgEFHpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:45:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D4F1DBA18A7654661CE1;
        Wed,  6 May 2020 15:45:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 6 May 2020
 15:45:43 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: change maximum zstd compression buffer
 size
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200504143039.155644-1-jaegeuk@kernel.org>
 <7177aab9-630e-e077-7005-0023c93134b3@kernel.org>
 <20200505230559.GA203407@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9aaeac5e-4511-5c81-653c-23a85b3c335a@huawei.com>
Date:   Wed, 6 May 2020 15:45:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200505230559.GA203407@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/6 7:05, Jaegeuk Kim wrote:
> On 05/05, Chao Yu wrote:
>> On 2020-5-4 22:30, Jaegeuk Kim wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> Current zstd compression buffer size is one page and header size less
>>> than cluster size. By this, zstd compression always succeeds even if
>>> the real compression data is failed to fit into the buffer size, and
>>> eventually reading the cluster returns I/O error with the corrupted
>>> compression data.
>>
>> What's the root cause of this issue? I didn't get it.
>>
>>>
>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> ---
>>>  fs/f2fs/compress.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>>> index 4c7eaeee52336..a9fa8049b295f 100644
>>> --- a/fs/f2fs/compress.c
>>> +++ b/fs/f2fs/compress.c
>>> @@ -313,7 +313,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
>>>  	cc->private = workspace;
>>>  	cc->private2 = stream;
>>>
>>> -	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
>>> +	cc->clen = ZSTD_compressBound(PAGE_SIZE << cc->log_cluster_size);
>>
>> In my machine, the value is 66572 which is much larger than size of dst
>> buffer, so, in where we can tell the real size of dst buffer to zstd
>> compressor? Otherwise, if compressed data size is larger than dst buffer
>> size, when we flush compressed data into dst buffer, we may suffer overflow.
> 
> Could you give it a try compress_log_size=2 and check decompression works?

I tried some samples before submitting the patch, did you encounter app's data
corruption when using zstd algorithm? If so, let me check this issue.

Thanks,

> 
>>
>>>  	return 0;
>>>  }
>>>
>>> @@ -330,7 +330,7 @@ static int zstd_compress_pages(struct compress_ctx *cc)
>>>  	ZSTD_inBuffer inbuf;
>>>  	ZSTD_outBuffer outbuf;
>>>  	int src_size = cc->rlen;
>>> -	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
>>> +	int dst_size = cc->clen;
>>>  	int ret;
>>>
>>>  	inbuf.pos = 0;
>>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
