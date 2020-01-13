Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ADAC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071422080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgAMUCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:02:03 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:55436 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAMUCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:02:02 -0500
Received: by mail-il1-f197.google.com with SMTP id p8so8695354ilp.22
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 12:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0WQiXIsAJotmOovsOJkAJagLAGPEvGVf6LY+V+HPFS4=;
        b=qj/aoxdontuyohTWAHRc7tsObhQ3rx1B3Dr7vulZxosKIpH9FNyOj7DB8vAy4Q+tn8
         Gz6SzD4hFz0E3XnVnbvYQ3rWNf24uxh/o3xat5Ii9apDEzel0AIvlO0Qs/kYEgQQi/tL
         k3GiVBLhaBB4IBXDdI5uzaffaIFdWtk1GVnhYLUnXeq8uiueO7tv/0qte7fJU408jxci
         PdB+kaGzeuDc4wc9O1TiDUXutYEdCY9j7MmWg2zkSwc79lFI2gMd/caFs0KkDMKOr6Rc
         6EeejCVQ8TZCubYDEDERfhPecWweHm8XbicfhQhjNeFxU/cIQQBUa3uvm2pzbbRF5evt
         15HQ==
X-Gm-Message-State: APjAAAXtED711MH3vw7xPT+kDnOayE1KKfCsZaliXgTucQ8X1mnDcdmX
        QltYDbAjk5yKF597zg/BsUw+pZMM7XKg8XiUVxWAOUv3GS58
X-Google-Smtp-Source: APXvYqzdqdMaIuaZGYk4ZSDZ03EA/5GJly7oM+QoISUNLEYZzj5obAzt8M8gozRrhbdr7aFXuqtPDKn7Alg0OqUZ9748hJL8D8I9
MIME-Version: 1.0
X-Received: by 2002:a02:c611:: with SMTP id i17mr16208083jan.28.1578945721401;
 Mon, 13 Jan 2020 12:02:01 -0800 (PST)
Date:   Mon, 13 Jan 2020 12:02:01 -0800
In-Reply-To: <0000000000008dcde00590922713@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d80d1a059c0af28a@google.com>
Subject: Re: WARNING: refcount bug in chrdev_open
From:   syzbot <syzbot+1c85a21f1c6bc88eb388@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, will@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 68faa679b8be1a74e6663c21c3a9d25d32f1c079
Author: Will Deacon <will@kernel.org>
Date:   Thu Dec 19 12:02:03 2019 +0000

     chardev: Avoid potential use-after-free in 'chrdev_open()'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14412659e00000
start commit:   81b6b964 Merge branch 'master' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d98e4bd76baeb821
dashboard link: https://syzkaller.appspot.com/bug?extid=1c85a21f1c6bc88eb388
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147ad0a6e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15483312e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: chardev: Avoid potential use-after-free in 'chrdev_open()'

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
