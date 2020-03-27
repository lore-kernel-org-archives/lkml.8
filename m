Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AF1C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C8B206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585337555;
	bh=wWoAjZwt2nR5X1UPX0ZZp4acCT8N6K2BluWge4uJRGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZJ0Y04B9fseM3C2weuM3JnmpJl4+9CI4D28qDrIJ6aQFwzDvOmhTHTVtiCRHWtSGw
	 /fu8/bWaYnWuOjBZYJnPV8NrFzcSOqhYVo2ZPatxG1jg8LNH1pyxMFfttyI34NX6cc
	 55op1L+nevtfP85SO3fR2Mo/NywVICoxR1TGeE1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgC0Tce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0Tce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 15:32:34 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F43F20575;
        Fri, 27 Mar 2020 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585337553;
        bh=wWoAjZwt2nR5X1UPX0ZZp4acCT8N6K2BluWge4uJRGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZIdX+zVLGrFZGp9dBUOVypptkgXVWdke59yk8jKqMZpdpClIGzxKm2WW990B2Xq3w
         Ycgwyu0RSSByNv0YKGZ2hWNga+DXU4+PwFWzck9gYDldbJWpDsfE1qHVMH/JkWe4Ha
         IniH6OY7izr4MJGs8sp2auOMJRfD+eAD4WKlRqOI=
Date:   Fri, 27 Mar 2020 12:32:33 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 3/3] f2fs: fix to check f2fs_compressed_file() in
 f2fs_bmap()
Message-ID: <20200327193233.GB186975@google.com>
References: <20200327102953.104035-1-yuchao0@huawei.com>
 <20200327102953.104035-3-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327102953.104035-3-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27, Chao Yu wrote:
> Otherwise, for compressed inode, returned physical block address
> may be wrong.

We can use bmap to check the allocated (non)compressed blocks.

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 24643680489b..f22f3ba10a48 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3591,6 +3591,8 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
>  
>  	if (f2fs_has_inline_data(inode))
>  		return 0;
> +	if (f2fs_compressed_file(inode))
> +		return 0;
>  
>  	/* make sure allocating whole blocks */
>  	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> -- 
> 2.18.0.rc1
