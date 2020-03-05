Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFF7C3F2D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250632073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eP4PywIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCEWqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:46:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39582 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgCEWp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id j1so325329wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9sq0PtD8PNHpFz8zMGkeDZ+7pm8RbcY+CPM2RzsDCk=;
        b=eP4PywIzRgVit2fpuHBiJTdsQvjshoxSOh+qwoBlcybf0i9xDogLqT85o71Fi+P/9R
         HqEZaI2rHhglnVfO4somc6sf5/USl645wLlCurxZb506neBqVAeK3vvwdyzZulnC4Pvw
         RDa21VXWYGFnhH5bAKrAPk8ugJx7zo2dBEoVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9sq0PtD8PNHpFz8zMGkeDZ+7pm8RbcY+CPM2RzsDCk=;
        b=TkNhtB/ynLkQepx+T7aCbLmNwLIu2aOCHdWjZZgQ6xJ5i4N4RfiMiNhh8F+BPzOn7C
         Q+khWv+ANlk7w5FSgzZlyr/x0ZQO/zPMCDflERHNJrlkGvR+4+lLnEmXuHKxL2hVBNxu
         bl+a2jimw83zDu3C4q/qdctXBqSjDI2XfQTiGfzE2uMNgmh4s0UVCkLJ5xFOaJeffIi1
         /NInNGIblRvek/iCHAik7HQYovBU1bcl6KGMCt+juUjTI+ff5P7Efg9JwDfy/HrJmomq
         xMxIz0FDYICeRjiTFAtrG6f733rUjD6yJBE7NInpvHF/DExnTl9oozbmCR+dcj8LCQ6t
         vjTA==
X-Gm-Message-State: ANhLgQ1qfeER4ptcljye3D5zK8mNvMQVDDh73hpkXRPf8m/GRzzmspCn
        TTEmIAttnvl+57dbnFao5Px5J6gXOS2KyvV4ZqZ6HQ==
X-Google-Smtp-Source: ADFU+vvqVjTvY+ZvpBG/SyVlH1n2le8rs/DsJ6zfYE+D9t4+SBuVLkfUK8u0gAALeIFdhOzKl45G1+kCL0B1PLJNdRM=
X-Received: by 2002:a05:600c:291a:: with SMTP id i26mr29766wmd.161.1583448355691;
 Thu, 05 Mar 2020 14:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20200305193511.28621-1-ignat@cloudflare.com> <20200305202124.GV23230@ZenIV.linux.org.uk>
In-Reply-To: <20200305202124.GV23230@ZenIV.linux.org.uk>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Thu, 5 Mar 2020 22:45:44 +0000
Message-ID: <CALrw=nF-0E2icB85aU6hDoGmukQ0Hp_b0Un0savTco=meQV4uw@mail.gmail.com>
Subject: Re: [PATCH] mnt: add support for non-rootfs initramfs
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 8:21 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Mar 05, 2020 at 07:35:11PM +0000, Ignat Korchagin wrote:
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
> > One can solve this problem from userspace, but it is much more cumbersome. We
> > either have to create a multilayered archive for initramfs, where the outer
> > layer creates a tmpfs filesystem and unpacks the inner layer, switches root and
> > does not forget to properly cleanup the old rootfs. Or we need to use keepinitrd
> > kernel cmdline option, unpack initramfs to rootfs, run a script to create our
> > target tmpfs root, unpack the same initramfs there, switch root to it and again
> > properly cleanup the old root, thus unpacking the same archive twice and also
> > wasting memory, because kernel stores compressed initramfs image indefinitely.
> >
> > With this change we can ask the kernel (by specifying nonroot_initramfs kernel
> > cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
> > before the initramfs handling code, so initramfs gets unpacked directly into
> > the "leaf" tmpfs with rootfs being empty and no need to clean up anything.
>
> IDGI.  Why not simply this as the first thing from your userland:
>         mount("/", "/", NULL, MS_BIND | MS_REC, NULL);
>         chdir("/..");
>         chroot(".");
> 3 syscalls and you should be all set...

(sorry for duplicate - didn't press "reply all" the first time)
Container people really prefer pivot_root over chroot due to some
security concerns around chroot.
As far as my (probably limited) understanding goes, while the above
approach will make it work,
it will have the same security implications as just using chroot: we
trick the system to perform
pivot_root, however we don't get rid of the actual host root
filesystem in the cloned namespace.
