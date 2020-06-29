Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FA5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A7420656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRvSW+Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404189AbgF2VrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732044AbgF2Vqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:46:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4818C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:46:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o22so3523341pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xDU696YPFQFByaDgj4TaIBYY7b7GogdeGS2pZGLrlCo=;
        b=VRvSW+UkmvsRa52leABslqppFhohbUv2Y57EAfRfPkSiCXJCBOO9xVFfpsrzQDJOz1
         tjHENNBB0/+3Up4/WUfV+mnRv86LFjidyGgKNMUbXJ9VfrhsySuQhWo3Gx5q+g60UJ06
         OLGHuN6fNwEWTFEnUExSpqTC0CaLqdgr6Zs/PmudwGeW35RPOrTzF8HQ/A+2MLCM5QIY
         5IXlTK0hW/R7RPNOXKFl8XLNkZO8/FR+FHMFUtVj6lML7eI4+rCW9SFrAiQT0bM+SKYf
         JGfnagg6+MAuL+UEPKM/5LG1Z0FFnenGZAI9pMDD+20HXrnQMR3GSCqrRwC+7ujmg/02
         FWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDU696YPFQFByaDgj4TaIBYY7b7GogdeGS2pZGLrlCo=;
        b=S1I3zoABur6Fq5Ohu2Fi5CG0Wyy4qQ3142DH1d1G02vrWZs5nny3JiCclUjESGyQbw
         JZuFaoMFjPC+1vcPvrhaaLA8p5bZB0ro07Gbv6QT9k1kb3uVXHjjcoQMbdr02kp/ieQG
         tsY5J4Tcyjlqku+nQ0FJCOzmkozkWVrUg0ijrjjVR3KP8KMil6VfVulLK15gKjt2M94T
         lOXkMjt6BD3RHnxWQ69MrlZaNYqF0WieqsmMyrxhAdQ3EkNY2laZkhq+cBvNnTo/Q7w+
         CLJR4B8V0SUwJFYiwIAe8m4XsDQ072AWYSwsI7bhRcKV4PrYdxUav6oFJTzVBTWaFjPc
         3XHw==
X-Gm-Message-State: AOAM533gDUxtHuWfcxvFiGTWFm1unvT2eD3AyiWsZY495udE9bYLF9I5
        gNPujNDJc0/mkOmJSxwIoZUFeJ9Pi9H6gftCXrrJ4Q==
X-Google-Smtp-Source: ABdhPJyVbma1Y1Qr7DDoDmXJbO16+ERslv8h5KufpVJ/JEIQyzOIKMbLCSM3o5jNmvfFr/eEujaPmuHDb3spxeUzjb0=
X-Received: by 2002:a17:90a:21ef:: with SMTP id q102mr20001058pjc.101.1593467210715;
 Mon, 29 Jun 2020 14:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200627190230.1191796-1-luca.stefani.ge1@gmail.com>
In-Reply-To: <20200627190230.1191796-1-luca.stefani.ge1@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jun 2020 14:46:39 -0700
Message-ID: <CAKwvOdk5_tq6hrBMEwssksGniMyAWSMKOSaWbiBsX_bssmmztA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: Fix ntfs_test_inode and ntfs_init_locked_inode
 function type
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        freak07 <michalechner92@googlemail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 12:02 PM Luca Stefani
<luca.stefani.ge1@gmail.com> wrote:
>
> If the kernel is built with CFI we hit a __cfi_check_fail
> while mounting a partition

Luca,
Since CFI is not yet upstream (is downstream in Android, blocked on
LTO patches currently working their way through upstreaming+code
review), it might help explain to reviewers what CFI *even is*.
Something like:

"""
Clang's Control Flow Integrity (CFI) is a security mechanism that can
help prevent JOP chains, deployed extensively in downstream kernels
used in Android.

It's deployment is hindered by mismatches in function signatures.  For
this case, we make callbacks match their intended function signature,
and cast parameters within them rather than casting the callback when
passed as a parameter.

When running `mount -t ntfs ...` we observe the following trace:
"""

I also always recommend setting an explicit `--to=` when sending
patches; some maintainers only know to take a look at patches if
they're in the To: list.  Maybe they have email filters on this.  You
can you `./script/get_maintainer.pl` on your patch file, or manually
check MAINTAINERS.  In this case, it looks like Anton is cc'ed at
least.

Since this patch modifies the type signature of callbacks to the
expected type, casting the callback's parameters instead; I'm happy
with this patch.  The callbacks never get invoked directly (not
explicitly called, only invoked indirectly), there is no argument for
loss of type safety (the interfaces are already lossy in that the
interface uses void* parameters).  I just would like the commit
message beefed up before I sign off.  Are you comfortable sending a
V2?

More on JOP/CFI:
https://www.comp.nus.edu.sg/~liangzk/papers/asiaccs11.pdf
> CFI has not seen wide deployment, likely due to concerns over performance, especially in the case of real-time enforcement.

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
> Fixing iget5_locked and ilookup5 callers seems enough
>
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> Tested-by: freak07 <michalechner92@googlemail.com>
> ---
>  fs/ntfs/dir.c   |  2 +-
>  fs/ntfs/inode.c | 23 ++++++++++++-----------
>  fs/ntfs/inode.h |  4 +---
>  fs/ntfs/mft.c   |  4 ++--
>  4 files changed, 16 insertions(+), 17 deletions(-)
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

Looks like the signature of ilookup5 is:

struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
     int (*test)(struct inode *, void *), void *data)

while ntfs_test_inode is:

int ntfs_test_inode(struct inode *vi, ntfs_attr *na)

while test_t is defined way below to:

typedef int (*test_t)(struct inode *, void *);


>         if (bmp_vi) {
>                 write_inode_now(bmp_vi, !datasync);
>                 iput(bmp_vi);
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index d4359a1df3d5..a5d3bebe7a85 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -30,7 +30,7 @@
>  /**
>   * ntfs_test_inode - compare two (possibly fake) inodes for equality
>   * @vi:                vfs inode which to test
> - * @na:                ntfs attribute which is being tested with
> + * @data:              data which is being tested with
>   *
>   * Compare the ntfs attribute embedded in the ntfs specific part of the vfs
>   * inode @vi for equality with the ntfs attribute @na.
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
> @@ -72,7 +73,7 @@ int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
>  /**
>   * ntfs_init_locked_inode - initialize an inode
>   * @vi:                vfs inode to initialize
> - * @na:                ntfs attribute which to initialize @vi to
> + * @data:              data which to initialize @vi to
>   *
>   * Initialize the vfs inode @vi with the values from the ntfs attribute @na in
>   * order to enable ntfs_test_inode() to do its work.
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
> 2.26.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200627190230.1191796-1-luca.stefani.ge1%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
