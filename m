Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C53C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549922074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzvuBbCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGIMQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGIMQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:16:42 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63300C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 05:16:42 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j11so1653654oiw.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtY52tIWq853opmnP05cRWTZadfrEh+7Mvow4ysB5UI=;
        b=EzvuBbCcza5Lc8H1+xaFsL/GcpsQiQft83Dr6MKsXK3kDsM+hDdyHDoqnHpZpg6EwJ
         /ivR7cDmUWY37h1yECGYSlLtzFV77GBgDOvRsp03aLFEdses53OGGeoJ4eF3eyuhVqvw
         bzJdh24RXKh842DpjoGMFrWxPKYlMyIZyLs9mOaPz2tUdalWRtrobBBynqo9ift+1gfw
         MLvdnJJDcd4DM1Mv+PEoE598xR+IUqMWqPDpJOhmsuJb4t93IL8hTu6tJXXQR+FZGqJ4
         CtmCIbbX7mAkFHC9/g72wQzFtmRRWmwSF9tgt8O8XN2FiXw64vh8RlAdckdm/yJneBMe
         SpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtY52tIWq853opmnP05cRWTZadfrEh+7Mvow4ysB5UI=;
        b=LFkeZXx+Aa5/2JElL8OHd15CP/mDs2qrF59VaX97cDAOiY+5XGVbh9DWtGYwI6m8Vm
         2tAi3lsP4CKOEP55ZaKr+ovK0QNNVDG/esvcVhTl54Q1Lu6yvV2EfUfenOvqX1d/NHfq
         06bsrfDUjuQJOYlCppXVUSRLO0zlzVOPsWT5IxZzlhIFcLj5j60Vg9MpMkxBhzRfJslP
         xIQwzZmS026nepR93pgECMZ2C+OFyFU42vTBcnlRgeq0UCnkfMZcI1izftCbLWPECeny
         2LSKsv5CD7WsXUMNvncT49yNRfFTHsvh8CTsOwJiiCqZOwGC0sUNL2b7X9BTTB/sop0o
         LGFA==
X-Gm-Message-State: AOAM533POABakiZ6rV7CjxPyqTnCISz+fZltqDyRCHNW8iiVREm3E7xN
        /bQkdp+yT9M6wG2OaWjWLeOaN/c55Z0U30w1bzU=
X-Google-Smtp-Source: ABdhPJxC54gbkQcmJ7hMV9rfO1LmLlmANkmq03x+B3tgI3fE47ZQkrvnd21LOza2x6DgCmrY2RzlwfHDM6Gbi3i51wo=
X-Received: by 2002:aca:2b18:: with SMTP id i24mr11349219oik.103.1594297001482;
 Thu, 09 Jul 2020 05:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200623004520.26520-1-TheSven73@gmail.com> <20200623004520.26520-3-TheSven73@gmail.com>
In-Reply-To: <20200623004520.26520-3-TheSven73@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 9 Jul 2020 08:16:30 -0400
Message-ID: <CAGngYiVM4xLXfxxKDrXw94tRM-ayTVmmkmSUR04WR1ahd6aH3g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] romfs: address performance regression since v3.10
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Janos Farkas <chexum+dev@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Al,

You are the closest I could find to a romfs maintainer. get_maintainer.pl
doesn't appear to list any.

This attempted performance regression fix didn't generate much feedback
(to say the least). It's however a real issue for us when supporting a legacy
product where we don't have the luxury of switching to a better-supported
fs.

Is there anything I can do to further this? Is lkml
currently accepting bug / regression fixes to romfs, or is it obsolete?

Many thanks,
Sven

