Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34017C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123452072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgAQJGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:06:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:35307 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgAQJGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:06:02 -0500
Received: by mail-il1-f199.google.com with SMTP id h18so18273705ilc.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WNXjdzyGh8ua3twp/xWEP9YTi5f399ywdktK+q8UWxU=;
        b=ogt23IScY57zAUkEPpZJw127YhQLBQX1xAOVbfHonvdQ8yUc3bHu0Wsc1AJix1odEL
         77d6RxOuifCMAnVcTtQEZ2kuNX0MPVUDeo/zzIHTuYc9WELY31oY+JUPPw1aALEBVsnn
         imGrUcf0QV4vafQw0KhmUlVeKTyOIyIEbxGo2Ai3ikZ+DyAe/cjGNPZ19+r4j9lAqPgW
         KBwNhoNiBNbQbYvXz114SzzSKwoihxa5sZyrmthWHzq73T4pkAHmMchcP9SFwOo8H0ii
         /fKJ3hTa2aA8CXV5X1hLyziqtmQBmaGUrr2M9W/z5pOp8D+N4DIsTrxtseZ9LmAx/av7
         ggtg==
X-Gm-Message-State: APjAAAV+Fm19QDNc9pai7aRGTbGatyFP455XOhptlRcwni08CCY6ic+Y
        K9EoQU4xK3uVzrwFOFJyPxX7e0wO5+GAn/bukYmlwIKMGj6O
X-Google-Smtp-Source: APXvYqzeQjj9HgIT2ODEiPfQcwnJHJ9IOn5ynE9jA++dhS1p4psfqy43bh3944jkXkKtmBgvbsSRbYi2cKGJWAjjnFtqgPVESlLS
MIME-Version: 1.0
X-Received: by 2002:a5d:9d10:: with SMTP id j16mr1297633ioj.0.1579251961344;
 Fri, 17 Jan 2020 01:06:01 -0800 (PST)
Date:   Fri, 17 Jan 2020 01:06:01 -0800
In-Reply-To: <000000000000a367e3059691c6b4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ab713059c524079@google.com>
Subject: Re: general protection fault in j1939_sk_bind
From:   syzbot <syzbot+4857323ec1bb236f6a45@syzkaller.appspotmail.com>
To:     bst@pengutronix.de, davem@davemloft.net,
        dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de,
        netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 00d4e14d2e4caf5f7254a505fee5eeca8cd37bd4
Author: Oleksij Rempel <o.rempel@pengutronix.de>
Date:   Fri Dec 6 14:18:35 2019 +0000

     can: j1939: j1939_sk_bind(): take priv after lock is held

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1001b266e00000
start commit:   32ef9553 Merge tag 'fsnotify_for_v5.5-rc1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e464ae414aee8c
dashboard link: https://syzkaller.appspot.com/bug?extid=4857323ec1bb236f6a45
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177c34a2e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: can: j1939: j1939_sk_bind(): take priv after lock is held

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
