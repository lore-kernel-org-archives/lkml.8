Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8D0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D9D2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRc/dzK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgA2O7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:59:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40537 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgA2O7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:59:20 -0500
Received: by mail-qk1-f193.google.com with SMTP id t204so16441904qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 06:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFFnDEPV8qmyFvWAxO/SsQ1ehnqonaxGmlVfD7DOHfw=;
        b=VRc/dzK3xlehE4NkXiPMTzQvco1YgZqPdC67Aj4XVnuYXdNkzl3gH/3q9wgQCEXrEp
         1WnH9g1GcpcXS/Dadf2PmPjf3BZ1tB89mrZor0Wv6gVb//ED/V9CL85atg8KgIGRbhoE
         UtpOfEjAmgSf0JjL1XlYUR85oWVnW4Did/+iD4hBaKVQD7KQ7PA/i/ZXC3jRIlIcLRbm
         fWUiWIK0RbJxX116SieaSBN3Vnhk6IGxcF3q+sAeB/0tG8ytEOjqZWVUaPOOmh9krclh
         TqIfKEGMyzHJF5V+3bcrRFQBXvSpG3gFoTJ/3goH0dBXGPN7cGqbebQ5QRBCj4Q1+75r
         SzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFFnDEPV8qmyFvWAxO/SsQ1ehnqonaxGmlVfD7DOHfw=;
        b=FZ7ekcfD/Uq8CBPVyZL6dBqINyVD+HmWzv6cs4S9NA6Y0fzE41ttaprjfyZW2MNAai
         3pvXI3IyT84QI9ZqLVubc+wd1zD3lgUaPzQsFymktq+Suhv3Cnd2zDHT/AdJPxNdCon5
         qB6c4Khe/dZN+FSm6C/SJSMvfFTaWiblE5mSuUiu5AcwmwRv9PoYL2EkvjjHD9HMS8p3
         5j+kjLK74UaJnbjHEV4R5MFO0Vkfrb9+g6RC8dx4OGOTyhPnR2F1yIK3Qd6aI5a2wwl+
         34l+MdY2oamsWMlvFjXBev1jZGh7W1wFE+UGC7RCgt4vrFglnhc6rdfFcDQnYrKpyEcv
         oQew==
X-Gm-Message-State: APjAAAXnOCbS5b97D+2bZ7YH7aGMXSk8EgkhB/+VokTsOsWB4+VXwWD8
        XL4uWj6wcToqpEMlqMnqXHzZJqCk8ReXWo5CsH+jmA==
X-Google-Smtp-Source: APXvYqwBRCLvaDwM/oWv/aFmiTw4TFm3vq6Ctvjx34oTuJTJNW+q/P9l5V5F0gFF1pyjOyG52SAL74GWBo5NlxJ1bQI=
X-Received: by 2002:ae9:e50c:: with SMTP id w12mr25953401qkf.407.1580309959502;
 Wed, 29 Jan 2020 06:59:19 -0800 (PST)
MIME-Version: 1.0
References: <CAA=061EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com>
 <CGME20200128124918eucas1p1f0ce2b2b7b33a5d63d33f876ef30f454@eucas1p1.samsung.com>
 <20200128124912.chttagasucdpydhk@pathway.suse.cz> <4ab69855-6112-52f4-bee2-3358664d0c20@samsung.com>
 <20200129141517.GA13721@jagdpanzerIV.localdomain> <20200129141759.GB13721@jagdpanzerIV.localdomain>
 <20200129143754.GA15445@jagdpanzerIV.localdomain>
In-Reply-To: <20200129143754.GA15445@jagdpanzerIV.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 29 Jan 2020 15:59:07 +0100
Message-ID: <CACT4Y+bavHG8esK3jsv0V40+9+mUOFaSdOD1+prpw6L4Wv816g@mail.gmail.com>
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

On Wed, Jan 29, 2020 at 3:40 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> Cc-ing Dmitry and Tetsuo
>
> Original Message-id: CAA=061EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com
>
> On (20/01/29 23:17), Sergey Senozhatsky wrote:
> > > Hmm. There is something strange about it. I use vga console quite
> > > often, and scrolling happens all the time, yet I can't get the same
> > > out-of-bounds report (nor have I ever seen it in the past), even with
> > > the reproducer. Is it supposed to be executed as it is, or are there
> > > any preconditions? Any chance that something that runs prior to that
> > > reproducer somehow impacts the system? Just asking.
> >
> > These questions were addressed to anon anon (742991625abc@gmail.com),
> > not to Bartlomiej.
>
> Could this be GCC_PLUGIN related?

syzkaller repros are meant to be self-contained, but they don't
capture the image and VM setup (or actual hardware). I suspect it may
have something to do with these bugs.
syzbot has reported a bunch of similar bugs in one of our internal kernels:

KASAN: slab-out-of-bounds Read in vgacon_scroll
KASAN: slab-out-of-bounds Read in vgacon_invert_region
KASAN: use-after-free Write in vgacon_scroll
KASAN: use-after-free Read in vgacon_scroll
KASAN: use-after-free Read in vgacon_invert_region
BUG: unable to handle kernel paging request in vgacon_scroll

But none on upstream kernels. That may be some difference in config?
I actually don't know what affects these things. When I tried to get
at least some coverage of that code in syzkaller I just understood
that relations between all these
tty/pty/ptmx/vt/pt/ldisc/vcs/vcsu/fb/con/dri/drm/etc are complex to
say the least...
