Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B038AC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831162087F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgAKKAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:00:15 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:46368 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbgAKKAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:00:02 -0500
Received: by mail-io1-f72.google.com with SMTP id p206so3099315iod.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 02:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=DrXkIWbrBX7Fd3/gNLvsOw44mmxpzBLe8lrnfiRlxxU=;
        b=C2ypjF/xy5mwflnRBv6/B2GyHBNZjQeg1IDXAIj4nQmezylCVv75JnUOgzhYYBmQae
         ZOM49+jNNzTtb+ncc7boc9H8VqeOcFlvoSIddFHfyc3D5Q9ZqWIR25tScpKqhzaXKRP+
         yhLOmC9KtUvkYVIVrfUlB4z3Z3gFeicXGri8i1WzDFsVsjRtNzKMTSMf+hO39qDub9pm
         VzjQlB/tsPxXGPIw6zn/kY+K63hqoZ+iFg8/bILtOnfhGIqlCOsh1SGnAWiZGLZRvNXU
         qVKARyCkaD4EEeO1PDUU9e7Gr8KPNaTQDMvGdnl4j/bOEt/IBW+0D/mzaIrwO4UCgM7p
         cQEA==
X-Gm-Message-State: APjAAAWuZG17eNbRohK1rSyn8xDpEah/Jk8AJ9ehTQedGgKexF4MUbRB
        KWA/1IltonZdKefRet1qDQ5TRBuYke1God7oeVO8QqQ0PpHh
X-Google-Smtp-Source: APXvYqyyzAXe87hNpCj8KaNkoKxDWd8rM9/pHrdZJgUyZW+0chTRAqzVJVUlQ1uS+a/5JliEf7yngQJ01ZzullfmzWMeqcTDBvPj
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5c3:: with SMTP id l3mr6947066ils.260.1578736801574;
 Sat, 11 Jan 2020 02:00:01 -0800 (PST)
Date:   Sat, 11 Jan 2020 02:00:01 -0800
In-Reply-To: <0000000000007a5aad057e7748c9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004078ac059bda4ef9@google.com>
Subject: Re: KASAN: use-after-free Read in lock_sock_nested
From:   syzbot <syzbot+500c69d1e21d970e461b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhogan@kernel.org, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        netdev@vger.kernel.org, paul.burton@mips.com,
        paulburton@kernel.org, ralf@linux-mips.org,
        syzkaller-bugs@googlegroups.com, tbogendoerfer@suse.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit a07e3324538a989b7cdbf2c679be6a7f9df2544f
Author: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Date:   Mon May 13 11:47:25 2019 +0000

     MIPS: kernel: only use i8253 clocksource with periodic clockevent

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11dd033ee00000
start commit:   3ea54d9b Merge tag 'docs-5.3-1' of git://git.lwn.net/linux
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=195ab3ca46c2e324
dashboard link: https://syzkaller.appspot.com/bug?extid=500c69d1e21d970e461b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145318b4600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ac7b78600000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: MIPS: kernel: only use i8253 clocksource with periodic clockevent

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
