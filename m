Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7056C10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B332070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 17:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgCGRzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 12:55:03 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:56548 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgCGRzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 12:55:03 -0500
Received: by mail-il1-f198.google.com with SMTP id b17so4172338iln.23
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 09:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5XlGTUdKaoKDhEvj92iVjkqpOpiaj1Gy4Ag7Slt+VSE=;
        b=sFhXhH2sZSNzi48dzyZREkxtDNsxpAgdnP/nZI7u5YmXlWbU4KrXburjv8ObDfAriK
         GPCy4zP5K4MuUkMMLoRwb23Nu6hIsdpEgp8iUcCpUFX8EVO7CmUG9TbQcVSbBGQ0+IXa
         g6s7TL3seluqRcRp0FJYn2Zb8ZHvN+R4oP8vI9ttuOIE4jXl6788EemeK3VqCt07g0PG
         3Hx7Te1pJBrzpp+gfbwelcn3J8W4t45kWVOIzzveK/RdAh76Dyi6BA7HO8j1zlTNpG1x
         qg4XSwQL83Da1azBIgKhx391jHxbkh4bjjmTFjcHaIC6yHdU6n0u+sHXxSJHnf4kNA9H
         lG/Q==
X-Gm-Message-State: ANhLgQ19KqglNXVeQtm6hjcm5ZZotQ1CCNQ6N1++wPLFVYInFGu9FHcP
        KDwn+I6SCVYqLM5VmRoOvy/L1nLlZrkNViY+gPbVohll0INz
X-Google-Smtp-Source: ADFU+vuLgMHbaY1mipKsmH9VLZy1Z02IGCAYBUAO+ljcgofoCeOVF0pdQbHPy18zxSf3UjDYYU/odqGn8BTsLNJ8Hj4Fg+UZTN1W
MIME-Version: 1.0
X-Received: by 2002:a92:5c0a:: with SMTP id q10mr4435314ilb.65.1583603702374;
 Sat, 07 Mar 2020 09:55:02 -0800 (PST)
Date:   Sat, 07 Mar 2020 09:55:02 -0800
In-Reply-To: <000000000000a98a1705a03bbcbe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000252cf605a0477843@google.com>
Subject: Re: general protection fault in __queue_work (2)
From:   syzbot <syzbot+889cc963ed79ee90f74f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, hannes@cmpxchg.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        schatzberg.dan@gmail.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 29dab2122492f6dbc0b895ca5bd047e166684d1a
Author: Dan Schatzberg <schatzberg.dan@gmail.com>
Date:   Tue Feb 25 04:14:07 2020 +0000

    loop: use worker per cgroup instead of kworker

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14d6b01de00000
start commit:   770fbb32 Add linux-next specific files for 20200228
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16d6b01de00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12d6b01de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=576314276bce4ad5
dashboard link: https://syzkaller.appspot.com/bug?extid=889cc963ed79ee90f74f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176d7f29e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134c481de00000

Reported-by: syzbot+889cc963ed79ee90f74f@syzkaller.appspotmail.com
Fixes: 29dab2122492 ("loop: use worker per cgroup instead of kworker")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
