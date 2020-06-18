Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E419AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF11F207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ImTybs6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgFRMLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgFRMLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:11:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFADC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:11:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so2459977pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PL1HZQ8aaf++sBDojnbREv0sad8DZMIxx3HxxbQPktU=;
        b=ImTybs6DruPYHljttLxe3i82qqe38RYrzsWOiNu4v4WFmRJQhCWTUH2Eg+ri0dAG1h
         DX1yIRtMTqd1Z8GDpciM2xSA2or4G0c2g+rNzfCQDzIb/4K+8NTnjDYceyj7ebodX42t
         7UR35htjQy4yfrZn3bz862O+BK2Pzfi9DcrCEil89oiyovCgt73FOr6bP3EhUR9VWurn
         j92pzNgNRmr1CD+Aej9I9p12F+CA/rYuPuiYQf+8YS0FNKnLBFH6F0LUFtOoiP0/cb6S
         SHfbN7lRNX881SKaAOR2VwzZS3dmVCOihKDMDtlg+Sq45gRKAySiOcNaJRuLR6Qe7FlX
         Ix1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PL1HZQ8aaf++sBDojnbREv0sad8DZMIxx3HxxbQPktU=;
        b=jVmiNrM7MSw2qe5EYeLpFZBysl+9pP/bnm220L+74nzeahzP6iIx1JhAJ8O+nzHb4s
         cXxu9lOHGJZeKow46Eok8W5GfCFmSkh2J6EC4a7PZFlXk/qFzBrcrFrg1VavlaOHYEd0
         kr2aMDOxOZYpJlijwmA9xlYuz/pV3eZOvE0qRlCMMbqhNmxLqYv1uRr7PH72voNRHhvS
         LSS6KvHZ9am4SyPaJYbVR5y/xAJzdmdv03wAcrElx4+cBYfDJM9YqX7TlAUYHSj8/bXL
         eA5hBwjpD1u3HImP4yLG1Ko5yatjVXF/hyk2DJaV0d4q9QNOpq9ROJ41tAHtefKkftLK
         FwuQ==
X-Gm-Message-State: AOAM532u5ShGgpkQNvKQ+9z5rGnge2/POdwmIy6VQt0foRc4Y5BOhRWF
        B7lbO8X8hI5aW4O79rXYwf2wO5DKlae2uIPCARYmTQ==
X-Google-Smtp-Source: ABdhPJz5oTPlMwHiusukbIWc/vaQWY32BCs4Y1k7faNUTrJ2XV1v8N/fDB+AUu0LHbK4GNDNqVn4eAd48V1QkYIaMsI=
X-Received: by 2002:a17:902:6ac1:: with SMTP id i1mr3586925plt.147.1592482268172;
 Thu, 18 Jun 2020 05:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000b9e820599fbe9a7@google.com>
In-Reply-To: <0000000000000b9e820599fbe9a7@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 18 Jun 2020 14:10:57 +0200
Message-ID: <CAAeHK+ya=UAGYZMOW3AKfdo+Qqj_MY6TYVQUfe3s7d75GH+-4g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in hidinput_hid_event
To:     syzbot <syzbot+c961cb836a707f66e2f8@syzkaller.appspotmail.com>
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

On Wed, Dec 18, 2019 at 4:15 PM syzbot
<syzbot+c961cb836a707f66e2f8@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d533c992 usb: core: kcov: collect coverage from usb comple..
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=100798b9e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=743b91162e9f9496
> dashboard link: https://syzkaller.appspot.com/bug?extid=c961cb836a707f66e2f8
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15519951e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166f72fee00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c961cb836a707f66e2f8@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in test_bit
> include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
> BUG: KASAN: use-after-free in hidinput_hid_event+0x1111/0x15d3
> drivers/hid/hid-input.c:1381
> Read of size 8 at addr ffff8881cfb19738 by task swapper/0/0
>
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.0-rc2-syzkaller #0
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
>   __usb_hcd_giveback
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
