Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25863C433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0095A22B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgGTHIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:08:09 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:37515 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgGTHIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:08:07 -0400
Received: by mail-io1-f71.google.com with SMTP id 63so10688813ioy.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 00:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hf+kwcKJaoB2O2XzZ62VTTEDTpLPt+1+yZptVyrXu3Y=;
        b=Cd0ZM5qyuQdTgs89Gm7X/APDtUaQGerbHKTYh4Omci2kO6yRE4R5RZpR4tWZeyWl55
         phjCCz7iYY9EFP8XVd+pMwLsSe1j4oxUS0GFdwE+Ii5TzMGlz8knOeXXy1gOGeYlKT+n
         66/uZmOQKm4T1ujQGBLmYLcDzAJke6Aps4qgugn+nEHfo+jZ1evpaxQBsvc7XaMobIJL
         7czzYoM6WzLx4LybQ3ZjtcmIUG5kBbISM1SsouLvHmjEAqBcZj7Vvl4uW006DvbIrir1
         biWonAgARHuSqBWvN+rdPujZ2NsHXTxyuwGh/PNbT4NF8FYb7+7xEI9illFeP5M22cMv
         KvRA==
X-Gm-Message-State: AOAM5301p/+D6JBG4v10KTjYcn1JxphAdwo163WUkFeI42rpRyYTMEfQ
        xLLlQQzMQUATQttornTcCPcoFuULS/q9qT39i2uHzkfJmgF0
X-Google-Smtp-Source: ABdhPJxo/yL9uQtzaZRRNF+0FqYGONLLfW8cud6VWFvmxM1Yav75gunkUZy2TqikI8tHCMeJFCpPmRIsXPeM+7wwYZcGZeKzh4Ah
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2601:: with SMTP id m1mr17777548jat.141.1595228885931;
 Mon, 20 Jul 2020 00:08:05 -0700 (PDT)
Date:   Mon, 20 Jul 2020 00:08:05 -0700
In-Reply-To: <0000000000005d946305a9f5d206@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014dc1805aada2bea@google.com>
Subject: Re: INFO: rcu detected stall in sock_close (3)
From:   syzbot <syzbot+4168fa4c45be33afa73c@syzkaller.appspotmail.com>
To:     Markus.Elfring@web.de, davem@davemloft.net, fweisbec@gmail.com,
        hdanton@sina.com, jmaloy@redhat.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tipc-discussion@lists.sourceforge.net,
        tuong.t.lien@dektech.com.au, ying.xue@windriver.com
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c5517d100000
start commit:   7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15c5517d100000
console output: https://syzkaller.appspot.com/x/log.txt?x=11c5517d100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=183dd243398ba7ec
dashboard link: https://syzkaller.appspot.com/bug?extid=4168fa4c45be33afa73c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112223b7100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154793a3100000

Reported-by: syzbot+4168fa4c45be33afa73c@syzkaller.appspotmail.com
Fixes: 5e9eeccc58f3 ("tipc: fix NULL pointer dereference in streaming")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
