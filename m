Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303E4C433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F91206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJrAnC24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgGTQM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387949AbgGTQMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:12:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96998C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:12:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so8889524plk.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2F4okR0544vetAlDfB7iTkE3QWvIeEOYCah5TZgQj2o=;
        b=OJrAnC24SNIdD4WiC3bvYWrYj6F1F8Ft4xqUAxkPu5wqB1dMQ87lONlUYCW2pmccaS
         hYs7gCXc4Nu5pmwWmWEPfHVTHNEylA/07R3CoyS4WRIaY1YF1CpGo5ypPvXIF3FxJdSy
         b3LfrY9VP7mULG0QqGZux77z4/5i+rctveZhQoEpM7f3GgRT8M2Lng1J/QP/GFwZ91DU
         +bQXSK36kI/+gX9XBzWiQgnmWPoti+CrmMpCktgwiJrf7n6hJ4PlCH3NEOaFeMzuFTYF
         St37vWDYivZmLa6CwvnUT7Z3DJSNuQOIyeiIafcZ9qvoKmhfcz/n2FZFrjTSHJ1fPyXt
         7m7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2F4okR0544vetAlDfB7iTkE3QWvIeEOYCah5TZgQj2o=;
        b=RntpowkRovc5RLL7DO765Gaaj6Y/EXOLr3b0o1ZZ3lC1sGASAaRjONFxFzZgBApqu7
         FgvEPaVmn9e35jPRHE9BYxJGNwS8GMR7wcfgM/Er6Xg1JOvZDwhxczhqCwmLG8FzxnoD
         MfdSK8cKIqoSSs1fmLD1LUhVcmsfOJLq+ezNpFhMUuqMfAGubkb5OpfiWmgggFr2J6Bf
         ICkeT5kYKfX9HTxgP+LcAjMeyMW/VDy3QmGRXNywFws7Ev8Gmshu6hkzlb2LYd5yalJr
         mOnk5Fz2+Z4TmGRirKR8b8jXU/i/CXMCZODFpfRCgWyOIvTmFrIX1H6gvvMHBlPUB7/l
         mNyw==
X-Gm-Message-State: AOAM533H3upzGi0+OglzGB2W5BxI6oRG7i+2vDCUauiBDYwlSeNMixZm
        RvCqSouzOWS1qTaI7yaMm37O0zWzN6U1+M3TTs5TqA==
X-Google-Smtp-Source: ABdhPJyF+ZUKZIxRociEgrADM+zlY+uhpV7CRGEU2dU589TgtL4i/ARGsszMGAArLEZUbBci4WwOehEDoUlAk+vAFYI=
X-Received: by 2002:a17:90a:30ea:: with SMTP id h97mr170399pjb.32.1595261544607;
 Mon, 20 Jul 2020 09:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200627190230.1191796-1-luca.stefani.ge1@gmail.com> <20200718112513.533800-1-luca.stefani.ge1@gmail.com>
In-Reply-To: <20200718112513.533800-1-luca.stefani.ge1@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 20 Jul 2020 09:12:14 -0700
Message-ID: <CAKwvOd=wVeUuxcLThf0hr+CL0PhjLjUtXAqwrF9S6-qzfWOxDQ@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: Fix ntfs_test_inode and ntfs_init_locked_inode
 function type
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        freak07 <michalechner92@googlemail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 4:25 AM Luca Stefani <luca.stefani.ge1@gmail.com> wrote:
>
> Clang's Control Flow Integrity (CFI) is a security mechanism that can
> help prevent JOP chains, deployed extensively in downstream kernels
> used in Android.
>
> It's deployment is hindered by mismatches in function signatures.  For
> this case, we make callbacks match their intended function signature,
> and cast parameters within them rather than casting the callback when
> passed as a parameter.
>
> When running `mount -t ntfs ...` we observe the following trace:
>
> Call trace:
> __cfi_check_fail+0x1c/0x24
> name_to_dev_t+0x0/0x404
> iget5_locked+0x594/0x5e8
> ntfs_fill_super+0xbfc/0x43ec
> mount_bdev+0x30c/0x3cc
> ntfs_mount+0x18/0x24
> mount_fs+0x1b0/0x380
> vfs_kern_mount+0x90/0x398
> do_mount+0x5d8/0x1a10
> SyS_mount+0x108/0x144
> el0_svc_naked+0x34/0x38
>
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> Tested-by: freak07 <michalechner92@googlemail.com>
> Acked-by: Anton Altaparmakov <anton@tuxera.com>

