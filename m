Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD43C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1C720780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgDQTFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:05:04 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:41372 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgDQTFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:05:03 -0400
Received: by mail-il1-f197.google.com with SMTP id y2so3505288ilm.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 12:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5c8LCDRq12f8g3OYrnBxOb2S1vJ1If0MMyvK95Cf5Fk=;
        b=Nvqvgsd46DKEz3SayhUU1nOTIN274bhHkprfg9t3+H+bo8avxerqAr46A7G/ugytZa
         bnmcNpxjRAcMdpP6S12w8r9TpAfnel8IZXq2rj/+3ZxDbJAITeLUuuicEqKvRs1mWbas
         bI3wQ9W93rm/Ds+22Y9g0SL87KwmFyRunMxJPCxrqX0EQvlPEUaYBRhxXED0nii+H7Rs
         Lo+Npmj7SgG6IRiAgB2Jb61qSOkrzojKD7RPc/4MZS4R+ULoI5pZ5aWfl7b3Q/Cwpmgn
         EUPpNT6QlbPySd8JRBUbsrqaY+hXgUqMdXPReYVXnpiUSUUPqI6vNtYWrUOlG/TrFFcO
         nNYg==
X-Gm-Message-State: AGi0Pua6SqM4ZHMsPIf1P+fwZjhrGkWmcB7i2p++xUpFttjnEJdFi3YQ
        06pERPLEJg4DKH01DjQsageMYAOrUjpKdNtITY4hyFk1PfI8
X-Google-Smtp-Source: APiQypKsq7TxaiPrXeHTLAURaor6Vs0GiUzQw/HOVdjNTAiVTr5h6r9VDsXe7qVE1r1NZsa4mN8p+sOD4iQMPGQkiM1vyKec2V7l
MIME-Version: 1.0
X-Received: by 2002:a92:b74e:: with SMTP id c14mr4736743ilm.52.1587150302788;
 Fri, 17 Apr 2020 12:05:02 -0700 (PDT)
Date:   Fri, 17 Apr 2020 12:05:02 -0700
In-Reply-To: <00000000000088487805a116880c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000c55c05a3813a66@google.com>
Subject: Re: KASAN: use-after-free Write in tcindex_change
From:   syzbot <syzbot+ba4bcf1563f90386910f@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a956d7e00000
start commit:   ac309e77 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6dfa02302d6db985
dashboard link: https://syzkaller.appspot.com/bug?extid=ba4bcf1563f90386910f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1771b973e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1248a61de00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net_sched: keep alloc_hash updated after hash allocation

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
