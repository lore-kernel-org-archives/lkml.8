Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430A7C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB70217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCCBvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:51:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726816AbgCCBu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:50:59 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D4F04A19C6B7C1797461;
        Tue,  3 Mar 2020 09:50:57 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 3 Mar 2020
 09:50:53 +0800
Subject: Re: [PATCH] f2fs: compress: support zstd compress algorithm
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200228111456.11311-1-yuchao0@huawei.com>
 <20200302175014.GA98133@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <efce624c-1247-4519-576b-fd60c0a03cb0@huawei.com>
Date:   Tue, 3 Mar 2020 09:50:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200302175014.GA98133@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/3 1:50, Eric Biggers wrote:
> On Fri, Feb 28, 2020 at 07:14:56PM +0800, Chao Yu wrote:
>> Add zstd compress algorithm support, use "compress_algorithm=zstd"
>> mountoption to enable it.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  Documentation/filesystems/f2fs.txt |   4 +-
>>  fs/f2fs/Kconfig                    |   9 ++
>>  fs/f2fs/compress.c                 | 151 +++++++++++++++++++++++++++++
>>  fs/f2fs/f2fs.h                     |   2 +
>>  fs/f2fs/super.c                    |   7 ++
>>  include/trace/events/f2fs.h        |   3 +-
>>  6 files changed, 173 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
>> index 4eb3e2ddd00e..b1a66cf0e967 100644
>> --- a/Documentation/filesystems/f2fs.txt
>> +++ b/Documentation/filesystems/f2fs.txt
>> @@ -235,8 +235,8 @@ checkpoint=%s[:%u[%]]     Set to "disable" to turn off checkpointing. Set to "en
>>                         hide up to all remaining free space. The actual space that
>>                         would be unusable can be viewed at /sys/fs/f2fs/<disk>/unusable
>>                         This space is reclaimed once checkpoint=enable.
>> -compress_algorithm=%s  Control compress algorithm, currently f2fs supports "lzo"
>> -                       and "lz4" algorithm.
>> +compress_algorithm=%s  Control compress algorithm, currently f2fs supports "lzo",
>> +                       "lz4" and "zstd" algorithm.
>>  compress_log_size=%u   Support configuring compress cluster size, the size will
>>                         be 4KB * (1 << %u), 16KB is minimum size, also it's
>>                         default size.
>> diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
>> index f0faada30f30..bb68d21e1f8c 100644
>> --- a/fs/f2fs/Kconfig
>> +++ b/fs/f2fs/Kconfig
>> @@ -118,3 +118,12 @@ config F2FS_FS_LZ4
>>  	default y
>>  	help
>>  	  Support LZ4 compress algorithm, if unsure, say Y.
>> +
>> +config F2FS_FS_ZSTD
>> +	bool "ZSTD compression support"
>> +	depends on F2FS_FS_COMPRESSION
>> +	select ZSTD_COMPRESS
>> +	select ZSTD_DECOMPRESS
>> +	default y
>> +	help
>> +	  Support ZSTD compress algorithm, if unsure, say Y.
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index bd3ea01db448..c8e1175eaf4e 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/backing-dev.h>
>>  #include <linux/lzo.h>
>>  #include <linux/lz4.h>
>> +#include <linux/zstd.h>
>>  
>>  #include "f2fs.h"
>>  #include "node.h"
>> @@ -291,6 +292,151 @@ static const struct f2fs_compress_ops f2fs_lz4_ops = {
>>  };
>>  #endif
>>  
>> +#ifdef CONFIG_F2FS_FS_ZSTD
>> +#define F2FS_ZSTD_DEFAULT_CLEVEL	1
>> +
>> +static int zstd_init_compress_ctx(struct compress_ctx *cc)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void zstd_destroy_compress_ctx(struct compress_ctx *cc)
>> +{
>> +}
>> +
>> +static int zstd_compress_pages(struct compress_ctx *cc)
>> +{
>> +	ZSTD_parameters params;
>> +	ZSTD_CStream *stream;
>> +	ZSTD_inBuffer inbuf;
>> +	ZSTD_outBuffer outbuf;
>> +	void *workspace;
>> +	unsigned int workspace_size;
>> +	int src_size = cc->rlen;
>> +	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
>> +	int ret;
>> +
>> +	params = ZSTD_getParams(F2FS_ZSTD_DEFAULT_CLEVEL, src_size, 0);
>> +	workspace_size = ZSTD_CStreamWorkspaceBound(params.cParams);
>> +
>> +	workspace = f2fs_kvmalloc(F2FS_I_SB(cc->inode),
>> +					workspace_size, GFP_NOFS);
>> +	if (!workspace)
>> +		return -ENOMEM;
>> +
>> +	stream = ZSTD_initCStream(params, 0,
>> +					workspace, workspace_size);
> 
> Why is this allocating the memory for every compression operation, instead of
> ahead of time in ->init_compress_ctx()?

Actually, zstd decompression flow needs workspace like its compression flow,
however I realized that we don't have related callback interfaces in decompress
path, so I just add all steps of {,de}compression into .{,de}compress_pages()
functions.

In order to not break callback function fwk of compression, how about adding
{init,destroy}_decompress_ctx() callback interfaces, and relocating
initialization and destroy step into correct callback functions?

Thanks,

> 
> - Eric
> .
> 
