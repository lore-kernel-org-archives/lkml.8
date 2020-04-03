Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95099C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 06:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68ED1208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 06:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbgDCGfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 02:35:06 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:52924 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbgDCGfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:35:05 -0400
Received: by mail-il1-f199.google.com with SMTP id a79so5916612ill.19
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 23:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=XvuEaZQv34Wl9b97Fox7ORd+MiG4pPZiu4HFMMCz9b8=;
        b=H+n4I7Avg9aahM4sU8qBG5rLN8GSQNlh6d3YZFmrqRUDNB7+U6Qid1NlsscQI0SQn+
         zahp3P2Prg51p0v5nDjx3DKUD82S4Hfg5YOoP0FRRPK94u21ssUvABUf/2NZIbACvzVZ
         K1s2kQ+VtxMgXelsEXLztcoSh8fUeqI/UZuJEJ0A8oipgDOP7UJ7yLFnNGFdB64ftsMK
         jVRu6yy4DkRv/UD101PO4v/FYSCKcyxlahy6BJUtlNmlkUBMQtFaoyw8zk+CUNuYcOJP
         FRoHh/nmg8/INDORRxX/t7d3GKRvqvfhNiWgwZVXbCVLrhkHkPIsoH+wO3nyxyvK+lmh
         c75A==
X-Gm-Message-State: AGi0PuYTIAmt+0k6UbZn4M2K9UTaTg0qvKzRoDGk4xZyhlhfWLFPZ77L
        z2ui4gzBJixpJHbXZ5OgpweNqDcNqjmwwxll5gpE69H+CWqf
X-Google-Smtp-Source: APiQypKgLxYQRiqluE41KROTRCotuILsRHbZsSaEH/+7vCLB93a2aY6B1Ii2FwOvd8Q/As54JAPWEwyCmr2596qDdnICcLdBc2AL
MIME-Version: 1.0
X-Received: by 2002:a02:6c8:: with SMTP id 191mr6878565jav.133.1585895704787;
 Thu, 02 Apr 2020 23:35:04 -0700 (PDT)
Date:   Thu, 02 Apr 2020 23:35:04 -0700
In-Reply-To: <000000000000f1aa0d05a25cfab6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000227f0c05a25d1e9e@google.com>
Subject: Re: possible deadlock in free_ioctx_users (2)
From:   syzbot <syzbot+832aabf700bc3ec920b9@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        allison@lohutok.net, areber@redhat.com, aubrey.li@linux.intel.com,
        avagin@gmail.com, bcrl@kvack.org, christian@brauner.io,
        cyphar@cyphar.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, guro@fb.com, joel@joelfernandes.org,
        keescook@chromium.org, linmiaohe@huawei.com, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, oleg@redhat.com,
        peterz@infradead.org, sargun@sargun.me,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7bc3e6e55acf065500a24621f3b313e7e5998acf
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Thu Feb 20 00:22:26 2020 +0000

    proc: Use a list of inodes to flush from proc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164ae51fe00000
start commit:   7be97138 Merge tag 'xfs-5.7-merge-8' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=154ae51fe00000
console output: https://syzkaller.appspot.com/x/log.txt?x=114ae51fe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec722f9d4eb221d2
dashboard link: https://syzkaller.appspot.com/bug?extid=832aabf700bc3ec920b9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f37663e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16feb91fe00000

Reported-by: syzbot+832aabf700bc3ec920b9@syzkaller.appspotmail.com
Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
