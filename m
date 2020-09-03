Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4113C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8567B206D4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgICPdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:33:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35543 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgICPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:33:06 -0400
Received: by mail-io1-f72.google.com with SMTP id k20so2319132iog.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 08:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NOQoaI8MmUjTmRPzTkswBuSyXsa4TobuGT61RtxiEdk=;
        b=YsAGv6LYuIo/b520Zs8d2c3rHZRFW4vuwGWS9bptYAs70EC0SPXw7NcfoQcNnFNRnl
         uZYdGdqtx+GYBKkX1htTwFtcJ30f79bqHq6DvSijqmia5mc6HIgsCjuI+P4bxZH/bGvI
         ErETC6yWzO7vyK3JapIRBz6k+U56ExOzQeaYQ2YkLB+Nysi0a8F6Wd2EoqpBQrl3ppGT
         2i0vn0u834vQVUYw8k9pXqRqxAxwDx+pXjMeAHzX00YzjedlUvCI5ssgVOktPuK8kALQ
         63Q76R1WJlKfwq09mZAMQhrQ1EmkV9jj8pl9ccOhlAAS7qlas7ZI5qhoQYDHYuqGnH0x
         c4kw==
X-Gm-Message-State: AOAM533NaDT04fg9qZl/AlsXftGMc+4V2Ylt3txe0QJLCVO33H2o+n/S
        nZ7mctnZS7AOLHOWPc38sMJCTvM3pH0Bkak3lvN1zHgAq+2u
X-Google-Smtp-Source: ABdhPJy/G9JyxC5525578EvfqwJfRzuzFC+hyFWJWTSwCgZXoOjSHHNx7mjShsCPPxJCqgHLR1nJSK3dV9yrHHRIfOtDrEoegrlw
MIME-Version: 1.0
X-Received: by 2002:a6b:6016:: with SMTP id r22mr3664364iog.42.1599147186374;
 Thu, 03 Sep 2020 08:33:06 -0700 (PDT)
Date:   Thu, 03 Sep 2020 08:33:06 -0700
In-Reply-To: <00000000000014fd1405ae64d01f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcd01005ae6a77e7@google.com>
Subject: Re: INFO: task hung in tcf_ife_init
From:   syzbot <syzbot+80e32b5d1f9923f8ace6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, eric.dumazet@gmail.com, jhs@mojatatu.com,
        jiri@mellanox.com, jiri@resnulli.us, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vladbu@mellanox.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 4e8ddd7f1758ca4ddd0c1f7cf3e66fce736241d2
Author: Vlad Buslov <vladbu@mellanox.com>
Date:   Thu Jul 5 14:24:30 2018 +0000

    net: sched: don't release reference on action overwrite

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ae08e9900000
start commit:   1996cf46 net: bcmgenet: fix mask check in bcmgenet_validat..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ae08e9900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ae08e9900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
dashboard link: https://syzkaller.appspot.com/bug?extid=80e32b5d1f9923f8ace6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161678e1900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f826d1900000

Reported-by: syzbot+80e32b5d1f9923f8ace6@syzkaller.appspotmail.com
Fixes: 4e8ddd7f1758 ("net: sched: don't release reference on action overwrite")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