Make sure to set an explicit --to!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  fs/ntfs/dir.c   |  2 +-
>  fs/ntfs/inode.c | 27 ++++++++++++++-------------
>  fs/ntfs/inode.h |  4 +---
>  fs/ntfs/mft.c   |  4 ++--
>  4 files changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> index 3c4811469ae8..e278bfc5ee7f 100644
> --- a/fs/ntfs/dir.c
> +++ b/fs/ntfs/dir.c
> @@ -1503,7 +1503,7 @@ static int ntfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
>         na.type = AT_BITMAP;
>         na.name = I30;
>         na.name_len = 4;
> -       bmp_vi = ilookup5(vi->i_sb, vi->i_ino, (test_t)ntfs_test_inode, &na);
> +       bmp_vi = ilookup5(vi->i_sb, vi->i_ino, ntfs_test_inode, &na);
>         if (bmp_vi) {
>                 write_inode_now(bmp_vi, !datasync);
>                 iput(bmp_vi);
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index d4359a1df3d5..9bb9f0952b18 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -30,10 +30,10 @@
>  /**
>   * ntfs_test_inode - compare two (possibly fake) inodes for equality
>   * @vi:                vfs inode which to test
> - * @na:                ntfs attribute which is being tested with
> + * @data:      data which is being tested with
>   *
>   * Compare the ntfs attribute embedded in the ntfs specific part of the vfs
> - * inode @vi for equality with the ntfs attribute @na.
> + * inode @vi for equality with the ntfs attribute @data.
>   *
>   * If searching for the normal file/directory inode, set @na->type to AT_UNUSED.
>   * @na->name and @na->name_len are then ignored.
> @@ -43,8 +43,9 @@
>   * NOTE: This function runs with the inode_hash_lock spin lock held so it is not
>   * allowed to sleep.
>   */
> -int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
> +int ntfs_test_inode(struct inode *vi, void *data)
>  {
> +       ntfs_attr *na = (ntfs_attr *)data;
>         ntfs_inode *ni;
>
>         if (vi->i_ino != na->mft_no)
> @@ -72,9 +73,9 @@ int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
>  /**
>   * ntfs_init_locked_inode - initialize an inode
>   * @vi:                vfs inode to initialize
> - * @na:                ntfs attribute which to initialize @vi to
> + * @data:      data which to initialize @vi to
>   *
> - * Initialize the vfs inode @vi with the values from the ntfs attribute @na in
> + * Initialize the vfs inode @vi with the values from the ntfs attribute @data in
>   * order to enable ntfs_test_inode() to do its work.
>   *
>   * If initializing the normal file/directory inode, set @na->type to AT_UNUSED.
> @@ -87,8 +88,9 @@ int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
>   * NOTE: This function runs with the inode->i_lock spin lock held so it is not
>   * allowed to sleep. (Hence the GFP_ATOMIC allocation.)
>   */
> -static int ntfs_init_locked_inode(struct inode *vi, ntfs_attr *na)
> +static int ntfs_init_locked_inode(struct inode *vi, void *data)
>  {
> +       ntfs_attr *na = (ntfs_attr *)data;
>         ntfs_inode *ni = NTFS_I(vi);
>
>         vi->i_ino = na->mft_no;
> @@ -131,7 +133,6 @@ static int ntfs_init_locked_inode(struct inode *vi, ntfs_attr *na)
>         return 0;
>  }
>
> -typedef int (*set_t)(struct inode *, void *);
>  static int ntfs_read_locked_inode(struct inode *vi);
>  static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi);
>  static int ntfs_read_locked_index_inode(struct inode *base_vi,
> @@ -164,8 +165,8 @@ struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no)
>         na.name = NULL;
>         na.name_len = 0;
>
> -       vi = iget5_locked(sb, mft_no, (test_t)ntfs_test_inode,
> -                       (set_t)ntfs_init_locked_inode, &na);
> +       vi = iget5_locked(sb, mft_no, ntfs_test_inode,
> +                       ntfs_init_locked_inode, &na);
>         if (unlikely(!vi))
>                 return ERR_PTR(-ENOMEM);
>
> @@ -225,8 +226,8 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
>         na.name = name;
>         na.name_len = name_len;
>
> -       vi = iget5_locked(base_vi->i_sb, na.mft_no, (test_t)ntfs_test_inode,
> -                       (set_t)ntfs_init_locked_inode, &na);
> +       vi = iget5_locked(base_vi->i_sb, na.mft_no, ntfs_test_inode,
> +                       ntfs_init_locked_inode, &na);
>         if (unlikely(!vi))
>                 return ERR_PTR(-ENOMEM);
>
> @@ -280,8 +281,8 @@ struct inode *ntfs_index_iget(struct inode *base_vi, ntfschar *name,
>         na.name = name;
>         na.name_len = name_len;
>
> -       vi = iget5_locked(base_vi->i_sb, na.mft_no, (test_t)ntfs_test_inode,
> -                       (set_t)ntfs_init_locked_inode, &na);
> +       vi = iget5_locked(base_vi->i_sb, na.mft_no, ntfs_test_inode,
> +                       ntfs_init_locked_inode, &na);
>         if (unlikely(!vi))
>                 return ERR_PTR(-ENOMEM);
>
> diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
> index 98e670fbdd31..363e4e820673 100644
> --- a/fs/ntfs/inode.h
> +++ b/fs/ntfs/inode.h
> @@ -253,9 +253,7 @@ typedef struct {
>         ATTR_TYPE type;
>  } ntfs_attr;
>
> -typedef int (*test_t)(struct inode *, void *);
> -
> -extern int ntfs_test_inode(struct inode *vi, ntfs_attr *na);
> +extern int ntfs_test_inode(struct inode *vi, void *data);
>
>  extern struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no);
>  extern struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index fbb9f1bc623d..0d62cd5bb7f8 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -958,7 +958,7 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
>                  * dirty code path of the inode dirty code path when writing
>                  * $MFT occurs.
>                  */
> -               vi = ilookup5_nowait(sb, mft_no, (test_t)ntfs_test_inode, &na);
> +               vi = ilookup5_nowait(sb, mft_no, ntfs_test_inode, &na);
>         }
>         if (vi) {
>                 ntfs_debug("Base inode 0x%lx is in icache.", mft_no);
> @@ -1019,7 +1019,7 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
>                 vi = igrab(mft_vi);
>                 BUG_ON(vi != mft_vi);
>         } else
> -               vi = ilookup5_nowait(sb, na.mft_no, (test_t)ntfs_test_inode,
> +               vi = ilookup5_nowait(sb, na.mft_no, ntfs_test_inode,
>                                 &na);
>         if (!vi) {
>                 /*
> --
> 2.27.0
>
> --

-- 
Thanks,
~Nick Desaulniers
