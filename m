Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7250C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9246521569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgAWWWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:22:03 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:49757 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAWWWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:22:03 -0500
Received: by mail-il1-f197.google.com with SMTP id p67so19868ill.16
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 14:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=U2ciZII89LyEb1jgPxE5/IJrQKEwwRWzV2RXknpTZh0=;
        b=s+zvO/Vk6AevJ0woR+fITZL6btQVrZrlL1ugTbQQ1bf25C3wqcR9hnA6w+b+OSYnOs
         l/TKDN3trj9KxDSjcIvTvLw0P+4e4+5fQerPb1g8v1e2/A1AIbst4cTUz3Pejq/M9TA9
         I89KPniJ3je/nEMsS7ZDCL74kJGMMmDMd3Dkfy4vQP5JnYb1Gqap7xwsrHs2iyKr+xas
         KgErYg9oZ/UtaQLL+EBTjiviT8JqU5zuXvt+qqcQajA/z24uvCX/Mzs5uQS8eoisjcBM
         NZjLtyAJutgO90VuJb/CG9AZnheGo4v5Y6kRMKA8kMSfi3Q7+Q748B5TAasgVE0vOTVE
         LUwQ==
X-Gm-Message-State: APjAAAU8EXWMt+C7SdyD7/E4V+Hrim/Rz17oqlV6Bct0lASDAWszD2rU
        L0aA8mr5pObmXcWoGoMbmN7fuBofchlHMqtpwLQcekxPrUKl
X-Google-Smtp-Source: APXvYqzaQsx9AEgaVI+glQ1AcIBsAAutP1ZctuK9ZTtYuJ4mdcopjSrfR25SqY6ZJWnqbTQIJlRs2yTGajrbtyPIUwun6yUoBqiI
MIME-Version: 1.0
X-Received: by 2002:a02:8587:: with SMTP id d7mr59180jai.39.1579818122597;
 Thu, 23 Jan 2020 14:22:02 -0800 (PST)
Date:   Thu, 23 Jan 2020 14:22:02 -0800
In-Reply-To: <000000000000da7a79059caf2656@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001df94059cd612b2@google.com>
Subject: Re: WARNING in __proc_create (2)
From:   syzbot <syzbot+b904ba7c947a37b4b291@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        dan.carpenter@oracle.com, davem@davemloft.net, dhowells@redhat.com,
        info@drgreenstore.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f4b3526d83c40dd8bf5948b9d7a1b2c340f0dcc8
Author: David Howells <dhowells@redhat.com>
Date:   Thu Nov 2 15:27:48 2017 +0000

    afs: Connect up the CB.ProbeUuid

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1627a721e00000
start commit:   d96d875e Merge tag 'fixes_for_v5.5-rc8' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1527a721e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1127a721e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=b904ba7c947a37b4b291
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c96185e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f859c9e00000

Reported-by: syzbot+b904ba7c947a37b4b291@syzkaller.appspotmail.com
Fixes: f4b3526d83c4 ("afs: Connect up the CB.ProbeUuid")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
