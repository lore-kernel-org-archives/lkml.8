Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8293CC2BB86
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6467520705
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgDLOLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 10:11:14 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:43148 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDLOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 10:11:14 -0400
Received: by mail-il1-f199.google.com with SMTP id o9so7720679ila.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 07:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=73xQG11pagPgCICtXY2EiAPlDki56JGVb2G/W2gPtpw=;
        b=PnJ/iPrbjCgXCzA/9myx6Oad9Jbh9Ya4muL4V21P+G9RIbuHcU4CO53jOQnpR8jVV4
         AauyYDngoto/Vwzuk5dqHiMnP67OodSrpEusQKzUKhfK7xznGUqaiKsAiE62VGWtldeb
         ZDM7Kdl/LrBnZkDbEbPwSFqAmPuWrrzPAw6417xG4mYmftbk+zCmyP+RYOSIFgeIk5hl
         UAb8LLmrjhauX1GqI9b4jy5Bqe4m6V6PCAneQpUsqxQ+UgEDvGkNRe5FqM16J5uWkQGh
         6BSWY93saHkSwye6G4oLVzxAdKOT/Ve+9pW9nryfCKaMlTrGjn9yorTZ7oOTY20Pq3Gt
         7I9w==
X-Gm-Message-State: AGi0PuZ3sy8F1H9ZHYsX9H5Yt05BzmCCixhTcQVt+z2bFSwFdQGjWWkA
        Pn8qGs4i6zO4UhIoHMC6w1mnsIEDHneCJ5zmn6Hb6qaHuwBg
X-Google-Smtp-Source: APiQypJNgeXiWcgYp+NUapQFGn3xzuFCCkC4aRZxSFeZJxsGPY1nw7qj/FfTZXe6ys7i9Parky9Vh1Dddg/myTeGca5tdsJG0zUJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:52d:: with SMTP id h13mr794798ils.18.1586700672492;
 Sun, 12 Apr 2020 07:11:12 -0700 (PDT)
Date:   Sun, 12 Apr 2020 07:11:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2ecd605a31889d0@google.com>
Subject: KASAN: null-ptr-deref Read in init_emulate_ctxt
From:   syzbot <syzbot+4a946e65aa25edfdb55f@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f5e94d10 Merge tag 'drm-next-2020-04-08' of git://anongit...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e6d61be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca75979eeebf06c2
dashboard link: https://syzkaller.appspot.com/bug?extid=4a946e65aa25edfdb55f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4a946e65aa25edfdb55f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in init_emulate_ctxt+0x497/0x4a0 arch/x86/kvm/x86.c:6424
Read of size 8 at addr 0000000000000005 by task syz-executor.2/9707

CPU: 1 PID: 9707 Comm: syz-executor.2 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 __kasan_report.cold+0x5/0x4d mm/kasan/report.c:515
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 init_emulate_ctxt+0x497/0x4a0 arch/x86/kvm/x86.c:6424
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9707 Comm: syz-executor.2 Tainted: G    B             5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 end_report+0x4d/0x53 mm/kasan/report.c:103
 __kasan_report.cold+0xd/0x4d mm/kasan/report.c:518
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 init_emulate_ctxt+0x497/0x4a0 arch/x86/kvm/x86.c:6424
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
