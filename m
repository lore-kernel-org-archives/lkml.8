Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CFDC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 21:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E742320709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 21:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgEPV1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 17:27:06 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:54397 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgEPV1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 17:27:05 -0400
Received: by mail-il1-f199.google.com with SMTP id j69so5840939ila.21
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 14:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=f3hko+0TXM3ZTxTzVXQjaXqhvt2WnzZbWWNxH4vk64g=;
        b=BK3ToBKCxsD1T7O/Ru7OlpqOOqp7tp6eqg97d9yPbQCRLxDN7JGRd/p06AeAoEmkqb
         fsLqFV9qpPiqimBWgkzcBcupW4xm16C14yO3INvZ7W/e96zV9UCv9xR4c/YK7cEWnvRb
         r15tCAnofxAmw4fcc2Y9Ro9ofEWZ4KO/2IqSyy1ZdarXIUv+YZS6ygW5Y2PH0gRS1bPV
         Gf4lQeqlp39pI2Ku6oIEYhJsb7cxgqqEdwho6RIEpCpjTDF8qddDd8SnpKc+l+GFqlN1
         1jpC9FaUxgzYTIQihBpVxoJU1eZoOb71oocDuwGnjCcrwLgBTGke8UWgnzQmefJPpf10
         au2A==
X-Gm-Message-State: AOAM532MUd9ydbcPzIcfq3g7Ym5NWdzIrvOSI7p1uEZTrrV6pR6iubxX
        EsEwQlnLtFlsH386rVrgTZr71z+M8ynGi85g/TcdFZ3c9aEx
X-Google-Smtp-Source: ABdhPJz0cH5oPpV8Crm3N4eRME8yr4YUcg2zWCEKfV1oaXJx6vivQpTeE+zffP6GmIpSFnRS9D7COeZSShOVJTZOtPesbiPzsDog
MIME-Version: 1.0
X-Received: by 2002:a02:860e:: with SMTP id e14mr1019310jai.109.1589664423356;
 Sat, 16 May 2020 14:27:03 -0700 (PDT)
Date:   Sat, 16 May 2020 14:27:03 -0700
In-Reply-To: <0000000000003692760578e651dd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044329005a5ca97eb@google.com>
Subject: Re: KASAN: use-after-free Write in hci_sock_release
From:   syzbot <syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, davem@davemloft.net, dvyukov@google.com,
        jack@suse.cz, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org, mmarek@suse.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit f1e67e355c2aafeddf1eac31335709236996d2fe
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Mon Nov 18 13:28:24 2019 +0000

    fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a regular spinlock_t

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1761ce06100000
start commit:   645ff1e8 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
dashboard link: https://syzkaller.appspot.com/bug?extid=b364ed862aa07c74bc62
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152532bb400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f73320c00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a regular spinlock_t

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
