Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E5EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9513F2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgXnBq7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBGGma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:42:30 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35864 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgBGGma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:42:30 -0500
Received: by mail-vs1-f68.google.com with SMTP id a2so564485vso.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 22:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mnZl4Flxp12HlNTJDtFOrHxyLdPSwOlEthWkb2XefBE=;
        b=dgXnBq7u8i/qlJWOjO4V/z48t3afrAtEEfd45aJ41yjpQ8BjjfV7pjme8YfokkxXGH
         HVvw6tVBEIGj02Dprhr5BIfjj/kVmrQlli0YemSZ4xeeHZJvv+ygShc6ChJehYcqL/lr
         Y7AzMhAdVIkAzy/QrqlUS1UyX375KTRDMs1xSFwmjZl/+lVA3mY/V9xX0LxJvz2/xkfR
         TUPDx4mY4uj2JCZNjujoW75Z3yejnWYXdo1T7V1PXY+3rBNBeOSyAK/WBBOxVsti0JBq
         mYqql1aMl/tfsTrf2scjNvJ2ZGWl6l7I8wBjksL5RISRqbeFqyL+uxNiNR4lfkdysIDi
         w6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mnZl4Flxp12HlNTJDtFOrHxyLdPSwOlEthWkb2XefBE=;
        b=ivAqdTmR4eC/b6eEd0F1GlsF3pxa3fi23Zf4PcGi3+MYUrJFako+SsMO2U0ku/oegn
         6liVUNxbTO8PEE0XyENFSxvZ0wp482E1tMcNpxTAGmhWwMiVYxmd4DSlDJ37vTurpD4a
         va9Gj09GIkQ7hsNWSlbgiFmgWld/fXQ0fqF23gmp0ilTkzHZgbplxP+QVoer2P3ozlA+
         SJE2k3yJgEP7KmpwYu65WdclwrmY5sCUPGGNK0ZFHTUJZpXNGDPPmYT+RmfqBsyshaWW
         q3QlZmDvt0wx+4rAEAWOtfxGfdMHYiURqJHIfy/aibOvvXkLluejwKol9xUApwNSZ6Zi
         wRfw==
X-Gm-Message-State: APjAAAXNjkXbwLx9HmNPsvamcsvCOekKDFJ/9yblrkCrExt3PbsVjmJl
        jDiSwDYYlNT1DkKaLSZCjg33+5lRhzGPo1ANvvM=
X-Google-Smtp-Source: APXvYqx2ilqaaRtvjaxR7jjdPcds343sPqT/P2DSq37zZoZ/hy5E9GXuj4DUQLOmym+y2EFrALx8Vk4KTo0G2AUVqdk=
X-Received: by 2002:a05:6102:7a4:: with SMTP id x4mr3922197vsg.85.1581057749268;
 Thu, 06 Feb 2020 22:42:29 -0800 (PST)
MIME-Version: 1.0
References: <20191227104456.24528-1-yuchao0@huawei.com>
In-Reply-To: <20191227104456.24528-1-yuchao0@huawei.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Fri, 7 Feb 2020 15:42:18 +0900
Message-ID: <CAD14+f2jh5pfeW1Z2KTJLoWFivDbjH2SB3j9OVQ932WwBZZHjg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to add swap extent correctly
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

I think this should be sent to linux-stable.
Thoughts?

Thanks.

On Fri, Dec 27, 2019 at 7:45 PM Chao Yu <yuchao0@huawei.com> wrote:
>
> As Youling reported in mailing list:
>
> https://www.linuxquestions.org/questions/linux-newbie-8/the-file-system-f2fs-is-broken-4175666043/
>
> https://www.linux.org/threads/the-file-system-f2fs-is-broken.26490/
>
> There is a test case can corrupt f2fs image:
> - dd if=/dev/zero of=/swapfile bs=1M count=4096
> - chmod 600 /swapfile
> - mkswap /swapfile
> - swapon --discard /swapfile
>
> The root cause is f2fs_swap_activate() intends to return zero value
> to setup_swap_extents() to enable SWP_FS mode (swap file goes through
> fs), in this flow, setup_swap_extents() setups swap extent with wrong
> block address range, result in discard_swap() erasing incorrect address.
>
> Because f2fs_swap_activate() has pinned swapfile, its data block
> address will not change, it's safe to let swap to handle IO through
> raw device, so we can get rid of SWAP_FS mode and initial swap extents
> inside f2fs_swap_activate(), by this way, later discard_swap() can trim
> in right address range.
>
> Fixes: 4969c06a0d83 ("f2fs: support swap file w/ DIO")
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 19cd03450066..ee4d3d284379 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3608,7 +3608,8 @@ int f2fs_migrate_page(struct address_space *mapping,
>
>  #ifdef CONFIG_SWAP
>  /* Copied from generic_swapfile_activate() to check any holes */
> -static int check_swap_activate(struct file *swap_file, unsigned int max)
> +static int check_swap_activate(struct swap_info_struct *sis,
> +                               struct file *swap_file, sector_t *span)
>  {
>         struct address_space *mapping = swap_file->f_mapping;
>         struct inode *inode = mapping->host;
> @@ -3619,6 +3620,8 @@ static int check_swap_activate(struct file *swap_file, unsigned int max)
>         sector_t last_block;
>         sector_t lowest_block = -1;
>         sector_t highest_block = 0;
> +       int nr_extents = 0;
> +       int ret;
>
>         blkbits = inode->i_blkbits;
>         blocks_per_page = PAGE_SIZE >> blkbits;
> @@ -3630,7 +3633,8 @@ static int check_swap_activate(struct file *swap_file, unsigned int max)
>         probe_block = 0;
>         page_no = 0;
>         last_block = i_size_read(inode) >> blkbits;
> -       while ((probe_block + blocks_per_page) <= last_block && page_no < max) {
> +       while ((probe_block + blocks_per_page) <= last_block &&
> +                       page_no < sis->max) {
>                 unsigned block_in_page;
>                 sector_t first_block;
>
> @@ -3670,13 +3674,27 @@ static int check_swap_activate(struct file *swap_file, unsigned int max)
>                                 highest_block = first_block;
>                 }
>
> +               /*
> +                * We found a PAGE_SIZE-length, PAGE_SIZE-aligned run of blocks
> +                */
> +               ret = add_swap_extent(sis, page_no, 1, first_block);
> +               if (ret < 0)
> +                       goto out;
> +               nr_extents += ret;
>                 page_no++;
>                 probe_block += blocks_per_page;
>  reprobe:
>                 continue;
>         }
> -       return 0;
> -
> +       ret = nr_extents;
> +       *span = 1 + highest_block - lowest_block;
> +       if (page_no == 0)
> +               page_no = 1;    /* force Empty message */
> +       sis->max = page_no;
> +       sis->pages = page_no - 1;
> +       sis->highest_bit = page_no - 1;
> +out:
> +       return ret;
>  bad_bmap:
>         pr_err("swapon: swapfile has holes\n");
>         return -EINVAL;
> @@ -3701,14 +3719,14 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
>         if (f2fs_disable_compressed_file(inode))
>                 return -EINVAL;
>
> -       ret = check_swap_activate(file, sis->max);
> -       if (ret)
> +       ret = check_swap_activate(sis, file, span);
> +       if (ret < 0)
>                 return ret;
>
>         set_inode_flag(inode, FI_PIN_FILE);
>         f2fs_precache_extents(inode);
>         f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> -       return 0;
> +       return ret;
>  }
>
>  static void f2fs_swap_deactivate(struct file *file)
> --
> 2.18.0.rc1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
