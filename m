Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2E2C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 13:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8E6206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 13:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VxLdtqtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDDNAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 09:00:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37175 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgDDNAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 09:00:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id j19so10820639wmi.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 06:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRUK9Ms0WeS5OK2iO/4vjHdnRSnaNQskl7BP9q0uE6I=;
        b=VxLdtqtEso8z+nbdFzeBHULpwTxfHFk2lHLH3sGQXdnWdQR9GBV6evBqa4v/Hd67id
         Ppnt+JRvh3n5cph+hdz2Je5ZLrISsbuFaMru8mZHNZ0kwSu71Rhntw8kg252fp8U3GZM
         hcQo6t16ejHZ6TTIBsxxZnH1H0NUye7dtkxN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRUK9Ms0WeS5OK2iO/4vjHdnRSnaNQskl7BP9q0uE6I=;
        b=eOWKuBGGp6F/GfBZ5DaDgI0R5lNjBP0O9thpf77z3IoujtQ/T2OitAd037jVkuQ7ym
         O5c7GyEO+7Rus0MGoUcXj6oTs1SqffkuVzsO+Ey/8HZgtJi1xCTM5h/e3fNZBAAzrFri
         Mta5ZC12dfhwMGdqXYYRcLFcwAEoraGxiRfhhLleKEI52D25xo6f/1X7j0uS50AeaD/e
         gv9JUWGEEu66W762k9Lz6qmAIBTwQgqVeh0RixVxEaKw0dNaVasrAnYHWHKgVvIddFbK
         zx32kizYqYQoPHciBNDaeCh9PXIz1eHRaq50H8+gSw5m9xNRbrnKIPtH1Bo9gU/RIalY
         wRaw==
X-Gm-Message-State: AGi0Puagdk5ru99L5c871ZqiwvbglO/QpMZ6NRQ3uMSnKzlb9Z6M04QD
        +bQOY96pR19VMk67Ml5dnl3CJDE0fhjqZmPx0dEantV8
X-Google-Smtp-Source: APiQypLI7YvZQkb0mLx8qp8JXyMLlLFqQ8w/4kT24eFi/Y15UdOQb13Elit3vs6Eg9CD9fZPxSvRVVYGtLm+ZdVxhCw=
X-Received: by 2002:a7b:cd8c:: with SMTP id y12mr5425396wmj.106.1586005242282;
 Sat, 04 Apr 2020 06:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200330131439.2405-1-ignat@cloudflare.com> <20200330131439.2405-2-ignat@cloudflare.com>
 <f96ad8b8-0a26-448a-4a27-8712a82001c4@infradead.org>
In-Reply-To: <f96ad8b8-0a26-448a-4a27-8712a82001c4@infradead.org>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Sat, 4 Apr 2020 14:00:31 +0100
Message-ID: <CALrw=nH=Stp9RMCrZveASdp=bf_t8-pSRnXv7E7pC8+aGHsj4w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mnt: add support for non-rootfs initramfs
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forgot to follow up in this thread. I've reposted v2 patches
with documentation.

Regards,
Ignat

On Mon, Mar 30, 2020 at 8:03 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 3/30/20 6:14 AM, Ignat Korchagin wrote:
> > The main need for this is to support container runtimes on stateless Linux
> > system (pivot_root system call from initramfs).
> >
> > Normally, the task of initramfs is to mount and switch to a "real" root
> > filesystem. However, on stateless systems (booting over the network) it is just
> > convenient to have your "real" filesystem as initramfs from the start.
> >
> > This, however, breaks different container runtimes, because they usually use
> > pivot_root system call after creating their mount namespace. But pivot_root does
> > not work from initramfs, because initramfs runs form rootfs, which is the root
> > of the mount tree and can't be unmounted.
> >
> > One workaround is to do:
> >
> >   mount --bind / /
> >
> > However, that defeats one of the purposes of using pivot_root in the cloned
> > containers: get rid of host root filesystem, should the code somehow escapes the
> > chroot.
> >
> > There is a way to solve this problem from userspace, but it is much more
> > cumbersome:
> >   * either have to create a multilayered archive for initramfs, where the outer
> >     layer creates a tmpfs filesystem and unpacks the inner layer, switches root
> >     and does not forget to properly cleanup the old rootfs
> >   * or we need to use keepinitrd kernel cmdline option, unpack initramfs to
> >     rootfs, run a script to create our target tmpfs root, unpack the same
> >     initramfs there, switch root to it and again properly cleanup the old root,
> >     thus unpacking the same archive twice and also wasting memory, because
> >     the kernel stores compressed initramfs image indefinitely.
> >
> > With this change we can ask the kernel (by specifying nonroot_initramfs kernel
> > cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
> > before the initramfs handling code, so initramfs gets unpacked directly into
> > the "leaf" tmpfs with rootfs being empty and no need to clean up anything.
> >
> > This also bring the behaviour in line with the older style initrd, where the
> > initrd is located on some leaf filesystem in the mount tree and rootfs remaining
> > empty.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > ---
> >  fs/namespace.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
>
> Hi,
> Please document "nonroot_initramfs" in
> Documentation/admin-guide/kernel-parameters.txt.
>
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 85b5f7bea82e..a1ec862e8146 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -3701,6 +3701,49 @@ static void __init init_mount_tree(void)
> >       set_fs_root(current->fs, &root);
> >  }
> >
> > +#if IS_ENABLED(CONFIG_TMPFS)
> > +static int __initdata nonroot_initramfs;
> > +
> > +static int __init nonroot_initramfs_param(char *str)
> > +{
> > +     if (*str)
> > +             return 0;
> > +     nonroot_initramfs = 1;
> > +     return 1;
> > +}
> > +__setup("nonroot_initramfs", nonroot_initramfs_param);
> > +
> > +static void __init init_nonroot_initramfs(void)
> > +{
> > +     int err;
> > +
> > +     if (!nonroot_initramfs)
> > +             return;
> > +
> > +     err = ksys_mkdir("/root", 0700);
> > +     if (err < 0)
> > +             goto out;
> > +
> > +     err = do_mount("tmpfs", "/root", "tmpfs", 0, NULL);
> > +     if (err)
> > +             goto out;
> > +
> > +     err = ksys_chdir("/root");
> > +     if (err)
> > +             goto out;
> > +
> > +     err = do_mount(".", "/", NULL, MS_MOVE, NULL);
> > +     if (err)
> > +             goto out;
> > +
> > +     err = ksys_chroot(".");
> > +     if (!err)
> > +             return;
> > +out:
> > +     printk(KERN_WARNING "Failed to create a non-root filesystem for initramfs\n");
> > +}
> > +#endif /* IS_ENABLED(CONFIG_TMPFS) */
> > +
> >  void __init mnt_init(void)
> >  {
> >       int err;
> > @@ -3734,6 +3777,10 @@ void __init mnt_init(void)
> >       shmem_init();
> >       init_rootfs();
> >       init_mount_tree();
> > +
> > +#if IS_ENABLED(CONFIG_TMPFS)
> > +     init_nonroot_initramfs();
> > +#endif
> >  }
> >
> >  void put_mnt_ns(struct mnt_namespace *ns)
> >
>
> thanks.
> --
> ~Randy
>
