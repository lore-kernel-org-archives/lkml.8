Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED6C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC3C20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaB1Z5tA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgEENpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729022AbgEENpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:45:14 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4795C061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:45:12 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g16so1886322qtp.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpZGV2cFYdg509BirBHZ7UsYovRP7E9mXl70khXE+Yg=;
        b=oaB1Z5tAY1jA4cgdEhNqen4ZiSZ0IF7LyeOMXells7W87g5yIUHpfarJaZ/cEaPa/J
         HP/hdI1Hb1lXcUqCXlGiCFp4TfVFNcDffbI6X5ib62sLdNwloT5X/JFIXI/OAQwFP2Oh
         P/yLfXsjqI2+zMMTaqKwpfGqidgwOqTHNMwltC6NGSXGmHnLHX5vCn87BKhEu2jODPRD
         edLP/YNScbyqtBmPDy3aEQPAMRGeuhgiuswpuU9LQnNxMUq9s6ny2ibN//I4Tw9IOirm
         7/FUUe4PKtnl1QquB6uqIfnH4Es3LEqkKVFLF9zvOKSSfYjDS+m57uJaTkCDZif4snYS
         y2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpZGV2cFYdg509BirBHZ7UsYovRP7E9mXl70khXE+Yg=;
        b=t69LFpm+T/d6Xju6NCNdHbvgSpZOb2gzNfi6LOW0rQH6gVRwWuRtShJ7gjzdR6KNnU
         RGVcIwWsG6TokWLNphKueDRc4Ktte1dtUnLsoN2kUDXqNei49BQV6hUe79ELnkFhs9Ag
         vTCV66wHyygjEDqQKshM19qvKbd7iC1K5tN8YCY0A0TbhQrTpY4vQWEgllx04WS3k1pw
         pxf7KlIsKUrqJdtw9mJYnGU8swlikeP1orO6PGdgA7sJWBhG3gfdxDB/fo/+z9pM8g1x
         +kd1dLoiMsYN6BdN4ejopnBRnmUlBrEdmNrUtAcTLNEHuX16MivwCLulSqQdq8mA4al1
         mfnQ==
X-Gm-Message-State: AGi0PuYDnjbY4iZnwP+wMhDJhQdcZUaEr6LWy3wkcjEvp73SSSvJpfWB
        FD1Ma2O36TnmuYXHKvLkg8+d8qbA8f1G9Sxj29Tklg==
X-Google-Smtp-Source: APiQypIQnqlnKlTUwTz4stU5KhGXfg9rPA+FBzDsV7Uz9ztLly+3ic300+uRgn67dm2QVbQb4u+5SRDs7KZNqIQtvwI=
X-Received: by 2002:ac8:6c24:: with SMTP id k4mr2653777qtu.257.1588686311674;
 Tue, 05 May 2020 06:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000610eb059e429abd@google.com> <1588684948.13662.11.camel@suse.com>
In-Reply-To: <1588684948.13662.11.camel@suse.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 5 May 2020 15:44:58 +0200
Message-ID: <CACT4Y+YqeYnH7ZynaAOhddCQF=yoV-=2QSV+doAA0sW6Nxe71w@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in betop_probe
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+07efed3bc5a1407bd742@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

,On Tue, May 5, 2020 at 3:23 PM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Montag, den 10.02.2020, 17:16 -0800 schrieb syzbot:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    e5cd56e9 usb: gadget: add raw-gadget interface
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1517fed9e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8cff427cc8996115
> > dashboard link: https://syzkaller.appspot.com/bug?extid=07efed3bc5a1407bd742
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147026b5e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1683b6b5e00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+07efed3bc5a1407bd742@syzkaller.appspotmail.com
> >
> > betop 0003:20BC:5500.0001: unknown main item tag 0x0
> > betop 0003:20BC:5500.0001: hidraw0: USB HID v0.00 Device [HID 20bc:5500] on usb-dummy_hcd.0-1/input0
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
> > BUG: KASAN: slab-out-of-bounds in betopff_init drivers/hid/hid-betopff.c:99 [inline]
> > BUG: KASAN: slab-out-of-bounds in betop_probe+0x396/0x570 drivers/hid/hid-betopff.c:134
> > Write of size 8 at addr ffff8881d4f43ac0 by task kworker/1:2/94
> >
> > Freed by task 12:
> >  save_stack+0x1b/0x80 mm/kasan/common.c:72
> >  set_track mm/kasan/common.c:80 [inline]
> >  kasan_set_free_info mm/kasan/common.c:337 [inline]
> >  __kasan_slab_free+0x117/0x160 mm/kasan/common.c:476
> >  slab_free_hook mm/slub.c:1444 [inline]
> >  slab_free_freelist_hook mm/slub.c:1477 [inline]
> >  slab_free mm/slub.c:3024 [inline]
> >  kfree+0xd5/0x300 mm/slub.c:3976
> >  urb_destroy drivers/usb/core/urb.c:26 [inline]
> >  kref_put include/linux/kref.h:65 [inline]
> >
>
> Hi,
>
> this indicates that I am confused. Why are we getting an out-of-bounds
> on a freed region? Is this a strange way of reporting access
> to already freed memory?

Hi Oliver,

This is being tracked in:
https://bugzilla.kernel.org/show_bug.cgi?id=198425
