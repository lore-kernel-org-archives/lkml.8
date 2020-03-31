Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CDAC2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1D5208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgCaLOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:14:05 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:54776 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgCaLOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:14:04 -0400
Received: by mail-il1-f199.google.com with SMTP id m2so19678801ilb.21
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 04:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VDzK7SMPTn5+1NJ0X+ZSAYeFxCx7H6x/5RbxADZ4d6E=;
        b=OsYlGQibCrwQYuKUj4GqmKVGDFFkx9kVZ5IcakUJwmyuO/RL/YyvD3zL6U4tIAnjV8
         PxOPKSCZpQ8Dza6476bB46b2JZ9mUE0aNpHXrRMpnvcQttgudJvl862bhI1+g8XOPwCi
         knR5r2Hr5/SrJaA/d9oJpS4bp1/WkV+elOxYZ7zwDiHxxQN1k3M8EgdHQ9v8G9vPuIf2
         K0plSECflwxVHhgDVUQhu+6rkx03W0SUvS1U5JMHdCSBXmtSeoN6CIv3dRRSwA9JzUVB
         3BJLa50XJU7i4/epCAGu+M2MBdH9SuabRJ+13b29k9JYID8n+yPzky5mAaEQaxBWvzKv
         KLsA==
X-Gm-Message-State: ANhLgQ01Be0jXQiagRa4KozxwH0NosszQZC6KSZiD/Udr5IUnsJkpsxe
        Kra4WdBlN35DeYzpVqEEuLQo16A16swrb0HntHT34H4jalf5
X-Google-Smtp-Source: ADFU+vvsMmk+9AB6KhfsUlDFCpZCCk2oL4klTi/WKgJzTCgTsfyMEXJagR3lLTbUr0mSEfKTgEbpdznTLp2fsXhW7dvop7Eq42Q3
MIME-Version: 1.0
X-Received: by 2002:a5d:950e:: with SMTP id d14mr14672462iom.77.1585653243655;
 Tue, 31 Mar 2020 04:14:03 -0700 (PDT)
Date:   Tue, 31 Mar 2020 04:14:03 -0700
In-Reply-To: <0000000000002efe6505a221d5be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000533b4505a224aa8b@google.com>
Subject: Re: INFO: trying to register non-static key in io_cqring_ev_posted (2)
From:   syzbot <syzbot+0c3370f235b74b3cfd97@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hdanton@sina.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b41e98524e424d104aa7851d54fd65820759875a
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Feb 17 16:52:41 2020 +0000

    io_uring: add per-task callback handler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115adadbe00000
start commit:   673b41e0 staging/octeon: fix up merge error
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=135adadbe00000
console output: https://syzkaller.appspot.com/x/log.txt?x=155adadbe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acf766c0e3d3f8c6
dashboard link: https://syzkaller.appspot.com/bug?extid=0c3370f235b74b3cfd97
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ac1b9de00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10449493e00000

Reported-by: syzbot+0c3370f235b74b3cfd97@syzkaller.appspotmail.com
Fixes: b41e98524e42 ("io_uring: add per-task callback handler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
