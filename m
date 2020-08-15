Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAA9C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48472053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgHOV5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgHOVwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:06 -0400
Received: from mail-il1-x148.google.com (mail-il1-x148.google.com [IPv6:2607:f8b0:4864:20::148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61709C061251
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 22:23:09 -0700 (PDT)
Received: by mail-il1-x148.google.com with SMTP id o18so7940008ill.20
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 22:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+25FmT8dO4pWjXPGwlb17rDpAfTAbCr3FFkhBNcwuAs=;
        b=mcTgLsr973kYPoTMt4veKSPutegxmmPLJn/w3gnlxASrDNxQQxIA5Fbu5/YkDlfMYn
         +sL8WyOcER5IQgjTyObAhymed5tWWmMTARTWCsl8dWM+iAEph5XZn7BG+lMEO6OltLz1
         qRYSivCFOX+v2a7oocuzWgTt6vq4/3bQxOEzPt9ZRaK7/0/vjGN01P6nEmvBps/Nqsdk
         kyRZdAY0V4JTz5lbjsgLIcHJvT28l6LWUUKR/zSnY8Q3ZTZIdI+5PlPQ0lONQro15jpe
         Y9hjlzUzCzgZdKEmDgdp9K9EfzgU5bKQxW80tPe+nKedDE8+t0gTL6lM0mfyYYg47m1P
         Lpcw==
X-Gm-Message-State: AOAM533mjsyjTBMYg4yCwhzv4DVk6NzfCtTWxTsDjcJNgJpkmkLmd6E9
        /rQmhlkPitqQRdTUu/Jgv7cT616pi+fmJq63ZKZv8Y1lg5i0
X-Google-Smtp-Source: ABdhPJydlCxs/36cUc4UNHPK6M0HkLjuUhkbtL2IuaVgPgv4K8a6I+NSpBzJX7MWxkS2M/6tiP8RcVV1wSXKsNQxeGt/4EVo4FU6
MIME-Version: 1.0
X-Received: by 2002:a92:b712:: with SMTP id k18mr2432857ili.220.1597468988463;
 Fri, 14 Aug 2020 22:23:08 -0700 (PDT)
Date:   Fri, 14 Aug 2020 22:23:08 -0700
In-Reply-To: <000000000000eb6a8e057ab79f82@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098e02c05ace3bbfb@google.com>
Subject: Re: WARNING: refcount bug in p9_req_put
From:   syzbot <syzbot+edec7868af5997928fe9@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, ericvh@gmail.com,
        hch@lst.de, kuba@kernel.org, linux-kernel@vger.kernel.org,
        lucho@ionkov.net, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a39c46067c845a8a2d7144836e9468b7f072343e
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri Jul 10 08:57:22 2020 +0000

    net/9p: validate fds in p9_fd_open

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1015f012900000
start commit:   459e3a21 gcc-9: properly declare the {pv,hv}clock_page sto..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef1b87b455c397cf
dashboard link: https://syzkaller.appspot.com/bug?extid=edec7868af5997928fe9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1642ee48a00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/9p: validate fds in p9_fd_open

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
