Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3396BC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE2F20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="iOUsMJPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgCKOBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:01:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41180 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgCKOBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:01:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id s14so2751909wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+P7+pJIgh6gd0t13DtDNhTnBHDAH10Yd4Pyahm4lR54=;
        b=iOUsMJPFwYobPXu76nckVIEXev0vW2wwKkvMsyk7fXE21GKHgAqDB0SF4VoTuYZSUx
         PC6R1rsjHwKJnBWnbvHGFnrXm3xzrawBXmS8+qUmG3ujPQWziv14kLjQkr82D88w5N7C
         voNqdkP+bpk0A5J0PBPwmCSj48PuP6f0cD/Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+P7+pJIgh6gd0t13DtDNhTnBHDAH10Yd4Pyahm4lR54=;
        b=KmlStMNP9yunLqU83meQHKzkKiVtIddvLA4f+piSrKanqX4ROSSZdEql6JFk2TNHs8
         BAGl05QszfxmZhdTaSD0dVtRTyeG+8XfS+fUMclR6JpuGmDSFaWvQ804X7vm4fFm7+zX
         dJW1a1j0YmM8FHWQWLv0IhLirbVMGfMGNyZfiGF3bvCzR3ocxAIkrApDz+UFzFCP8UdS
         Lctj7M4JeHCRuTBmD5oteI3bGaxGyCjNR0Jfz4FOqWn2CzpjvNJH2T3OOOaCRQFrjWZy
         gwOGRyXJ+6CgDRfdUhrLh724MYOnjenpGUSLICauB/jaSfi+3+wIQbv4eEIE8QBLxQWZ
         iAJw==
X-Gm-Message-State: ANhLgQ2zBLdauNHPsnGvpwX2wYvni9lvlbtXP6BbZiKIhpERckjxqsfO
        JdrVOZCaDsSSOB+iXCh1gV29HV6e6loWXimuFzvR2uuitxmL8A==
X-Google-Smtp-Source: ADFU+vsauYA6xe6B3HcZlg3SOKC1GH/qlO9NdrDS25tcn5h036TwrYu9RpchTcWmvGip4MX11xHU94vZtlYiRTqOLJ8=
X-Received: by 2002:a5d:420c:: with SMTP id n12mr4672779wrq.173.1583935306319;
 Wed, 11 Mar 2020 07:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200305193511.28621-1-ignat@cloudflare.com>
In-Reply-To: <20200305193511.28621-1-ignat@cloudflare.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 11 Mar 2020 14:01:35 +0000
Message-ID: <CALrw=nGp-N81=ZQNustvwM-CBcPhPCF7HO+D+B_J74ULD=8hrg@mail.gmail.com>
Subject: Re: [PATCH] mnt: add support for non-rootfs initramfs
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up on this: is there a way to move this forward somehow or
we're stuck with complex userspace code to achieve the same, like
https://git.kernel.org/pub/scm/libs/klibc/klibc.git/tree/usr/kinit/run-init/runinitlib.c,
but for tmpfs?

Just FYI, here is an example of a fix for a security issue, which is
caused by using chroot vs pivot_root in containers:
https://github.com/opencontainers/runc/commit/28a697cce3e4f905dca700eda81d681a30eef9cd

Alternatively, if the use-case is not generic enough, we could keep
the patch to ourselves - just would appreciate some advice/potential
concerns with this approach which we might have overlooked.

Thanks,
Ignat

On Thu, Mar 5, 2020 at 7:35 PM Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> The main need for this is to support container runtimes on stateless Linux
> system (pivot_root system call from initramfs).
>
> Normally, the task of initramfs is to mount and switch to a "real" root
> filesystem. However, on stateless systems (booting over the network) it is just
> convenient to have your "real" filesystem as initramfs from the start.
>
> This, however, breaks different container runtimes, because they usually use
> pivot_root system call after creating their mount namespace. But pivot_root does
> not work from initramfs, because initramfs runs form rootfs, which is the root
> of the mount tree and can't be unmounted.
>
> One can solve this problem from userspace, but it is much more cumbersome. We
> either have to create a multilayered archive for initramfs, where the outer
> layer creates a tmpfs filesystem and unpacks the inner layer, switches root and
> does not forget to properly cleanup the old rootfs. Or we need to use keepinitrd
> kernel cmdline option, unpack initramfs to rootfs, run a script to create our
> target tmpfs root, unpack the same initramfs there, switch root to it and again
> properly cleanup the old root, thus unpacking the same archive twice and also
> wasting memory, because kernel stores compressed initramfs image indefinitely.
>
> With this change we can ask the kernel (by specifying nonroot_initramfs kernel
> cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
> before the initramfs handling code, so initramfs gets unpacked directly into
> the "leaf" tmpfs with rootfs being empty and no need to clean up anything.
>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>  fs/namespace.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 85b5f7bea82e..a1ec862e8146 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3701,6 +3701,49 @@ static void __init init_mount_tree(void)
>         set_fs_root(current->fs, &root);
>  }
>
> +#if IS_ENABLED(CONFIG_TMPFS)
> +static int __initdata nonroot_initramfs;
> +
> +static int __init nonroot_initramfs_param(char *str)
> +{
> +       if (*str)
> +               return 0;
> +       nonroot_initramfs = 1;
> +       return 1;
> +}
> +__setup("nonroot_initramfs", nonroot_initramfs_param);
> +
> +static void __init init_nonroot_initramfs(void)
> +{
> +       int err;
> +
> +       if (!nonroot_initramfs)
> +               return;
> +
> +       err = ksys_mkdir("/root", 0700);
> +       if (err < 0)
> +               goto out;
> +
> +       err = do_mount("tmpfs", "/root", "tmpfs", 0, NULL);
> +       if (err)
> +               goto out;
> +
> +       err = ksys_chdir("/root");
> +       if (err)
> +               goto out;
> +
> +       err = do_mount(".", "/", NULL, MS_MOVE, NULL);
> +       if (err)
> +               goto out;
> +
> +       err = ksys_chroot(".");
> +       if (!err)
> +               return;
> +out:
> +       printk(KERN_WARNING "Failed to create a non-root filesystem for initramfs\n");
> +}
> +#endif /* IS_ENABLED(CONFIG_TMPFS) */
> +
>  void __init mnt_init(void)
>  {
>         int err;
> @@ -3734,6 +3777,10 @@ void __init mnt_init(void)
>         shmem_init();
>         init_rootfs();
>         init_mount_tree();
> +
> +#if IS_ENABLED(CONFIG_TMPFS)
> +       init_nonroot_initramfs();
> +#endif
>  }
>
>  void put_mnt_ns(struct mnt_namespace *ns)
> --
> 2.20.1
>