On Mon, Jun 22, 2020 at 8:45 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Problem
> -------
> romfs sequential read performance has regressed very badly since
> v3.10. Currently, reading a large file inside a romfs image is
> up to 12x slower compared to reading the romfs image directly.
>
> Benchmarks:
> - use a romfs image which contains a single 250M file
> - calculate the md5sum of the romfs image directly (test 1)
>   $ time md5sum image.romfs
> - loop-mount the romfs image, and calc the md5sum of the file
>   inside it (test 2)
>   $ mount -o loop,ro image.romfs /mnt/romfs
>   $ time md5sum /mnt/romfs/file
> - drop caches in between
>   $ echo 3 > /proc/sys/vm/drop_caches
>
> imx6 (arm cortex a9) on emmc, running v5.7.2:
> (test 1)  5 seconds
> (test 2) 60 seconds (12x slower)
>
> Intel i7-3630QM on Samsung SSD 850 EVO (EMT02B6Q),
>     running Ubuntu with v4.15.0-106-generic:
> (test 1) 1.3 seconds
> (test 2) 3.3 seconds (2.5x slower)
>
> To show that a regression has occurred since v3.10:
>
> imx6 on emmc, running v3.10.17:
> (test 1) 16 seconds
> (test 2) 18 seconds
>
> Proposed Solution
> -----------------
> Increase the blocksize from 1K to PAGE_SIZE. This brings the
> sequential read performance close to where it was on v3.10:
>
> imx6 on emmc, running v5.7.2:
> (test 2 1K blocksize) 60 seconds
> (test 2 4K blocksize) 22 seconds
>
> Intel on Ubuntu running v4.15:
> (test 2 1K blocksize) 3.3 seconds
> (test 2 4K blocksize) 1.9 seconds
>
> There is a risk that this may increase latency on random-
> access workloads. But the test below suggests that this
> is not a concern:
>
> Benchmark:
> - use a 630M romfs image consisting of 9600 files
> - loop-mount the romfs image
>   $ mount -o loop,ro image.romfs /mnt/romfs
> - drop all caches
> - list all files in the filesystem (test 3)
>   $ time find /mnt/romfs > /dev/null
>
> imx6 on emmc, running v5.7.2:
> (test 3 1K blocksize) 9.5 seconds
> (test 3 4K blocksize) 9   seconds
>
> Intel on Ubuntu, running v4.15:
> (test 3 1K blocksize) 1.4 seconds
> (test 3 4K blocksize) 1.2 seconds
>
> Practical Solution
> ------------------
> Introduce a mount-option called 'largeblocks'. If present,
> increase the blocksize for much better sequential performance.
>
> Note that the Linux block layer can only support n-K blocks if
> the underlying block device length is also aligned to n-K. This
> may not always be the case. Therefore, the driver will pick the
> largest blocksize which the underlying block device can support.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: Janos Farkas <chexum+dev@gmail.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> To: linux-kernel@vger.kernel.org
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  fs/romfs/super.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 57 insertions(+), 5 deletions(-)
>
> diff --git a/fs/romfs/super.c b/fs/romfs/super.c
> index 6fecdea791f1..93565aeaa43c 100644
> --- a/fs/romfs/super.c
> +++ b/fs/romfs/super.c
> @@ -65,7 +65,7 @@
>  #include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/blkdev.h>
> -#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/mount.h>
>  #include <linux/namei.h>
>  #include <linux/statfs.h>
> @@ -460,6 +460,54 @@ static __u32 romfs_checksum(const void *data, int size)
>         return sum;
>  }
>
> +enum romfs_param {
> +       Opt_largeblocks,
> +};
> +
> +static const struct fs_parameter_spec romfs_fs_parameters[] = {
> +       fsparam_flag("largeblocks", Opt_largeblocks),
> +       {}
> +};
> +
> +/*
> + * Parse a single mount parameter.
> + */
> +static int romfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +       struct fs_parse_result result;
> +       int opt;
> +
> +       opt = fs_parse(fc, romfs_fs_parameters, param, &result);
> +       if (opt < 0)
> +               return opt;
> +
> +       switch (opt) {
> +       case Opt_largeblocks:
> +               fc->fs_private = (void *) 1;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * pick the largest blocksize which the underlying block device
> + * is a multiple of. Or fall back to legacy (ROMBSIZE).
> + */
> +static int romfs_largest_blocksize(struct super_block *sb)
> +{
> +       loff_t device_sz = i_size_read(sb->s_bdev->bd_inode);
> +       int blksz;
> +
> +       for (blksz = PAGE_SIZE; blksz > ROMBSIZE; blksz >>= 1)
> +               if ((device_sz % blksz) == 0)
> +                       break;
> +
> +       return blksz;
> +}
> +
>  /*
>   * fill in the superblock
>   */
> @@ -467,17 +515,19 @@ static int romfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>         struct romfs_super_block *rsb;
>         struct inode *root;
> -       unsigned long pos, img_size;
> +       unsigned long pos, img_size, dev_blocksize;
>         const char *storage;
>         size_t len;
>         int ret;
>
>  #ifdef CONFIG_BLOCK
> +       dev_blocksize = fc->fs_private ? romfs_largest_blocksize(sb) :
> +                                        ROMBSIZE;
>         if (!sb->s_mtd) {
> -               sb_set_blocksize(sb, ROMBSIZE);
> +               sb_set_blocksize(sb, dev_blocksize);
>         } else {
> -               sb->s_blocksize = ROMBSIZE;
> -               sb->s_blocksize_bits = blksize_bits(ROMBSIZE);
> +               sb->s_blocksize = dev_blocksize;
> +               sb->s_blocksize_bits = blksize_bits(dev_blocksize);
>         }
>  #endif
>
> @@ -573,6 +623,7 @@ static int romfs_get_tree(struct fs_context *fc)
>  static const struct fs_context_operations romfs_context_ops = {
>         .get_tree       = romfs_get_tree,
>         .reconfigure    = romfs_reconfigure,
> +       .parse_param    = romfs_parse_param,
>  };
>
>  /*
> @@ -607,6 +658,7 @@ static struct file_system_type romfs_fs_type = {
>         .owner          = THIS_MODULE,
>         .name           = "romfs",
>         .init_fs_context = romfs_init_fs_context,
> +       .parameters     = romfs_fs_parameters,
>         .kill_sb        = romfs_kill_sb,
>         .fs_flags       = FS_REQUIRES_DEV,
>  };
> --
> 2.17.1
>
