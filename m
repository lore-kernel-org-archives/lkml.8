Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6711C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B56762076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgHKDfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:35:09 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:46272 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgHKDfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:35:08 -0400
Received: by mail-il1-f197.google.com with SMTP id q19so2672486ilt.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 20:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0XXF4gP00AKnsVQiDFXbJzMYIOYWHxHdd4RVsRPAbhc=;
        b=FQz/RU7teRydfQwWs2mbznrNw/F5h+XcgXAcKoookfrE2rZGrxdsUBNfzWd7DKTWUv
         vahHvXMbDwAZpLtv+qkS0ole78Ag99hZZLpzpNcoJnwsQ3L/8Bm9EP0AZObFPyoGu3uf
         FbgYHUEuibvTyjBEahDIR0P3x3wVblUvbZYxout58gHQIo3h8Mh+8cv7fBNEQfx5kFLX
         OsFWT8FWTkQqlljQ/P+H/+5jMPUhEN+nEwagA1yDJmLHNOlZFtC6v0hfqBYPyaAjRrSX
         quPY3dnjWVza7WepS8IoKBkFxuCUAlYpnitgkSj2nwyNAlw0r9augd3t/6DQ55QbWGkQ
         tcXg==
X-Gm-Message-State: AOAM5300TaiF6CWZusEZqzox1PhgIM0vSIa/Q0xe4xFaxpqnYzfS/Hye
        DpTMukZVUff8/y7EvqN8agzHDVHtKmuHOMUA6/sq5ZWF7m7E
X-Google-Smtp-Source: ABdhPJxgP7ejVjnfsazNH0Tqy82Cxwho0b25shTclrrEX2JEZZQVzsMpsyfvz791kmnbkiw1QrmUlfEf4tjZSNi1+1P0jsQ/cPE1
MIME-Version: 1.0
X-Received: by 2002:a6b:5502:: with SMTP id j2mr20825119iob.204.1597116908036;
 Mon, 10 Aug 2020 20:35:08 -0700 (PDT)
Date:   Mon, 10 Aug 2020 20:35:08 -0700
In-Reply-To: <000000000000734f2505ac0f2426@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7ec6f05ac91c11d@google.com>
Subject: Re: KASAN: use-after-free Write in hci_conn_del
From:   syzbot <syzbot+7b1677fecb5976b0a099@syzkaller.appspotmail.com>
To:     clm@fb.com, davem@davemloft.net, dsterba@suse.com,
        johan.hedberg@gmail.com, josef@toxicpanda.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        nborisov@suse.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 6a3c7f5c87854e948c3c234e5f5e745c7c553722
Author: Nikolay Borisov <nborisov@suse.com>
Date:   Thu May 28 08:05:13 2020 +0000

    btrfs: don't balance btree inode pages from buffered write path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f973c2900000
start commit:   5631c5e0 Merge tag 'xfs-5.9-merge-7' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16f973c2900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12f973c2900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afba7c06f91e56eb
dashboard link: https://syzkaller.appspot.com/bug?extid=7b1677fecb5976b0a099
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155d73fa900000

Reported-by: syzbot+7b1677fecb5976b0a099@syzkaller.appspotmail.com
Fixes: 6a3c7f5c8785 ("btrfs: don't balance btree inode pages from buffered write path")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
