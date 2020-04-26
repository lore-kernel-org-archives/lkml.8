Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD407C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AA2206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgDZR5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 13:57:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33932 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgDZR5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:57:03 -0400
Received: by mail-io1-f71.google.com with SMTP id v12so18101877iol.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 10:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8TjkhMFVPAtlJvNNJhAgu9a5c+xNP6W5RwxgCUtPT8A=;
        b=JfSZEactOyGexq23aqUdqZOZOpa2NPNoQGO9cN6i/ZqCMo1jyp6sdQZsEpzxAHvupn
         72iG0CgjDMwKRRrZTE5YJNHwMhGVWrNI5sBbd2lIoW+F6jKJEugBkGnVVGqNXTWyUqD9
         iWImtRBwoRRZKt+dMEK6Fr5r1jzoLJtjRDfpHY3+WLDI3tXoQu3u5mrCDxghD5uY0y/Z
         URyiAuZqLfiOsArAXxK4vvRvfQLnxQLQOaZJI6i/5GDU3CqXB0ndhRQVtoazXgk5bQGb
         Jmw3nt3SNa6G6e0j7PY4IfESlA0My0tuHrbDzDFs/3XnC3ta0ixaen5AWshBlxSe7DCi
         yG1g==
X-Gm-Message-State: AGi0PuZJ2AHg04OBz1NZMRcH9ajKciZnHPfl6A1KpSYgFblGuy0GPG6/
        k/3Tj4BV5PdJaXN8vpcWYkNC7KjhcV+sCkOdnIiD4TxgdAEm
X-Google-Smtp-Source: APiQypJ1WErfclfWRklquQXKUFrHvg+ilCR/GXhMmL7xYap+ltlezJQoVrYWsI2Igs/lBP1SJGZYdLEjU0efu91+I8ON/mzNsiup
MIME-Version: 1.0
X-Received: by 2002:a5d:8715:: with SMTP id u21mr2705169iom.46.1587923822561;
 Sun, 26 Apr 2020 10:57:02 -0700 (PDT)
Date:   Sun, 26 Apr 2020 10:57:02 -0700
In-Reply-To: <00000000000005d1ab05a4351006@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005fd19505a4355311@google.com>
Subject: Re: INFO: rcu detected stall in wg_packet_tx_worker
From:   syzbot <syzbot+0251e883fe39e7a0cb0a@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, davem@davemloft.net, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, jason@zx2c4.com, jhs@mojatatu.com,
        jiri@resnulli.us, krzk@kernel.org, kuba@kernel.org,
        kvalo@codeaurora.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vivien.didelot@gmail.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e7096c131e5161fa3b8e52a650d7719d2857adfd
Author: Jason A. Donenfeld <Jason@zx2c4.com>
Date:   Sun Dec 8 23:27:34 2019 +0000

    net: WireGuard secure network tunnel

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15258fcfe00000
start commit:   b2768df2 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17258fcfe00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13258fcfe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7a70e992f2f9b68
dashboard link: https://syzkaller.appspot.com/bug?extid=0251e883fe39e7a0cb0a
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f5f47fe00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e8efb4100000

Reported-by: syzbot+0251e883fe39e7a0cb0a@syzkaller.appspotmail.com
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
