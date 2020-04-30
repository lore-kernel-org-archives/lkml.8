Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996FFC83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7185B21973
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgD3GPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:15:04 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54862 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgD3GPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:15:03 -0400
Received: by mail-io1-f69.google.com with SMTP id u10so276671iog.21
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 23:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LGPQXr9UFNG0Da8I+jNxRs0HPIkBIqCGuS7p+9YCeGg=;
        b=ohlCrnx/kqfpwI1jctEhOsXIjIxYBXdUOwBZIJ54PSBwCKWRQM5a9bGWVYudZONm1l
         pcBlAz1ofWL0gbijOJ+MONpn89hdnErVX6FQeobUfwuyXa3z5GVb5Pwr5qI8gJMP1Hp6
         YZCM/jLnwDIIf3tHlUD/Hf/fDfkajL76ML2HA1YuN1RP/yvWE0a90E9yAwafYv5bL/7c
         KIDI+kwZ9pzSqVPMul0ByjYvfisnuRSgxFbC9b72By6LE5gxKyk/WE51HAwe4z1t88o0
         WNV6xRsNgNZSwn3Qjzl/l6ASHh+3Uf8ktEy9c5zCkYeRnag38SwAMiiJhVsFMXm0D6Bt
         gOPQ==
X-Gm-Message-State: AGi0PuadX8MDEMifdjnvb5UfeWMh0EERLTu1U7Qjxoxsv7UM+3QwhNbX
        r7hn3CbtAbhWri53Xxcig58VuA8SUzDuT/mm/cDKARUL77iz
X-Google-Smtp-Source: APiQypItWPCp/4iJfpJma41I1BKksbOFHTczxvYLYhN4aAIprmWe1R4Xi8W7XMYKiyqSv2IHXeW1rAQ1iMyE1Dy0TaNFKC2pTaCU
MIME-Version: 1.0
X-Received: by 2002:a92:c004:: with SMTP id q4mr380269ild.93.1588227302698;
 Wed, 29 Apr 2020 23:15:02 -0700 (PDT)
Date:   Wed, 29 Apr 2020 23:15:02 -0700
In-Reply-To: <000000000000fdd3f3058bfcf369@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033365905a47bfcd4@google.com>
Subject: Re: WARNING: bad unlock balance in rcu_lock_release
From:   syzbot <syzbot+f9545ab3e9f85cd43a3a@syzkaller.appspotmail.com>
To:     ebiggers@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 10476e6304222ced7df9b3d5fb0a043b3c2a1ad8
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Mar 13 08:56:38 2020 +0000

    locking/lockdep: Fix bad recursion pattern

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d64bac100000
start commit:   7d194c21 Linux 5.4-rc4
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c03e4d33fa96d51
dashboard link: https://syzkaller.appspot.com/bug?extid=f9545ab3e9f85cd43a3a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a0a8c0e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13dd2dd8e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: locking/lockdep: Fix bad recursion pattern

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
