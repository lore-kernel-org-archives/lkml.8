Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B381C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BDD2078A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407945AbgDPGZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:25:11 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:44095 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407734AbgDPGZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:25:06 -0400
Received: by mail-il1-f198.google.com with SMTP id c4so8107251ilf.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=S9b/LLGTp46xQuNkjprKkHL+JPInIWFFm9gLUxjatqM=;
        b=d1epOEha3ojAGEB3BAEFOIAMZjjFgQB6oPkykGm2PqCjC9NwiQMupPss4ONY8c9KS5
         UwPjzvfj2CdIyKomeQMKayCh6XM+SeOhp1ZygGUTVcCMt2L+3eX6dS/LNI6WRMKF+dg/
         J6u01ixl51ZFJYvYL+7IA0zKRw+dSX+FkW9uGX0C2r+ZQ0jw64BhOIFINP1hWriO3mMU
         93blui8yEkeuTJVCl3W7UjZ7LNxPcF8tfMMLEy51F1b+xWlHmORg3mO00OAlF7CvZmMM
         k3idtJgq85cY32UQ3X5cxb7PhCPvLfmk0zzBLSNpu+u9asNuw+WcWbydv54yF77/ur/A
         Q53A==
X-Gm-Message-State: AGi0PuYDAgjnemFw0ItTfLW1qUEL2oHTZC3aTd3GsPlXK7sb2UYDafQu
        k1YRWxU7SCno+xQ54qWddiwgWUnQwNBWaVgbrYIAiEUbgBmj
X-Google-Smtp-Source: APiQypK09xIpakUrRfClLjOKpZtYwC1UGo9n92wVet0wCZAL1e3IjdYSABPD1sVWI6uUY3bx7dSm2rd/iq5XTtAOUItChPURo+pC
MIME-Version: 1.0
X-Received: by 2002:a92:d1c1:: with SMTP id u1mr9027999ilg.280.1587018304537;
 Wed, 15 Apr 2020 23:25:04 -0700 (PDT)
Date:   Wed, 15 Apr 2020 23:25:04 -0700
In-Reply-To: <0000000000009b1944058ca3e4a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b4bbc05a3627e5e@google.com>
Subject: Re: WARNING: refcount bug in kobject_add_internal
From:   syzbot <syzbot+32259bb9bc1a487ad206@syzkaller.appspotmail.com>
To:     benh@kernel.crashing.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@kernel.org,
        peterz@infradead.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 810507fe6fd5ff3de429121adff49523fabb643a
Author: Waiman Long <longman@redhat.com>
Date:   Thu Feb 6 15:24:08 2020 +0000

    locking/lockdep: Reuse freed chain_hlocks entries

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1127249be00000
start commit:   6fbc7275 Linux 5.2-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bff6583efcfaed3f
dashboard link: https://syzkaller.appspot.com/bug?extid=32259bb9bc1a487ad206
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115bad39a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1241bdd5a00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: locking/lockdep: Reuse freed chain_hlocks entries

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
