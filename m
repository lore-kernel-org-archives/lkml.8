Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C8DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0E2206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udMylkJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgFJPOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbgFJPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:14:49 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E01FC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:14:49 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s21so2354091oic.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDtkEAKzZyv3dXNpsPsqMVmJ4Y+cSfCKakpKBa1zwUc=;
        b=udMylkJsBkLSPX/fhP5jeC4vIZEIk7TjusiPwvDt4TqgrxhpxZ32ukAYcSJ5mMIM9/
         gboTn/jhWul6F0UPWXzXg7jF4ZdDjjdwpiV7Sl8cLMvCDhOBOxJJGxdfWChSjWjNVmIh
         vpKi/71gW267IO6ChJVTCWAdeNh3yRhOyFajVZn9Bcl5PFGWoWyEvfkJ6+oZQJGfuo2s
         RumZM5ygadgjL17Q4SHDCYZLwcQ15xcngMgMDL5NNLosOL7bI+wqMcq161vNf+oWYHen
         4LIlPYpPZ5BIuUp53K9CHX8rMpO7BHFKXoBYKpJutad2geY1d6L+GMb/Nfu0+SiUBmRr
         F4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDtkEAKzZyv3dXNpsPsqMVmJ4Y+cSfCKakpKBa1zwUc=;
        b=c6kkTzBD8x9czCvL0YU+YMQw/kxDmrvO7xppto+E6Sclb+BmHKrBG+VQn3ePmGcIii
         OooDHmGlnekpyYM2ZoeTM+Y8+N0xqV96My3qoFRGt00fHx5rB0Op/3JEzARrYOTqE13e
         LyPhG1fMM28XCbpKZwY/kPyJPU2FHI+zOqn9yHV6LclqkYgfh2ue6bW8Rfa1N6wLGWe+
         q4nRLPdZjrcO3GtrckWfJ6a1AqhANnlkqb0HRZagNWm9uct0EKkEqyatvNI2xsoBQSMr
         tjUxCutimx/Enkbh5jAIkEVGevAUpy+BvhQvJ7AiDH2OEETb1GX7z3Sr9vT7Q3GdJgH1
         gZiw==
X-Gm-Message-State: AOAM530uZLdPV29SJm4boVPf9MjBXW10yjxnvRxk4RlHbGaaaICb64T/
        w0qHvrL7pohRRpQe5ed/5GMsRZtaE/t1Cb6dzge0Lw==
X-Google-Smtp-Source: ABdhPJz7VsuBtbPfx9RhfASCfcCtNEZDfA1tM4aFTMIKx3YAxZCxiJua2WBQytWigumUFZm42pnwJaUbj0Binjq2P/c=
X-Received: by 2002:aca:1308:: with SMTP id e8mr2665439oii.119.1591802088505;
 Wed, 10 Jun 2020 08:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200610083333.455-1-sumit.semwal@linaro.org> <CAK8P3a0PzmtWc1p-KgHzHhY+=gca0J8YsGD=ALGESWsgijQQ7w@mail.gmail.com>
In-Reply-To: <CAK8P3a0PzmtWc1p-KgHzHhY+=gca0J8YsGD=ALGESWsgijQQ7w@mail.gmail.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 10 Jun 2020 20:44:37 +0530
Message-ID: <CAO_48GEqxOOOZupGLAa92HXcnbe6_3ZfLvaJsDnv9_XFTTFe6w@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Move dma_buf_release() from fops to dentry_ops
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chenbo Feng <fengc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linaro MM SIG <linaro-mm-sig@lists.linaro.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        syzbot+3643a18836bce555bff6@syzkaller.appspotmail.com,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 at 14:57, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jun 10, 2020 at 10:33 AM Sumit Semwal <sumit.semwal@linaro.org> wrote:
> >
> > Charan Teja reported a 'use-after-free' in dmabuffs_dname [1], which
> > happens if the dma_buf_release() is called while the userspace is
> > accessing the dma_buf pseudo fs's dmabuffs_dname() in another process,
> > and dma_buf_release() releases the dmabuf object when the last reference
> > to the struct file goes away.
> >
> > I discussed with Arnd Bergmann, and he suggested that rather than tying
> > the dma_buf_release() to the file_operations' release(), we can tie it to
> > the dentry_operations' d_release(), which will be called when the last ref
> > to the dentry is removed.
> >
> > The path exercised by __fput() calls f_op->release() first, and then calls
> > dput, which eventually calls d_op->d_release().
> >
> > In the 'normal' case, when no userspace access is happening via dma_buf
> > pseudo fs, there should be exactly one fd, file, dentry and inode, so
> > closing the fd will kill of everything right away.
> >
> > In the presented case, the dentry's d_release() will be called only when
> > the dentry's last ref is released.
> >
> > Therefore, lets move dma_buf_release() from fops->release() to
> > d_ops->d_release().
> >
> > Many thanks to Arnd for his FS insights :)
> >
> > [1]: https://lore.kernel.org/patchwork/patch/1238278/
> >
> > Fixes: bb2bb9030425 ("dma-buf: add DMA_BUF_SET_NAME ioctls")
> > Reported-by: syzbot+3643a18836bce555bff6@syzkaller.appspotmail.com
> > Cc: <stable@vger.kernel.org> [5.3+]
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Reported-by: Charan Teja Reddy <charante@codeaurora.org>
> > Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
>
> The patch looks correct to me.
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> Obviously this should still be verified against the original report if possible.
Thanks, Arnd!
>
> >  drivers/dma-buf/dma-buf.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 01ce125f8e8d..92ba4b6ef3e7 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -54,8 +54,11 @@ static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
> >                              dentry->d_name.name, ret > 0 ? name : "");
> >  }
> >
> > +static void dma_buf_release(struct dentry *dentry);
> > +
> >  static const struct dentry_operations dma_buf_dentry_ops = {
> >         .d_dname = dmabuffs_dname,
> > +       .d_release = dma_buf_release,
> >  };
>
> I'd suggest rearranging the file to avoid the forward declaration, even
> if it makes it a little harder to review the change, the resulting code
> will remain organized more logically.
Got it, will update it in v2.
>
> >  static struct vfsmount *dma_buf_mnt;
> > @@ -77,14 +80,14 @@ static struct file_system_type dma_buf_fs_type = {
> >         .kill_sb = kill_anon_super,
> >  };
> >
> > -static int dma_buf_release(struct inode *inode, struct file *file)
> > +static void dma_buf_release(struct dentry *dentry)
> >  {
> >         struct dma_buf *dmabuf;
> >
> > -       if (!is_dma_buf_file(file))
> > -               return -EINVAL;
> > +       if (dentry->d_op != &dma_buf_dentry_ops)
> > +               return;
>
> I think the check here is redundant and it's clearer without it.
Ok, will remove.
>
>           Arnd

Best,
Sumit.
