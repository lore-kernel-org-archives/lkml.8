Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0708C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE85020736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbgCKURE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:17:04 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:46734 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbgCKURE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:17:04 -0400
Received: by mail-il1-f198.google.com with SMTP id a2so2246267ill.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 13:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Hk8leBLQn5EO2E5GYez0a5lDH0bgTVJ9Yjc9wD197GA=;
        b=AaEYSNvlpth2pAyGKT0qHGb92CUrhlldto6k36FsIhCeuTybFWJjKk6Umtktx2Vwmz
         H2RMxjsaWVdrMAfUT3zFXgzY3twNQlZc7fCRsbvrohh6JbpciFryQNbuz1MGbG05ei1I
         L+XbRHk3bkqRc7IxKgBbNomlOqOEecg2KQKG52+3hmHkLmLQKRKIHmMDsNqrMlyuanzH
         6ySq06viIzt6cvg9KyGBKRa9S0lUzaSv6jDGRYPjPaQWtDDdiSUFp0whUye/YFBgVYmk
         mI7MzHmzaEzQugm2f8+AoSre7OM8UJppzjX61nTxsVG79gFSvxcCQ1KFSRImu77t3aZ3
         zywQ==
X-Gm-Message-State: ANhLgQ2jBVd1WDjlxRkdyOoMDDtRHswDcfVoWtxaNn11Eo5Z2kWN2uFi
        R3uLJRpIrNJ2SnLle4MUCCBJ/xgLFsSQ8bxi8tL+RyrLYmaA
X-Google-Smtp-Source: ADFU+vuCk0oLjsQRK1OQUGd8tOfOULwTEpr37d1F6UYTw6+1J+u2VViJHjd/h7gGWV9DvDuMYhL3fUTIAi3lVakXW/slGPEJZJ+Y
MIME-Version: 1.0
X-Received: by 2002:a02:962e:: with SMTP id c43mr4679555jai.26.1583957823254;
 Wed, 11 Mar 2020 13:17:03 -0700 (PDT)
Date:   Wed, 11 Mar 2020 13:17:03 -0700
In-Reply-To: <00000000000030395e059f6aaa09@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064f9a805a099eb8a@google.com>
Subject: Re: general protection fault in j1939_netdev_start
From:   syzbot <syzbot+f03d384f3455d28833eb@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, jiri@mellanox.com, jiri@resnulli.us,
        kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mareklindner@neomailbox.ch, mkl@pengutronix.de,
        netdev@vger.kernel.org, robin@protonic.nl, socketcan@hartkopp.net,
        sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 8330f73fe9742f201f467639f8356cf58756fb9f
Author: Jiri Pirko <jiri@mellanox.com>
Date:   Wed Sep 4 07:40:47 2019 +0000

    rocker: add missing init_net check in FIB notifier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165cdcb1e00000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=155cdcb1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=115cdcb1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=f03d384f3455d28833eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162b8331e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f10a2de00000

Reported-by: syzbot+f03d384f3455d28833eb@syzkaller.appspotmail.com
Fixes: 8330f73fe974 ("rocker: add missing init_net check in FIB notifier")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
