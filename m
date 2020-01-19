Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB015C33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 04:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89047206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 04:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgASElC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 23:41:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:35078 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgASElC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 23:41:02 -0500
Received: by mail-il1-f200.google.com with SMTP id h18so22416608ilc.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 20:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EHfWBR0huIHFcTJaoFUtGUR7IDOZ8MVrcyGekqx8mAE=;
        b=KzzworalQ2fsCUf6g0VWw1zI1uARAhSKwLYU3i4+h0AX0lamulMfPet5nRY+moGBeW
         j+eE9Prb9gjd+74XKRK7/Bh3/URVnAkuMt+xWjeo4FilmcMy4D+S1Z6b+OcNlFXeWJRd
         huwPSFZ+3tHP6yV+DTa1VcmeKMmT3CLkyJg7V9NNAYPE6pGMr5M7fOuvRMkalX/0nZfm
         D4seVe0sP/DVSxhIjli6qJE7bvXvrr/a15RSkS/LCZ23rAJR/jhNVw7XEgZsmNIU5AKt
         VbiYHGBXnepo4XNFUJa1wON06vrl7tZy7YFmk6poED2luXF+iDYGvbNSYOx0Vpc7S2Pm
         Ro7w==
X-Gm-Message-State: APjAAAVXI4eLrBktNFbLYfflswDkXz+XFNZIlTD3pTAHpLk9fGNWiwCe
        VwWUMKntw3x0ppRn80nJ5Vyw25a5pcEomBkHyxxPpoEJxUHJ
X-Google-Smtp-Source: APXvYqxTvS9QIRjVWv+5NS7HReJdEStlb/ujZ5/QAI12PGUg0ITxDVVyZ+dB04yYCxhUmlbpujJjRydgNvYEngV+/fm8FPnQG0fR
MIME-Version: 1.0
X-Received: by 2002:a92:b712:: with SMTP id k18mr5669699ili.259.1579408861675;
 Sat, 18 Jan 2020 20:41:01 -0800 (PST)
Date:   Sat, 18 Jan 2020 20:41:01 -0800
In-Reply-To: <000000000000717523059c6cabc9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027c814059c76c818@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ip_gc
From:   syzbot <syzbot+df0d0f5895ef1f41a65b@syzkaller.appspotmail.com>
To:     allison@lohutok.net, arvid.brodin@alten.se, coreteam@netfilter.org,
        davem@davemloft.net, fw@strlen.de, info@metux.net,
        jeremy@azazel.net, kadlec@netfilter.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b9a1e627405d68d475a3c1f35e685ccfb5bbe668
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Jul 4 00:21:13 2019 +0000

    hsr: implement dellink to clean up resources

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ddfa85e00000
start commit:   25e73aad Merge tag 'io_uring-5.5-2020-01-16' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=103dfa85e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17ddfa85e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbb8fa33f49f9f3
dashboard link: https://syzkaller.appspot.com/bug?extid=df0d0f5895ef1f41a65b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124774c9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15aa48d6e00000

Reported-by: syzbot+df0d0f5895ef1f41a65b@syzkaller.appspotmail.com
Fixes: b9a1e627405d ("hsr: implement dellink to clean up resources")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
