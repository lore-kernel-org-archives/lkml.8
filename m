Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8462C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1B120792
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbgHFDZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:25:10 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:55062 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbgHFDZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:25:05 -0400
Received: by mail-il1-f200.google.com with SMTP id a17so13234660ilb.21
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PGyhv+RRFzosio5aiRxqPTJSOPnLEgYHzjRgxNcNcJM=;
        b=UHkSBTuPJkaQm/XHAoVwKFPcwxUBuD+uJv64Lm3iSREKMQ1bZYeV/pgeqBc1HDq6Rb
         ZlZF15qURsa6baeKF9xU1YRy+WG1+LGNT33rXZTIv94QI5HisXT8zOaR7TeKK26wLRU/
         H3C2+ieQ/1Sd1DGTK+k8WXGU9BTH5BwJjTFF+oDKhCzL4NYKY68XAF8L6j3H276mDBHv
         FesAkW4eivwTyk+I1ICqINoVjH/OMaGItY9SY4oIbAyFnSYOePULdfsPvMtf9A0bQwJm
         MwYE79Ft52rsBXPzpJmtuhJotPKjsN/X7jYJ7yIXd7gR6QmrmQmpkrN1EPOFkQ+CF+ry
         KmhA==
X-Gm-Message-State: AOAM533GMIInwNlAbE3B6VMqw00TpDemyk6KQO1XRmOAM5/ISmcJdFkl
        Gwjml6xgDi5zkbYZOgUr9mWKgl2SZ6wH/5zJrf1/sC0Lc6au
X-Google-Smtp-Source: ABdhPJxN9h7tsirIK4Go1MLKweo1tMD2JSQJduOjcZJ6N2j9EP6Wauz92Wl+rQLa9pUMa4RjoLIkOxE0iMTpUzONhZC22w+m4MJZ
MIME-Version: 1.0
X-Received: by 2002:a02:234c:: with SMTP id u73mr6578278jau.141.1596684304793;
 Wed, 05 Aug 2020 20:25:04 -0700 (PDT)
Date:   Wed, 05 Aug 2020 20:25:04 -0700
In-Reply-To: <00000000000039638605a991eca7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce496c05ac2d0857@google.com>
Subject: Re: WARNING in rxrpc_recvmsg
From:   syzbot <syzbot+1a68d5c4e74edea44294@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, kuba@kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        marc.dionne@auristor.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 65550098c1c4db528400c73acf3e46bfa78d9264
Author: David Howells <dhowells@redhat.com>
Date:   Tue Jul 28 23:03:56 2020 +0000

    rxrpc: Fix race between recvmsg and sendmsg on immediate call failure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10bd3bcc900000
start commit:   7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=1a68d5c4e74edea44294
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a5022f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150932a7100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: rxrpc: Fix race between recvmsg and sendmsg on immediate call failure

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
