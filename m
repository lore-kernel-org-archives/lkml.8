Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D472DC35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D64821556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzJx44Re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgBYGhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:37:32 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37703 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgBYGhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:37:31 -0500
Received: by mail-ua1-f65.google.com with SMTP id h32so4148085uah.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 22:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHa86/wmoQGkRYQ2PfZCXHRW/f0snyckDltYTbnlufE=;
        b=pzJx44Reo3ZBGEHnlCeQRfKf6QzDFvJC9/ESlgVuvLhTrtTskumX6XphWt72F8lz2i
         XWG7l+mZMXdlrk4XyHjwoZ2bGXyjL40Em6EI3SXpPaottaA42LL7Yxjncjsjvq8DVZBS
         xANCTPnmEOLJNgY76ATtZfAuZpceX2T7nMLZT11M3xhVFssAl+bKzexO0s0Wy/a38ey8
         dFtKBGVNfXr40Kk0G6g3xWCeo2XUttx5hCAHD9YltgGe6OIe0UoEo61IIq0bqm4VSskd
         7voyXOOKTMUYEXt24mxb5bC8k19X0RxbRg+sXmbt+kSflI3bx4byu1jJM2sMCWToaYPc
         jQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHa86/wmoQGkRYQ2PfZCXHRW/f0snyckDltYTbnlufE=;
        b=TremeZVJUWXsVTvVYQsCoP98KkVVmONax6enZhVOHPD2fc8LUyEcLqi4yCZI0SN/44
         kcA4axCphRvfed6RyGeeATWM13GISJiHapguZpBq0Ixzfss52wp7+ZiRks3L3CjwaC8B
         oiQRCcE9i7NmQMT2ttrXQCArLv6rT2ahXu4g27pyErrOGOvWJdORHylABEnameGsyqW/
         KUbLhMagOW1f39KUbNnf6HQZOX8lPKc3xRgk2O9RU9EuNS/4oha8klPS1yWh9O3oVTsw
         GAHqGz2NNbBV2KXKCnl4dk3pgrIbbfzPAO1ZxPDTwCsd7xVWcoG2zcKj6xuTj8rgL4md
         JfBQ==
X-Gm-Message-State: APjAAAXu/CTd16Clacu6/47EsWC5SyconKJegf6Gob+gJ8+97ISDupCL
        rXfFjaJlF7f3SDSwlRkitGLy6uOZLRHcPekOWXK2XH1EF2Q=
X-Google-Smtp-Source: APXvYqzWdH//9SDcefrBf8q8Pc8ls6MeTd2RiJR/hUevj+GxiRAGu4sYxICkgWb19+cfsw33A4kPRXcDuzHjBAIjbS4=
X-Received: by 2002:ab0:374a:: with SMTP id i10mr26445743uat.97.1582612647087;
 Mon, 24 Feb 2020 22:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20200225014257.83903-1-yuchao0@huawei.com>
In-Reply-To: <20200225014257.83903-1-yuchao0@huawei.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Tue, 25 Feb 2020 15:37:15 +0900
Message-ID: <CAD14+f0e5RsntWQk+0=_6f0rJt=0GNBQBZZ3BqjbQzZqJ7f4iw@mail.gmail.com>
Subject: Re: [PATCH] f2fs: use kmem_cache pool during inline xattr lookups
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao.

Sorry for the late reply, I've been busy with my uni stuffs.

It's nice to see this issue getting some attentions back, but
unfortunately, I can't test it at the moment.

Here's the patch we used to see the alloc statistics:
https://pastebin.com/bhBh2dgs by Sultan Alsawaf.

Hope it helps.

