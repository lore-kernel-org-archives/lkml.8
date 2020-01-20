Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FE4C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 01:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B482C20684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 01:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgATBfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 20:35:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:39015 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgATBfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 20:35:01 -0500
Received: by mail-il1-f199.google.com with SMTP id n6so24204666ile.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 17:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SIy1Y3nZuLhuVMewjZxysiWahWNFeojJqO9vrYtj798=;
        b=kdfbc8jXrDZBQvOIjxuhurXTd1ihWI2adMgyDI2Wlbwour7wg+8JPpQQ4OwsxW3i3l
         8ZkV/j25DvtBvozgOWZiMAGCvgiZVo1ZLPer+tS3B7jG2AqV8ChgMIESFhtqpeX3h1Az
         jkdldhJonT2j+H1YFZgB7yOsA6p7N3qH/Bvxjk1ZXrMMiKjd2UTnvKcS7EcvE9f26d4v
         KBkgZzBPwR8/7yOC1SGWCz2yaifA/7CGPwWxEfNd5HaRwDEh1/Jq4RbwsqWpcECQs/tv
         jiIPk+rkIKE00x+uJacGCJWCwwXDYOUPqqO4k7dhqdY9TjBN/J4jCYcwYK7PCFd0hiO8
         38Og==
X-Gm-Message-State: APjAAAV+MY9uRoCAWtAmYWWxs+fQoOzOU0/l5giR+bEN3Z07o8k5WxL5
        Zny2BGMcTXagf7IVTVmbmfXgdwngAKhQmrKHjNRHPr4XkQRt
X-Google-Smtp-Source: APXvYqwxdtT4a7BzshbFsXu5QysWavFxC8kpPU9PQQ8ENYkxIBwMzu1UUle0sf0x3jxjUjZL+Uhywd3DMA1wzvJ6JCkPaqCidVsU
MIME-Version: 1.0
X-Received: by 2002:a92:8307:: with SMTP id f7mr8911636ild.73.1579484101183;
 Sun, 19 Jan 2020 17:35:01 -0800 (PST)
Date:   Sun, 19 Jan 2020 17:35:01 -0800
In-Reply-To: <000000000000bdb5b2059c865f5c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c795fa059c884c21@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ip_ext_cleanup
From:   syzbot <syzbot+6491ea8f6dddbf04930e@syzkaller.appspotmail.com>
To:     a@unstable.cc, akpm@linux-foundation.org, allison@lohutok.net,
        arnd@arndb.de, axboe@kernel.dk, b.a.t.m.a.n@lists.open-mesh.org,
        bp@alien8.de, catalin.marinas@arm.com, chris@zankel.net,
        christian@brauner.io, coreteam@netfilter.org, davem@davemloft.net,
        elena.reshetova@intel.com, florent.fourcot@wifirst.fr,
        fw@strlen.de, geert@linux-m68k.org, hare@suse.com,
        heiko.carstens@de.ibm.com, hpa@zytor.com, info@metux.net,
        jcmvbkbc@gmail.com, jeremy@azazel.net, johannes.berg@intel.com,
        kadlec@netfilter.org, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux@armlinux.org.uk,
        mareklindner@neomailbox.ch, mingo@redhat.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, peterz@infradead.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit d68dbb0c9ac8b1ff52eb09aa58ce6358400fa939
Author: Christian Brauner <christian@brauner.io>
Date:   Thu Jun 20 23:26:35 2019 +0000

    arch: handle arches who do not yet define clone3

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1456fed1e00000
start commit:   09d4f10a net: sched: act_ctinfo: fix memory leak
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1656fed1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1256fed1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e89bd00623fe71e
dashboard link: https://syzkaller.appspot.com/bug?extid=6491ea8f6dddbf04930e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141af959e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1067fa85e00000

Reported-by: syzbot+6491ea8f6dddbf04930e@syzkaller.appspotmail.com
Fixes: d68dbb0c9ac8 ("arch: handle arches who do not yet define clone3")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
