Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6B6C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F8920678
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgATNAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:00:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:53498 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgATNAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:00:01 -0500
Received: by mail-il1-f198.google.com with SMTP id d3so24997959ilg.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 05:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ccHZGw3XzyeKhK1JvL4mqzYRrPRSlX015G5X9Rh8ai8=;
        b=fCfimtSqt7UMm9UkUtA4PR9nT8JxQGhwFdrcWSGlRubWTGi/ALPquzZ1poW0ZH3sEX
         oQHX6VYqWFGTfqPJd+Rydr6Nbk3ozSCkwLJwkvXCVrufUKfKOw9EuHrcRe74bqp1DAyE
         Mq4WMLKe96o7pxXc8Y1VNNN+9GxbkqQel4iFizsMuobGZgJF2gTtxCQgqMYTk4bbQIRf
         VQoWvddkq0UMdzaCZtSiOoTDUCdCwfvbp2Dn+5+qIbHd4CEWw16fNkbMDrSfk7N9yHNR
         IbCxtQeTrDntJTyTopX5EhFrusaQYtAbqOF+FsP/ktPPQs4l8tA26IZVlWiRiaNiSp9i
         qQYg==
X-Gm-Message-State: APjAAAVzGtP7g4o1KSqxZaFCOzKHWRMz+ff4TThETukfIkNHoPBSib7y
        RoCdB0jouOKBe7lJrPyZpmAklD0WrCA1+ro9tYeBgMBTfYXs
X-Google-Smtp-Source: APXvYqzQK4xEJEEsdRXQxcEUPQa8SvkDpzTuytQHbP5WG/fHyScj0aBkpDkh/RGn23ijeRueaCc2L5jXxGCZSUtAxquAIlP3GCeX
MIME-Version: 1.0
X-Received: by 2002:a02:3948:: with SMTP id w8mr42297420jae.124.1579525201269;
 Mon, 20 Jan 2020 05:00:01 -0800 (PST)
Date:   Mon, 20 Jan 2020 05:00:01 -0800
In-Reply-To: <000000000000f649ad059c8ca893@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008916f1059c91de99@google.com>
Subject: Re: KASAN: slab-out-of-bounds Write in bitmap_ip_del
From:   syzbot <syzbot+24d0577de55b8b8f6975@syzkaller.appspotmail.com>
To:     allison@lohutok.net, arvid.brodin@alten.se, coreteam@netfilter.org,
        davem@davemloft.net, dirk.vandermerwe@netronome.com, fw@strlen.de,
        gregkh@linuxfoundation.org, jakub.kicinski@netronome.com,
        jeremy@azazel.net, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0f93242d96ff5a04fe02c4978e8dddb014235971
Author: Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Tue Jul 9 02:53:08 2019 +0000

    nfp: tls: ignore queue limits for delete commands

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f4e966e00000
start commit:   09d4f10a net: sched: act_ctinfo: fix memory leak
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13f4e966e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15f4e966e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e89bd00623fe71e
dashboard link: https://syzkaller.appspot.com/bug?extid=24d0577de55b8b8f6975
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1799c135e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176b8faee00000

Reported-by: syzbot+24d0577de55b8b8f6975@syzkaller.appspotmail.com
Fixes: 0f93242d96ff ("nfp: tls: ignore queue limits for delete commands")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
