Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96FCC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D382071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDYOcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:32:05 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:40414 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDYOcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:32:04 -0400
Received: by mail-il1-f199.google.com with SMTP id k5so13808790ilg.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 07:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rmlyaSN6XAcsIU4KSfybtQVJJEftnTSClaEZrW6WcQU=;
        b=FOziFROJiy78VDyEq4Z02rrOLG/bdMpIEJzYFSds0GHCosxQ4xH9bu3zbkdpdGVyPd
         rSZkMswJa+oZMDWM7LrxFy+QCQYO4J/G8J83cNYwnJ7hU8tNCq3ysf019dt256V27Nba
         fqrPv48fJbDZxsMf3B13kSzmAO95usg9/N7n7QCbUYf2P6QEvChJfBTSjEOnT/+ei2J+
         RMYlnd/ZBd0/yISD6YQuC7ggFjrPlkzwTrgH0t4WRN3wNy4GDD5FFwju+kAJc9E/Ap6l
         ilLzKwwP03/31zkwanjdQU9sgGbJeLatn9Ic0NfNbAmgz7pygPSzOxHgIr/2OqHFtsyN
         LSJw==
X-Gm-Message-State: AGi0PuYZ0SUM/8NXSwDp3CbMcwChaqBv9EtLCQYJbR6LvPHMqQ3awZsT
        DwAPs9lMrxveQV87b+F9R7WTA5QXhxeVe1wC6tPRKmtqUnmk
X-Google-Smtp-Source: APiQypI++Mtlx8XClDy5/XNNiu+1H0kUMLFRZD3sWDB4Aa8lzzoEoKOC3FYxwiJ9yXlLAmyYuF2FE58rlTm2ekn/XWhGCsiAbA/k
MIME-Version: 1.0
X-Received: by 2002:a92:8499:: with SMTP id y25mr13978461ilk.268.1587825123164;
 Sat, 25 Apr 2020 07:32:03 -0700 (PDT)
Date:   Sat, 25 Apr 2020 07:32:03 -0700
In-Reply-To: <0000000000006233e4059aa1dfb6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e8a3e05a41e5813@google.com>
Subject: Re: possible deadlock in do_io_accounting (3)
From:   syzbot <syzbot+87a1b40b8fcdc9d40bd0@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        bernd.edlinger@hotmail.de, casey@schaufler-ca.com,
        christian@brauner.io, ebiederm@xmission.com,
        kent.overstreet@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 76518d3798855242817e8a8ed76b2d72f4415624
Author: Bernd Edlinger <bernd.edlinger@hotmail.de>
Date:   Fri Mar 20 20:27:41 2020 +0000

    proc: io_accounting: Use new infrastructure to fix deadlocks in execve

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124347cfe00000
start commit:   46cf053e Linux 5.5-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=87a1b40b8fcdc9d40bd0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15693866e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12847615e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: proc: io_accounting: Use new infrastructure to fix deadlocks in execve

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
