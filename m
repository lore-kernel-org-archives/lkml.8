Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1574C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A902920665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khxyAtO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgB1MxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:53:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42498 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgB1MxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:53:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id 15so1681423pfo.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 04:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvtq6YgokW3dOsLf2LiPLCXiFYliWMU8X+XdnMUFWTY=;
        b=khxyAtO9q1wRQ+lcr4BsHyhmrJldouT8tHUupK/MZO/ZAUYk0/7vF97R72t0CoaEKy
         JueyKryrU/84wqmBTlYE9VnXL3BKt2Chqyy3/WT0mNdcGs/h9GDtjBeTa5ENhthLvN7J
         pcucStY7cyn4ZZ87wJKaPubABydibuewIdKqsn4nPl2MM3kSziMyUSFW6MF5igElPFC3
         3KY/DO9VB4NahsgYIihMqOfMNQib1RNbnBI0XFqw9+COeMG5YNnPCYjzh9Ml1gO1F9gk
         ga5N+/yuwrgzPuDFuXbTkLORhCbst8Ukk48hOQ+he2pWpMISOnySanzh8VR0ps8Z8jiX
         tRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvtq6YgokW3dOsLf2LiPLCXiFYliWMU8X+XdnMUFWTY=;
        b=hJ8k6SWjanglYA5VH6h+Y3DHQIjEYZVC/hvH8cWgYHZKkyJ+6kqP6p0Vi9HtdO4UEW
         fUw3WNXANieMI8pk2pUih7yzFmnwsn10evVi57uEXou20Bp0epdXBM+hUtTZwp7DfaR4
         s64fkiqyJYoCD1DyZ+eM8Q/Lu82lutXu5NEO1tk8R9l3X6DCNjrgwZg+asWcEZhrypBj
         tG/vs3WFG7bKzuY98A23+Gy+SgRPFEPnCJMFGRjwUGHpkLdvGBzJkikCTTT/ocoGnBmV
         Msad8uh2E744oE1AxMX80MptELaUoNTHkWdsB3b7beJ1kRVjfIZd80KhSiDDBWHK2SIY
         8R+w==
X-Gm-Message-State: APjAAAVB7WOCXY+B2zXZXCa9QHWjqH4hlJVhlSTzRts80dOspAwAkmCr
        UUxeSlwn6LB44mkR8Br86zMw1CMM/eHO2f5Vl/kBKQ==
X-Google-Smtp-Source: APXvYqzpwNsgK3YVAW6YE68jIRhoDu3kMleJRygqKjLOc2b4xFIq5YJb+HtXnkwHHxD99JTpetytK9OtGZnpjMJoanU=
X-Received: by 2002:a63:f242:: with SMTP id d2mr4526336pgk.130.1582894385752;
 Fri, 28 Feb 2020 04:53:05 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003bf3fb059fa247eb@google.com>
In-Reply-To: <0000000000003bf3fb059fa247eb@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 28 Feb 2020 13:52:54 +0100
Message-ID: <CAAeHK+wXm115pU+rTpFQ_293bF6w9_5pgsEeZrFpeEQMPGBSCA@mail.gmail.com>
Subject: Re: BUG: bad host encryption descriptor; descriptor is too short (1
 vs 5 needed)
To:     syzbot <syzbot+2470d4931705e03b0977@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 1:50 PM syzbot
<syzbot+2470d4931705e03b0977@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d6ff8147 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=15cd9a81e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=90a3d9bed5648419
> dashboard link: https://syzkaller.appspot.com/bug?extid=2470d4931705e03b0977
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cfbd09e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170e3645e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2470d4931705e03b0977@syzkaller.appspotmail.com
>
> usb 1-1: config 0 interface 0 altsetting 0 has 2 endpoint descriptors, different from the interface descriptor's value: 4
> usb 1-1: New USB device found, idVendor=13dc, idProduct=5611, bcdDevice=40.15
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> hwa-hc 1-1:0.0: Wire Adapter v106.52 newer than groked v1.0
> usb 1-1: BUG: bad host encryption descriptor; descriptor is too short (1 vs 5 needed)
> usb 1-1: supported encryption types:
> usb 1-1: E: host doesn't support CCM-1 crypto
> hwa-hc 1-1:0.0: Cannot initialize internals: -19
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz dup: BUG: bad host security descriptor; not enough data (4 vs 5 left)
