Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EAFC33CB6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 22:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3F2246A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 22:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgARWaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 17:30:02 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42995 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgARWaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 17:30:01 -0500
Received: by mail-io1-f69.google.com with SMTP id e7so17550616iog.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 14:30:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yYySPTzXjesI6rMbrrYCnEOoWQeyP6zwNDoBKllcD6s=;
        b=WFFEfrzQ0Y6yQV89NTwJ37XUbiXNkIPfnz0RWeh3eCwo8YWLMsaN6b04GCH2lDhfTY
         dnD0C/ynFFE+iguI3mhitQQhVFJp4mtKssCQwpDZXTeu+iXFqV72LPlNmneke+oSVM8S
         uIKM4TdS7hx2qxRNIRjgeAtruRCeVaEaOUbphbx8Id1ZAGh81nY12/gqsCC492Nuba/c
         /8mnK33oMJX9LQkBKTGJWcXL5lHTrtGl2yNddJa09A2tQOVWCUmdsa7d6lOlUImFXS0l
         3ig9KzYkWdnG6HsAEVFtn5FqRtCMd/mv1SapEBR4njqSK8Ko5z5+Sm5c2lmdyuo8NXD6
         Nn7Q==
X-Gm-Message-State: APjAAAV49XPjBjybaAFgnwo1qdMOFvC7sAFNne0COX7HyMMGlZuECr+c
        ia5yBfZaBgPa5IsB46F6Dv/usnsgV5vXGI66g9psezAEcVuH
X-Google-Smtp-Source: APXvYqx1pd31epsuW/G1/6eX4XtJtvHwMaQ8qI1MCUim2ZtcFsWE4ZOYVf2vl7dBgVGnmVgzwNIdSp63LSgF0NEjWlUwyEVcpUX/
MIME-Version: 1.0
X-Received: by 2002:a6b:d214:: with SMTP id q20mr29420477iob.298.1579386600669;
 Sat, 18 Jan 2020 14:30:00 -0800 (PST)
Date:   Sat, 18 Jan 2020 14:30:00 -0800
In-Reply-To: <0000000000006de432059c6cabb1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bc94b059c71994f@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_port_gc
From:   syzbot <syzbot+53cdd0ec0bbabd53370a@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, coreteam@netfilter.org, davem@davemloft.net,
        fw@strlen.de, gregkh@linuxfoundation.org, jeremy@azazel.net,
        kadlec@netfilter.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b9a1e627405d68d475a3c1f35e685ccfb5bbe668
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Jul 4 00:21:13 2019 +0000

    hsr: implement dellink to clean up resources

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170438d6e00000
start commit:   25e73aad Merge tag 'io_uring-5.5-2020-01-16' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=148438d6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=108438d6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=53cdd0ec0bbabd53370a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eb74c9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14db11d1e00000

Reported-by: syzbot+53cdd0ec0bbabd53370a@syzkaller.appspotmail.com
Fixes: b9a1e627405d ("hsr: implement dellink to clean up resources")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
