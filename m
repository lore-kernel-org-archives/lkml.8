Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCD6C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53702077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="lZYtk3M1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgDAJbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:31:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54924 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgDAJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:31:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id c81so5785503wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 02:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cxtvDm1VvJFB9Mgn1VqvYbCokzNoQWD8prtGIwBZ3MQ=;
        b=lZYtk3M149mrSzxboHicdNgduVmvN4GsyG3JuDDEEYVoYhE0HL02ybjXbaXTAnexeW
         4lis+tJxsraFjN8nan3Gwr/vijdEhz3wNgUmGq15Iwvd41vPtFs7DX1Aaw8Aw/PEg+Hi
         layedYFdZEK9izXv8X2l4kCHmoROw8Or7jBz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cxtvDm1VvJFB9Mgn1VqvYbCokzNoQWD8prtGIwBZ3MQ=;
        b=puKJQzDJjGqnBr6pCUl6qdzlbAhIkTvmjvZ0mA0Us+CsSY4B3qCf6Y8r1RGnhUAhiy
         C+XkICyHsO/QDITB8d2S7jPwzkhY93lRneXfrDSx8xjiAOlitVglM/LwARwnAA9EBo5Q
         LFBl6Rs4nLKfKC9Sa5IeUUv1XBYlM0/E9onlMvTaV/NvQaDE+N4eEFmhft2Q/AXJn8Bj
         RL0QiAyJl4U4RZ/UmQr3kccwUYiZ4A8vY4hZXjGGmB8mHF/n2KkxSKlExDJ2UdyZg8QK
         KOV+SdhtQSJ0Z0O+cbWkfki+fpB+Kz0yMCVXvQVpvCvyYCjh/VcnU9phVFTEObga/Jcx
         7oBg==
X-Gm-Message-State: AGi0Pua8fTa6Lc90yHgRMtAUGq/Fa6TyWDmYW/S+QbqcIIT15M5BKEVT
        YtAUXNLFLXXDbrrveRUDfjfSG9e65aO9ysb4m1ExjA==
X-Google-Smtp-Source: APiQypJBhc6QztWy3dXB2l0pETwxSIYbA2CAzK7s7Kmg8aFV6Sim+2d+QHvwULmkvbEHsJej660OniyDDX8XG8KVbsk=
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr3190261wmb.81.1585733461192;
 Wed, 01 Apr 2020 02:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200331124017.2252-1-ignat@cloudflare.com> <20200331124017.2252-2-ignat@cloudflare.com>
 <20200401063620.catm73fbp5n4wv5r@yavin.dot.cyphar.com> <20200401063806.5crx6pnm6vzuc3la@yavin.dot.cyphar.com>
In-Reply-To: <20200401063806.5crx6pnm6vzuc3la@yavin.dot.cyphar.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 1 Apr 2020 10:30:50 +0100
Message-ID: <CALrw=nFmi_f-c3fbU5ZizP228y4R2LxHdN8eQ1ht3YVBW0CWjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mnt: add support for non-rootfs initramfs
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        containers@lists.linux-foundation.org, christian.brauner@ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 7:38 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2020-04-01, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > On 2020-03-31, Ignat Korchagin <ignat@cloudflare.com> wrote:
> > > The main need for this is to support container runtimes on stateless Linux
> > > system (pivot_root system call from initramfs).
> > >
> > > Normally, the task of initramfs is to mount and switch to a "real" root
> > > filesystem. However, on stateless systems (booting over the network) it is just
> > > convenient to have your "real" filesystem as initramfs from the start.
> > >
> > > This, however, breaks different container runtimes, because they usually use
> > > pivot_root system call after creating their mount namespace. But pivot_root does
> > > not work from initramfs, because initramfs runs form rootfs, which is the root
> > > of the mount tree and can't be unmounted.
> > >
> > > One workaround is to do:
> > >
> > >   mount --bind / /
> > >
> > > However, that defeats one of the purposes of using pivot_root in the cloned
> > > containers: get rid of host root filesystem, should the code somehow escapes the
> > > chroot.
> > >
> > > There is a way to solve this problem from userspace, but it is much more
> > > cumbersome:
> > >   * either have to create a multilayered archive for initramfs, where the outer
> > >     layer creates a tmpfs filesystem and unpacks the inner layer, switches root
> > >     and does not forget to properly cleanup the old rootfs
> > >   * or we need to use keepinitrd kernel cmdline option, unpack initramfs to
> > >     rootfs, run a script to create our target tmpfs root, unpack the same
> > >     initramfs there, switch root to it and again properly cleanup the old root,
> > >     thus unpacking the same archive twice and also wasting memory, because
> > >     the kernel stores compressed initramfs image indefinitely.
> > >
> > > With this change we can ask the kernel (by specifying nonroot_initramfs kernel
> > > cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
> > > before the initramfs handling code, so initramfs gets unpacked directly into
> > > the "leaf" tmpfs with rootfs being empty and no need to clean up anything.
> > >
> > > This also bring the behaviour in line with the older style initrd, where the
> > > initrd is located on some leaf filesystem in the mount tree and rootfs remaining
> > > empty.
> > >
> > > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> >
> > I know this is a bit of a stretch, but I thought I'd ask -- is it
> > possible to solve the problem with pivot_root(2) without requiring this
> > workaround (and an additional cmdline option)?
> >
> > From the container runtime side of things, most runtimes do support
> > working on initramfs but it requires disabling pivot_root(2) support (in
> > the runc world this is --no-pivot-root). We would love to be able to
> > remove support for disabling pivot_root(2) because lots of projects have
> > been shipping with pivot_root(2) disabled (such as minikube until
> > recently[1]) -- which opens such systems to quite a few breakout and
> > other troubling exploits (obviously they also ship without using user
> > namespaces *sigh*).
> >
> > But requiring a new cmdline option might dissuade people from switching.
> > If there was a way to fix the underlying restriction on pivot_root(2),
> > I'd be much happier with that as a solution.
> >
> > Thanks.
> >
> > [1]: https://github.com/kubernetes/minikube/issues/3512
>
> (I forgot to add the kernel containers ML to Cc.)
>
> --
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>

In my opinion we just did not expect pivot_root to be so popular with
containers as well as the fact people are running full stateless
systems from initramfs rather than immediately switching to another
root filesystem on boot. This all feels to me use-cases which were not
considered before for the pivot_root+initramfs combo.

However now we see more and more cases needing this and the
boilerplate code and the additional memory copying (and sometimes
security issues like you mentioned), which can handle this from the
userspace becomes too much. I understand the simplicity reasons
described in [1] ("You can't unmount rootfs for approximately the same
reason you can't kill the init process..."), but to support this
simplicity as well as the new containerised Linux world the kernel
should give us a hand.

I currently see no reason why we can't apply this patch without the
cmdline conditional, because we would just be in the same place as we
would have used initrd instead of the initramfs. But I leave the
decision to the subsystem maintainers. After all, if you are running
from initramfs, this is a stateless system, so I would expect
maintainers of such system having an easy way to add the cmdline
parameter on reboot.

[1]: https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt

Ignat
