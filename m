Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A2C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7DEE2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgEFJmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:42:07 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:37705 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgEFJmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:42:06 -0400
Received: by mail-il1-f199.google.com with SMTP id v9so1378211iln.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 02:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1duKq7szTDTyKaohCShGnT1dGsbqpgWG34qMl98tMGg=;
        b=ZS6qpUYesxj7gtoMjV46iA4qdXjY7S8FhJwMrciT7li+H/qZKAd8aMH6EmcKBuPp7j
         Zd9hljDXzEjRDMKxyHPNKLF5vwu5iX5i0GF9yHmc103qqnk7DYCAqDXFsq9rYydKmikH
         2mB0S6FVfUlHJz7/5B57eRv5wZCwvIL7gpnupH76V+LDK4dfsXCRSoiaAHwndUHETraC
         nRfrTZUnqWBi//EMoO0JCAD2F+Xph9rdUOYypHbRvRhlnpzCTuUAX1klTgt34/l89Ijo
         iw6l3ygCV7Y0Zdbt5Zv8x/yJS+SVyIJ/OpA8fPXm90ZP30hrydUHNpscoAvrYhhnZo63
         gBTw==
X-Gm-Message-State: AGi0PubiXkXLxazF7oW26cRlePdJmkBh1aAAp1Ms9Ru0OvEWz/RzJL9u
        pnw0pUVFZSP1ZJ3GtDnETgjTGklj9MK5vnxKw+g1RX3eVAt7
X-Google-Smtp-Source: APiQypJdwS6IXvlDyKFYWvKC1sYkUXaqiXSGvXeFx1JBzzoNX6kOusu0ZBrpShP3tyhlc/K/ZMXCl6oWgZdHai1LkL1RSXAx1RFO
MIME-Version: 1.0
X-Received: by 2002:a92:5c57:: with SMTP id q84mr8119397ilb.203.1588758125215;
 Wed, 06 May 2020 02:42:05 -0700 (PDT)
Date:   Wed, 06 May 2020 02:42:05 -0700
In-Reply-To: <000000000000ea641705a350d2ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0077705a4f79399@google.com>
Subject: Re: WARNING: proc registration bug in snmp6_register_dev
From:   syzbot <syzbot+1d51c8b74efa4c44adeb@syzkaller.appspotmail.com>
To:     ap420073@gmail.com, davem@davemloft.net, edumazet@google.com,
        hdanton@sina.com, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e0a4b99773d3d8d3fb40087805f8fd858a23e582
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Fri Feb 28 18:02:10 2020 +0000

    hsr: use upper/lower device infrastructure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14811182100000
start commit:   ac935d22 Add linux-next specific files for 20200415
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16811182100000
console output: https://syzkaller.appspot.com/x/log.txt?x=12811182100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc498783097e9019
dashboard link: https://syzkaller.appspot.com/bug?extid=1d51c8b74efa4c44adeb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148e6150100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115c379c100000

Reported-by: syzbot+1d51c8b74efa4c44adeb@syzkaller.appspotmail.com
Fixes: e0a4b99773d3 ("hsr: use upper/lower device infrastructure")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
