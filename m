Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CF5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1A9208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZ115KcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbgFSOYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733024AbgFSOYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:24:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D684C0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:24:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g12so3977123pll.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RY8kpVpM7lodY11RSLTnplr/cinEHPu5K7Smg6Q1P2A=;
        b=bZ115KcWZXs7c4ahUvcb/xbiijlWUHIg/Q6K/9JF6JH2bIF5nB3FELlzmsmvv+YMEN
         PyDgEY8NOeieSjyTd2BoFpdWV4pVcUZP06Dpqi5+3PxqsZbppXklk8KS4iDya1ykEtzK
         lZOaRsr2ewTan+s1FzuZqfon33qyjfwlqXn4JDqXHBhBdD9Ifxr1/igYrgNq+End9KvI
         K1Q0UrJJT0Kc0eY/VBeUlDDF+kVskjcI5feUmzCdn4c1vlrXnFL4TGqV2I4SJocp3dN5
         lVBwDlpzGd2YLttjB7Q6ffasK4uyTYt7kdYKFpAE78muLB08JbSBZClrmAJoVKSFCOs6
         4MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RY8kpVpM7lodY11RSLTnplr/cinEHPu5K7Smg6Q1P2A=;
        b=Yr7R2I7WRloo96mVBEdD6EzQEBMBJxvVz9w4N+yAPDz8Cgz7VuptOYflChd3apgePu
         DmkAJi0LzRepFi+01i3mliT7pKLVBmYW4gnqMqBwQMfEm/OiRhlR/1YWCIYSAFPsBFSa
         eTQFH9qmLX3kJDbABP4QosiVhibe6ZxV3I+/LK1M5vv9qUOrOS9rD8m/F4Rq8PyJlJ4P
         l+xkOi2dSJUcew5RxqfQb0eTK/6p9lziCtrbPSS9dVDPpy7C/ysXwZTDFvhtwsn2S4dM
         kTF+GS1dbqtNWswSFVaWvdb4+7A6mUmSmWEy+ZHqKZoUm6iWKyoZ2cP2lVC1IjNSUpLs
         tg8A==
X-Gm-Message-State: AOAM5329MnGX/o+WcsEI8RVGyyyVgbuCXlD24XcCv/tm1+/MxUOjeNNN
        Iotr9QV6N9/70RN6tFpcb4SQWau1k0AzgZBxyS5gPQ==
X-Google-Smtp-Source: ABdhPJyzkpKpXORnlDfu3HOs2bnsAu2O3ITik2hKPTV4r3qLFoVmfVixc+sjZhhgMJViipGH33mYgymarZBTBL8VVx0=
X-Received: by 2002:a17:90a:c283:: with SMTP id f3mr3599488pjt.166.1592576649034;
 Fri, 19 Jun 2020 07:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005166b905a845e639@google.com> <CAAeHK+zVVHK-XxFCTkRVB8WooDgCRbFRZqR7J8uPCNC0nu9fVQ@mail.gmail.com>
In-Reply-To: <CAAeHK+zVVHK-XxFCTkRVB8WooDgCRbFRZqR7J8uPCNC0nu9fVQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 19 Jun 2020 16:23:57 +0200
Message-ID: <CAAeHK+xZrVVzmHov1hEr+=qPXXKXUFbQxE9U9LAD+qdRAYb4cw@mail.gmail.com>
Subject: Re: WARNING in corrupted/usb_submit_urb
To:     syzbot <syzbot+120d387f677320f6a57c@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ingrassia@epigenesys.com, LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 2:58 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Wed, Jun 17, 2020 at 1:24 PM syzbot
> <syzbot+120d387f677320f6a57c@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    d6ff8147 usb: gadget: add raw-gadget interface
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=140052c3e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=90a3d9bed5648419
> > dashboard link: https://syzkaller.appspot.com/bug?extid=120d387f677320f6a57c
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16195fd9e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1610f2c3e00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+120d387f677320f6a57c@syzkaller.appspotmail.com
> >
> > ati_remote 1-1:0.0: Unknown Medion X10 receiver, using default ati_remote Medion keymap
> > ------------[ cut here ]------------
> > usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> > WARNING: CPU: 1 PID: 81 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 1 PID: 81 Comm: kworker/1:1 Not tainted 5.6.0-rc3-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0xef/0x16e lib/dump_stack.c:118
> >  panic+0x2aa/0x6e1 kernel/panic.c:221
> >  __warn.cold+0x2f/0x30 kernel/panic.c:582
> >  report_bug+0x27b/0x2f0 lib/bug.c:195
> >  fixup_bug arch/x86/kernel/traps.c:174 [inline]
> >  fixup_bug arch/x86/kernel/traps.c:169 [inline]
> >  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
> >  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
> >  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> > RIP: 0010:usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
> > Code: 4d 85 ed 74 46 e8 18 ce dd fd 4c 89 f7 e8 d0 5c 17 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 e0 e7 3b 86 e8 a0 5f b2 fd <0f> 0b e9 20 f4 ff ff e8 ec cd dd fd 0f 1f 44 00 00 e8 e2 cd dd fd
> > RSP: 0018:ffff8881d8a0f0b8 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000005166b905a845e639%40google.com.
>
> Corrupted report, will be fixed by https://github.com/google/syzkaller/pull/1839

#syz invalid
