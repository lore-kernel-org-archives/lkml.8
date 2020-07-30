Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C914EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4C02074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pE6CSjWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgG3IUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbgG3IHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:07:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4A6C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:07:25 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d18so27361174ion.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xk9Rc7RW0dpZR2H7aQdCd9x/8Qyf+LufFcyvFMA4TRc=;
        b=pE6CSjWSaGf1LyVds1/RMgYF8RUGn5TZJHXjYS/z/3WaD/zI5X1T9UbxdlEfExt4ww
         fiqw/WQL2m4SbqfCbmmkBHeRQhdJSW9DpRLqk8AR9klNEzDn7/B/DxPU58pcTa/roMhX
         q+NiInRLqX2FCBQqSqR6dwQePoBJg1KF++pHOAaL1fbTI2Pt7YBGj0qEbkSBbQ+gLBVT
         f1wmkKBYvpRYP+sJwr0AaAzhTNcWtqdtQ00XyCegbxhSgtCxlXIZ5LsbRBM4B2/sMoNW
         AIdPy1KUeQ6cltA6WKnQG6UCU/dajwelb3Ze02nd0x9mlUt6DJJGOH8d6VqI6qpXvQHi
         9byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xk9Rc7RW0dpZR2H7aQdCd9x/8Qyf+LufFcyvFMA4TRc=;
        b=ZakwWQwo/SPKBV/5anufCYDJWa8HHWcw8NJqnfX6GzHmu5cH+y5c/8Hy5TjSmUkiKT
         6J4jckBpGtCgdpyjA28PX97HXrfW5etDu5mNvG/XntzISplZAaMWp8hpVsowJT+uHtib
         cGEJaz17VHm0DI0uxhhDiAHkYL1j0f8vsRavIWyDrjTjWYfQeMnl0ubYDGrtVqRGg0Tl
         CT7kBIrpfx8dG1UyWSGCmeycak8xO+WUKsCHqk2a+cB6pMNhNnZsZOWjWSwL6DgmxiUu
         lWFD/weYVTOcaEOy7V9qzju7Nd984CNRDleG/M0T9EY2usHo4kVMb5IsN/wAM25SeVXv
         31Xg==
X-Gm-Message-State: AOAM533fc8hTUwq7I9pg8jKEaq17cY325nT4zvXrnkruOOZI13ZJEAgG
        /fazw8uXwCVMXeiecR8bcl5lxmnLxrzUTBLXWKMXEQ==
X-Google-Smtp-Source: ABdhPJxfkHJ3U7r6qBlC/pLcD5o2kytIEOIjvVwTzQ/51wksja7qhQ1JZwpuFNgqoFoF8gdCdxryLyzWjzfDs75oQlc=
X-Received: by 2002:a02:854a:: with SMTP id g68mr2156366jai.24.1596096444677;
 Thu, 30 Jul 2020 01:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200726220557.102300-1-yepeilin.cs@gmail.com>
 <20200726222703.102701-1-yepeilin.cs@gmail.com> <CAK8P3a3NB2BVo9fH-Wcinrhhs-QJ=9dK59Ds83TvgLmEkRy3qA@mail.gmail.com>
 <20200727131608.GD1913@kadam> <CACRpkda7k4L+nqAYE6z2FVZF-WT2Pm3CHH_=fW24xz_u+QCMRQ@mail.gmail.com>
 <20200728130632.GI1913@kadam> <CAK8P3a3MEUYH3qG-+dxgH1Omx2gtcqSRXzKLLaAw21Xho6HAeQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3MEUYH3qG-+dxgH1Omx2gtcqSRXzKLLaAw21Xho6HAeQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 30 Jul 2020 10:07:13 +0200
Message-ID: <CAMRc=MciXb152=CHAi1kfpwFuELLN55-BfNOo8hBg8Tzp4wMnQ@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH v3] media/v4l2-core: Fix
 kernel-infoleak in video_put_user()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vandana BN <bnvandana@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 3:58 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 28, 2020 at 3:06 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Tue, Jul 28, 2020 at 02:22:29PM +0200, Linus Walleij wrote:
> > > On Mon, Jul 27, 2020 at 3:17 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > > Here are my latest warnings on linux-next from Friday.
> > >
> > > Thanks for sharing this Dan, very interesting findings.
> > >
> > > > drivers/gpio/gpiolib-cdev.c:473 lineevent_read() warn: check that 'ge' doesn't leak information (struct has a hole after 'id')
> > >
> > > We are revamping the ABI for 64bit compatibility so we are now running
> > > pahole on our stuff. I suppose we need to think about mending this old ABI
> > > as well.
> >
> > Yeah...  But this one is a false positive.  It's not super hard for me
> > to silence it actually.  I'll take care of it.  It could be a while
> > before I push this to the public repository though...
>
> The lineevent_read() function still needs to be fixed to support
> 32-bit compat mode on x86, which is independent of the warning.
>
> Something like
>
> static int lineevent_put_data(void __user *uptr, struct gpioevent_data *ge)
> {
> #ifdef __x86_64__
>         /* i386 has no padding after 'id' */
>         if (in_ia32_syscall()) {
>                 struct {
>                         compat_u64      timestamp __packed;
>                         u32             id;
>                 } compat_ge = { ge->timestamp, ge->id };
>
>                 if (copy_to_user(uptr, &compat_ge, sizeof(compat_ge)))
>                         return -EFAULT;
>
>                 return sizeof(compat_ge);
>         }
> #endif
>
>         if (copy_to_user(uptr, ge, sizeof(*ge))
>                 return -EFAULT;
>
>         return sizeof(*ge);
> }
>
>        Arnd

Hi Arnd,

Andy actually had a patch for that but since this isn't a regression
(it never worked), we decided to leave it as it is and get it right in
v2 API.

Bartosz
