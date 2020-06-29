Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A07C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D6DE206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593458126;
	bh=W1dt6kfSnOHTFoS6K7XMXEcOthu54wUoE2DzEwzuUCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xnDiIge6iNaPguA8l0EPDkW3dnRbL5fAUGgYA/iXUOTCgRV1P3ULyF33rggOVn4yK
	 W8JVXdfeP9Mbvzrg3qzQhUf8cDQcQ4rPtjsHPxiOyVHElBOO4935GZuD0EIito68Fq
	 bgyFXO9zEAm0hbT9dco8t3caJOT8sfoJXq3/S7hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgF2TPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730567AbgF2TPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:15:15 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F64725584;
        Mon, 29 Jun 2020 16:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446976;
        bh=W1dt6kfSnOHTFoS6K7XMXEcOthu54wUoE2DzEwzuUCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxrwItvubx0lq7oIN/a7Rq7cYTKxXqo5fqEXmzLXWogl6W9oG5klLLotwLjdgv5qS
         FznAmT3k1zilakXVbzMjT06uJ/5FUDaZP0tOZISIIzbPdUqTOv1cMt6ZcC9CmRUWM1
         mdSdiiHj2iIeTTYSOT2dPyZiv32d6Hv2i0vDArdo=
Date:   Mon, 29 Jun 2020 09:09:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid readahead race condition
Message-ID: <20200629160934.GA1752982@gmail.com>
References: <20200624012148.180050-1-jaegeuk@kernel.org>
 <20200629150323.GA3293033@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629150323.GA3293033@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 08:03:23AM -0700, Jaegeuk Kim wrote:
> If two readahead threads having same offset enter in readpages, every read
> IOs are split and issued to the disk which giving lower bandwidth.
> 
> This patch tries to avoid redundant readahead calls.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v2:
>  - add missing code to bypass read
> 
>  fs/f2fs/data.c  | 18 +++++++++++++++++-
>  fs/f2fs/f2fs.h  |  1 +
>  fs/f2fs/super.c |  2 ++
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d6094b9f3916..9b69a159cc6c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2403,6 +2403,7 @@ int f2fs_mpage_readpages(struct address_space *mapping,
>  #endif
>  	unsigned max_nr_pages = nr_pages;
>  	int ret = 0;
> +	bool drop_ra = false;
>  
>  	map.m_pblk = 0;
>  	map.m_lblk = 0;
> @@ -2413,13 +2414,25 @@ int f2fs_mpage_readpages(struct address_space *mapping,
>  	map.m_seg_type = NO_CHECK_TYPE;
>  	map.m_may_create = false;
>  
> +	/*
> +	 * Two readahead threads for same address range can cause race condition
> +	 * which fragments sequential read IOs. So let's avoid each other.
> +	 */
> +	if (pages && is_readahead) {
> +		page = list_last_entry(pages, struct page, lru);
> +		if (F2FS_I(inode)->ra_offset == page_index(page))
> +			drop_ra = true;
> +		else
> +			F2FS_I(inode)->ra_offset = page_index(page);
> +	}

This is a data race because ra_offset can be read/written by different threads
concurrently.

It either needs locking, or READ_ONCE() and WRITE_ONCE() if races are okay.

- Eric
