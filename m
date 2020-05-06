Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2366EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DFF208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588776971;
	bh=LEE9kaUuq3swcyipv2Z5cVdwEM6Qz9YdRajLpVMAeUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xaUjLLBeALmpRXcWWE4A4dBHTu9f/y5R0nOR4f94+H0fjoDPjoVHGIlFvDT52DtQD
	 7dDJxdLHkDB5Zu+OLdKn6barH/H1odjuyR1NQfJ6JsHH9N0xP9xMpT0mnq0l5G8ODf
	 E7xZynqTOFSbD+BFNdYYIOxo6Xxxd79JO5PtSjtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgEFO4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbgEFO4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:56:09 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B32C208D5;
        Wed,  6 May 2020 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588776969;
        bh=LEE9kaUuq3swcyipv2Z5cVdwEM6Qz9YdRajLpVMAeUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xx0fK9FbNR3TwpC9RsM9U17z+Mt/rhgEorkbaAzNLrrJ5WXebxTK6DxpMb2Sts2Kt
         2WZlLZ3Z4qZT1yyx73AZOjHrvnd1l+JnjbHu8P9OJ7Gz9mYE7Cx8da7oJKDsWObkY/
         Ym2zOZ0YfaUYi7Ja/4gf4WIJLkZzi6HrVMsxYrx0=
Date:   Wed, 6 May 2020 07:56:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: change maximum zstd compression buffer
 size
Message-ID: <20200506145608.GD107238@google.com>
References: <20200504143039.155644-1-jaegeuk@kernel.org>
 <7177aab9-630e-e077-7005-0023c93134b3@kernel.org>
 <20200505230559.GA203407@google.com>
 <9aaeac5e-4511-5c81-653c-23a85b3c335a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aaeac5e-4511-5c81-653c-23a85b3c335a@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06, Chao Yu wrote:
> On 2020/5/6 7:05, Jaegeuk Kim wrote:
> > On 05/05, Chao Yu wrote:
> >> On 2020-5-4 22:30, Jaegeuk Kim wrote:
> >>> From: Daeho Jeong <daehojeong@google.com>
> >>>
> >>> Current zstd compression buffer size is one page and header size less
> >>> than cluster size. By this, zstd compression always succeeds even if
> >>> the real compression data is failed to fit into the buffer size, and
> >>> eventually reading the cluster returns I/O error with the corrupted
> >>> compression data.
> >>
> >> What's the root cause of this issue? I didn't get it.
> >>
> >>>
> >>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>> ---
> >>>  fs/f2fs/compress.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> >>> index 4c7eaeee52336..a9fa8049b295f 100644
> >>> --- a/fs/f2fs/compress.c
> >>> +++ b/fs/f2fs/compress.c
> >>> @@ -313,7 +313,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
> >>>  	cc->private = workspace;
> >>>  	cc->private2 = stream;
> >>>
> >>> -	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> >>> +	cc->clen = ZSTD_compressBound(PAGE_SIZE << cc->log_cluster_size);
> >>
> >> In my machine, the value is 66572 which is much larger than size of dst
> >> buffer, so, in where we can tell the real size of dst buffer to zstd
> >> compressor? Otherwise, if compressed data size is larger than dst buffer
> >> size, when we flush compressed data into dst buffer, we may suffer overflow.
> > 
> > Could you give it a try compress_log_size=2 and check decompression works?
> 
> I tried some samples before submitting the patch, did you encounter app's data
> corruption when using zstd algorithm? If so, let me check this issue.

Daeho reported:
1. cp -a src_file comp_dir/dst_file (comp_dir is a directory for compression)
2. sync comp_dir/dst_file
3. echo 3 > /proc/sys/vm/drop_caches
4. cat comp_dir/dst_file > dump (it returns I/O error depending on the file).

> 
> Thanks,
> 
> > 
> >>
> >>>  	return 0;
> >>>  }
> >>>
> >>> @@ -330,7 +330,7 @@ static int zstd_compress_pages(struct compress_ctx *cc)
> >>>  	ZSTD_inBuffer inbuf;
> >>>  	ZSTD_outBuffer outbuf;
> >>>  	int src_size = cc->rlen;
> >>> -	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> >>> +	int dst_size = cc->clen;
> >>>  	int ret;
> >>>
> >>>  	inbuf.pos = 0;
> >>>
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> > 
