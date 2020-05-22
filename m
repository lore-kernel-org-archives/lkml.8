Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ED5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB6020814
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Gk2163ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgEVHxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgEVHxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:53:16 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F08C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:53:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 79so10430971iou.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hMIF0bX1Z2ctSQRsIH8bL7klvWMt1Ycgv5mMdX899A=;
        b=Gk2163dsjAuCNMV7LA/ZO42nMwxeZZ8nqJ1CBTIwgC8z9GLVnppYZnzstChQrm2qfD
         8mK9im+afdMDewIqO5+X0zY8inurUF6yBtXCr4le9dq07HdNqzliYP9linligez9q6A4
         vz5QgloIQQzgBn68xxitBfY7Z/LTbARHOfPzkJ85zkXpSMx997hIS9xwP2ZvNBtV0vlF
         vMWlbsnsL2vmVoJo2A+kURB5Z24W+eD7ovARCe+hLsKTyGNk6JMBNtxzJ3142utLLo4h
         XBZFh7Wpw3WPne/kbai3pyc0huvqfMtLzf7bZ/JqN7UuT379sgLl2mz4R8+evKeOPCON
         njuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hMIF0bX1Z2ctSQRsIH8bL7klvWMt1Ycgv5mMdX899A=;
        b=OeFBz2ZPI3Uz2lsqH75XnzuZlDnSJPMs4IMOGq7EXtCWXG/kNwE78fSneAhjXCYUew
         4r7CqSDWyFt0WDZPbEtjJX/yKR9TWQK/b0yTYAxC+6hV9YKhRNeWu1GNxibcFqVb4Q6b
         pvEU47U7yvwRwrP0kckeOMNrORgOHcXpARmmz5oqbS7Ue1akUO2/9b+DgbUXgl5mfDQK
         gmpFUBELp2VHhNJ3lTk1qQvDxQy7VjwokmsAxB8lFaCmE9f0xrKFca5rjGcZXMwWCK4x
         lLeZ9OVvBVrHm/D5l6L2oH1rUkJmacLTEqWnMiss2sgI48fRv22nF7tjioVCB2f4TFbE
         Rb/g==
X-Gm-Message-State: AOAM5314gbj6tQazzUH/R+qvBkeOP18GMjhwcCS19XI2w+yO2fug6MNQ
        XUUElTdcn2/u5ScfevnyAlWuA0rX5aPWyJUf46F0FA==
X-Google-Smtp-Source: ABdhPJw8ie6elC0IvR64+rA0KFztqvvPkNu/yxHl9rVx5DEDKO3Y7o1i7gvscpCS/kn/kL6IVesi9lAsfGqChJXom24=
X-Received: by 2002:a5e:c603:: with SMTP id f3mr2039700iok.56.1590133995721;
 Fri, 22 May 2020 00:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200521123835.70069-1-songmuchun@bytedance.com> <20200521164746.GD28818@bombadil.infradead.org>
In-Reply-To: <20200521164746.GD28818@bombadil.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 22 May 2020 15:52:39 +0800
Message-ID: <CAMZfGtWn4xa-5-0rN2KJzUYioiOOUYX9BFcUDNZS85H11sYDEA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] files: Use rcu lock to get the file
 structures for better performance
To:     Matthew Wilcox <willy@infradead.org>
Cc:     adobriyan@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        ebiederm@xmission.com, bernd.edlinger@hotmail.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 12:47 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, May 21, 2020 at 08:38:35PM +0800, Muchun Song wrote:
> > +++ b/fs/proc/fd.c
> > @@ -34,19 +34,27 @@ static int seq_show(struct seq_file *m, void *v)
> >       if (files) {
> >               unsigned int fd = proc_fd(m->private);
> >
> > -             spin_lock(&files->file_lock);
> > +             rcu_read_lock();
> > +again:
> >               file = fcheck_files(files, fd);
> >               if (file) {
> > -                     struct fdtable *fdt = files_fdtable(files);
> > +                     struct fdtable *fdt;
> > +
> > +                     if (!get_file_rcu(file)) {
> > +                             /*
> > +                              * we loop to catch the new file (or NULL
> > +                              * pointer).
> > +                              */
> > +                             goto again;
> > +                     }
> >
> > +                     fdt = files_fdtable(files);
>
> This is unusual, and may not be safe.
>
> fcheck_files() loads files->fdt.  Then it loads file from fdt->fd[].
> Now you're loading files->fdt again here, and it could have been changed
> by another thread expanding the fd table.
>
> You have to write a changelog which convinces me you've thought about
> this race and that it's safe.  Because I don't think you even realise
> it's a possibility at this point.

Thanks for your review, it is a problem. I can fix it.

>
> > @@ -160,14 +168,23 @@ static int proc_fd_link(struct dentry *dentry, struct path *path)
> >               unsigned int fd = proc_fd(d_inode(dentry));
> >               struct file *fd_file;
> >
> > -             spin_lock(&files->file_lock);
> > +             rcu_read_lock();
> > +again:
> >               fd_file = fcheck_files(files, fd);
> >               if (fd_file) {
> > +                     if (!get_file_rcu(fd_file)) {
> > +                             /*
> > +                              * we loop to catch the new file
> > +                              * (or NULL pointer).
> > +                              */
> > +                             goto again;
> > +                     }
> >                       *path = fd_file->f_path;
> >                       path_get(&fd_file->f_path);
> > +                     fput(fd_file);
> >                       ret = 0;
> >               }
> > -             spin_unlock(&files->file_lock);
> > +             rcu_read_unlock();
>
> Why is it an improvement to increment/decrement the refcount on the
> struct file here, rather than take/release the spinlock?
>

lock-free vs spinlock.

Do you think spinlock would be better than the lock-free method?
Actually I prefer the rcu lock.

-- 
Yours,
Muchun
