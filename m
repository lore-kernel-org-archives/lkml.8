Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA0BC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5152077B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbgAJGuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:50:01 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:52690 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731540AbgAJGuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:50:01 -0500
Received: by mail-il1-f199.google.com with SMTP id n9so876808ilm.19
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 22:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nSBEziQIAgMmreD/bwiDUMfwTZxHkivHwZB8qVu7K9M=;
        b=F3fgRY/BAE9iuCyfTMvH35PtsAqfgf035w37Hi8I/YmmdC+Ljjm9FC+G6CKopPDAf3
         GoSYZFW7Ot+RIVHCPwOY5Wrrts9/kOqjyKmkM4xkAh4lGrIsIu+fwIwFrhqQiJ5ieCL1
         5H+1s8aunBwJ60UwmH+L+sDQQqdHET3dmgQmieiwnWdkupoWYuRNpejqsFrRkyhO8h38
         sznJQfdFMtA3Ysw6ZFV9ur3GRFS0p1CFKVrpiB/VZfuqsuhJM8QmNMLpcXovo2/WOjJd
         8KPCBLmkDy0zftq56cTh7YqunEHynBtYyi2XYIPV9o3eUaMrpF+PJavcjTJuQXgpzlEj
         2elw==
X-Gm-Message-State: APjAAAVe0nRTlbM5ksWwFFCkgg0MJtnOdDcG355hR8GTuTekk3Pi18Nd
        she26sithUPGN30ZJKDtfXjRzCA3zEpR0WgXI1/MxM/AL0Q1
X-Google-Smtp-Source: APXvYqygb++rANaYFZ2skaGuTLPRW7b0m2B1Xr7kXiLH/wZnhkt0oZWvxvj3A3b+HGzLordUY9WM6fV0K7+EMxq+HVsg4swltiWA
MIME-Version: 1.0
X-Received: by 2002:a92:84d1:: with SMTP id y78mr1319946ilk.69.1578639000707;
 Thu, 09 Jan 2020 22:50:00 -0800 (PST)
Date:   Thu, 09 Jan 2020 22:50:00 -0800
In-Reply-To: <000000000000946842058bc1291d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ddae64059bc388dc@google.com>
Subject: Re: WARNING in add_event_to_ctx
From:   syzbot <syzbot+704bfe2c7d156640ad7a@syzkaller.appspotmail.com>
To:     acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, arvid.brodin@alten.se,
        ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, jbacik@fb.com, jolsa@redhat.com, kafai@fb.com,
        kernel-team@fb.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, xiyou.wangcong@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 311633b604063a8a5d3fbc74d0565b42df721f68
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed Jul 10 06:24:54 2019 +0000

     hsr: switch ->dellink() to ->ndo_uninit()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1005033ee00000
start commit:   6fbc7275 Linux 5.2-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bff6583efcfaed3f
dashboard link: https://syzkaller.appspot.com/bug?extid=704bfe2c7d156640ad7a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1016165da00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b27be5a00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: hsr: switch ->dellink() to ->ndo_uninit()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
