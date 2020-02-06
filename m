Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1355C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9703A20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgBFB3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 20:29:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:32818 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBFB3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 20:29:02 -0500
Received: by mail-il1-f197.google.com with SMTP id s9so3148538ilk.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 17:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=klRVBdr46Gl8WIF/3JqDp9paxXMagfLFmZ3zT/aOfAA=;
        b=Ku//iGZX5AC3QFKGpVht8ULuoby4lhWlzqHPZ7l40VsaVaMt/FL2TMLgennsJ38D1u
         EtLW+2WRpxtc5sRGDWDSiSoNpgmRnWaL9pw3fSkB35gcDipHwfHWlAopd5cAwEIMih1E
         JcFQjkAGxqNnQb4jG1yjWJzBbBOdF/zztPpV8EBhZKiAWaFLBOfiV6fteKdC3nAfttyu
         4fYPYPuBKeJM6BDssR6EoGRJwttVx2j9yvdCRL7DrAT5bR/V/6K13ZBCGlC2jsBsey8y
         PP3kgdpoOEHslH2BGFKSsBeR0fc3ZGvbPRsnf2DG2q9fLjveJfEAKC4YgYl8ZK63vq/+
         xGWQ==
X-Gm-Message-State: APjAAAXMlfECUXTFen4u66RlY/sWh4vVbB0dIFSvDXJBFaB31oiswTlc
        WDOwcAxxw5XVZd0pAf5sVWDcp8iGZ4nZ+Z8UX+Musai25BPP
X-Google-Smtp-Source: APXvYqyWzNDAJ3ZpISUwsx17tVrhy9Z/G8ZUJfNIMmI6YX1SRk5jCpKRGWJGMzRGbI8uNNHSqXoSH+2xK2x4wJjiLsGtYiFdEy2t
MIME-Version: 1.0
X-Received: by 2002:a92:1bd9:: with SMTP id f86mr1114630ill.18.1580952541990;
 Wed, 05 Feb 2020 17:29:01 -0800 (PST)
Date:   Wed, 05 Feb 2020 17:29:01 -0800
In-Reply-To: <000000000000f0baeb059db8b055@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac1561059dde321a@google.com>
Subject: Re: inconsistent lock state in rxrpc_put_client_connection_id
From:   syzbot <syzbot+d82f3ac8d87e7ccbb2c9@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173d9dbee00000
start commit:   6992ca0d Merge branch 'parisc-5.6-1' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14bd9dbee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10bd9dbee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f22d38d7f9a488a8
dashboard link: https://syzkaller.appspot.com/bug?extid=d82f3ac8d87e7ccbb2c9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14317dbee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145a44f6e00000

Reported-by: syzbot+d82f3ac8d87e7ccbb2c9@syzkaller.appspotmail.com
Fixes: 5273a191dca6 ("rxrpc: Fix NULL pointer deref due to call->conn being cleared on disconnect")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
