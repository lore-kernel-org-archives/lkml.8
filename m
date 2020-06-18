Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8740C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB451208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592524776;
	bh=exf76+P68htTFPbqba8LsCF0K+Pu0lNqPq6KgbhKT8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=akBTFqeBOrvUaO4W1Hy/kqjIUYVSXbCV9QRjE9UGbEIjQ2eA/7Sth91WsM+1H8NPc
	 5XFQJBqKILOGfaJQFrd/6gl6MX2GojREBpQmVqYDcdfK30dIbfRAfqyJZgoiPexRv4
	 umDbdGhSnvbwUU1rMKD1qItVYKJ8TGcsACumpX7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgFRX7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgFRX7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:59:34 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57048208B3;
        Thu, 18 Jun 2020 23:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592524773;
        bh=exf76+P68htTFPbqba8LsCF0K+Pu0lNqPq6KgbhKT8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2OEoZFeRXhZwcfuvkHOTpztIMvz4dc8DhMquBNA7IgqCnYkiPKVGA3ane6pVczOD
         lsMKXsmtKksHJY9Sk+UB6OyFvIBipnDjMs46GbvBvR0SAOgRN80XFCGsN4FA3VcuRH
         28RduDOIZ+urcjNxs5K8BIbANxLsJG0TLu2v0rdI=
Date:   Thu, 18 Jun 2020 16:59:32 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 1/5] f2fs: fix to wait page writeback before update
Message-ID: <20200618235932.GA227771@google.com>
References: <20200618063625.110273-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618063625.110273-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 06/18, Chao Yu wrote:
> to make page content stable for special device like raid.

Could you elaborate the problem a bit?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/dir.c          |  2 ++
>  fs/f2fs/extent_cache.c | 18 +++++++++---------
>  fs/f2fs/f2fs.h         |  2 +-
>  fs/f2fs/file.c         |  1 +
>  fs/f2fs/inline.c       |  2 ++
>  fs/f2fs/inode.c        |  3 +--
>  6 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index d35976785e8c..91e86747a604 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -495,6 +495,8 @@ static int make_empty_dir(struct inode *inode,
>  	if (IS_ERR(dentry_page))
>  		return PTR_ERR(dentry_page);
>  
> +	f2fs_bug_on(F2FS_I_SB(inode), PageWriteback(dentry_page));
> +
>  	dentry_blk = page_address(dentry_page);
>  
>  	make_dentry_ptr_block(NULL, &d, dentry_blk);
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index e60078460ad1..686c68b98610 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -325,9 +325,10 @@ static void __drop_largest_extent(struct extent_tree *et,
>  }
>  
>  /* return true, if inode page is changed */
> -static bool __f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
> +static void __f2fs_init_extent_tree(struct inode *inode, struct page *ipage)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct f2fs_extent *i_ext = ipage ? &F2FS_INODE(ipage)->i_ext : NULL;
>  	struct extent_tree *et;
>  	struct extent_node *en;
>  	struct extent_info ei;
> @@ -335,16 +336,18 @@ static bool __f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_e
>  	if (!f2fs_may_extent_tree(inode)) {
>  		/* drop largest extent */
>  		if (i_ext && i_ext->len) {
> +			f2fs_wait_on_page_writeback(ipage, NODE, true, true);
>  			i_ext->len = 0;
> -			return true;
> +			set_page_dirty(ipage);
> +			return;
>  		}
> -		return false;
> +		return;
>  	}
>  
>  	et = __grab_extent_tree(inode);
>  
>  	if (!i_ext || !i_ext->len)
> -		return false;
> +		return;
>  
>  	get_extent_info(&ei, i_ext);
>  
> @@ -360,17 +363,14 @@ static bool __f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_e
>  	}
>  out:
>  	write_unlock(&et->lock);
> -	return false;
>  }
>  
> -bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
> +void f2fs_init_extent_tree(struct inode *inode, struct page *ipage)
>  {
> -	bool ret =  __f2fs_init_extent_tree(inode, i_ext);
> +	__f2fs_init_extent_tree(inode, ipage);
>  
>  	if (!F2FS_I(inode)->extent_tree)
>  		set_inode_flag(inode, FI_NO_EXTENT);
> -
> -	return ret;
>  }
>  
>  static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b35a50f4953c..326c12fa0da5 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3795,7 +3795,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
>  bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
>  						struct rb_root_cached *root);
>  unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink);
> -bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext);
> +void f2fs_init_extent_tree(struct inode *inode, struct page *ipage);
>  void f2fs_drop_extent_tree(struct inode *inode);
>  unsigned int f2fs_destroy_extent_node(struct inode *inode);
>  void f2fs_destroy_extent_tree(struct inode *inode);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 3268f8dd59bb..1862073b96d2 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1250,6 +1250,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
>  				f2fs_put_page(psrc, 1);
>  				return PTR_ERR(pdst);
>  			}
> +			f2fs_wait_on_page_writeback(pdst, DATA, true, true);
>  			f2fs_copy_page(psrc, pdst);
>  			set_page_dirty(pdst);
>  			f2fs_put_page(pdst, 1);
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index dbade310dc79..4bcbc486c9e2 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -340,6 +340,8 @@ int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
>  	struct f2fs_dentry_ptr d;
>  	void *inline_dentry;
>  
> +	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
> +
>  	inline_dentry = inline_data_addr(inode, ipage);
>  
>  	make_dentry_ptr_inline(inode, &d, inline_dentry);
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 44582a4db513..7c156eb26dd7 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -367,8 +367,7 @@ static int do_read_inode(struct inode *inode)
>  	fi->i_pino = le32_to_cpu(ri->i_pino);
>  	fi->i_dir_level = ri->i_dir_level;
>  
> -	if (f2fs_init_extent_tree(inode, &ri->i_ext))
> -		set_page_dirty(node_page);
> +	f2fs_init_extent_tree(inode, node_page);
>  
>  	get_inline_info(inode, ri);
>  
> -- 
> 2.18.0.rc1
