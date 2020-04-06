Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6902C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874A721D90
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="entol2rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgDFMle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:41:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40896 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgDFMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:41:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id r19so15098390otn.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sr72t4r7lxhc/Q3B1vivttix8afMzynpg5rTdMjQSoY=;
        b=entol2rHnqykEsDN6YkZxSuwSctDqAnKsid7hRR+PoqC5lMipLmtfJhXeba6wjsCWm
         rfaehblGx+Me4JYjbyW4WDcJeNAIw072KujfJUYa5Ld5UR+7o3ji9LNAJu4QZHm7mDfm
         U9KG1jjMrh/5skPTpZMtN9W1LtYTC7V9W6cd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sr72t4r7lxhc/Q3B1vivttix8afMzynpg5rTdMjQSoY=;
        b=c8tz9TN+bQflHr5CZ0aL4iFG8bLtuIei2/Ikc0KVHXPdwNTGb1SmsG5w/X6UhuJDLf
         mF0dgyeyJ1YLP49p8ybLwM6C06ccpeQ3eTTFbrWHuJTWZzR8PukUaX8QqZJApCwOvvfU
         qAMzEPuWpC0jxLwY0FBRFqoXFbnZB6NpIKUhQcUdb+ydLmvIHBa0ZeCqdqzJ4hgqP/W8
         Ce0B5wT6mS+ZdTHEu+pYHNX6LbOFXRTk0CxNtREhdQcguvsNIoZBoOkiO8gbhv+RroAu
         9/NXJSvB9phUfJEUlYpH4oj4pGNs6fds4l5T1taxjt5Nc7Y7gWWCEQxh5QCfqq9agsIc
         Js4A==
X-Gm-Message-State: AGi0PuaEP1lbMe3Wm2bf+9aZYk7frPJouQBDLoDnGWmqBcB5Ksy2BA4v
        uAPcJusI8nZoCxh6EJmwcBy5jKyDA9zDjqujACbftQ==
X-Google-Smtp-Source: APiQypJhwSTomdaZtFjbOnK4dQzBkSIMoNjO/uvTMoS9iCK7mUxexLxDXb1kSUc2EnvnB9OZEl1Z8vmKzFMuNZf8nBs=
X-Received: by 2002:a9d:6e8f:: with SMTP id a15mr18136881otr.188.1586176891766;
 Mon, 06 Apr 2020 05:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000091056b05a2999f1e@google.com> <CACT4Y+b4RcgG_GrcpaghmqhX47zUVsAcGGd6vb6MYJT=6gf89g@mail.gmail.com>
 <20200406080612.v5ubxvyliuso6v5h@sirius.home.kraxel.org>
In-Reply-To: <20200406080612.v5ubxvyliuso6v5h@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 6 Apr 2020 14:41:20 +0200
Message-ID: <CAKMK7uE9uQ_YCXfDOH9zQBu_ffoz546hqRd1R_r1+L-T072Lew@mail.gmail.com>
Subject: Re: upstream boot error: KASAN: slab-out-of-bounds Write in virtio_gpu_object_create
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com>,
        David Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 10:06 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Mon, Apr 06, 2020 at 09:07:44AM +0200, Dmitry Vyukov wrote:
> > On Mon, Apr 6, 2020 at 8:46 AM syzbot
> > <syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    ffc1c20c Merge tag 'for-5.7/dm-changes' of git://git.kerne..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1690471fe00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d6a1e2f9a9986236
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=d3a7951ed361037407db
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com
> >
> >
> > +drivers/gpu/drm/virtio/virtgpu_object.c maintainers
> > Now we have both mainline and linux-next boot broken (linux-next is
> > broken for the past 40 days).
> > No testing of new code happens.
> >
> > >  virtio_gpu_object_shmem_init drivers/gpu/drm/virtio/virtgpu_object.c:151 [inline]
> > >  virtio_gpu_object_create+0x9f3/0xaa0 drivers/gpu/drm/virtio/virtgpu_object.c:230
>
> Ah, that one.
>
> broken patch: f651c8b05542 ("drm/virtio: factor out the sg_table from virtio_gpu_object")
> fixed by: 0666a8d7f6a4 ("drm/virtio: fix OOB in virtio_gpu_object_create")
>
> Both are in drm-misc-next.  I suspect the fix was added after
> drm-misc-next was closed for the 5.7 merge window and thus should
> have been submitted to drm-misc-next-fixes instead.
>
> So, what to do now?  Should I cherry-pick 0666a8d7f6a4 into
> drm-misc-next-fixes?  Or should it go into drm-misc-fixes instead?

Yup cherry-pick it over, with -x, to drm-misc-next-fixes.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
