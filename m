Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B4C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA93208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgD2MME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:12:04 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:36221 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgD2MME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:12:04 -0400
Received: by mail-io1-f69.google.com with SMTP id m16so2204838ion.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PcO8Kd1YBitB52qqPhTJQcKlql/IIwrSnAimZeG48WY=;
        b=sR5GymXu2arnRIZnu7sdL3CL4ri9GqPV9ZmqM0D/FkIxQd1R1o10Kv20g4khIQGXM4
         UiAgAR7Quzr014OIcIGkXLPpQYjc52LI94ApD/T+rqXHMiK/V1xgWHpB6b4Dzas7eWsc
         1T8hsn3kVZeWp/H4xfVehCSOQf8b05V5zsu5VYPp9wVG3ro5vmY+M+N3kl9jv9BXGEbd
         vKYSRAeqN1MMkYtDJ0MUsZS5N3VAWpTqz353K5YrY+jU2njXr1bvg/i/jRssKu2XgAfo
         doXo/jn5lJ1MNlZ7D5xiL0ksrTxMOuS+6iXwh8MZKu9rP/qMo0qQcZN56dc1khB7JTZj
         51/w==
X-Gm-Message-State: AGi0Pubz4hmFTlfjrPkfkT6AwFOmo70BPrWcRGbYq/qL8xVUmmE4lhRR
        w7/kDrfKwnH/azNXCNoq2k/ybw6T/1SSIXAFuRoiiG6mMuM5
X-Google-Smtp-Source: APiQypJP2W68RxtxIieiSS1l8KwM59eBNQMIxwjGv9JUZ6878yRXgSmubwKDBS1vqBOIm8e+WhASeRnX1wkEPaga96kMUFN9cOqO
MIME-Version: 1.0
X-Received: by 2002:a92:6c0b:: with SMTP id h11mr72208ilc.158.1588162322766;
 Wed, 29 Apr 2020 05:12:02 -0700 (PDT)
Date:   Wed, 29 Apr 2020 05:12:02 -0700
In-Reply-To: <00000000000051770905984d38d3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001821b605a46cdb7f@google.com>
Subject: Re: WARNING in exfat_bdev_read
From:   syzbot <syzbot+1930da7118e99b06e4ab@syzkaller.appspotmail.com>
To:     alexander.levin@microsoft.com, davem@davemloft.net,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, namjae.jeon@samsung.com,
        pragat.pandya@gmail.com, syzkaller-bugs@googlegroups.com,
        valdis.kletnieks@vt.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 5f33771fb0ac484d6e8cc34cb1e27c37442cd0db
Author: Namjae Jeon <namjae.jeon@samsung.com>
Date:   Fri Jan 3 01:13:45 2020 +0000

    staging: exfat: add STAGING prefix to config names

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1407f818100000
start commit:   32ef9553 Merge tag 'fsnotify_for_v5.5-rc1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=1930da7118e99b06e4ab
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e208a6e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f83882e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: staging: exfat: add STAGING prefix to config names

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
