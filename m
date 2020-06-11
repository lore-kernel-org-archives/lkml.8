Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C321C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E6420747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="te1Hv+GH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgFKAXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgFKAXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 20:23:36 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6D3C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 17:23:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so4779485ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 17:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zV/9caxagCyIgNigVOFFt2aaFjY9J+PRXT/oGFhZoBA=;
        b=te1Hv+GHACPwT4DA++rJFJ/v3/XNg3hh/4gDbj8OIzHkNr69uTfNOUJPCX06fhhN8/
         kx0MeincOnv3n4QRO5/8bwLa4/tWIrRZRTU8G3iiZ4Ehg6Y3Dx91VusjFvthPDoJzBoj
         OyrIMXYKoas2GuSrSdKE5Qc4UZ9uKao2ehjk1gdTyELWoJugx1o+NDTb/Da/XQAU6sti
         oBgKbMA5vqbo3hCgKilnS4Jkdt3tUlLDntipU88NvPr7lQvVU1nrgC6BHCq9SEh5hnMm
         AXTspRe3VFtgvuzE77N/L65s1LZqVrT0X0jSPEgjo5B1n1cONZpcATOv0qShKzuXT0zJ
         svNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zV/9caxagCyIgNigVOFFt2aaFjY9J+PRXT/oGFhZoBA=;
        b=B2E9EdgmBW4DZXiGBSZJ6h5/uqrJSEJqWSe3tkSMP+bkq796IVZuhIX8NN0mKXKv6A
         +beRNmPXgo/LRHgQzlnf7J6pBpXP6Zvvq4Jcy9n/V1l9UQ9Vqm9xdqBhmC9dKcEcPvIF
         8ey3Zbd9vL4QPTgT4PfaYt2/taDePiYAo3YF/o+HDMzU7T11jGFYAKezL9U0iGkeRL5B
         6yRQmGHt0HXoKtiEso+7JLmCirVQKT/M2uhcdpRSVPj/0h8ATN4o67zNp6Jl1dD7ClLQ
         BXe1XHZJn4mj8Ph7g6tdCPRaVSvLrPTtTYLHWOCah5+PY8+3t6Ck1Cn9eVYtwNIMdEGg
         bEJw==
X-Gm-Message-State: AOAM5316pcQ9/uuXx8iYrp0/53bAtFEbANvZ9MLpBcX2XF96A6KdTtwI
        QGayW03iGpgGCHpBzYsIGxhpEeT5q+PCLuJktNJlMsRpYk1K+Q==
X-Google-Smtp-Source: ABdhPJwBgNDz9TnVUBsL2EOIQbMcDqxr3+qfLLpfzqynJHiVW5HH249mUncGSSbG+NEqUaB9xbjqBXNlLtk2WrVwa9A=
X-Received: by 2002:a2e:a0cc:: with SMTP id f12mr2812617ljm.250.1591835014295;
 Wed, 10 Jun 2020 17:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200609060137.143501-1-daeho43@gmail.com> <20200609165107.GA228564@gmail.com>
 <CACOAw_xEZ+au9yhFerq9amkRO62Dzxj7h71gEc=i16ReYu5xrg@mail.gmail.com>
 <20200610031532.GA6286@sol.localdomain> <CACOAw_wErOPC=Kf3UU8nFGhWRy84ZnCeJbsyPhSCcXv51B_XxQ@mail.gmail.com>
 <CACOAw_zka6d06RxFOUTwEV7B6o8A2-_6FvqWh_A1nJ0+7FU9yQ@mail.gmail.com>
 <CACOAw_yc4hxdyxyO+Lb4MArHek1tP4wxCq0tezWOocgqvK+tqg@mail.gmail.com> <20200611000037.GC1339@sol.localdomain>
In-Reply-To: <20200611000037.GC1339@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 11 Jun 2020 09:23:23 +0900
Message-ID: <CACOAw_xqHnL0MthPykSrKJ8OXez-XigCFgC-vwm_keEZh_g8zw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I saw the implementation in vfs_write().
But if we use mnt_want_write_file() here, it'll call mnt_clone_write()
internally if the file is already open in write mode.
Don't you think the below thing is needed? We can increase the counter
each of them, open and ioctl, like other filesystems such as ext4.

int mnt_clone_write(struct vfsmount *mnt)
{
        /* superblock may be r/o */
        if (__mnt_is_readonly(mnt))
                return -EROFS;
        preempt_disable();
        mnt_inc_writers(real_mount(mnt));
        preempt_enable();
        return 0;
}

2020=EB=85=84 6=EC=9B=94 11=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 9:00, E=
ric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Jun 11, 2020 at 08:53:10AM +0900, Daeho Jeong wrote:
> > > > > > Using FMODE_WRITE is more proper for this case, since we're goi=
ng to
> > > > > > modify the data. But I think mnt_want_write_file() is still req=
uired
> > > > > > to prevent the filesystem from freezing or something else.
> > > > >
> > > > > Right, the freezing check is actually still necessary.  But getti=
ng write access
> > > > > to the mount is not necessary.  I think you should use file_start=
_write() and
> > > > > file_end_write(), like vfs_write() does.
> > >
> > > I've checked this again.
> > >
> > > But I think mnt_want_write_file() looks better than the combination o=
f
> > > checking FMODE_WRITE and file_start_write(), because
> > > mnt_want_write_file() handles all the things we need.
> > > It checks FMODE_WRITER, which is set in do_dentry_open() when
> > > FMODE_WRITE is already set, and does the stuff that file_start_write(=
)
> > > is doing. This is why the other filesystem system calls use it.
> > >
> > > What do you think?
> >
> > Hmm, we still need FMODE_WRITE check.
> > But mnt_want_write_file() looks better, because it'll call
> > mnt_clone_write() internally, if the file is open for write already.
>
> There's no need to get write access to the mount if you already have a wr=
itable
> fd.  You just need file_start_write() for the freeze protection.  Again, =
see
> vfs_write().
>
> - Eric
