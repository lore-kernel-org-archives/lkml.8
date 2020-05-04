Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A8C47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777AE206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEDDCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 23:02:07 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:51358 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgEDDCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 23:02:06 -0400
Received: by mail-il1-f200.google.com with SMTP id p12so12323311iln.18
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 20:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VsgFqYSkkd5RuUdbSLmpmT3wYB5MsDwArGNEdSX9o6A=;
        b=lKcK27JJlZsj3AJZXYe3F74MJkJQTJ/af4nC/6oOsVSnJORnR8M5Rn8bVzNCDwCoUv
         CKKOeUZnE6KVAWiKAkhKncZZy43nGmH9j/1oKmLvdBHHUFWmYRcRHg5auWxjzqPcCHDQ
         6pRWo/TDgNavGwqn6iU/R5i91Gjj7kkj/2DU0Uico/GssYI/SXPnnGaidht5l9+65dEg
         NqH7aOUJgWNJn+WMPJgNoHXSOKOx7VkQ2Vc9t9pFHOf1BGz8Q0SJQCA+chS/X+XOhFCM
         b96SFCrv9//9tVEMZEv5DAkvadzjXZc9EqEJb7zLvME8qTm3sP6eizpno0kUpEoD/a31
         eUmw==
X-Gm-Message-State: AGi0PuYGpJWynnF5ynqXF/1Bi/SeFD5jLs5sslAjjXnLtcqjymZLx5am
        /+z5B9R/Q/KTZoLYsxNhgIvrpmFOxkuw2w9wCQKuTkzhE2eZ
X-Google-Smtp-Source: APiQypKVjvGUSvnQLOwHaUNc3oSLx1OL9IDYU+TwsaaCuFKXkqDorCljUIAIiJwrVKP9h2yMm1lLreb2XNEBCIfKdpGQt0q5p9WS
MIME-Version: 1.0
X-Received: by 2002:a6b:4113:: with SMTP id n19mr13759133ioa.187.1588561324819;
 Sun, 03 May 2020 20:02:04 -0700 (PDT)
Date:   Sun, 03 May 2020 20:02:04 -0700
In-Reply-To: <0000000000001b1a1d057e776c92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007851da05a4c9c169@google.com>
Subject: Re: WARNING in hsr_addr_subst_dest
From:   syzbot <syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com>
To:     ap420073@gmail.com, arvid.brodin@alten.se, axboe@fb.com,
        axboe@kernel.dk, davem@davemloft.net, dvyukov@google.com,
        hch@lst.de, kuba@kernel.org, linux-block@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 4b793acdca0050739b99ace6a8b9e7f717f57c6b
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Fri Feb 28 18:01:46 2020 +0000

    hsr: use netdev_err() instead of WARN_ONCE()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130746ffe00000
start commit:   ea200dec Merge tag 'armsoc-fixes' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcf10bf83926432a
dashboard link: https://syzkaller.appspot.com/bug?extid=b92e4f1472a54e1c7dec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b5cafee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12574271e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: hsr: use netdev_err() instead of WARN_ONCE()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
