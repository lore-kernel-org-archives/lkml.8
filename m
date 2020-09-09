Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2BFC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C02A2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgIINcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:32:53 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:44686 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbgIINTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:19:07 -0400
Received: by mail-il1-f207.google.com with SMTP id j11so1987813ilr.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 06:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=E3DC8oOc5Wv1kvi7EPmKvvKbe0T5xVJz7MHLJ6IZAsg=;
        b=g4o2pkDAP/5SYWV2TVenm1sJUrEUaQs+9bnw6u6OQEqQa+NbqtVhIwnVEM6+iJ/woq
         NiTwB689Mhj0R0MHeCBGvRr0VM1AQtiU0bydYyb9n+VQGWkOVRt2exP9mbxsk/BQx3cO
         +/ahYLUVxnSBW8jIsY8BfypSpdc8SHrJnaE1W/QKZjmHgZA4Zsd7p8TTA+O5Jj/wPI/F
         yjS/CXpRI274wLlY0skHlg3lRdHtxtQovzbEtOWbVSsc/85S8LGhgsikW9TUkOMhPWdx
         WCEguDoBKANoSVr8+bV6VX8T9hUdXAlZnOLie4FAMsYsLOPUQalm3y873owAv6KGqREk
         AV/w==
X-Gm-Message-State: AOAM530yzeOVGxzfpAocCq1sy+6x2hEI3jlM4qwsi+fH2vM4y7lELpXE
        Nr80+4FZYRkBcOGEYrB//Tw24XFooxsurozuPDh0WW8qStKC
X-Google-Smtp-Source: ABdhPJxcQGxT5cF6oLXv72p5cpZNhvBHKbh1UCXK1nE51/J5GhQOYBlu+S/ZZWIBLCIbFJoMJf4qNwXxdUWZdLn5fycpFuyANkem
MIME-Version: 1.0
X-Received: by 2002:a92:906:: with SMTP id y6mr3753912ilg.106.1599657546811;
 Wed, 09 Sep 2020 06:19:06 -0700 (PDT)
Date:   Wed, 09 Sep 2020 06:19:06 -0700
In-Reply-To: <0000000000002cdf7305aedd838d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7136005aee14bf9@google.com>
Subject: Re: WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected (2)
From:   syzbot <syzbot+22e87cdf94021b984aa6@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, boqun.feng@gmail.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit f08e3888574d490b31481eef6d84c61bedba7a47
Author: Boqun Feng <boqun.feng@gmail.com>
Date:   Fri Aug 7 07:42:30 2020 +0000

    lockdep: Fix recursive read lock related safe->unsafe detection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13034be1900000
start commit:   dff9f829 Add linux-next specific files for 20200908
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10834be1900000
console output: https://syzkaller.appspot.com/x/log.txt?x=17034be1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
dashboard link: https://syzkaller.appspot.com/bug?extid=22e87cdf94021b984aa6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108b740d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12daa9ed900000

Reported-by: syzbot+22e87cdf94021b984aa6@syzkaller.appspotmail.com
Fixes: f08e3888574d ("lockdep: Fix recursive read lock related safe->unsafe detection")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
