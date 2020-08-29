Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F7C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 23:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C512F20825
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 23:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598744668;
	bh=T86btTIeJaz0WbqNY52QJxthzlK/IGB8x+5hfU2xFp8=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:List-ID:From;
	b=KpWFwb9Ghr7qCRWpRTbzvvvpO8nhutU5kLKfCk6AkrUjG++nksk/5g9Fb2622z4Md
	 LkkHTlOBWog88jKrvAotSJ3gtoLyIiOZRfMrp3eBQajofnaBkuA3waUvKG7m0JOxmX
	 3tKpkzqK0jeG+QlwF8QXtMeWHtZEEka0B+EGGK2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgH2Xo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 19:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgH2XoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 19:44:22 -0400
Received: from [192.168.0.108] (unknown [49.65.245.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A889F20776;
        Sat, 29 Aug 2020 23:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598744661;
        bh=T86btTIeJaz0WbqNY52QJxthzlK/IGB8x+5hfU2xFp8=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=zFklHNGvPl0pOPdTnZD3JhNvOL4h4+J49XNOxGF2GJBikhRfXdEW2W4OpoA4TR/xG
         NB3vt3NUBVzHIWKFtPd8F3Ot1VclaeQZT7ofqsEz8ZuppSFOTDZ5u/iGBD6RLTpafH
         xi9N4F8Oddy+Meu4Al3H6+Ngz/h1R1rlG9nOVZHo=
Subject: Re: [f2fs-dev] [PATCH] f2fs: make fibmap consistent with fiemap for
 compression chunk
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20200828034953.354267-1-daeho43@gmail.com>
Cc:     Daeho Jeong <daehojeong@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <44f8d9f3-9438-fdfe-bbc3-f5347a9aaa29@kernel.org>
Date:   Sun, 30 Aug 2020 07:44:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200828034953.354267-1-daeho43@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-8-28 11:49, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
>
> Currently fibmap returns zero address for compression chunk. But it
> is not consistent with the output of fiemap, since fiemap returns
> real pysical block address related to the compression chunk. Therefore
> I suggest fibmap returns the same output with fiemap.

We can return real physical block address in fiemap, because we have set
FIEMAP_EXTENT_ENCODED flag in extent.fe_flags, then user can be noticed that he 
can not just read/write that block address for access/update in-there data.

Quoted from Documentation/filesystems/fiemap.rst
"
FIEMAP_EXTENT_ENCODED
   This extent does not consist of plain filesystem blocks but is
   encoded (e.g. encrypted or compressed).  Reading the data in this
   extent via I/O to the block device will have undefined results.
"

However, there is no such flag in fibmap interface, so I just return block 
address for those logical pages in non-compressed cluster.

Thanks,

>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/data.c | 33 ---------------------------------
>  1 file changed, 33 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c1b676be67b9..8c26c5d0c778 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3708,36 +3708,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
>  	return 0;
>  }
>
> -
> -static sector_t f2fs_bmap_compress(struct inode *inode, sector_t block)
> -{
> -#ifdef CONFIG_F2FS_FS_COMPRESSION
> -	struct dnode_of_data dn;
> -	sector_t start_idx, blknr = 0;
> -	int ret;
> -
> -	start_idx = round_down(block, F2FS_I(inode)->i_cluster_size);
> -
> -	set_new_dnode(&dn, inode, NULL, NULL, 0);
> -	ret = f2fs_get_dnode_of_data(&dn, start_idx, LOOKUP_NODE);
> -	if (ret)
> -		return 0;
> -
> -	if (dn.data_blkaddr != COMPRESS_ADDR) {
> -		dn.ofs_in_node += block - start_idx;
> -		blknr = f2fs_data_blkaddr(&dn);
> -		if (!__is_valid_data_blkaddr(blknr))
> -			blknr = 0;
> -	}
> -
> -	f2fs_put_dnode(&dn);
> -	return blknr;
> -#else
> -	return 0;
> -#endif
> -}
> -
> -
>  static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
>  {
>  	struct inode *inode = mapping->host;
> @@ -3753,9 +3723,6 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
>  	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
>  		filemap_write_and_wait(mapping);
>
> -	if (f2fs_compressed_file(inode))
> -		blknr = f2fs_bmap_compress(inode, block);
> -
>  	if (!get_data_block_bmap(inode, block, &tmp, 0))
>  		blknr = tmp.b_blocknr;
>  out:
>
