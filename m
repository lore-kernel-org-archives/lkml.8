Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039F5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD41217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAVQYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:24:03 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:52068 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAVQYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:24:02 -0500
Received: by mail-il1-f199.google.com with SMTP id v13so89523ili.18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 08:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zJCuXAAGGfmdn3xKT3mw1EQTFOCTjnZ0M4GP0MOAhHQ=;
        b=MqoyLRcjXNENzpgFvghGJmrqAVPAx1ekC4shiJe1rP1e8kPI4a2wzyBO+ENQAnxuH+
         +6kFSWjPiDv/RG82Dr9lcN7GNHOLfxjhpTO3AFB8KJJuKmNfl4fMFy8qRJD2TuBZe49P
         /Ct3g97f5pMg+rRwpJurcDPHRsY92OZzrv0ZeZU4DUicLf+hwY0+GVJhV9K8aBysdh6B
         uW0n40SL6hM/e2Mr+p/urJSITbx5qMx3gwsUG9LArk8JuIQgpkUP7a4aGwP9xoQccT/N
         WXybx0XBwFKULY9+m/akpUqZEjMkeDSmLadIa6UXCbGUAwly+9cSpZITqgxtLKegxqgD
         Sxsg==
X-Gm-Message-State: APjAAAVYe/09CybiiV2JcQX70MP7743p3DUfKU6XgPtd7/V8rLS19uSl
        2pj3jOCvVKR85c6AaHgbLbNWAmTw+Ur1zU2KGf4BMbr/m9C9
X-Google-Smtp-Source: APXvYqyJNUTQllpzChKWI3nNnvCCMcKFDK8FOmsX5mlgK8LQmSBOogF54plRyAyGRd+Lr8Pp2HjGvCwNo5+7ENt5YVZMH92fGi8/
MIME-Version: 1.0
X-Received: by 2002:a6b:8e47:: with SMTP id q68mr7385399iod.274.1579710241804;
 Wed, 22 Jan 2020 08:24:01 -0800 (PST)
Date:   Wed, 22 Jan 2020 08:24:01 -0800
In-Reply-To: <000000000000b6da7b059c8110c4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf992f059cbcf362@google.com>
Subject: Re: general protection fault in nf_flow_table_offload_setup
From:   syzbot <syzbot+e93c1d9ae19a0236289c@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@netfilter.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit a7965d58ddab0253ddfae58bd5c7d2de46ef0f76
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Mon Jan 13 18:02:22 2020 +0000

    netfilter: flowtable: add nf_flow_table_offload_cmd()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ea59c9e00000
start commit:   4f2c17e0 Merge branch 'master' of git://git.kernel.org/pub..
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=141a59c9e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=101a59c9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f93900a7904130d
dashboard link: https://syzkaller.appspot.com/bug?extid=e93c1d9ae19a0236289c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166fea6ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108d6185e00000

Reported-by: syzbot+e93c1d9ae19a0236289c@syzkaller.appspotmail.com
Fixes: a7965d58ddab ("netfilter: flowtable: add nf_flow_table_offload_cmd()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
