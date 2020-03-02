Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694B3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE772465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583171418;
	bh=6k85wi2JdoMHglj+WpaRbnb+L0nNsUt9jd/nKM6n8H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MXrDpKbNN5lFr/jpYIaZWdIeRNbYQd2HA15TDEs1zAOcDWNYeFbaImkxs+ku/KaMk
	 nIXVR72224w4pzUGEtQEHW3E7cXPIk84BizPpnecq/jdYTOm8oSMeCgP/O1Tp2/Kk0
	 d8M7Y4QIHHWUd2IaFP1o+/syNhX/+vJm9T1dWh+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgCBRuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgCBRuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:50:16 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB0DE214DB;
        Mon,  2 Mar 2020 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583171416;
        bh=6k85wi2JdoMHglj+WpaRbnb+L0nNsUt9jd/nKM6n8H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAx9vtyE2Nf9ytTuEaFKQIrVapER7/q84E+ugRqoRoWvIpNsZGCEN/5TR9LsKwUgQ
         vpH19g2uv2ZFc40IwwJ6E4PxKM4ABmefg98Xf3Ve9EXrT6V4iVSNR98TUTPxok+X0s
         sUGDcJfYg0F/LmQhiSw4ev4u+c9jyxx8GkU4FTZk=
Date:   Mon, 2 Mar 2020 09:50:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: compress: support zstd compress algorithm
Message-ID: <20200302175014.GA98133@gmail.com>
References: <20200228111456.11311-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228111456.11311-1-yuchao0@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 07:14:56PM +0800, Chao Yu wrote:
> Add zstd compress algorithm support, use "compress_algorithm=zstd"
> mountoption to enable it.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  Documentation/filesystems/f2fs.txt |   4 +-
>  fs/f2fs/Kconfig                    |   9 ++
>  fs/f2fs/compress.c                 | 151 +++++++++++++++++++++++++++++
>  fs/f2fs/f2fs.h                     |   2 +
>  fs/f2fs/super.c                    |   7 ++
>  include/trace/events/f2fs.h        |   3 +-
>  6 files changed, 173 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index 4eb3e2ddd00e..b1a66cf0e967 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -235,8 +235,8 @@ checkpoint=%s[:%u[%]]     Set to "disable" to turn off checkpointing. Set to "en
>                         hide up to all remaining free space. The actual space that
>                         would be unusable can be viewed at /sys/fs/f2fs/<disk>/unusable
>                         This space is reclaimed once checkpoint=enable.
> -compress_algorithm=%s  Control compress algorithm, currently f2fs supports "lzo"
> -                       and "lz4" algorithm.
> +compress_algorithm=%s  Control compress algorithm, currently f2fs supports "lzo",
> +                       "lz4" and "zstd" algorithm.
>  compress_log_size=%u   Support configuring compress cluster size, the size will
>                         be 4KB * (1 << %u), 16KB is minimum size, also it's
>                         default size.
> diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
> index f0faada30f30..bb68d21e1f8c 100644
> --- a/fs/f2fs/Kconfig
> +++ b/fs/f2fs/Kconfig
> @@ -118,3 +118,12 @@ config F2FS_FS_LZ4
>  	default y
>  	help
>  	  Support LZ4 compress algorithm, if unsure, say Y.
> +
> +config F2FS_FS_ZSTD
> +	bool "ZSTD compression support"
> +	depends on F2FS_FS_COMPRESSION
> +	select ZSTD_COMPRESS
> +	select ZSTD_DECOMPRESS
> +	default y
> +	help
> +	  Support ZSTD compress algorithm, if unsure, say Y.
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index bd3ea01db448..c8e1175eaf4e 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -11,6 +11,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/lzo.h>
>  #include <linux/lz4.h>
> +#include <linux/zstd.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> @@ -291,6 +292,151 @@ static const struct f2fs_compress_ops f2fs_lz4_ops = {
>  };
>  #endif
>  
> +#ifdef CONFIG_F2FS_FS_ZSTD
> +#define F2FS_ZSTD_DEFAULT_CLEVEL	1
> +
> +static int zstd_init_compress_ctx(struct compress_ctx *cc)
> +{
> +	return 0;
> +}
> +
> +static void zstd_destroy_compress_ctx(struct compress_ctx *cc)
> +{
> +}
> +
> +static int zstd_compress_pages(struct compress_ctx *cc)
> +{
> +	ZSTD_parameters params;
> +	ZSTD_CStream *stream;
> +	ZSTD_inBuffer inbuf;
> +	ZSTD_outBuffer outbuf;
> +	void *workspace;
> +	unsigned int workspace_size;
> +	int src_size = cc->rlen;
> +	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> +	int ret;
> +
> +	params = ZSTD_getParams(F2FS_ZSTD_DEFAULT_CLEVEL, src_size, 0);
> +	workspace_size = ZSTD_CStreamWorkspaceBound(params.cParams);
> +
> +	workspace = f2fs_kvmalloc(F2FS_I_SB(cc->inode),
> +					workspace_size, GFP_NOFS);
> +	if (!workspace)
> +		return -ENOMEM;
> +
> +	stream = ZSTD_initCStream(params, 0,
> +					workspace, workspace_size);

Why is this allocating the memory for every compression operation, instead of
ahead of time in ->init_compress_ctx()?

- Eric
