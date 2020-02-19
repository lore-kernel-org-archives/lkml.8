Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C9EC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4AD207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBSCID convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:08:03 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:43365 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgBSCIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:08:02 -0500
Received: by mail-il1-f199.google.com with SMTP id o13so18709857ilf.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=4diWwWLXm7lY/GHl3gvscC/1M0a1R7YH2cSj9Fw5eHQ=;
        b=DnyEUbq71/Z/rVqY9k3Gu+5UKcLzewac1o1wU8GmrDtXSvc5Q/HpJtqLx7BTZ7APci
         1riQ/BbZ0SSR+JcANpXWdeBKIEQOHqfm3lMUQYzYz6Wt5Pu9iV9X8KMmC/LOsvCVa65Q
         8A3RXr3PdvNLX6tnCNRDMIV2HUCxn1oeM0zXks1jh3InVPvgI1//Q3WWa4HH6l53tvVM
         ROOrq0poPZl5+5fdY6nDmRAbLOcdNYrR6cCgGw94uxUcpNCeMJuaRSHfplsC/e+riX+/
         2uBE12ZFth8MKOw3j22TOw4ZHZ29Ywr/P7xfSyTb3V9SjVu7fKv99XF+d4+Fbxn8lzEu
         9XGA==
X-Gm-Message-State: APjAAAWd8+0FqKd0lKOh22iqho5yZy6Ky+PsApnETIYZ4dVJub8peNz/
        iu3hJ49X4sEZJKoH36fD4fOY5wbYr9POKZV7gMM/dfPAAUk6
X-Google-Smtp-Source: APXvYqzdxPP1bcYe7a4xOJJ2PZvwgFfZkFkliW3rcWAp+NO+QUzOk5XyZt5pyzhMqqramXLk6gwjJUtyolpYMy0PBvZtFLrsOuX6
MIME-Version: 1.0
X-Received: by 2002:a92:15c2:: with SMTP id 63mr22276770ilv.111.1582078081462;
 Tue, 18 Feb 2020 18:08:01 -0800 (PST)
Date:   Tue, 18 Feb 2020 18:08:01 -0800
In-Reply-To: <000000000000bb0378059c865fdf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d774c059ee442e6@google.com>
Subject: Re: KASAN: use-after-free Read in bitmap_ip_destroy
From:   syzbot <syzbot+8b5f151de2f35100bbc5@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        coreteam@netfilter.org, davem@davemloft.net,
        florent.fourcot@wifirst.fr, fw@strlen.de, jeremy@azazel.net,
        johannes.berg@intel.com, kadlec@blackhole.kfki.hu,
        kadlec@netfilter.org, linux-kernel@vger.kernel.org,
        lipeng321@huawei.com, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, tanhuazhong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 32c72165dbd0e246e69d16a3ad348a4851afd415
Author: Kadlecsik József <kadlec@blackhole.kfki.hu>
Date:   Sun Jan 19 21:06:49 2020 +0000

    netfilter: ipset: use bitmap infrastructure completely

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fc79b5e00000
start commit:   8f8972a3 Merge tag 'mtd/fixes-for-5.5-rc7' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbb8fa33f49f9f3
dashboard link: https://syzkaller.appspot.com/bug?extid=8b5f151de2f35100bbc5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e22559e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16056faee00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: ipset: use bitmap infrastructure completely

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
