Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597BBC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2053B2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588719961;
	bh=PNbwCvW8rBgUyy4cSZedXBMUal8bA25Ko1sv2PzKrbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xpTog4xOoLPZ06GDn6ny3zF4UeMpfuk/SzQ8GtyJWksiYLQk8TR3nvkK+oKIFibD/
	 B0+8AmpIzdH3Cr9wCvkpWzC+iA81JwkVRpjTJu6tgdbA5Iz01AGZkp7ruwRkFvfRcN
	 1TNwf1fE4M9mTljyIUdbVayAsT+PhHiOy4y/k8sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgEEXGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 19:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbgEEXF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 19:05:59 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E68420658;
        Tue,  5 May 2020 23:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588719959;
        bh=PNbwCvW8rBgUyy4cSZedXBMUal8bA25Ko1sv2PzKrbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o0oW0T0rIrr4DOBGJsvU1rN5sR2bB9IgnwHUf7LfKJ/z/xSNZ0+w60U6Vpoo/IqOK
         srPE+BquCr0CQJNmqk+wni0ty2ZiHPiuBVVAG6hR5nB38Fwl4IYaxL9G79RzMJetLi
         n1BzgsqYqW6MsARJZReLj7yQP+AcaigeH3fnZq7s=
Date:   Tue, 5 May 2020 16:05:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: change maximum zstd compression buffer
 size
Message-ID: <20200505230559.GA203407@google.com>
References: <20200504143039.155644-1-jaegeuk@kernel.org>
 <7177aab9-630e-e077-7005-0023c93134b3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7177aab9-630e-e077-7005-0023c93134b3@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05, Chao Yu wrote:
> On 2020-5-4 22:30, Jaegeuk Kim wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > 
> > Current zstd compression buffer size is one page and header size less
> > than cluster size. By this, zstd compression always succeeds even if
> > the real compression data is failed to fit into the buffer size, and
> > eventually reading the cluster returns I/O error with the corrupted
> > compression data.
> 
> What's the root cause of this issue? I didn't get it.
> 
> > 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/compress.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index 4c7eaeee52336..a9fa8049b295f 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -313,7 +313,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
> >  	cc->private = workspace;
> >  	cc->private2 = stream;
> > 
> > -	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> > +	cc->clen = ZSTD_compressBound(PAGE_SIZE << cc->log_cluster_size);
> 
> In my machine, the value is 66572 which is much larger than size of dst
> buffer, so, in where we can tell the real size of dst buffer to zstd
> compressor? Otherwise, if compressed data size is larger than dst buffer
> size, when we flush compressed data into dst buffer, we may suffer overflow.

Could you give it a try compress_log_size=2 and check decompression works?

> 
> >  	return 0;
> >  }
> > 
> > @@ -330,7 +330,7 @@ static int zstd_compress_pages(struct compress_ctx *cc)
> >  	ZSTD_inBuffer inbuf;
> >  	ZSTD_outBuffer outbuf;
> >  	int src_size = cc->rlen;
> > -	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> > +	int dst_size = cc->clen;
> >  	int ret;
> > 
> >  	inbuf.pos = 0;
> > 
