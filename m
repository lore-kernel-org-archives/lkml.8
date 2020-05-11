Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37320C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C6720801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgEKNTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:19:05 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:46059 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgEKNTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:19:04 -0400
Received: by mail-il1-f200.google.com with SMTP id t10so9103962ilf.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jf6uw931eaD0f37oBxexrpmMRBrOUigfkrOsk4tVxYc=;
        b=hi0ThZNlSN1tD5BNY5HVkBepjclZpBV+RIYCyk+VVzG2mvgTuLtLKWYCGU5bmwmMTZ
         sfp048U++IWyu/WuDr2NFU35UX2xNTL6NUxHhn/2SJtwMzLgPJP0RNSv/GC1qFON3mGI
         /rmzbTKw+9g9SZgNrCrjPtzg4irAAtrOQO5Q/EAaAYgc1Dug2xBInESOuJ2FXxTOUZJ9
         3aIjbrD5K6QPGmPY0vfdYFY1XctZ+0ZGwof2NGmMbZ1JPb+f3vIQ+4B4D9N98AX/nHd9
         /JalP/RMiDjftDnKvYgKt+CZSUXJPQinMKPZEnnBojHdgP4kwqthPAm2nDx8ZA0wUFfs
         0HhQ==
X-Gm-Message-State: AGi0Pub1WADpAwBa57qZ3DYe22tv/hgnVgHoueVCJtjqy7bxL+IXe2o/
        LC9W14gLv1ULeZyy5qjVQfYPBg6o0XcXQ5/yG8Ey86G1GGF2
X-Google-Smtp-Source: APiQypIWFQQNEix6FghGjLTcmyohjPLCLNUzuWW6Ma9AOT3A6ZMNkBFkuxbBwRni8OgL21OchNtkHFxpyYZIKZAk0qWHuNKrOrGB
MIME-Version: 1.0
X-Received: by 2002:a92:40c9:: with SMTP id d70mr16077782ill.291.1589203143785;
 Mon, 11 May 2020 06:19:03 -0700 (PDT)
Date:   Mon, 11 May 2020 06:19:03 -0700
In-Reply-To: <00000000000043ed6f059d1944bf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc82ac05a55f3005@google.com>
Subject: Re: INFO: task hung in do_read_cache_page (3)
From:   syzbot <syzbot+518c54e255b5031adde4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, amir73il@gmail.com, axboe@kernel.dk,
        darrick.wong@oracle.com, jack@suse.cz, josef@toxicpanda.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mchristi@redhat.com, syzkaller-bugs@googlegroups.com,
        william.kucharski@oracle.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 2da22da573481cc4837e246d0eee4d518b3f715e
Author: Mike Christie <mchristi@redhat.com>
Date:   Tue Aug 13 16:39:52 2019 +0000

    nbd: fix zero cmd timeout handling v2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d6ab14100000
start commit:   e99332e7 gcc-10: mark more functions __init to avoid secti..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13d6ab14100000
console output: https://syzkaller.appspot.com/x/log.txt?x=15d6ab14100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a96cf498e199d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=518c54e255b5031adde4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146e45ec100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164444a4100000

Reported-by: syzbot+518c54e255b5031adde4@syzkaller.appspotmail.com
Fixes: 2da22da57348 ("nbd: fix zero cmd timeout handling v2")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
