Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD97C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588B4206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGYFLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:11:05 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:37334 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgGYFLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:11:05 -0400
Received: by mail-il1-f200.google.com with SMTP id q9so1132430ilc.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OxvLZmqjPIgyfFJFD3jU0NCXtLqtMkM6RdMtuDq0MCs=;
        b=SqSirh+ib5iURU+TNKAFbJOTzK6aMdj9teV0WVRiNNAQ7fPbYiUv09IE6QThnbcFZ7
         hLO30OA10j5MTzEu0i6KBZYXco9PkTuMW0m9peFH6vOn/CUjNsBSaybrznPaYOmEtgjN
         dfB75oRHgbVgol1NmZRJg5DkI+lec4oIm8i6Y3v/wPCjDJtYLLZIpRHiVxsbJ2nUm8XC
         Mpvnh1mCUfwI1e4SQgOotrSOzx+pQ/l134dAHhwEFukRfTrf90U1TE/447Ios8oTPTCn
         ZLXryTyFHva6HSwKD9BMR5+YysjBVtNiY1O7XgdLUHPWm6pRQaMm0SNfjjqdXzA+QBA8
         cbUw==
X-Gm-Message-State: AOAM5328WwQF3K+NBaZJq2zhrJqXvm+aY8P6F7MS4AJ6QObR/SPcnGSa
        fQ4ZkvUQtNEDf6rUenaw06plpKOgmOCCnhEO+ygA1dsD6AoL
X-Google-Smtp-Source: ABdhPJz7r05qYNwD8iAc+QKC+Tc9C8Eqv0mYlaRsqfEyEpJszHU46Z43bkEBNCZQUn51WRKL3DEvQ3smKEI3RDnTLqC1oTSQ+4/l
MIME-Version: 1.0
X-Received: by 2002:a92:c912:: with SMTP id t18mr10628820ilp.186.1595653864438;
 Fri, 24 Jul 2020 22:11:04 -0700 (PDT)
Date:   Fri, 24 Jul 2020 22:11:04 -0700
In-Reply-To: <000000000000402c5305ab0bd2a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c641a505ab3d1d48@google.com>
Subject: Re: INFO: task hung in synchronize_rcu (3)
From:   syzbot <syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, davem@davemloft.net, jhs@mojatatu.com,
        jiri@resnulli.us, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vinicius.gomes@intel.com, viro@zeniv.linux.org.uk,
        xiyou.wangcong@gmail.com
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149057ef100000
start commit:   4fa640dc Merge tag 'vfio-v5.8-rc7' of git://github.com/awi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=169057ef100000
console output: https://syzkaller.appspot.com/x/log.txt?x=129057ef100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
dashboard link: https://syzkaller.appspot.com/bug?extid=0c6da80218456f1edc36
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e2a437100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13af00e8900000

Reported-by: syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
