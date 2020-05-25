Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE7BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964E72078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389720AbgEYKTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:19:05 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:34262 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbgEYKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:19:05 -0400
Received: by mail-il1-f197.google.com with SMTP id d8so14876519ilo.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 03:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=whoLZ/cMcXb882oZ1pDdASgEN3wOLkDsAb0kfev0mIU=;
        b=oG3OYFZpHzjY1B1q3/LPD6LYt7VVkD5Z/+V2IS438294ZI/VcND0acE4Onf2y1kd5r
         JQljJ0MluRhcSTO5dqdOg6x5x5dpTG69aPg5b112wvor/XbCqjugbDqTHBIqNtCNpxxG
         iR1PLi4KAabEPhEWILpZJRlIMuFyoqll2VCy7QvyA5a3963kcay7+SbLc1KWQd6cQIaI
         ekUj19RJ7sYj6BAXAiCi9LL1lTxXBg8EQD00forqgaLavjeV+HM2LXNqh0RDpnaHpDdu
         VJAXMxtXpLTLWEZavpgL61e+DnkpS68uWQeZdrvXo5iQrkDO5Vt2sbOhnI9sQbgR8aNK
         /41Q==
X-Gm-Message-State: AOAM5307biRJtPzEqdy1KVMqS5/t58x9C9eUKKXFmrsyokjO8kZ3lK28
        EGmXLjXp5XUzOdjTqOt297JtcNPC/k4UcCKrWWFky2E2ZDlF
X-Google-Smtp-Source: ABdhPJx+tnjOlgCi02g4SUjSWTWYNC0Cv4sVgDVr14y8LKntAXEIw1aJC8Vk3mNbVow1S6zjJQ4Lbgs7vJILAN2bfDVXV1/HhbNz
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:965:: with SMTP id q5mr23266428ilt.272.1590401944546;
 Mon, 25 May 2020 03:19:04 -0700 (PDT)
Date:   Mon, 25 May 2020 03:19:04 -0700
In-Reply-To: <0000000000000a9cca057cd141bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f472ee05a6764e46@google.com>
Subject: Re: inconsistent lock state in icmp_send
From:   syzbot <syzbot+251ec6887ada6eac4921@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, jmaloy@redhat.com,
        jon.maloy@ericsson.com, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 1378817486d6860f6a927f573491afe65287abf1
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu May 21 18:29:58 2020 +0000

    tipc: block BH before using dst_cache

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cbef06100000
start commit:   f5d58277 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=251ec6887ada6eac4921
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ab6ba3400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: tipc: block BH before using dst_cache

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
