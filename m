Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C36C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934F822B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgHEUHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:07:37 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:50428 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHEQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:33:08 -0400
Received: by mail-il1-f197.google.com with SMTP id a15so9450134iln.17
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 09:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xdDF8KAwPeDbsdN5hACSBVSNt3eeL93Vn3ZE06PW0ws=;
        b=fo/FLZZe8cS6uVivjFidc2bW9QzF8fzWCrPgAkCJ+M78WijC7Jl9cnU513nhNU8tmh
         9b0VGXgHm6Hmar2J14EIr8je6HoXsW0hCjflRIORBWtDngJ1Q4GNJ384EyTAAWq/lmnu
         9C9NTPsSnxl6y77PrIzuw1lJu8crIedp2RWLRArdX1iJBMkU7lnkdqeu3t8Pj8NQQyT0
         5aCCxcx4iL0pAm0TOza4KgOzMThJKb8/XLVSwnJjqiO81nvDRAeD6soYKWNdgs29Jufv
         ouDuhpywTHhi3KMYIS5kBZ88e5tTCB19OFq3lvgQOALeFlIYtvHrr36cTHYvF/73qS8v
         Inag==
X-Gm-Message-State: AOAM531/jXiupQidtlXJ82I4c02huLtQlVMJ2ei38SspwQFcTfHLhVQ6
        CIUTYmsirgfxNFBZ1Vy78/m87UZoBUFtWNPDX5rJEGtVHf0S
X-Google-Smtp-Source: ABdhPJx1bzir56joK2ABAxtH0sKqUYFQk87L5ebinbPqcd6dHIycZoH3GBn4mZAYZSuRbVEjVUHzKuZ7t4g9wSnDVEVr5CKihhk0
MIME-Version: 1.0
X-Received: by 2002:a6b:ba06:: with SMTP id k6mr4243404iof.101.1596645187111;
 Wed, 05 Aug 2020 09:33:07 -0700 (PDT)
Date:   Wed, 05 Aug 2020 09:33:07 -0700
In-Reply-To: <00000000000023efa305ac1b5309@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035d35105ac23ed6d@google.com>
Subject: Re: WARNING: refcount bug in l2cap_global_chan_by_psm
From:   syzbot <syzbot+39ad9f042519082fcec9@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, edubezval@gmail.com,
        johan.hedberg@gmail.com, kaber@trash.net, kadlec@blackhole.kfki.hu,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        marcel@holtmann.org, mchehab@kernel.org, mchehab@s-opensource.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 3c1e300966d7edc380e405b3ab70b6e3c813a121
Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date:   Tue Oct 18 19:44:12 2016 +0000

    [media] si4713: don't break long lines

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108f4002900000
start commit:   c0842fbc random32: move the pseudo-random 32-bit definitio..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=128f4002900000
console output: https://syzkaller.appspot.com/x/log.txt?x=148f4002900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76cacb0fe58c4a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=39ad9f042519082fcec9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14491b04900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1188e392900000

Reported-by: syzbot+39ad9f042519082fcec9@syzkaller.appspotmail.com
Fixes: 3c1e300966d7 ("[media] si4713: don't break long lines")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
