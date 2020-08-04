Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB06C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BFB20781
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgHDFxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:53:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:38546 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbgHDFxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:53:06 -0400
Received: by mail-io1-f72.google.com with SMTP id a65so19452546iog.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 22:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BRdtTRPOEaQKBrhbJMVyVg8f+gg0wNhNpfaLQFbDwIc=;
        b=buy2W0y2p15Yqz13ZyvcUWRWOZtsh4La0NXPZtSrxWEGeKzVZW0Mfcn95UXAdo7s+d
         7ruCh48qvh68PO2EEJmir6ZXN86+yLgQxaQF3n5NxQ0q2Injl7zCcbLEx1SPPLucHNj/
         Ro4d1HTyMZQyUO8WyiFxkKX0jYGhCKDITnSKI2EjJh0Zu0MBvkVw4GGOtpmaC+Rr+CBm
         ZmHY45owN0vJ17aAzWL5KnVGzEwCdk8Jmre14M4KKzNSQi83XgGm1i3Mz+/7fa2CozB4
         cGRQJTssZZ2G6mjwziYfZI/tUuCxIPjkO82gixiu8JthiPkgoNo/1vnzX4qHIIv76fTl
         Uv+Q==
X-Gm-Message-State: AOAM5325A+Tqenn6KVFgDkVYRzGjY3G74mb9r8r03+w92TPjg8clcde1
        tcGvW0EUxeWyuRQna7BYY6b2UrzwGJeYR5xMr83jMA1xthN8
X-Google-Smtp-Source: ABdhPJzEkoMCbnNdFUe97FE5HM517BQ0ax1yAE9KKbwZVWX1mKbnq4Vi7DM1AkTvDXzbANiqrkZroxhk4raf2RYgrw3J8jVZ61+P
MIME-Version: 1.0
X-Received: by 2002:a6b:e216:: with SMTP id z22mr3305588ioc.97.1596520385235;
 Mon, 03 Aug 2020 22:53:05 -0700 (PDT)
Date:   Mon, 03 Aug 2020 22:53:05 -0700
In-Reply-To: <0000000000003d6e8405abeb1da7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070529b05ac06deaa@google.com>
Subject: Re: KASAN: use-after-free Read in hci_send_acl
From:   syzbot <syzbot+98228e7407314d2d4ba2@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, mareklindner@neomailbox.ch,
        michael.chan@broadcom.com, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 4ffcd582301bd020b1f9d00c55473af305ec19b5
Author: Michael Chan <michael.chan@broadcom.com>
Date:   Mon Sep 19 07:58:07 2016 +0000

    bnxt_en: Pad TX packets below 52 bytes.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167b0f04900000
start commit:   ac3a0c84 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=157b0f04900000
console output: https://syzkaller.appspot.com/x/log.txt?x=117b0f04900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0cfcf935bcc94d2
dashboard link: https://syzkaller.appspot.com/bug?extid=98228e7407314d2d4ba2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152f1904900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1482dfca900000

Reported-by: syzbot+98228e7407314d2d4ba2@syzkaller.appspotmail.com
Fixes: 4ffcd582301b ("bnxt_en: Pad TX packets below 52 bytes.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
