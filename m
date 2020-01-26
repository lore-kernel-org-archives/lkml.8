Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F8FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 15:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F032071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 15:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgAZPZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 10:25:03 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:44218 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgAZPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 10:25:02 -0500
Received: by mail-il1-f197.google.com with SMTP id h87so5739469ild.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 07:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RjRY8jb+5UI6pjP3QDbg06fxukj7aEOy3CbF/dNamkc=;
        b=Duboda4Q7Fm/EasnMm+twoxvXTZcU9dO6HjfKGmwtEUI0tUsRonO99BrY+TT8yE1MK
         zRahVAcSrTyzAymFRT+iFrhwKUw4ENgrjv4Nh3PRZkhL7fsBkP2JBdT76bi71WICgtT1
         IJ0v9fCyv3YG31bK80Cbw7KbL4sU30dfViYDn/flyVtv0kLfZu81VHCYFIO/GPMTVyLx
         cwQL0OcZY0/dB6lHXfwA26RxD5wDHkRuU3DKTwSGMUYp/c3sYBWl1uBmdnvjcfIy0363
         UuKWQe0PXpN2sfdqlYjNidUemt/ow5tLIImJc8Yk7PpYyCfLP6M7kptcPAv1+bc2AxLL
         7fiQ==
X-Gm-Message-State: APjAAAUcy2fww5sF3M+nYrwykyNNFs+H0HBO660jVYHqtXKaAUeHPxKF
        ZeyK2AHgqXNfz9JnfxIX2f9J1+lVRYSQUbUY8K8+FjKqV3KX
X-Google-Smtp-Source: APXvYqxx8mMeFFgL/ZBVyqZz9kOD/SiLe3QSxztT5lA5/Xu2sGr9dWlclDW5GVH4eU2r0rYEIZFk2fSbaf1Mo91+scqt7ZMxnXOr
MIME-Version: 1.0
X-Received: by 2002:a6b:600f:: with SMTP id r15mr9168784iog.54.1580052302010;
 Sun, 26 Jan 2020 07:25:02 -0800 (PST)
Date:   Sun, 26 Jan 2020 07:25:02 -0800
In-Reply-To: <0000000000003cf909059a69fe9a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003021ea059d0c98b4@google.com>
Subject: Re: INFO: rcu detected stall in addrconf_rs_timer (3)
From:   syzbot <syzbot+c22c6b9dce8e773ddcb6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit d9e15a2733067c9328fb56d98fe8e574fa19ec31
Author: Eric Dumazet <edumazet@google.com>
Date:   Mon Jan 6 14:10:39 2020 +0000

    pkt_sched: fq: do not accept silly TCA_FQ_QUANTUM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1625d479e00000
start commit:   a1ec57c0 net: stmmac: tc: Fix TAPRIO division operation
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=7159d94cd4de714e
dashboard link: https://syzkaller.appspot.com/bug?extid=c22c6b9dce8e773ddcb6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168e33b6e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178c160ae00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: pkt_sched: fq: do not accept silly TCA_FQ_QUANTUM

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
