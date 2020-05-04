Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89554C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6439E20757
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgEDHFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:05:05 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:56873 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgEDHFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:05:05 -0400
Received: by mail-il1-f198.google.com with SMTP id z24so12667568ilk.23
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 00:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=u3a78ZSqYtMPKHHAjJSNj5CtWeDAIi+gNz7+0hYnnWI=;
        b=ryclp+Mjn90JDCd8Sw4kBSWW/rOmrFr4DreA+/r1vfWoOh4BlLnjmIZKBxvdD1nLwM
         judn3GjMAfiGgM45eD0hKne1lxTSM+5dLz7Igcy2ByZsF6Gh7oJ7SShIWxsSMmH/XIaw
         RyU76/NqwjnH7XBAFbcs9kU2xNMy4At0nNBDerM5phyQY2TqlzbsXz4oqdbL+EMnn/mM
         OBwSfS+mmgtp2fKkAOg/aY/I9Ln43qY1r3UwlPJwndohwpfkXCr4fM7si8LZX9yi9Zbd
         dK52lRyWgQ/joxrBJDC8o6BcWUaN3bsKxPgE5ZTM/rS1rzS0Opcy65Ha9nRKEMNbcBJ3
         EAXQ==
X-Gm-Message-State: AGi0PuajNH8UwbmVAqnj3ZNIX4wU6uiJkelMDbgGRPlj/9VoSQM1ktuw
        Y0zFkmtwv95VjRjjIcrzFGOJZXor/0Bqvy5wIkCgyFUQHOMG
X-Google-Smtp-Source: APiQypJoS44zQk9wi0Sxu/Y9n64DarEKre69MS+FF88hVeGqZryFDTLDuYB2V3PmvQ9hW8h0OBRfR17f+aByoFxd0BOKIBQz/zJ+
MIME-Version: 1.0
X-Received: by 2002:a92:8515:: with SMTP id f21mr14830968ilh.20.1588575904094;
 Mon, 04 May 2020 00:05:04 -0700 (PDT)
Date:   Mon, 04 May 2020 00:05:04 -0700
In-Reply-To: <000000000000c0bffa0586795098@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076622305a4cd26ae@google.com>
Subject: Re: WARNING: bad unlock balance in rcu_core
From:   syzbot <syzbot+36baa6c2180e959e19b1@syzkaller.appspotmail.com>
To:     aia21@cantab.net, bvanassche@acm.org, dvyukov@google.com,
        gaoxiang25@huawei.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miaoxie@huawei.com, mingo@kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 10476e6304222ced7df9b3d5fb0a043b3c2a1ad8
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Mar 13 08:56:38 2020 +0000

    locking/lockdep: Fix bad recursion pattern

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142baee4100000
start commit:   5a1e843c Merge tag 'mips_fixes_5.4_3' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=420126a10fdda0f1
dashboard link: https://syzkaller.appspot.com/bug?extid=36baa6c2180e959e19b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1108239ce00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cf40a8e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: locking/lockdep: Fix bad recursion pattern

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
