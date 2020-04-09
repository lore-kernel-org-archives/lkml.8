Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93394C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7092120757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgDIEvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 00:51:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51629 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgDIEvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:51:07 -0400
Received: by mail-io1-f69.google.com with SMTP id s1so2287399iow.18
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 21:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Yk+x42oEX6NPVtof+fwUTcYBaykSE3TPHHScZ5sRcbQ=;
        b=Z/mKa+uB4Y9XcT0PQT0WufHiy5mBBYghQdP791WPZkk1xpdF0XbLwNIfx0LtHoXRmW
         4ckqWmSO7iZlTP+VcXZ0bkHcN8NGwhTcEpJVopZEZyEMVEy8p2X9NM21gBszpRZevXcl
         AN9pXC9mQPtzTp40RK7sCGqk185uF4uVmplsosj8llcE7F2cNLrCsBQf+Lotbbp89+/n
         RvlitQraBGCiQCZT79V+1pVJ6Di23TDwmMLrAIN1wlXBvLlSc7Akbhj93t3USvoLNjeH
         kH3k+VeHMpycwoCQqTeY2R4nXX0a3k7COEcnUAEf+hysR1pU24ze6oQmmdpUOYCBbjO2
         4SyA==
X-Gm-Message-State: AGi0Pub5FzN5roxKcqCCWo7e5q5eCYluCKt/ySgLXFrcpKT9By2eyS7n
        FtBop3rwQJd23rgWzQ6fkbyLZrs7WJ/9JMnOUDWKiGux7yb0
X-Google-Smtp-Source: APiQypLn7zMw/7P+fKa8CU3hxdQVFVajIQITeI3FCvHiaE5RKeyHuTcfFX3S5O8iY9W5R3DeJXsv7wxpJTD+bVVIi2d+2SImhIUk
MIME-Version: 1.0
X-Received: by 2002:a02:b70b:: with SMTP id g11mr992206jam.16.1586407866737;
 Wed, 08 Apr 2020 21:51:06 -0700 (PDT)
Date:   Wed, 08 Apr 2020 21:51:05 -0700
In-Reply-To: <000000000000f3b11305a0879723@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005da8f705a2d45d81@google.com>
Subject: Re: WARNING in kfree (2)
From:   syzbot <syzbot+50ef5e5e5ea5f812f0c2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 0d1c3530e1bd38382edef72591b78e877e0edcd3
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Mar 12 05:42:28 2020 +0000

    net_sched: keep alloc_hash updated after hash allocation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1640e277e00000
start commit:   2c523b34 Linux 5.6-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e311dba9a02ba9
dashboard link: https://syzkaller.appspot.com/bug?extid=50ef5e5e5ea5f812f0c2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d8ae91e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net_sched: keep alloc_hash updated after hash allocation

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