On Tue, Feb 25, 2020 at 10:43 AM Chao Yu <yuchao0@huawei.com> wrote:
>
> It's been observed that kzalloc() on lookup_all_xattrs() are called millions
> of times on Android, quickly becoming the top abuser of slub memory allocator.
>
> Use a dedicated kmem cache pool for xattr lookups to mitigate this.
>
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>
> Hi, Ju Hyung,
>
> Let me know if you have any objection on this patch. :)
>
>  fs/f2fs/f2fs.h  |  3 +++
>  fs/f2fs/super.c | 10 ++++++++-
>  fs/f2fs/xattr.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-----
>  fs/f2fs/xattr.h |  4 ++++
>  4 files changed, 65 insertions(+), 6 deletions(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 12a197e89a3e..23b93a116c73 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1486,6 +1486,9 @@ struct f2fs_sb_info {
>         __u32 s_chksum_seed;
>
>         struct workqueue_struct *post_read_wq;  /* post read workqueue */
> +
> +       struct kmem_cache *inline_xattr_slab;   /* inline xattr entry */
> +       unsigned int inline_xattr_slab_size;    /* default inline xattr slab size */
>  };
>
>  struct f2fs_private_dio {
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d241e07c0bfa..0b16204d3b7d 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1201,6 +1201,7 @@ static void f2fs_put_super(struct super_block *sb)
>         kvfree(sbi->raw_super);
>
>         destroy_device_list(sbi);
> +       f2fs_destroy_xattr_caches(sbi);
>         mempool_destroy(sbi->write_io_dummy);
>  #ifdef CONFIG_QUOTA
>         for (i = 0; i < MAXQUOTAS; i++)
> @@ -3457,12 +3458,17 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>                 }
>         }
>
> +       /* init per sbi slab cache */
> +       err = f2fs_init_xattr_caches(sbi);
> +       if (err)
> +               goto free_io_dummy;
> +
>         /* get an inode for meta space */
>         sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
>         if (IS_ERR(sbi->meta_inode)) {
>                 f2fs_err(sbi, "Failed to read F2FS meta data inode");
>                 err = PTR_ERR(sbi->meta_inode);
> -               goto free_io_dummy;
> +               goto free_xattr_cache;
>         }
>
>         err = f2fs_get_valid_checkpoint(sbi);
> @@ -3735,6 +3741,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>         make_bad_inode(sbi->meta_inode);
>         iput(sbi->meta_inode);
>         sbi->meta_inode = NULL;
> +free_xattr_cache:
> +       f2fs_destroy_xattr_caches(sbi);
>  free_io_dummy:
>         mempool_destroy(sbi->write_io_dummy);
>  free_percpu:
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index a3360a97e624..e46a10eb0e42 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -23,6 +23,25 @@
>  #include "xattr.h"
>  #include "segment.h"
>
> +static void *xattr_alloc(struct f2fs_sb_info *sbi, int size, bool *is_inline)
> +{
> +       *is_inline = (size == sbi->inline_xattr_slab_size);
> +
> +       if (*is_inline)
> +               return kmem_cache_zalloc(sbi->inline_xattr_slab, GFP_NOFS);
> +
> +       return f2fs_kzalloc(sbi, size, GFP_NOFS);
> +}
> +
> +static void xattr_free(struct f2fs_sb_info *sbi, void *xattr_addr,
> +                                                       bool is_inline)
> +{
> +       if (is_inline)
> +               kmem_cache_free(sbi->inline_xattr_slab, xattr_addr);
> +       else
> +               kvfree(xattr_addr);
> +}
> +
>  static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
>                 struct dentry *unused, struct inode *inode,
>                 const char *name, void *buffer, size_t size)
> @@ -301,7 +320,8 @@ static int read_xattr_block(struct inode *inode, void *txattr_addr)
>  static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>                                 unsigned int index, unsigned int len,
>                                 const char *name, struct f2fs_xattr_entry **xe,
> -                               void **base_addr, int *base_size)
> +                               void **base_addr, int *base_size,
> +                               bool *is_inline)
>  {
>         void *cur_addr, *txattr_addr, *last_txattr_addr;
>         void *last_addr = NULL;
> @@ -313,7 +333,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>                 return -ENODATA;
>
>         *base_size = XATTR_SIZE(inode) + XATTR_PADDING_SIZE;
> -       txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode), *base_size, GFP_NOFS);
> +       txattr_addr = xattr_alloc(F2FS_I_SB(inode), *base_size, is_inline);
>         if (!txattr_addr)
>                 return -ENOMEM;
>
> @@ -362,7 +382,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>         *base_addr = txattr_addr;
>         return 0;
>  out:
> -       kvfree(txattr_addr);
> +       xattr_free(F2FS_I_SB(inode), txattr_addr, *is_inline);
>         return err;
>  }
>
> @@ -499,6 +519,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>         unsigned int size, len;
>         void *base_addr = NULL;
>         int base_size;
> +       bool is_inline;
>
>         if (name == NULL)
>                 return -EINVAL;
> @@ -509,7 +530,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>
>         down_read(&F2FS_I(inode)->i_xattr_sem);
>         error = lookup_all_xattrs(inode, ipage, index, len, name,
> -                               &entry, &base_addr, &base_size);
> +                               &entry, &base_addr, &base_size, &is_inline);
>         up_read(&F2FS_I(inode)->i_xattr_sem);
>         if (error)
>                 return error;
> @@ -532,7 +553,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>         }
>         error = size;
>  out:
> -       kvfree(base_addr);
> +       xattr_free(F2FS_I_SB(inode), base_addr, is_inline);
>         return error;
>  }
>
> @@ -767,3 +788,26 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
>         f2fs_update_time(sbi, REQ_TIME);
>         return err;
>  }
> +
> +int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi)
> +{
> +       dev_t dev = sbi->sb->s_bdev->bd_dev;
> +       char slab_name[32];
> +
> +       sprintf(slab_name, "f2fs_xattr_entry-%u:%u", MAJOR(dev), MINOR(dev));
> +
> +       sbi->inline_xattr_slab_size = F2FS_OPTION(sbi).inline_xattr_size *
> +                                       sizeof(__le32) + XATTR_PADDING_SIZE;
> +
> +       sbi->inline_xattr_slab = f2fs_kmem_cache_create(slab_name,
> +                                       sbi->inline_xattr_slab_size);
> +       if (!sbi->inline_xattr_slab)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi)
> +{
> +       kmem_cache_destroy(sbi->inline_xattr_slab);
> +}
> diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
> index 574beea46494..7345dfa7b7a9 100644
> --- a/fs/f2fs/xattr.h
> +++ b/fs/f2fs/xattr.h
> @@ -131,6 +131,8 @@ extern int f2fs_setxattr(struct inode *, int, const char *,
>  extern int f2fs_getxattr(struct inode *, int, const char *, void *,
>                                                 size_t, struct page *);
>  extern ssize_t f2fs_listxattr(struct dentry *, char *, size_t);
> +extern int f2fs_init_xattr_caches(struct f2fs_sb_info *);
> +extern void f2fs_destroy_xattr_caches(struct f2fs_sb_info *);
>  #else
>
>  #define f2fs_xattr_handlers    NULL
> @@ -151,6 +153,8 @@ static inline ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer,
>  {
>         return -EOPNOTSUPP;
>  }
> +static int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi) { return 0; }
> +static void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi) { return 0; }
>  #endif
>
>  #ifdef CONFIG_F2FS_FS_SECURITY
> --
> 2.18.0.rc1
>
