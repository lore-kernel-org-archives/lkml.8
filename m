Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EF2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF5012078E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgHJQEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:04:09 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:37120 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgHJQEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:04:06 -0400
Received: by mail-il1-f197.google.com with SMTP id 5so5022465ila.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 09:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JYunBAF0CO9I6T7+mCBUdOib7oLhSaU/1OgyuSzfO5o=;
        b=SkDbSTNvBvPLi/asP6szvHrwhEiDJ7a1NPRv8uIrfUWm8SCr/aQiWTBdEDYUKi5XiM
         Szg4HYoqW7GuOGi8mRzTp9V8NcFYC44YUuGOWZfjw12zMDFwJl4W2SlnnmQ9j/Nk2j4T
         yB31DIfyV+RddAYWU5YPhl7obwo2fP/nDmWBKhWOOT1yXcbjdZu37DVgeHIS3CcjC3ys
         oXNX8OlM0ycbV8EnUZ3cACf3lIpWMQwtD3MX2Ve3C6Pl9/DL6klUQgy+KyDWlyTpWsCq
         wymuMQUq8uiWLzHZihJGD6/T1AtvFuEzUzzgSLHlOV7QRAplZiOc57orn+pLle4qszeh
         mpRQ==
X-Gm-Message-State: AOAM530u2MDxqZVoeUSX0O0lPQmHOhmxEYATc2wVRhoJXBZiIkaLytrE
        MOOZ/s9hw08x3T9uqBOEp0dnvsskO1hbj+zM4HPTNh++og2t
X-Google-Smtp-Source: ABdhPJypEi0fFwm9FfdzOt9VyXzPHxfS3H30esVuwqWhNkdWmk6zkV7Hh5f843JOksGNlCV4c68qEFWIGDUNpN78VlBwMuSaIAFL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:546:: with SMTP id i6mr2505029ils.143.1597075445337;
 Mon, 10 Aug 2020 09:04:05 -0700 (PDT)
Date:   Mon, 10 Aug 2020 09:04:05 -0700
In-Reply-To: <000000000000391eaf05ac87b74d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099566305ac881a16@google.com>
Subject: Re: INFO: task hung in io_uring_flush
From:   syzbot <syzbot+6338dcebf269a590b668@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit f86cd20c9454847a524ddbdcdec32c0380ed7c9b
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Jan 29 20:46:44 2020 +0000

    io_uring: fix linked command file table usage

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16db4d3a900000
start commit:   9420f1ce Merge tag 'pinctrl-v5.9-1' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15db4d3a900000
console output: https://syzkaller.appspot.com/x/log.txt?x=11db4d3a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72cf85e4237850c8
dashboard link: https://syzkaller.appspot.com/bug?extid=6338dcebf269a590b668
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141dde52900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b196aa900000

Reported-by: syzbot+6338dcebf269a590b668@syzkaller.appspotmail.com
Fixes: f86cd20c9454 ("io_uring: fix linked command file table usage")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
