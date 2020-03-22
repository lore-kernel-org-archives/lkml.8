Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B2EC4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1422F20732
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpanGY9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCVNny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:43:54 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36048 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgCVNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 09:43:53 -0400
Received: by mail-qv1-f68.google.com with SMTP id z13so5758640qvw.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfkm4qDHJF0j1h7yV3iuIObqDhIo9L+RuUef/w4kNrQ=;
        b=GpanGY9Pbx8tQwMygJGCR6uWHh49kOht9cgocBLA+Xr1AzVgOsJ29rsyQiUyB8QGpF
         ShXltEpe+/+N+uieoVHEZWhMAUVrO2+wqHYnOMkFp/FzERQxhlA7Ygbqdq9A1xxhQRvU
         /igVj2WNqblFqAkV9EOMWHoZO5TLGjc0zfKlI6BzdIZwztDeB9v0xF0nQ5cdgbhueeNN
         K40Dde1cnjPANSHxJ+vF/RCkPhRLZ3LXw9LF0zoioE3o561FMo0iNz4/6S2f/8xiwQFY
         H92EFkYDwxhKlr/4VmgVmmxHR8mXGLIWebUe44ojxqqeJEDf8lauXR2R0DGIJc9lmF90
         0Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfkm4qDHJF0j1h7yV3iuIObqDhIo9L+RuUef/w4kNrQ=;
        b=t4iidYLs+gK0MYt2L3R/mwFEH2PdOoYTtCFn3gOP7Uzf67061DaKSkSdgByOjvYJ0R
         ZICu6KEiuJFTfjBiioave2eRwXB4h/Uax7OVpqM2gZHjdBZi2QyKwV1idTtUV+U7tnhm
         ztZNDUVaulYSw5mGn/Fz5nWjw5zctynWKzsVHaruXesF01KN3InX737j/HfkMkhfyWur
         jQbskX7OexHVGJ8sg4Yc4IaLsAsozXzlpCoZPIeYAgFZmXpsiMqvHWiV7fEr1E04264l
         0DgqK1Vw+9dgoJ+lqVt/pNQpL9L40/oFF6iDzjwF/a/tb7ajkbJwft5yrpzh4FDgDhAj
         cfxg==
X-Gm-Message-State: ANhLgQ30jWCDYgUarZgXnx8R0MunQOrp+M6ZQ79wlqvBOZwR2FpIGheS
        S+VaeYcW3evJmQFxEZShuSed9jqdI00pskI8JlacRA==
X-Google-Smtp-Source: ADFU+vtXIKY75T4uXrHCS90aIU/nIoX+WOv3uLm5a0ti0Wue34MeQ1eSlU4oBfzMxNJbPwYJq9ilSqklf/BKchR4TEg=
X-Received: by 2002:ad4:5051:: with SMTP id m17mr5182989qvq.122.1584884631847;
 Sun, 22 Mar 2020 06:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000277a0405a16bd5c9@google.com> <0000000000008172fe05a17180aa@google.com>
In-Reply-To: <0000000000008172fe05a17180aa@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 22 Mar 2020 14:43:40 +0100
Message-ID: <CACT4Y+YGjaD4dobFgB7ieVi3wbG72_EPdXuJQ+h4qQq1Qncspg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in handle_external_interrupt_irqoff
To:     syzbot <syzbot+3f29ca2efb056a761e38@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Miller <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kuba@kernel.org,
        KVM list <kvm@vger.kernel.org>, linux-afs@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, wanpengli@tencent.com,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 2:29 PM syzbot
<syzbot+3f29ca2efb056a761e38@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit f71dbf2fb28489a79bde0dca1c8adfb9cdb20a6b
> Author: David Howells <dhowells@redhat.com>
> Date:   Thu Jan 30 21:50:36 2020 +0000
>
>     rxrpc: Fix insufficient receive notification generation

This is unrelated.
Somehow the crash wasn't reproduced again on the same commit. Can it
depend on host CPU type maybe?

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1483bb19e00000
> start commit:   b74b991f Merge tag 'block-5.6-20200320' of git://git.kerne..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1683bb19e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1283bb19e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6dfa02302d6db985
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f29ca2efb056a761e38
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1199c0c5e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15097373e00000
>
> Reported-by: syzbot+3f29ca2efb056a761e38@syzkaller.appspotmail.com
> Fixes: f71dbf2fb284 ("rxrpc: Fix insufficient receive notification generation")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
