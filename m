Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012B3C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D478621D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505827AbgDPLlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:41:55 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:47335 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633487AbgDPLlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:41:06 -0400
Received: by mail-il1-f200.google.com with SMTP id a15so8579203ild.14
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=C9yW33QDEUiY5an82lDXKD3mLsUL223GO6Ib+tlyzoM=;
        b=fI+CMG2mWBFuf2N1FEmuoa3dVorNuRax+K7wql8iFVtDuVWT1ayD/pjBIoxJAZCUof
         5PSGggn+DhrIpysvXuYGhtgzkVpNg5oVQ18nuzfSiD7IAk3xqXHACDEa6Q1CYrSNBEit
         +/iWsxfd7lN+z02XGUAYFr0LG4gvI7onk1ZxWS7fk2+aEUamo2GxOmFU9IEiMBxuu0o7
         zW23mAf9Dgiq3fKmZMGy62HpU9l80I/8T7+gbuKsc7SnqHN5m+0hdP6pGFOmX/agXoa5
         1eO9s8KimgkA1lc1eQpT8/lP6xxjDULH/4KfHkQTeQutpUtCveKZM4L5hAisz8jJFLIG
         9Pig==
X-Gm-Message-State: AGi0PuZRqpnTHvf/BCby5+5xKJ2E7ITs8XwlOrZX1hsm2Rr3HSMq00P5
        l3ffQJj9GK7u4qNttIOYWB7pbup+Nmw+w5mwpgyn/+YvQpAj
X-Google-Smtp-Source: APiQypLGCbfrNBXGAzTYguk/JReM3IFzhEiQP93KNzG3OtYg4VohI8tQeAUPLXVpEeM0uiK/1QFybXNi9nCvgC+u4R70td4JgNv0
MIME-Version: 1.0
X-Received: by 2002:a92:bad5:: with SMTP id t82mr2221201ill.171.1587037264592;
 Thu, 16 Apr 2020 04:41:04 -0700 (PDT)
Date:   Thu, 16 Apr 2020 04:41:04 -0700
In-Reply-To: <000000000000e15ee0058f5dfa81@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066c5a605a366e88c@google.com>
Subject: Re: WARNING in kernfs_new_node
From:   syzbot <syzbot+499aea72daa2cea73cb7@syzkaller.appspotmail.com>
To:     benh@kernel.crashing.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@kernel.org,
        peterz@infradead.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 810507fe6fd5ff3de429121adff49523fabb643a
Author: Waiman Long <longman@redhat.com>
Date:   Thu Feb 6 15:24:08 2020 +0000

    locking/lockdep: Reuse freed chain_hlocks entries

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=177d726fe00000
start commit:   1e78030e Merge tag 'mmc-v5.3-rc1' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e397351d2615e10
dashboard link: https://syzkaller.appspot.com/bug?extid=499aea72daa2cea73cb7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111d80fc600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d9060c600000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: locking/lockdep: Reuse freed chain_hlocks entries

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
