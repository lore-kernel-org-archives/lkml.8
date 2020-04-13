Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E64C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91B820732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgDMLDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:03:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:57301 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgDMLDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:03:05 -0400
Received: by mail-io1-f71.google.com with SMTP id v3so9953934iod.23
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 04:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2IOvHbBUeIFh4zGFQjXxW5DQqukbUbAB0rjAVOkLv/w=;
        b=lQawSWLvldvpAQYapAaDJbt0PxS4a+WCxZgI7JAunhcpos1mncFAGMGKQ7tUQP7xtr
         gja0XHkYR4Nnt54KKuOfv3JiTu9mouJoB8tR5Zn+AoQ+Bkr3fb7qrUZgfGD5nfuhK8uC
         zZQi/3KfTKLDvky9mCZ6IoWsapcIfX5ZcfE9SqZngY9t8d2vABpT8R76dugVbgNgfp7P
         MyDXHqhML1BtTgoSuhaJnQHCPJHyngxnqcGsfN1lHsEZ55LgOKIYCOfzgpgCixnVrK/j
         U4g/oXCw2rLwqOEJ6CXdA6bIgFH2K0XJY+8L/XLuK0OA6XP09oojTd+PhJ1PYcV9wpXQ
         hyMA==
X-Gm-Message-State: AGi0PubZW04gORyg4vgyulWlJczqaByiobPiNIWZmbWeLJ9aOxiQQ3Dx
        IFEdRAdCyzuHQEAoE8f2mhVLB3pCPjSmbvKIH9L3RD7EV3oe
X-Google-Smtp-Source: APiQypLicYJNdk15GuKhgeGZAg5xWK36DdcdM4+DwXTrzX3cEvE+bTGd6A8kvDoJZPtS1k1WvcOTKwpdKA0d2t1jNBkZKQ6dx5jB
MIME-Version: 1.0
X-Received: by 2002:a92:d98c:: with SMTP id r12mr4971216iln.224.1586775784334;
 Mon, 13 Apr 2020 04:03:04 -0700 (PDT)
Date:   Mon, 13 Apr 2020 04:03:04 -0700
In-Reply-To: <0000000000003311fd05a327a060@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6ae4905a32a0633@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in gfn_to_memslot
From:   syzbot <syzbot+2e0179e5185bcd5b9440@syzkaller.appspotmail.com>
To:     christoffer.dall@arm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, pbonzini@redhat.com,
        peterx@redhat.com, sean.j.christopherson@intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 36947254e5f981aeeedab1c7dfa35fc34d330e80
Author: Sean Christopherson <sean.j.christopherson@intel.com>
Date:   Tue Feb 18 21:07:32 2020 +0000

    KVM: Dynamically size memslot array based on number of used slots

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1099775de00000
start commit:   4f8a3cc1 Merge tag 'x86-urgent-2020-04-12' of git://git.ke..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1299775de00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1499775de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bfbde87e8e65624
dashboard link: https://syzkaller.appspot.com/bug?extid=2e0179e5185bcd5b9440
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e78c7de00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cf613fe00000

Reported-by: syzbot+2e0179e5185bcd5b9440@syzkaller.appspotmail.com
Fixes: 36947254e5f9 ("KVM: Dynamically size memslot array based on number of used slots")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
