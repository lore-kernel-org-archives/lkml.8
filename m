Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F783C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB3E2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgBDFlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 00:41:03 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:49322 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgBDFlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:41:02 -0500
Received: by mail-il1-f200.google.com with SMTP id p67so13953770ill.16
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 21:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AM193aqkTInnm2sGLnq+KUrIMqtAH2ZiKkzgZdOGVwQ=;
        b=bGht1+kEBburJM6sU7c+uYxMmFTFcgNZqD6tLOUOzZbMVDOsC4TLyYwjUsq25lFkeR
         koy2QmVCD2BzgljN2S6yEYPUBqI6IZEMGAUOQZV+YyFzHIbRwCnGkpPh1oaSHp6cpNu2
         Jf3t8kJZU+2ov6v+uOzjtBp09bmxe07dIjl2UkkVXQkpu/mf6W3sVRayREFxffoZwC/o
         Ad9MW5M19xwodD+eTwmBJblg70MTbsOlRbm4X1sjuCPQ2+EVQIbtMCNi+OboDE+70AHm
         cBh5FaAfPBFiqNhw8Aor+K5TqQ8TpOO4B6w3QSS1UYQT/2KxeRi3C7fbFGsY7hzEbkVH
         BnPw==
X-Gm-Message-State: APjAAAU7I++bMYEyv4Vutd7Xg9buftbLmAgGBvbhEd1Vqq2/oej3zD7X
        6AX4csI0nbIk2M/ESHni2vykdg0dVsj6FDN/jG4NzLgUBEca
X-Google-Smtp-Source: APXvYqwvRwRXAdFpSeJjYEpr6KHxHErox1HBAN2yNAGNRqLGQTC61VxpwWiTrg0QVCAeJf2FuqLD24CFactmGu/hKq+lNVtjl291
MIME-Version: 1.0
X-Received: by 2002:a6b:24b:: with SMTP id 72mr20523024ioc.63.1580794861893;
 Mon, 03 Feb 2020 21:41:01 -0800 (PST)
Date:   Mon, 03 Feb 2020 21:41:01 -0800
In-Reply-To: <000000000000350337059db54167@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034bde7059db97cf4@google.com>
Subject: Re: inconsistent lock state in rxrpc_put_client_conn
From:   syzbot <syzbot+3f1fd6b8cbf8702d134e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, kuba@kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 5273a191dca65a675dc0bcf3909e59c6933e2831
Author: David Howells <dhowells@redhat.com>
Date:   Thu Jan 30 21:50:36 2020 +0000

    rxrpc: Fix NULL pointer deref due to call->conn being cleared on disconnect

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1182314ee00000
start commit:   3d80c653 Merge tag 'rxrpc-fixes-20200203' of git://git.ker..
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1382314ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1582314ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95b275782b150c86
dashboard link: https://syzkaller.appspot.com/bug?extid=3f1fd6b8cbf8702d134e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ac314ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ec4c5ee00000

Reported-by: syzbot+3f1fd6b8cbf8702d134e@syzkaller.appspotmail.com
Fixes: 5273a191dca6 ("rxrpc: Fix NULL pointer deref due to call->conn being cleared on disconnect")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
