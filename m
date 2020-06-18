Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51A0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC2D207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0hZaVlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgFRMKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgFRMKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:10:42 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1ABC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:10:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l24so2828306pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iy/6jfGKd+Ed+qybvlGSsWGCaOiCD++gM/TgQv4eHHA=;
        b=t0hZaVlD5GvkzIevBROzY5lS96YBLGAH/1fvEJKUWlRiF25qrG5QFIlC1VT6EkkVjz
         W3ie0+aBFUGu08vEEPLa8CW7e+igis+F++6wlVCsLagA923iUzJbB2BVaiuCCHcWlKo4
         xelmsYsTot81nUguvtqnKmLj+ayAmageGjIw1vUsbfKYTHGlWJ/+WuiOBnAj6kN4yoRr
         5Puw7Q/hMUX7iDwIBQ04ExjGFDMyMd4IP8X+sjm/ne14uLo01V5/QHa2M3dBBe9AVHVM
         hxKoYariYsFX/AcFLVW0rBQtq78JKbW+VIWNSnjrQd4QwFG7EvJTKBILmXGJuljEl639
         Qq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iy/6jfGKd+Ed+qybvlGSsWGCaOiCD++gM/TgQv4eHHA=;
        b=BklPJrBBpsHyNpHQyA/O/gKep4ceTpUr+HAOP9wnZlYQfFJ3z6z53uOUBbuAfZPluh
         AqNqZsFp9/iAD6JYxuSsItw/S82QOaPDQ/IaTvEeu5DU8MZYCzkc97NN9Wowp+B1Nkbg
         iavxleFOGIIw/eg9v1eB0+2xtFhlKwFY0runYEybYO+avemDEdyNkmJUliAtcGQtkX+1
         lGTqxrZ4+dPfwX4Lc5eI0vXOg0E3OYSfFXEbpnN/wd/ErjILVw8HvA1iUFpD+U1RMttZ
         nXq8zjuR+lYuNN4U2NSfehY8DGSkVCyZaMdb7p/uPUkoX3rQj36dNLogxCK9jSWuqVZu
         ZHoQ==
X-Gm-Message-State: AOAM5305H6Jb3jXpW7MKDwVMlNfg2E4tzOEZnFFRJjHUT+PvFK9M5Zsa
        ih6xMnRfaNNmDgstjqQmqLxxOcXf/2PShUpDSDesIw==
X-Google-Smtp-Source: ABdhPJyDG5qDGt10MC50NMmkOoQjHBaCb37f8tnAQy+s4PJP87973+bL2Mnu9s4yayiMkJudk0VGKc3p5+lWrdDy+5Y=
X-Received: by 2002:a63:724a:: with SMTP id c10mr3077259pgn.130.1592482241245;
 Thu, 18 Jun 2020 05:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000daea9f0599fb7da6@google.com>
In-Reply-To: <000000000000daea9f0599fb7da6@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 18 Jun 2020 14:10:30 +0200
Message-ID: <CAAeHK+xaCyJPc-Mm3-wmOJh=xXrmXGuxYgsv2+zwDcqTYdoNWQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hidinput_hid_event
To:     syzbot <syzbot+00eaa791c74b27f5e7b1@syzkaller.appspotmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 3:45 PM syzbot
<syzbot+00eaa791c74b27f5e7b1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d533c992 usb: core: kcov: collect coverage from usb comple..
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e440aee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=743b91162e9f9496
> dashboard link: https://syzkaller.appspot.com/bug?extid=00eaa791c74b27f5e7b1
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1445d9fae00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12557049e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+00eaa791c74b27f5e7b1@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in test_bit
> include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
> BUG: KASAN: slab-out-of-bounds in hidinput_hid_event+0x1111/0x15d3
> drivers/hid/hid-input.c:1381
> Read of size 8 at addr ffff8881cf4d2cd0 by task swapper/1/0
>
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.5.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xef/0x16e lib/dump_stack.c:118
>   print_address_description.constprop.0+0x16/0x200 mm/kasan/report.c:374
>   __kasan_report.cold+0x37/0x7f mm/kasan/report.c:506
>   kasan_report+0xe/0x20 mm/kasan/common.c:639
>   check_memory_region_inline mm/kasan/generic.c:185 [inline]
>   check_memory_region+0x152/0x1c0 mm/kasan/generic.c:192
>   test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
>   hidinput_hid_event+0x1111/0x15d3 drivers/hid/hid-input.c:1381
>   hid_process_event+0x4a0/0x580 drivers/hid/hid-core.c:1506
>   hid_input_field drivers/hid/hid-core.c:1550 [inline]
>   hid_report_raw_event+0xabb/0xed0 drivers/hid/hid-core.c:1757
>   hid_input_report+0x315/0x3f0 drivers/hid/hid-core.c:1824
>   hid_irq_in+0x50e/0x690 drivers/hid/usbhid/hid-core.c:284
>
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

#syz dup: KASAN: global-out-of-bounds Write in kbd_event
