Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C921C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC5420787
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437037AbgDORuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:50:19 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:51281 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411506AbgDORuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:50:05 -0400
Received: by mail-io1-f72.google.com with SMTP id s1so20579515iow.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nHxID+TcYcl1NAxOyN05IyLFyVfL/SAIIcfsEnpexvY=;
        b=OYBLR1oZ9VDGmDJkicyL6ctWgNMQ3lnQXoTSEF3v6aqDgE2gC3bvAw/IYfvhBi1cb5
         pAgC8g49d7eN6WazOuFIzObABN+oV/qG4PEW5jejyRW/4LFoHtIHZPmID1BJ+QT7WL21
         gHKB7uE2nz5do/nBVOicBHATTdBvJWQSqqrpYrDfsLB+un/szMxKALtDm+DOI/WuiZJo
         FB5nTk5b5EeLr4tDg0UpyoEq81c4lRBx3Wj7cp8xpOjK10qlOyrVkQzgiy6lpqB/mm2/
         RHDW8h/x+kbK5cKrhtMOHfNPD+kEsPHtxdw8v1bHr/ppdRT4Nuy0RhsQf7EPbYS26T+4
         cb7w==
X-Gm-Message-State: AGi0PubjIJYpuolnK+Td94k6wdVZ9PX7L3TohTyVaysdu8sthXzb6ijm
        bZjWt73Y/kngqOrLiRH09n82j83u0AHZ4AjFlheSSDSwlszO
X-Google-Smtp-Source: APiQypKCFYBPF9OFykDZd9n8d4hXnAVLQ6F+DTzMLIY+9TSrA/7PY0fhxsgiHvbNThyhKTwcCS3oyc4PK82BmuGBS5ArqpOAKflC
MIME-Version: 1.0
X-Received: by 2002:a02:7785:: with SMTP id g127mr26306155jac.134.1586973002978;
 Wed, 15 Apr 2020 10:50:02 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:50:02 -0700
In-Reply-To: <000000000000f8a16405a0376780@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c5eaa05a357f2e1@google.com>
Subject: Re: possible deadlock in proc_pid_personality
From:   syzbot <syzbot+d9ae59d4662c941e39c6@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        bernd.edlinger@hotmail.de, christian@brauner.io,
        ebiederm@xmission.com, guro@fb.com, kent.overstreet@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 2db9dbf71bf98d02a0bf33e798e5bfd2a9944696
Author: Bernd Edlinger <bernd.edlinger@hotmail.de>
Date:   Fri Mar 20 20:27:24 2020 +0000

    proc: Use new infrastructure to fix deadlocks in execve

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=136aea00100000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=d9ae59d4662c941e39c6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1374670de00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: proc: Use new infrastructure to fix deadlocks in execve

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
