Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03096C3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF9120705
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588644526;
	bh=WA4NF4Zrsn/AZscHkiK0AuxGMzZiCnAsbzhY8KUi4w0=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=fFbp644ZHKBsy7Rk7kCxjk5wTGx17Trb/wVbdwkzCYZ+SexH+GLXR2KGrYfmauESU
	 dwBmhKTtlkL0X8uDxG+Ty5Fl2R7LaQBOdDvZW1CuUxRHx4AAU+yMRE3hXwmvekHcxE
	 k21fIjnU9ZlyTJ6g5k+4fv+zSo0vmfnM1fbsLmYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgEECIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 22:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgEECIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 22:08:45 -0400
Received: from [192.168.0.107] (unknown [58.213.210.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F2F206D7;
        Tue,  5 May 2020 02:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588644525;
        bh=WA4NF4Zrsn/AZscHkiK0AuxGMzZiCnAsbzhY8KUi4w0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=fMN8n8tRQXf1Xn4ZeO8JjyvlKub1XKr/IMBo7ozbkZDKaAMKH29LkrAWe0quuLyIM
         Orp6jaTKVFgbxlOCLm+liNy9gek39BAcEW2E82h3Cjj7RJYcH0NiWAw8jLZFDuGtQK
         qtMDBUCKIlx0o3D2eh15JtbooNKPgRjm4TWNW7I0=
Subject: Re: [f2fs-dev] [PATCH] f2fs: change maximum zstd compression buffer
 size
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20200504143039.155644-1-jaegeuk@kernel.org>
 <7177aab9-630e-e077-7005-0023c93134b3@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5dadaf04-ef9e-f6a8-c132-8fa072e8e6fe@kernel.org>
Date:   Tue, 5 May 2020 10:08:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <7177aab9-630e-e077-7005-0023c93134b3@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-5-5 9:52, Chao Yu wrote:
> On 2020-5-4 22:30, Jaegeuk Kim wrote:
>> From: Daeho Jeong <daehojeong@google.com>
>>
>> Current zstd compression buffer size is one page and header size less
>> than cluster size. By this, zstd compression always succeeds even if
>> the real compression data is failed to fit into the buffer size, and
>> eventually reading the cluster returns I/O error with the corrupted
>> compression data.
>
> What's the root cause of this issue? I didn't get it.
>
>>
>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>> ---
>>  fs/f2fs/compress.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index 4c7eaeee52336..a9fa8049b295f 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -313,7 +313,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
>>      cc->private = workspace;
>>      cc->private2 = stream;
>>
>> -    cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
>> +    cc->clen = ZSTD_compressBound(PAGE_SIZE << cc->log_cluster_size);

Max size of intermediate buffer has been set as below?

- zstd_init_compress_ctx
  - params = ZSTD_getParams(F2FS_ZSTD_DEFAULT_CLEVEL, cc->rlen, 0)
  - ZSTD_CStreamWorkspaceBound(params.cParams)
   - outBuffSize = ZSTD_compressBound(blockSize) + 1;
   - workspace_size = ... + outBuffSize + ...
  - workspace = f2fs_kvmalloc(workspace_size)

>
> In my machine, the value is 66572 which is much larger than size of dst buffer,
> so, in where we can tell the real size of dst buffer to zstd compressor?
> Otherwise, if compressed data size is larger than dst buffer size, when we flush
> compressed data into dst buffer, we may suffer overflow.
>
>>      return 0;
>>  }
>>
>> @@ -330,7 +330,7 @@ static int zstd_compress_pages(struct compress_ctx *cc)
>>      ZSTD_inBuffer inbuf;
>>      ZSTD_outBuffer outbuf;
>>      int src_size = cc->rlen;
>> -    int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
>> +    int dst_size = cc->clen;
>>      int ret;
>>
>>      inbuf.pos = 0;
>>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
