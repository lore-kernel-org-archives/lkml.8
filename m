Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FE0C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA1C20748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgIDJRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:17:15 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:50494 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgIDJRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:17:09 -0400
Received: by mail-il1-f198.google.com with SMTP id l8so4357058ilo.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 02:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=A0XXOCOsCKpVbiOmCtSMND7R8pvo4WiohDym5VmGicM=;
        b=C0CxY7jw52IT0E2/XCwtBz7iD/cNJBOR1H9hspHqIIu1J5M0Bhrd4HpFQQKkhZ2b32
         2NZVNMju5mYbdtQXLagV1W/GQCtRnx96V6GrxHAKXJTwn16/Wd8QRVmXMBioTvfb4EG1
         5ZJFCDSToo6o7WjCnmGEwJN7Pq1vq0nzYoBblc8pd9rI4tOjbppDLeyglupaQGkZS57O
         l2axynCeUQuZzjCS3cmty03aAkjN8Uzo7G/g6HoqfPLvo1/x1/qqvsmH/RdL64Ay8qkt
         sQKK1BrH1x3CndIKj+PDx0+BbfEgSDghr7/UtpiosYwxaZFEgorzrDV2qHP7i9d0SeNu
         4e+A==
X-Gm-Message-State: AOAM530CB3DQAJmci37rVHTdusnV6/h0eCz9PeMj1EG+WnN6KPYl5SNd
        rmYLkLCp1GPV+p2/c9YWLWNsXdhkz6rSi2oQTCtuq/NpO60t
X-Google-Smtp-Source: ABdhPJz4l9diDvi6JeZoFv4l/8t/lebVi6lVVRaf0FpautrVybTTmaZYgtTJ+rMvN9/aU+pvBmFLgHlR3xJZ/DGghivcPWtVoGV3
MIME-Version: 1.0
X-Received: by 2002:a92:6606:: with SMTP id a6mr6903338ilc.128.1599211028247;
 Fri, 04 Sep 2020 02:17:08 -0700 (PDT)
Date:   Fri, 04 Sep 2020 02:17:08 -0700
In-Reply-To: <000000000000a358f905ae6b5dc6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000427d4405ae795514@google.com>
Subject: Re: KASAN: use-after-free Read in dump_schedule
From:   syzbot <syzbot+621fd33c0b53d15ee8de@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, leandro.maciel.dorileo@intel.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vedang.patel@intel.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 7b9eba7ba0c1b24df42b70b62d154b284befbccf
Author: Leandro Dorileo <leandro.maciel.dorileo@intel.com>
Date:   Mon Apr 8 17:12:17 2019 +0000

    net/sched: taprio: fix picos_per_byte miscalculation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15464af9900000
start commit:   fc3abb53 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17464af9900000
console output: https://syzkaller.appspot.com/x/log.txt?x=13464af9900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1c560d0f4e121c9
dashboard link: https://syzkaller.appspot.com/bug?extid=621fd33c0b53d15ee8de
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1129d0e9900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fb6a25900000

Reported-by: syzbot+621fd33c0b53d15ee8de@syzkaller.appspotmail.com
Fixes: 7b9eba7ba0c1 ("net/sched: taprio: fix picos_per_byte miscalculation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
