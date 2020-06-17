Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E99C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFB8207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m1fEZ+uI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFQM6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQM6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:58:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8024EC061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 05:58:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s88so1009876pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfwLw3QJAVtHygbvabJXqcRn0kg5PpR3kajE83O7Ri0=;
        b=m1fEZ+uIz7zy1EyXYzGbO/NPwCgY1khdx1dTtdMRXqfFT+2/84rjw7GRyTm7k7fWtx
         nRIB12JLst+zuCeCRIcQqLLuzePyo6gNs3k+D/MUfHhrR4VKqSK/kNSzTi8NhSYgmdGt
         dFQj/mYmO8x86d7uSZruu1eMXM0ViHHCmNC3vmjbl0wXRlVj/zIGu9jZIfQw25kqrea5
         txDHvk7mLrtRHBjVm6rF/378bPS6L7RxZ19L+6yYAYuY/QFXdyLZf8DrBKYCKkXhiZXE
         NCxgsO+0L+cawcGb95eALHlwbf90en3wj5oNlVz/2Z+V4lEZ9/WjfNzK9ehipfDEjbJC
         iCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfwLw3QJAVtHygbvabJXqcRn0kg5PpR3kajE83O7Ri0=;
        b=p3QW/n5H4SDfuRbDHkEEj2Xd0vggtGFBdOd1ghJ2GkzRjrbOyj0KingSN7SaVzyWad
         0c46LCfsAjTW1bV9Aap557wfWD6fegxKwq8ykRVo0I9WU9VAkVwkZytm4sy5ZSwIBCP5
         BSotF1pCg/Pt7WQ6XNFQpbnnPxYCaaIHqGYXfkB+D9CwG148kcVzWXB8YICdluaBFubl
         dmeNrTDsLh3P07LKgCb8RZFwcYyPtOqVE8TcPOOqhZFfu0DEvbiM1P2LPFjb4FMdx7Gb
         sR+DTI9+e/O5mrlz3xhNZIAK827ATZ+1Fc1mPUF707WaknaiJVWib8c0iK2xFZcXkktD
         O70w==
X-Gm-Message-State: AOAM530dtxDWVJC0h3U8W1Pe1IfMxh5wW/ooK1mDV82jGjYhJB6nD92G
        GhKuK7AeQyUxCzyrROXAnBPB1Uf3cNNEnZSFAyTWZA==
X-Google-Smtp-Source: ABdhPJzj5D83e7c70n8ta5lWjN4sn1klSuD6mN/IipBezstm99Mj1AogE3FsCCh4brTy4fZ9tdwxbJjKdlm4DFK46/4=
X-Received: by 2002:a17:902:e9d2:: with SMTP id 18mr6424361plk.336.1592398718671;
 Wed, 17 Jun 2020 05:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005166b905a845e639@google.com>
In-Reply-To: <0000000000005166b905a845e639@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 17 Jun 2020 14:58:27 +0200
Message-ID: <CAAeHK+zVVHK-XxFCTkRVB8WooDgCRbFRZqR7J8uPCNC0nu9fVQ@mail.gmail.com>
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

On Wed, Jun 17, 2020 at 1:24 PM syzbot
<syzbot+120d387f677320f6a57c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d6ff8147 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=140052c3e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=90a3d9bed5648419
> dashboard link: https://syzkaller.appspot.com/bug?extid=120d387f677320f6a57c
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16195fd9e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1610f2c3e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+120d387f677320f6a57c@syzkaller.appspotmail.com
>
> ati_remote 1-1:0.0: Unknown Medion X10 receiver, using default ati_remote Medion keymap
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> WARNING: CPU: 1 PID: 81 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 81 Comm: kworker/1:1 Not tainted 5.6.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xef/0x16e lib/dump_stack.c:118
>  panic+0x2aa/0x6e1 kernel/panic.c:221
>  __warn.cold+0x2f/0x30 kernel/panic.c:582
>  report_bug+0x27b/0x2f0 lib/bug.c:195
>  fixup_bug arch/x86/kernel/traps.c:174 [inline]
>  fixup_bug arch/x86/kernel/traps.c:169 [inline]
>  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
>  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
>  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> RIP: 0010:usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
> Code: 4d 85 ed 74 46 e8 18 ce dd fd 4c 89 f7 e8 d0 5c 17 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 e0 e7 3b 86 e8 a0 5f b2 fd <0f> 0b e9 20 f4 ff ff e8 ec cd dd fd 0f 1f 44 00 00 e8 e2 cd dd fd
> RSP: 0018:ffff8881d8a0f0b8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000005166b905a845e639%40google.com.

Corrupted report, will be fixed by https://github.com/google/syzkaller/pull/1839
