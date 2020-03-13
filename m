Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A910C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50361206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+sI1cXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCMHn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 03:43:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33442 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCMHn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 03:43:27 -0400
Received: by mail-qk1-f193.google.com with SMTP id p62so11002317qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXhlxw0H0UxInHwvt9KvKKCMEzPCeaquOmuSCkPzud0=;
        b=h+sI1cXCwzNduk1+KPxBrjiJYQOJhEB0mg1jOSbiThtaXOYgLygUPLsJgyMcUYqjgN
         JUhe/9+M6vPYo6QxRjrb7XxaaKIXzWSrJvpBCUY4cr+hKbHf6WWVLJcNum9L9BX1TSbj
         atglcrYR1CPrbvpeHJXv7Yo+tQgF0kymGjZVklcE1ySLXGlRZkM9xpvdx+Dtgomy8kw0
         G0cw2y/3vUPPdmR3MVQNQ2VY1pG2dEg+gubS/G41CgwXMuM8OKYVID8wN/xWZ1/LNHN7
         hCb7LIoRr46x0wc/6etuKcGD/SON+kvqoNPb6f63krKPo74VXCScmYWaLgyaIPSQ9+M7
         cNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXhlxw0H0UxInHwvt9KvKKCMEzPCeaquOmuSCkPzud0=;
        b=ZoYEGdGMHHUh6R6KT/1ntll/LwypSg3HCq1SJas6fmDiPyRkZ1IxpP3U580Vj7K7Wh
         W7LgpXxhaX0+1WgFEwp2vsRzsohap0Y+VZvorFi46/wpWXuSRzxIiGG6CjRPA8Gei9kQ
         2c4ckcHaDAMTTq4aEGUpKuZXij+39bl0UMDfatXjT6/ptRjL6aZAsvHOqiWbreHRTOMk
         yR9SYJKJ2PPSM2wYBKvx0A3tMvUJW9OnGJXNUZgv6x31y3SFxKrnxzySIOSnHKTdlXPM
         PdmtGX/p1kjKQ1gmE6u1tBOxPTPE+Cs3HFIZQY0j/S41ShFk0gsiV24F7fPrTqlcfncY
         4hVg==
X-Gm-Message-State: ANhLgQ2kpBmFHjA+iivD/RFAL60jja2gW3ORTYLYTZ0YFlPrdNBf4v8K
        zFcujI7iGT61CjcH2zCu6u+WIyCJ0+5uSO15gzvsTQ==
X-Google-Smtp-Source: ADFU+vv8dcCrPh+V242OIdOde/pzqrPhm9pDTY7ZzK3ExFlbMkoVEYuIf/fgtBwAnbyxkgkPs4su4NISkLxAtMh92+w=
X-Received: by 2002:ae9:e003:: with SMTP id m3mr11947751qkk.250.1584085406355;
 Fri, 13 Mar 2020 00:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eb546f0570e84e90@google.com> <20180713145811.683ffd0043cac26a5a5af725@linux-foundation.org>
 <CACT4Y+b1HC5CtFSQJEDBJrP8u1brKxXaFcYKE=g+h3aOW6K3Kg@mail.gmail.com>
 <5f715c98-2b81-4eee-be3c-11cbc1bc36a8@googlegroups.com> <CACT4Y+ZCKFXK+9Bw1__ofUBLy6y8mQRoQHm5Qt135mByOrYk8g@mail.gmail.com>
 <CALMp9eRuaFnav=ZUJdb1AefkCPhzH9rjpSHis_4XNVFG4rRimg@mail.gmail.com> <CALMp9eTVzEMpGEOhOKxH8tjyggeXFJ=+3xxipzQ=yFB3cT85GA@mail.gmail.com>
In-Reply-To: <CALMp9eTVzEMpGEOhOKxH8tjyggeXFJ=+3xxipzQ=yFB3cT85GA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 13 Mar 2020 08:43:15 +0100
Message-ID: <CACT4Y+bCat++Gc5H2JYjsQQ2hzQyEa3H-VKmb93H7tLrTVS31A@mail.gmail.com>
Subject: Re: unexpected kernel reboot (3)
To:     Jim Mattson <jmattson@google.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 9:36 PM Jim Mattson <jmattson@google.com> wrote:
>
> On Wed, Mar 11, 2020 at 1:35 PM Jim Mattson <jmattson@google.com> wrote:
> >
> > On Wed, Mar 11, 2020 at 1:18 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > > This happened 10K+ times.
> > > If GCE VM is rebooted by doing something with KVM subsystem, I assume
> > > it's a GCE bug (?). +Jim
> >
> > The L1 guest may have done something that's unsupported, or it may
> > just be a bug in the L0 hypervisor.
>
> I can't reproduce this in GCE with the collateral provided.

As far as I understand, this may depend on GCE host kernel and/or host
CPU, right? Do we have an ability to unit test on all combinations?
Looking at the rate and reproducers on the dashboard I see interesting
patterns. Perhaps the best time to try to reproduce is these periods
when syzbot comes up with lots of reproducers. But it's not now...
