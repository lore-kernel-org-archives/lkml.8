Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B63AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8ABE208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 10:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEBKHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 06:07:05 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:54806 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgEBKHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 06:07:04 -0400
Received: by mail-il1-f197.google.com with SMTP id e68so7568965ilg.21
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=m1hRXR9BMt4ToPnusTADtXKnayxV/ZH6J13/KcH/RN8=;
        b=REPm+Roope7TGcwbn9vhUTuU+AtZhsvP4152jOemukDRjewIk4s7rQUeomRwNSgNbo
         K/Rgk0wqj2FvLtOdwmQJKphrR6/xvEJashd+AgEqHx9ATNqd2uRU/rH5S2OCVbp7kDAK
         Qzmu8shaGeCvaDVZOIH/6UgXutx9zjPYZDB4+W9UFrkI2rEXAbVf3mUHJGYvSf9sBKaB
         QtJ6t+1vXsflXkr8I+55ijvEFdMyrU2nt+FsPYDLsWc9dP6tjfelXWBzNW1V1U0lNmHi
         jS5ca7aWvKhDM3S4J8uKYaRM41sfc6aEahXA89lo5O6vBLFyhQUyj8Povi4FbInZuLj9
         IgWQ==
X-Gm-Message-State: AGi0PubxapdlIDjhLOgZ1CINLZdRI7y/n8VSTiyQgM98JEElkrENYt6j
        apE9skCjU5tfI6Xr3Quzhb/cwwnYoS8V85PM60CtLmUeKRkG
X-Google-Smtp-Source: APiQypLKoorYfxGAxfQDfwHAhcqeI9HJWjEq5A0H7WxkYG55YC8uqJYuqoZzZKQbbAF6862mCDXEKO9b6SOkLeJkNTcni5YPyrpl
MIME-Version: 1.0
X-Received: by 2002:a6b:f20f:: with SMTP id q15mr7704601ioh.48.1588414023349;
 Sat, 02 May 2020 03:07:03 -0700 (PDT)
Date:   Sat, 02 May 2020 03:07:03 -0700
In-Reply-To: <0000000000002ef1120597b1bc92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e3eb505a4a7759e@google.com>
Subject: Re: possible deadlock in lock_trace (3)
From:   syzbot <syzbot+985c8a3c7f3668d31a49@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        bernd.edlinger@hotmail.de, casey@schaufler-ca.com,
        christian@brauner.io, ebiederm@xmission.com, guro@fb.com,
        kent.overstreet@gmail.com, khlebnikov@yandex-team.ru,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17222ec4100000
start commit:   a42a7bb6 Merge tag 'irq-urgent-2020-03-15' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e311dba9a02ba9
dashboard link: https://syzkaller.appspot.com/bug?extid=985c8a3c7f3668d31a49
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1185f753e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: proc: Use new infrastructure to fix deadlocks in execve

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
