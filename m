Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66574C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414FF206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGQEUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 00:20:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33341 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgGQEUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 00:20:05 -0400
Received: by mail-io1-f72.google.com with SMTP id a12so5712066ioo.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 21:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=j3PfTK/pr4L9iYESodCey/qnyjNi8Dw657O6Mf+Zg20=;
        b=GO7YLB01wrwyBgTdIAISisfdqj2ZfigPaRI7hwTl8eOngS8ME2cdBvKrVJZ+WNK9ke
         +t9/KHJwAHA97z1QTc0MiKqh9Q/6JLldcbW+hKrtLuuEqHKI8lmiyDGhZ6d/0/uvEHjm
         VtuV1HEwz7SbB0g5vO9reDERaDoTTJrXQg37m/wsNHL3KN4xuXOBp+Enasyt2iZb5pxE
         Ky76aahEYI5nMJNX5Q9wDILpQd97oJ9LHa8a21egh+d52NeCi7oAjWNkVARbsJZmqBHb
         w432zanr1kdYOlxArsRi+8PsC5hPKNWZJWV3VQB9OMqF8G/r4rjWkJThDv7zsV6AAmDD
         CTBQ==
X-Gm-Message-State: AOAM532OYIaB09HpbpIaWTCa4hfndPoQMinwSh78h9x/Tc7O5Vby9xNk
        dgFto8f0Mr4zQISz/T78a4IJ6LcrsiRLE0GbkASlvNN3/qW0
X-Google-Smtp-Source: ABdhPJw4xwEhl32rilyRDk1xXUs9He2nKD1ic8BW/rpDuSPhQLS4k36SMiiZktAg7h2AcmcBDhCU1OoPlc3a6bevTEdbZc6L7EZA
MIME-Version: 1.0
X-Received: by 2002:a6b:8e56:: with SMTP id q83mr7806086iod.61.1594959604449;
 Thu, 16 Jul 2020 21:20:04 -0700 (PDT)
Date:   Thu, 16 Jul 2020 21:20:04 -0700
In-Reply-To: <000000000000264c6305a9c74d9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a787b205aa9b7863@google.com>
Subject: Re: INFO: rcu detected stall in tipc_release
From:   syzbot <syzbot+3654c027d861c6df4b06@syzkaller.appspotmail.com>
To:     bp@alien8.de, davem@davemloft.net, fweisbec@gmail.com,
        hpa@zytor.com, jmaloy@redhat.com, jmattson@google.com,
        joro@8bytes.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mingo@redhat.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tuong.t.lien@dektech.com.au,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5e9eeccc58f3e6bcc99b929670665d2ce047e9c9
Author: Tuong Lien <tuong.t.lien@dektech.com.au>
Date:   Wed Jun 3 05:06:01 2020 +0000

    tipc: fix NULL pointer dereference in streaming

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14641620900000
start commit:   7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16641620900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12641620900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=3654c027d861c6df4b06
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12948233100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11344c05100000

Reported-by: syzbot+3654c027d861c6df4b06@syzkaller.appspotmail.com
Fixes: 5e9eeccc58f3 ("tipc: fix NULL pointer dereference in streaming")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
