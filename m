Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01D0C83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DAB2076A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgD2DDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:03:04 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:37673 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgD2DDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:03:04 -0400
Received: by mail-il1-f199.google.com with SMTP id v9so1133084iln.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=N8mW6W7Y78YylLmYnbJuNiFdBMiqWdbzuI1dVnHVmdY=;
        b=N8mHei7J1NmXEFn8CKl9DH+cuUlu9507TW8u4CFB1zqtb7VxlhP1WnhYnDuL4utx2W
         pq/OWQMa8hfUZpYqetdjeyplTxs+P+/X/9kQjw71jH/NTBZUS7/s45XjsSAAFl6tJE7S
         oF0EkEe5r73LLmVvLymrNFEuyisqgv9O6Tb/hV8OoYseS3QCWEIQtQYbwEVbgAvmmVu+
         Y+cWqSLKRErlwhzQqdNyRXGVZk9k9UDqFYvq+geouHlbCuB593Am2p0dbJwrZxSalyCU
         nSgYLWhpgvNt3xBqQr/pKo2I3/klrn0E3jD7FVoP6MbwPZ6el7KEsn2NZpmgl+CP1a1S
         nyxw==
X-Gm-Message-State: AGi0PuYhT1yLD/UDsV2EL7S8Mw4BQd6sf6ayUzVwtUxcZMaMfxTS9GYi
        xnnxmUaho+JQ9txmJ9kS6tBVWf3vdmJCashP8fe+11YjSPkU
X-Google-Smtp-Source: APiQypK+2ms6ncmWJOWhIQQVVliR9Zr/n/qv2KwLwCey7WgpXY/yCDsGr2fm1ZtCS3RqQpq8WFKsrGLw5CdokvGGfIGga6fJkuUN
MIME-Version: 1.0
X-Received: by 2002:a6b:8bd2:: with SMTP id n201mr8634223iod.131.1588129383557;
 Tue, 28 Apr 2020 20:03:03 -0700 (PDT)
Date:   Tue, 28 Apr 2020 20:03:03 -0700
In-Reply-To: <0000000000006601b005a08774fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3b0f205a4652f38@google.com>
Subject: Re: general protection fault in tcf_action_destroy (2)
From:   syzbot <syzbot+92a80fff3b3af6c4464e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 0d1c3530e1bd38382edef72591b78e877e0edcd3
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Mar 12 05:42:28 2020 +0000

    net_sched: keep alloc_hash updated after hash allocation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e74154100000
start commit:   67d584e3 Merge tag 'for-5.6-rc6-tag' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f894bd92023de02
dashboard link: https://syzkaller.appspot.com/bug?extid=92a80fff3b3af6c4464e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160c3223e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f790ade00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net_sched: keep alloc_hash updated after hash allocation

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
