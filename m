Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DADC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 13:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6972468D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 13:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgARNSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 08:18:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:47142 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgARNSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 08:18:02 -0500
Received: by mail-il1-f199.google.com with SMTP id x69so21085779ill.14
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 05:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vq35VVCLiUmdGfGTUu+QUj9vaGq4rOYJnMIEDAOexh0=;
        b=XFrvXjzB7r5d9K4ELv2xxADbuIFfLogvHP/x9J9MASBWA3u/gq6IjiBcv74vQHsB4O
         hI+5ponlvGofZkeWUDlIWZ0EEeyVDYUez56qSzE44AzQ2fZKStLVSd4CzL1G7DWq5SfW
         Mp+gsF/9x1KW9PmveV2F2GJVLe8jG31Blig/rJfZvsrqT40U4E0945R/dONHAs/I9kMJ
         yY7znM7x3GrPOudOLCrRKXMz8glOczxWrLm+cCTFgPuF9xN6U3ehtKgZFeCHni/fRNQ2
         p8dmBRYI+mHbNuYK3b/YYz1p6VshUTLtI56HWzcTXix9lvw1d8oPeon1uHwVQGR6OrM9
         OxHg==
X-Gm-Message-State: APjAAAW/qudTiA8Km3HMV/a6eVVyGZgYOTA+MRSApSA4d++rIORlTKb1
        rnI+VhwyrkufB76xpqO+TKPV1mafTP3fZnyRPMHdcqUkAq3u
X-Google-Smtp-Source: APXvYqzqyVM1WO4urZ8jwJ7gyp+6An1CaUUfyk+oaSk6LhPtK6f3CFyjZy5MFZCQgV/r7Fb+ohevMMxbS9He7fx6jrgtiQUMv0Pw
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr2982632ils.54.1579353481772;
 Sat, 18 Jan 2020 05:18:01 -0800 (PST)
Date:   Sat, 18 Jan 2020 05:18:01 -0800
In-Reply-To: <0000000000001ba488059c65d352@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004185c0059c69e3f9@google.com>
Subject: Re: BUG: corrupted list in __nf_tables_abort
From:   syzbot <syzbot+437bf61d165c87bd40fb@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@netfilter.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit ec7470b834fe7b5d7eff11b6677f5d7fdf5e9a91
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Mon Jan 13 17:09:58 2020 +0000

    netfilter: nf_tables: store transaction list locally while requesting module

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1075ccc9e00000
start commit:   5a9ef194 net: systemport: Fixed queue mapping in internal ..
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1275ccc9e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1475ccc9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e89bd00623fe71e
dashboard link: https://syzkaller.appspot.com/bug?extid=437bf61d165c87bd40fb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1285ccc9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1424c135e00000

Reported-by: syzbot+437bf61d165c87bd40fb@syzkaller.appspotmail.com
Fixes: ec7470b834fe ("netfilter: nf_tables: store transaction list locally while requesting module")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
