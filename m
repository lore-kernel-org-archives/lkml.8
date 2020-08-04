Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B1DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8F02075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgHDNCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:02:11 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:39753 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgHDNBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:01:08 -0400
Received: by mail-il1-f198.google.com with SMTP id i66so21889673ile.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 06:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=06+82rKMp3PGXLDD6Ap7gC365MaLMsLGY5Rl6STa3zE=;
        b=Lm6UxQ0XX4cHLa+QNUb2KSXVGfGayeFSUHP9JDdLfxygMTxXaM0ojrzFNA4020296M
         cecbfBHrTpM3nktHk3AzyTGXHBtLt6f68BFSPhLsATCb1ZcgBP7pEIScNP3xUVN+jk6T
         /KJA9v+eZPBAKGDgilhzTOrQDhEtkhSZDHIFhwkTP2ZUUwCCgf5gGuywiFs4nk2oGHv/
         VwT3pz8RZKIj+VwSDM2uYe7F4czrfL51af19b2egFSrDcOEpuN85pf7xmMR2wh7UfiPy
         UkDmKqWf5JbVE0yD0wA/bBTPQLRUhUkOtswfHRffKWK6/BulOeOY7EpEx83oWoIf9YTP
         o7ng==
X-Gm-Message-State: AOAM531vExzKv7qb4tOdA8Kf0IyIgWuzTGSJNJNjaCmlbojKhEHl0ktl
        QbpMQQBBgRxiKwRujPJN8ycShJCcc5BIhW3wPblFR5sDPBGA
X-Google-Smtp-Source: ABdhPJysIn/3rq8mJzFBZcPdgkiq5Vci73yhB6VXvAfDq6syCOUZWs4ErkDjGmgAWbCV304S/arGJe8W97c4vCtTU2PHRCJr/z6K
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d51:: with SMTP id h17mr4320234ilj.155.1596546066783;
 Tue, 04 Aug 2020 06:01:06 -0700 (PDT)
Date:   Tue, 04 Aug 2020 06:01:06 -0700
In-Reply-To: <000000000000a7eb5e05abeb197d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002da68705ac0cd9ab@google.com>
Subject: Re: general protection fault in hci_event_packet
From:   syzbot <syzbot+0bef568258653cff272f@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, geert@linux-m68k.org, javier@osg.samsung.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, marcel@holtmann.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 941992d2944789641470626e9336d663236b1d28
Author: Javier Martinez Canillas <javier@osg.samsung.com>
Date:   Mon Sep 12 14:03:34 2016 +0000

    ethernet: amd: use IS_ENABLED() instead of checking for built-in or module

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155180c2900000
start commit:   bcf87687 Linux 5.8
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=175180c2900000
console output: https://syzkaller.appspot.com/x/log.txt?x=135180c2900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b489d75d0c8859d
dashboard link: https://syzkaller.appspot.com/bug?extid=0bef568258653cff272f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1043af04900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ca1dea900000

Reported-by: syzbot+0bef568258653cff272f@syzkaller.appspotmail.com
Fixes: 941992d29447 ("ethernet: amd: use IS_ENABLED() instead of checking for built-in or module")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
