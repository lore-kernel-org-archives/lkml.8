Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3489AC2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF9820772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gePLR3I5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbgDAJNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:13:10 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36505 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgDAJNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:13:09 -0400
Received: by mail-qv1-f68.google.com with SMTP id z13so12444485qvw.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkMgyGLx/BAkeNtxDN6Xm/ZbanBZQvNQbU7eOJcnXos=;
        b=gePLR3I5HlC84w7tgJzEsRDClSwTX0vkukGGPouc74j9tPxnFXOnMxG8zqKusXyLSD
         P1CXTLsHgRD/S8Q8S5YIH4ka/bNjg1DuR3op0rVEU8qu0/3qvutPbOxc2nl/iI4PR1x3
         kISWfSQmZqfiL2nFZ6Rb5KCWgl65Wka5UzT/xrbBgOXxVwSphSnqGCN+0f7ErOkgeCzo
         pdkfIyKq3i2TpWjKqfjvvvBKyxACnt5KZbkN1iV4yOXUi95SDk+EdLX7WIfIWb+0/FFM
         axOTi9LYHzFUG7NygICZeM4Vfcw9ZoImKssVQE87l7r8QgXtWFHq59KR2dylCJRYjYsK
         0DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkMgyGLx/BAkeNtxDN6Xm/ZbanBZQvNQbU7eOJcnXos=;
        b=PoZF48U52L8FDdB1zpwdzNB6+Sm2g6DV03Oc7UgRlRh0t2fe6umjqT7YgzLM4A3Eg4
         iQ0N6/KZoecB8llwxVBGezDJBShZsu/GubP6Zq3EntY+TWcEB9/SHmFguf8Unuz5Lxgi
         yIAoHdm3JUOb1WlehTrDv6KuMLr7PhgNVAk6R23V4QDpXgrEDL1nWMrjb2j3SZyZQ2nl
         8uZWxGu9JKItB1ZxkgDsTOgTyXFU0SrbqPmrcsUC9SIDDwVWbJMXP1weZdmvtY4asjaL
         u5k4Vg7hGR1TzlTtJnOuR5LI01zLTBKD5oK/PQLiYxQrkSU7lhHLuJtgWW1X99IjW/Y3
         grAA==
X-Gm-Message-State: ANhLgQ1ad3NTmPEGEGbUHWcHtVyxqBkdtWkkIOCCkqUhQoMgJCR7Uy6V
        RMCoI4H4kGcM77ZFBEAv+5kw0MsqFnRJt+Zqw269Pg==
X-Google-Smtp-Source: ADFU+vs06wImJZ2EPBdCY2ie1qh0IX+7CluGHJHL2V6FICU7OeYMC84ibT4JTW0BL1dvRyCt/qMHZuA5ONrD8dluF/U=
X-Received: by 2002:ad4:49d1:: with SMTP id j17mr21052173qvy.80.1585732387345;
 Wed, 01 Apr 2020 02:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000da6059059fcfdcf9@google.com> <0000000000005b022005a22a0050@google.com>
 <20200331174116.GA1844017@kroah.com> <CANEJEGuhZChGXFzbwaEwArM4UKjUxZo=WNbREPH3887xtu62Nw@mail.gmail.com>
In-Reply-To: <CANEJEGuhZChGXFzbwaEwArM4UKjUxZo=WNbREPH3887xtu62Nw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Apr 2020 11:12:55 +0200
Message-ID: <CACT4Y+Yk_93iScH6F0hhR2yo+pCx_0J32TaTC-_QfXy69pauMA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in skb_release_data (2)
To:     Grant Grundler <grundler@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        syzbot <syzbot+a66a7c2e996797bb4acb@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, festevam@gmail.com,
        Hayes Wang <hayeswang@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>, kernel@pengutronix.de,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, nishadkamdar@gmail.com,
        peter.chen@nxp.com, Prashant Malani <pmalani@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 7:44 PM Grant Grundler <grundler@chromium.org> wrote:
>
> On Tue, Mar 31, 2020 at 10:41 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 31, 2020 at 10:36:01AM -0700, syzbot wrote:
> > > syzbot suspects this bug was fixed by commit:
> > >
> > > commit d9958306d4be14f4c7466242b38ed3893a7b1386
> > > Author: Nishad Kamdar <nishadkamdar@gmail.com>
> > > Date:   Sun Mar 15 10:55:07 2020 +0000
> > >
> > >     USB: chipidea: Use the correct style for SPDX License Identifier
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d4940be00000
> > > start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> > > git tree:       upstream
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=a66a7c2e996797bb4acb
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c25a81e00000
> > >
> > > If the result looks correct, please mark the bug fixed by replying with:
> > >
> > > #syz fix: USB: chipidea: Use the correct style for SPDX License Identifier
> >
> > I really doubt a comment change fixed a syzbot bug :)
>
> Just as I don't believe the bug was caused by pmalani's patch to r8152.
>
> syzbot is just having trouble automatically bisecting/tracking this
> bug since it appears only intermittently.

Checking if vmlinux changes after applying the patch looked like a
smart and simple way to detect all of:
- Comment-only change
- Documentation-only change
- Change to a non-current arch
- Changed to non-enabled configs
- Changes to tests only

But it's not working in reality, there is some bug in kernel or compiler:
https://github.com/google/syzkaller/issues/1271#issuecomment-559093018

You may see in this bisection log as well:
culprit signature:
85ed07d5a8769c26fa0d170475624841e367ea0d08ea79f55ca450a9e97429a0
parent  signature:
2244116b3fcae3bb24003990bcd2b06a03861effee2d94675e527446c3da078f

So this commit somehow does very realistically affect the kernel
binary. So far nobody figured out why...

Before you ask, syzkaller filters out debug info, etc:
https://github.com/google/syzkaller/blob/master/pkg/build/linux.go#L168-L178
