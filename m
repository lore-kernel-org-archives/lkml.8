Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E19C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C4D2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDKIwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 04:52:05 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:56605 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDKIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 04:52:04 -0400
Received: by mail-il1-f197.google.com with SMTP id 191so4759542ilb.23
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 01:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qTINh29b/Yp/7SVCFmk8/NkoIg3EopMO0nTDlPRjtbI=;
        b=nbi6Mt28QnDG9sQxyo0UjaJXTt3JYvguIGBfZzqZJrbib6ajqvSPDFrBVLZ+26Y318
         Lp++nB24t66OwfHr94VVJ9RSj+HByAkbm6iFtB17ITNfVlgo/TY1p37GouUWBUW3JUmG
         xyVMxg0rkznniC1s222Xz8CudG37oqB0VZurZZTK3KqosVLAp4RqgfDPH+mr5AkhtmkS
         JfBFewq/SDGIGTJS6b3g4LiqH59K1+tw14zjiuddTjMd24D4Hw77n3vZ6nTNKFD98pkg
         DTnGJCPXPzrRNQ0acdQVECMC4VFnQaX/RZ/tUYB4Oiomg3U/C75reBXRcmP2rMCmKGlr
         b49Q==
X-Gm-Message-State: AGi0PuZAKMzXWOeu+bEXd/MLYnOgMXfy4e7S8QEl7+re56OaMI6kVBFL
        FyOsWVVhx6B3UWN1np/ZUE8X1WfvbJKL9DXnFg5BNUbuwfcr
X-Google-Smtp-Source: APiQypJFRmWFTlWYX4yEqUwZwWBorQJssSnDRNG2VNHqEipwwTeLuySk+MyV/DhdV/b7R+ZeE/WBQ+yQDOPU1DNnAGTi35gKpGmv
MIME-Version: 1.0
X-Received: by 2002:a02:aa93:: with SMTP id u19mr7967615jai.70.1586595123042;
 Sat, 11 Apr 2020 01:52:03 -0700 (PDT)
Date:   Sat, 11 Apr 2020 01:52:03 -0700
In-Reply-To: <000000000000571acf05a229cb2f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b61fcf05a2fff6ed@google.com>
Subject: Re: possible deadlock in shmem_mfill_atomic_pte
From:   syzbot <syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 71725ed10c40696dc6bdccf8e225815dcef24dba
Author: Hugh Dickins <hughd@google.com>
Date:   Tue Apr 7 03:07:57 2020 +0000

    mm: huge tmpfs: try to split_huge_page() when punching hole

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17c463e7e00000
start commit:   ab6f762f printk: queue wake_up_klogd irq_work only if per-..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=142463e7e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=102463e7e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3010ccb0f380f660
dashboard link: https://syzkaller.appspot.com/bug?extid=e27980339d305f2dbfd9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d3c5afe00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7f51be00000

Reported-by: syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com
Fixes: 71725ed10c40 ("mm: huge tmpfs: try to split_huge_page() when punching hole")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
