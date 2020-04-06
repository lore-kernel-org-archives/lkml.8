Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75DFC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DD92064A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgDFSQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:16:14 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:56950 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgDFSQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:16:14 -0400
Received: by mail-il1-f199.google.com with SMTP id 191so15830377ilb.23
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 11:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZJqNZn8LEubj1nzduXSuA2Dna6rbbp3U6TLqK8HEJm8=;
        b=mW8Aff6L/M4Olg20/JFNN/1wDWgjfi9C38d0OOAb/K5i3dghZ+68/i9F73/JyZlg9R
         5eGKsIrVCuVLfay6tmn19Z2DjPYVEmuXYatvpW/rggeCA/ZrA3MY9L0GA4nPxWOuu0Rn
         BanwI5/Cqw5aACwlOOhCRpwNT424QekPvRgsB7aVl6dXGcGI+33KtrirPl5ZCL6fjcJJ
         LeHKYnDIeXZjNKE2a7ctO5CNZdsd+prS98YEuM1ApOBjZwH4CPuTADcMdt7+qnYQHOAX
         BgQ3xDQAoMN+DfxnTJmJxC36FTWLp3hJYOimOemJY5sz1lYzKqdVIoflTrr4Sfp/PL2x
         th2w==
X-Gm-Message-State: AGi0PuZMWHhQ8Ah/hrvn/wrutW+GvXVfX/VmuRsx8X1MPTA27oXDOrua
        xhtOAysmiZ3j1vCaveJkRqjz3G7O7tjT09V+Rrg6jHIwow5d
X-Google-Smtp-Source: APiQypL4+QSe/MgeSLSE1bofXL2FFuFiqWpUKjOZwV45cWKksWyjWgBnRov9afCG8lwmxhCKWvQhwESESc/Hf4m1TMd28QTp45C1
MIME-Version: 1.0
X-Received: by 2002:a02:a49a:: with SMTP id d26mr561686jam.117.1586196973157;
 Mon, 06 Apr 2020 11:16:13 -0700 (PDT)
Date:   Mon, 06 Apr 2020 11:16:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021008f05a2a34336@google.com>
Subject: KASAN: user-memory-access Read in put_page
From:   syzbot <syzbot+b4501d3e966ff59f6090@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bgeffon@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterx@redhat.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16940efbe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f72ba8a207627d60
dashboard link: https://syzkaller.appspot.com/bug?extid=b4501d3e966ff59f6090
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d79efbe00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1705901be00000

The bug was bisected to:

commit 4426e945df588f2878affddf88a51259200f7e29
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Apr 2 04:08:49 2020 +0000

    mm/gup: allow VM_FAULT_RETRY for multiple times

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1441b1fbe00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1641b1fbe00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1241b1fbe00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b4501d3e966ff59f6090@syzkaller.appspotmail.com
Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")

==================================================================
BUG: KASAN: user-memory-access in atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: user-memory-access in page_ref_count include/linux/page_ref.h:67 [inline]
BUG: KASAN: user-memory-access in put_page_testzero include/linux/mm.h:675 [inline]
BUG: KASAN: user-memory-access in put_page+0x110/0x1d0 include/linux/mm.h:1136
Read of size 4 at addr 00003fbf7e8680b0 by task syz-executor574/7201

CPU: 0 PID: 7201 Comm: syz-executor574 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 __kasan_report+0x122/0x190 mm/kasan/report.c:507
 kasan_report+0x4d/0x80 mm/kasan/common.c:648
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7201 Comm: syz-executor574 Tainted: G    B             5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:221
 end_report mm/kasan/report.c:96 [inline]
 __kasan_report+0x187/0x190 mm/kasan/report.c:510
 kasan_report+0x4d/0x80 mm/kasan/common.c:648
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
