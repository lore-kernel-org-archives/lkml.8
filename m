Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B95C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1439820787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgGPUlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:41:05 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:45135 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgGPUlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:41:05 -0400
Received: by mail-io1-f70.google.com with SMTP id d64so4322825iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MJOPP91fI02T11IImb5jr+gjqr0RxeB4C7mwZ09S0ac=;
        b=QzRS8M96yReCrQKnVKZQVn5hfZgmL+7QgFE2TvsKn7Ornfl9hLqiuW6vy49G9eStRJ
         k7J+6t9m/DWodMnTafDA8Y1LAg5UKGN8aQjaoBFojgCXkhkklHFeCHDFiGRDRmCtIqVa
         a+1zgBz16R3pz2bJogNt0XewnSubX5ke/BQawYvVoF0wX2z1W/Tbp3mWo4H7zQKWD5/D
         zC6a1ngnCcG9O3dlFoJqjcIlDY2VbCjdPjE+n4DGPELQwzziQEveZUWoQxFyIDx2QWd6
         b5+4j68TIPZSA2QPIKb9iq1p0p7iA/c7l0u5GfFxT/qDqndL/R2UxnmHvDFyr/mqkAYF
         XTZw==
X-Gm-Message-State: AOAM531qFK/RXNtf3qsloQ5oECHkOaSvmyXi4ahzQZFCHB0AMDHA5N+A
        IaCnGq4+aitPIb/14A4o3RKWxTtmycEVOdOHi6ljqmruEOp0
X-Google-Smtp-Source: ABdhPJzv2CNM+Kml3MecWCgob+RHzrgpODX2HxZNVirGkjOmGSYqaiVYO323EJ7wT8l+qtjglQjZCXtHQGB8uokL4mPFWgQs++oy
MIME-Version: 1.0
X-Received: by 2002:a02:cf12:: with SMTP id q18mr7002957jar.3.1594932064186;
 Thu, 16 Jul 2020 13:41:04 -0700 (PDT)
Date:   Thu, 16 Jul 2020 13:41:04 -0700
In-Reply-To: <000000000000983e0405a9c7b870@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002077ca05aa950f9f@google.com>
Subject: Re: INFO: rcu detected stall in __sys_sendmsg
From:   syzbot <syzbot+f517075b510306f61903@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=109a63cf100000
start commit:   7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149a63cf100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=183dd243398ba7ec
dashboard link: https://syzkaller.appspot.com/bug?extid=f517075b510306f61903
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f01c1f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c40ba7100000

Reported-by: syzbot+f517075b510306f61903@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
