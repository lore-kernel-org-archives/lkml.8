Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7241C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6B4206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgCRB7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:59:04 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:39298 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgCRB7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:59:04 -0400
Received: by mail-il1-f200.google.com with SMTP id w76so12786321ila.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 18:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0HNo1qd7HDCjZwp/AckavVWsU51cjSgzVKKMqeaV0/Q=;
        b=GSFtrhCUq1zK0KMMBhySxLHQ3zf5BILUtXExEe/XxmVsDWPewgyaPEeqlxy6OQMeqd
         ohtnmm4iOKpXVh4jvVUSmyMHuT+tzj18e+PVpccG7xDY31o0mzUSnU3HDxllNuOHn6lg
         +MvZ9LaYp1W7Kc1XAn8zLaJfgJm03RhFW7JRSjupkjXI9ubjB/AiqGQOqenZEGFJFXsY
         qETOpz2W5/2FE3d6rRSn9tU2B+P4p5ZnhnqttCJwXQt+YViUKNMwCgm8+CjpJvqeL7/m
         Yu4B/4SuBF977I/Aw37h3CFOcupp4Ome3OcA3YLIYvR/eRit00UKHYg+giCDHmV8j7ld
         O1oA==
X-Gm-Message-State: ANhLgQ1VshLJDBxatXcE6x5+7l/G8n8UdL1A+GsW8DtogXbnPni7Pqa7
        JFkOC3idvISfOeyWDPXzKt0e3NTJ/snnVkGNHlXcnKJMPDM9
X-Google-Smtp-Source: ADFU+vsJ30sc+Dzh9VHBJOAI0emX3Sfo1QftuTzYodRR9NKuh9cYqsuC48zEhQnxNxrdJ3ulsDA9CbCBEePqgxPvqlJYkrCy3Jwf
MIME-Version: 1.0
X-Received: by 2002:a5d:8f96:: with SMTP id l22mr1608247iol.19.1584496743564;
 Tue, 17 Mar 2020 18:59:03 -0700 (PDT)
Date:   Tue, 17 Mar 2020 18:59:03 -0700
In-Reply-To: <00000000000088487805a116880c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c4f0805a11765a0@google.com>
Subject: Re: KASAN: use-after-free Write in tcindex_change
From:   syzbot <syzbot+ba4bcf1563f90386910f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 599be01ee567b61f4471ee8078870847d0a11e8e
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon Feb 3 05:14:35 2020 +0000

    net_sched: fix an OOB access in cls_tcindex

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14dbc973e00000
start commit:   fb33c651 Linux 5.6-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16dbc973e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12dbc973e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6dfa02302d6db985
dashboard link: https://syzkaller.appspot.com/bug?extid=ba4bcf1563f90386910f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1748dfdde00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16afffdde00000

Reported-by: syzbot+ba4bcf1563f90386910f@syzkaller.appspotmail.com
Fixes: 599be01ee567 ("net_sched: fix an OOB access in cls_tcindex")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
