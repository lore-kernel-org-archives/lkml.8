Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC43C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 01:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62D420787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 01:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgC0B2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 21:28:05 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51172 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgC0B2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 21:28:04 -0400
Received: by mail-io1-f69.google.com with SMTP id s2so7067358iot.17
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 18:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fpOoO95ghuCLLCEIiKHNf1Vn4Rzo9M55/w0gJcRUpiM=;
        b=LbhPRqVa/W5TYtBTr3FZvvIXEhYLI1uA660HUfr/OPSRU1ELxUbEILOXhsnn2C5YCr
         PFojmyBJZ6RZlwxXZgAl+yCQ/wxIImPlM55TIR9/q/J5SCR+abNPBNA4zah6yZmikE5D
         jUOXtMBWEbPvmRx04OQq8C2m0DsQqSuKCcv7roZznXYtEtFr+VbYik1KevMWgRALlwdu
         s6ZGWTCh6/hcZS7FpeeK6Yr9SunxAsq48+wx3nGubZ19fmplgI9wFUx7l6sGME72rLXz
         gEhmtWrfUDJWafkg+08lLGWtkWcS1uMhhAYvRluZJHmkBRBghmQUqoWUvveLemoAGn9i
         dKpA==
X-Gm-Message-State: ANhLgQ3dtppatSkZ44Yvtx7EmUkfK5zkoX+/9oKwHySPPFfkpyjAZwb+
        T18l52AFVVc4XWH7r9YiA9qDYmhS6MVS4e9xmFTzHvSA5mfy
X-Google-Smtp-Source: ADFU+vvuj9CdqnaKA39zoipe43VtYnqnycnu6XYDRVQ3pQdtkCj1GJ/YWcoFF34sHC9pd58juZJvz3MqwN724aP7IdgdRuetL7J1
MIME-Version: 1.0
X-Received: by 2002:a92:9107:: with SMTP id t7mr11623063ild.140.1585272483961;
 Thu, 26 Mar 2020 18:28:03 -0700 (PDT)
Date:   Thu, 26 Mar 2020 18:28:03 -0700
In-Reply-To: <00000000000047770d05a1c70ecb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004760b805a1cc03fc@google.com>
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
From:   syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>
To:     a@unstable.cc, axboe@kernel.dk, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, dongli.zhang@oracle.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 768134d4f48109b90f4248feecbeeb7d684e410c
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Nov 11 03:30:53 2019 +0000

    io_uring: don't do flush cancel under inflight_lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14233ef5e00000
start commit:   1b649e0b Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16233ef5e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12233ef5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
dashboard link: https://syzkaller.appspot.com/bug?extid=313d95e8a7a49263f88d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13850447e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119a26f5e00000

Reported-by: syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com
Fixes: 768134d4f481 ("io_uring: don't do flush cancel under inflight_lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
