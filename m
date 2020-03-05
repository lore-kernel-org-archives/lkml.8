Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A69C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7577C206D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b1JAp8/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgCEWyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:54:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40623 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEWyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:54:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id r17so129933wrj.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiDTbwvMn8WO9wINMLyHXgdgqSVs97pcrSC3Kr6hZio=;
        b=b1JAp8/IJOWv1m+6Ozb9cLVBTaZ5wHLqQQgeQusaZVS6W3rnbnp/lPkH0qGznO4pyL
         p4sMiQhR8IRLXYbFM3loBE7piAUHqV7dn0SuAPILrm0A9e/no2Q00SuI3L47iXeWImk5
         yWWwW7qGg05rrmK182hAktdzxTMCU7+pwq5zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiDTbwvMn8WO9wINMLyHXgdgqSVs97pcrSC3Kr6hZio=;
        b=oEjUGvOIlMrn4/5hPa9P0zDBHAqLdauhfNmjaWoRnYGlyZsIyvCsjGsh64UhsrIobN
         0b3QYGzOsVCurZIGjYnkYgzFMtlYES7wy/CV6R1dL2x/qOf0J1maGWoukWfFGTe4uvBZ
         ZJA3qFBD53g+pLzRGYgAgVLD6J+heQm77oIdFeDVF2GugQOxjk3UdLDl6nVGMdgja4bQ
         sIgBSZhDSdxi+Ny/X/5rmHctaXqRB4fLWaHKkroU1FRpSMCGh5mPto04uoVkyAu4Rdvg
         UJSeDMkrGK3R0j15L9ntMFkRbWTGM+HuKxgUrE40ayG+A5RGo96jMTBxKY1frS1+wi3B
         evxA==
X-Gm-Message-State: ANhLgQ0FfHZfBcChFnzeHb+eLmkqZwS94fiHHaCCvp1a+Xc4MCh2tOjp
        5hU309moRSZic28Yu8YizdswezNPn6zwlkKHtXrMoQ==
X-Google-Smtp-Source: ADFU+vuGBZvhgCiZerEs9r/+vkeGo1ctGGm1GxI5fgLBC8zGqFJJ+m4kRso/QZZ/pDKzt7VSXofXra2cS2bkJaijp9c=
X-Received: by 2002:adf:fc12:: with SMTP id i18mr202355wrr.354.1583448845752;
 Thu, 05 Mar 2020 14:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20200305193511.28621-1-ignat@cloudflare.com> <1583442550.3927.47.camel@HansenPartnership.com>
 <20200305222117.GA1291132@rani.riverdale.lan>
In-Reply-To: <20200305222117.GA1291132@rani.riverdale.lan>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Thu, 5 Mar 2020 22:53:54 +0000
Message-ID: <CALrw=nH3pOmjUqN44MkBPcBCXU4VrgT36Bs0R66aSdLPg08XQg@mail.gmail.com>
Subject: Re: [PATCH] mnt: add support for non-rootfs initramfs
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 10:21 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Mar 05, 2020 at 01:09:10PM -0800, James Bottomley wrote:
> > On Thu, 2020-03-05 at 19:35 +0000, Ignat Korchagin wrote:
> > > The main need for this is to support container runtimes on stateless
> > > Linux system (pivot_root system call from initramfs).
> > >
> > > Normally, the task of initramfs is to mount and switch to a "real"
> > > root filesystem. However, on stateless systems (booting over the
> > > network) it is just convenient to have your "real" filesystem as
> > > initramfs from the start.
> > >
> > > This, however, breaks different container runtimes, because they
> > > usually use pivot_root system call after creating their mount
> > > namespace. But pivot_root does not work from initramfs, because
> > > initramfs runs form rootfs, which is the root of the mount tree and
> > > can't be unmounted.
> >
> > Can you say more about why this is a problem?  We use pivot_root to
> > pivot from the initramfs rootfs to the newly discovered and mounted
> > real root ... the same mechanism should work for a container (mount
> > namespace) running from initramfs ... why doesn't it?
>
> Not sure how it interacts with mount namespaces, but we don't use
> pivot_root to go from rootfs to the real root. We use switch_root, which
> moves the new root onto the old / using mount with MS_MOVE and then
> chroot to it.
>
> https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt
>
> >
> > The sequence usually looks like: create and enter a mount namespace,
> > build a tmpfs for the container in some $root directory then do
> >
> >
> >     cd $root
> >     mkdir old-root
> >     pivot_root . old-root
> >     mount --
> > make-rprivate /old-root
> >     umount -l /old-root
> >     rmdir /old-root
> >
> > Once that's done you're disconnected from the initramfs root.  The
> > sequence is really no accident because it's what the initramfs would
> > have done to pivot to the new root anyway (that's where container
> > people got it from).
> >
> >
> > James
> >

Yes, to add to Arvind's point the above sequence will only work for
"old style" initrd (block ramdisk with some filesystem image on top),
but will not work for the "new style" initramfs (just a disguised
tmpfs). The sequence will fail on "pivot_root" with EINVAL (see
pivot_root(2)). In fact this patch conceptually tries to have the same
behaviour as with "old style" initrd. As currently, if you use initrd:
1. The kernel will create an empty "dummy" initramfs
2. Create a ramdisk
3. Unpack the FS image into the ramdisk
4. Mount the the disk
5. Do switch_root/move etc

So we have initial mount tree as: rootfs->some_initrd_fs
(and pivot_root works here and you get empty rootfs by default)

With this option we have similar in the end: rootfs->tmpfs
and rootfs is empty, because the kernel never unpacked anything there.
