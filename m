Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A3DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3340720658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgGOQjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:39:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:57278 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgGOQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:39:05 -0400
Received: by mail-io1-f71.google.com with SMTP id a10so1690210ioc.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bpi1X2/kiZRhiI5Uh4MWU1GOK2TwFKFWyvVbQHnHroo=;
        b=RJ+RE69pgxrMAvpum8u4SjPpcILUX/R5WsExJeGwhCYPSG6r3Womn0hp5mPP5uRmBe
         iccYK9APpiWn4/oIjadThyP8PMcrK5HlSauSOcGvgWzxWr1HtHYZdRbdkQvN0w2jyWS5
         TwQgmJe5N2kgkVibRt8JnUIICrw4vylCzb0IkVEg+BMRHpbolcLEXJBDTc7MUwQY76oe
         2at+KvzPjcSFRDKos17wp1Hbhm5sxXB0tZTnZoARGNWNtx9VrKMS2wnEUIS9Pb7jF6nN
         p3fFGavzcZFeS9sFAoUVFccqaHL60I0ySx6zTTMar3pZ5ob7bt/wtSB8960pv5HentOR
         I+Hw==
X-Gm-Message-State: AOAM531q9z6BXuPceUucNbWB1bDVvkMDU8xxmT3so8hky1ZTdHwMYbza
        ua2fxP8lDthKKXvO/rdukj1rcUgjMJJS6CAIO/hDWHyDnO+2
X-Google-Smtp-Source: ABdhPJyj/1GBiR6PORckm/5csMRZ7ojgTW/dLEi19AkOiFkL5lHeuRaRNTDxUunwfQt8Wvb4CMqCf2S1geELgmOTfXfL7noTXw6M
MIME-Version: 1.0
X-Received: by 2002:a6b:16c4:: with SMTP id 187mr130872iow.7.1594831144722;
 Wed, 15 Jul 2020 09:39:04 -0700 (PDT)
Date:   Wed, 15 Jul 2020 09:39:04 -0700
In-Reply-To: <00000000000065e73d05aa743471@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbb12b05aa7d8f77@google.com>
Subject: Re: INFO: rcu detected stall in __do_sys_clock_adjtime
From:   syzbot <syzbot+587a843fe6b38420a209@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=158ab3e0900000
start commit:   a581387e Merge tag 'io_uring-5.8-2020-07-10' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138ab3e0900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=587a843fe6b38420a209
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14778a77100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15150e13100000

Reported-by: syzbot+587a843fe6b38420a209@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
