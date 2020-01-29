Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4C9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EE420716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHycOpck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgA2PG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:06:58 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46241 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgA2PG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 10:06:58 -0500
Received: by mail-qv1-f66.google.com with SMTP id y2so4300688qvu.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 07:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InuKBX2au5PgZW6T2UC0fko2cqbcK+Z9FZ9mVarwTPc=;
        b=UHycOpckqcmEHlujxurhr+2yzJXIdF3P7M/bxMu5HRHXUFMy8t5uMpeIIvIg1zAf5a
         9O/hNk7D/5yWbFCcGAmsKMfAfuBtI7SpykFLDbojMWNcU+0Bltcr98zTC2AnVpvojl1U
         1BVzpyYAs5zc7l1o40O6rgqjAzUvfLnkNpaYhIGOZlu6GfF+RSyCvS+ah7wl66zbboVN
         GG5mZR2jJavEE60EAldt5qavIpwXX56JK5PB7+AHnQD9PbOXfurtN4qmGbPRvvNYdW7H
         I/9oH45TGNXxln3ZF2BpyQ5Vu19jrkPl4KQ6KGwstRBIOiE0PfrRsDtOzoPS0dEOMS+j
         pe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InuKBX2au5PgZW6T2UC0fko2cqbcK+Z9FZ9mVarwTPc=;
        b=OTQP0GZl6uwAjzb5qtoYpU+jrVtVzE4ocA8wzROt0+93frmQT1z+us4Ieii2qLPo0h
         7eo+eoVPrRkXfy7ojxgq/ZaeBlJ4lzcvYlh3y7EqXIOTuJYIQ7IBt7BfJ+0c3ti64ncq
         ewSDBqoxw0fpnEaGG3k51uwSsJzhF/JgMeTV/Zl6Ab0B9WKeoleMtMsEH9fRAVyF8Ij5
         fqVzY/VH06aIiYj62Bt7x4bdEOOizcswafxtRovsW6hHKWEvibGcnjC4MNduTRs/tH0e
         dzn7A9p6yh/0/c3X6sqg4YiLe/jQD2WVRBNK3/BLYLfQekweb0690YQ4V2/F1Xm+/2Pw
         rjKA==
X-Gm-Message-State: APjAAAUGv+1SGY9AWiwZ3jcAm9VQViCM5JhyDTzLa7035wuPhQfIfMGc
        WlCA6oBI6N+J8st6P5CdOt2/0NdPF5EQ/HhTbX066g==
X-Google-Smtp-Source: APXvYqxGXya7Ub3SmIcL1siAW7Ztqg0GnN7Sc8WRiWlrbmRJSMj/AvnQ1pJy7D+Vx9YUjv/TNuT7lT3ae0M7TlCuxdc=
X-Received: by 2002:a05:6214:1874:: with SMTP id eh20mr28761173qvb.122.1580310416499;
 Wed, 29 Jan 2020 07:06:56 -0800 (PST)
MIME-Version: 1.0
References: <CAA=061EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com>
 <CGME20200128124918eucas1p1f0ce2b2b7b33a5d63d33f876ef30f454@eucas1p1.samsung.com>
 <20200128124912.chttagasucdpydhk@pathway.suse.cz> <4ab69855-6112-52f4-bee2-3358664d0c20@samsung.com>
 <20200129141517.GA13721@jagdpanzerIV.localdomain> <20200129141759.GB13721@jagdpanzerIV.localdomain>
 <20200129143754.GA15445@jagdpanzerIV.localdomain> <CACT4Y+bavHG8esK3jsv0V40+9+mUOFaSdOD1+prpw6L4Wv816g@mail.gmail.com>
In-Reply-To: <CACT4Y+bavHG8esK3jsv0V40+9+mUOFaSdOD1+prpw6L4Wv816g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 29 Jan 2020 16:06:45 +0100
Message-ID: <CACT4Y+arS5GsyUa0A0s51OAWj7eJohZsCoY-7cuoU0HVsyeZ6Q@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in vgacon_scroll
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     anon anon <742991625abc@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 3:59 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jan 29, 2020 at 3:40 PM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> >
> > Cc-ing Dmitry and Tetsuo
> >
> > Original Message-id: CAA=061EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com
> >
> > On (20/01/29 23:17), Sergey Senozhatsky wrote:
> > > > Hmm. There is something strange about it. I use vga console quite
> > > > often, and scrolling happens all the time, yet I can't get the same
> > > > out-of-bounds report (nor have I ever seen it in the past), even with
> > > > the reproducer. Is it supposed to be executed as it is, or are there
> > > > any preconditions? Any chance that something that runs prior to that
> > > > reproducer somehow impacts the system? Just asking.
> > >
> > > These questions were addressed to anon anon (742991625abc@gmail.com),
> > > not to Bartlomiej.
> >
> > Could this be GCC_PLUGIN related?
>
> syzkaller repros are meant to be self-contained, but they don't
> capture the image and VM setup (or actual hardware). I suspect it may
> have something to do with these bugs.
> syzbot has reported a bunch of similar bugs in one of our internal kernels:
>
> KASAN: slab-out-of-bounds Read in vgacon_scroll
> KASAN: slab-out-of-bounds Read in vgacon_invert_region
> KASAN: use-after-free Write in vgacon_scroll
> KASAN: use-after-free Read in vgacon_scroll
> KASAN: use-after-free Read in vgacon_invert_region
> BUG: unable to handle kernel paging request in vgacon_scroll
>
> But none on upstream kernels. That may be some difference in config?
> I actually don't know what affects these things. When I tried to get
> at least some coverage of that code in syzkaller I just understood
> that relations between all these
> tty/pty/ptmx/vt/pt/ldisc/vcs/vcsu/fb/con/dri/drm/etc are complex to
> say the least...


It would also be good to figure out how we can cover this on syzbot/upstream.

Our upstream config is:

$ grep VGA upstream-kasan.config
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_FB_VGA16=y
CONFIG_VGASTATE=y
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_LOGO_LINUX_VGA16=y
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_VFIO_PCI_VGA is not set

where anon's is:
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_FB_VGA16 is not set
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_USB_SISUSBVGA is not set

And the one on which are catching the bugs in vgacon on internal kernel is:
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_VGASTATE is not set
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_VFIO_PCI_VGA is not set


May it be related to CONFIG_VGASTATE?
