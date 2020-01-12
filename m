Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED653C33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 20:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE611214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 20:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgALUNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 15:13:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:46113 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733212AbgALUNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 15:13:01 -0500
Received: by mail-il1-f197.google.com with SMTP id a2so6385111ill.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 12:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wSZwdREHh/ntl8Mv5tdng+7hV3BjjjHVSK0hr94al3E=;
        b=teMBtHnJpMSkOrUGOTCVCTQn5Mgh+1UjAT8yifPVIsIYMZjtXPlkQc/0S7h6nRfbQY
         +8xIEWr+qOJWPpxGbnCCjWvxa+BQ/N2TUOOTyBYdLQ1eDzWq3/cR4oaJgxojYD+t165L
         3CFSXFNrR3ZU52LVWo2l1yRdsyg7sowDnM+EJvmhZ8cb0KCu4W2kPhQO96kjOdQD4FWs
         tHZx/Rb1CiahVC71sBr0HzwABYWChxMNCZhkVfZHYfP2EyLDhMuWcCA7TmdyNRcOxzOF
         81U5vWC3xKfZIPc7LObFhwOrhDwHj6EEfRvZklMpeWYk+Qt2CIMBU9FOAG30vJijdbVn
         Fgww==
X-Gm-Message-State: APjAAAWbqm/1gkJIEXqx7CY9yQd+Uzhj5FTQrddqw+fatDVwtyYVycwn
        JgLij7eA1OkTHHV9jnbEBULraYCS6/0t1y6ifrpGXJTQNcz/
X-Google-Smtp-Source: APXvYqysv5E1t8WrfxtjWbC+uwQ/9OlRxhNSPyvPDsydc1sPB0QD741bCxjYAsJLKOy90RBDJm5/NfigIYFyDkKVs3CU0i6ItP1R
MIME-Version: 1.0
X-Received: by 2002:a92:da44:: with SMTP id p4mr12562216ilq.168.1578859980942;
 Sun, 12 Jan 2020 12:13:00 -0800 (PST)
Date:   Sun, 12 Jan 2020 12:13:00 -0800
In-Reply-To: <000000000000af1c5b059be111e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005073ea059bf6fce1@google.com>
Subject: Re: general protection fault in xt_rateest_put
From:   syzbot <syzbot+91bdd8eece0f6629ec8b@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, kadlec@blackhole.kfki.hu, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 3427b2ab63faccafe774ea997fc2da7faf690c5a
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri Mar 2 02:58:38 2018 +0000

     netfilter: make xt_rateest hash table per net

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129b9c35e00000
start commit:   e69ec487 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=119b9c35e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=169b9c35e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18698c0c240ba616
dashboard link: https://syzkaller.appspot.com/bug?extid=91bdd8eece0f6629ec8b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dbd58ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15eff9e1e00000

Reported-by: syzbot+91bdd8eece0f6629ec8b@syzkaller.appspotmail.com
Fixes: 3427b2ab63fa ("netfilter: make xt_rateest hash table per net")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
