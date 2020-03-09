Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE906C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 03:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B297120675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 03:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgCIDJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 23:09:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:33390 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgCIDJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 23:09:04 -0400
Received: by mail-io1-f70.google.com with SMTP id b4so2893657iok.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 20:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WbPwkzgEPrAuJzlxX3CcbeuVGuo6guJ+1bROjxY+tqA=;
        b=EGjtWrqx9azFi34PWGlJnVcTVZwYZmlvpk5lnbNM/KI0nqUI+uJIJzhlpbm2kDR+5o
         feazoodRqztAJhrVZZrKAmW8hY7YVrPiv6+ig6cuBqYI1FmKbZbveR4HYXzlObksxXyE
         D3us64C4cmXuvHGWj3+UqyE9pbbVbXfjkQvHWHO8m862PH3QFg1QBf1E/plTbEV3/maa
         dUqd/+irPt0lg5qYWElFWcY1Rs2bWwX9UfWsQH1Ik5JnuKAY8DyoDI2gsNIig3zL9nIB
         x43NW239cPIp2pracQp4jiuT7JJ33LR+yWV7vDd5R4K51XDovSWuN1t54AJLi3iqJLyr
         Kd5Q==
X-Gm-Message-State: ANhLgQ2FEqjo0rfPNrxwqdWgk+cijMgxb/j8xfzbiSwT9UL/viczHVp8
        6/VV3LTnBN28NniZfg3Lz46IXTxgLHnJSmgZA38dPMqkuunW
X-Google-Smtp-Source: ADFU+vuLUQs3pQJgI40e0FlWP1Od+6cgMq10RNWRdC+c5ejp2eHk5Lw4iP8+qGXXffXMdih3mGWzBhI08RLSfGUmhMETIsJUodno
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1786:: with SMTP id y6mr2447173iox.62.1583723342108;
 Sun, 08 Mar 2020 20:09:02 -0700 (PDT)
Date:   Sun, 08 Mar 2020 20:09:02 -0700
In-Reply-To: <0000000000006f20e205a01ef5e1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a9d4f05a063536a@google.com>
Subject: Re: possible deadlock in __static_key_slow_dec
From:   syzbot <syzbot+61ffbb75d30176841f76@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, bristot@redhat.com, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org,
        simon.horman@netronome.com, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b9a1e627405d68d475a3c1f35e685ccfb5bbe668
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Jul 4 00:21:13 2019 +0000

    hsr: implement dellink to clean up resources

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1449a0b1e00000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1649a0b1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1249a0b1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=61ffbb75d30176841f76
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f0efa1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119cf3b5e00000

Reported-by: syzbot+61ffbb75d30176841f76@syzkaller.appspotmail.com
Fixes: b9a1e627405d ("hsr: implement dellink to clean up resources")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
