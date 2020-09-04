Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465DFC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B922074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgIDOoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:44:15 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:46733 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbgIDOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:44:10 -0400
Received: by mail-il1-f208.google.com with SMTP id v6so4953257ili.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 07:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GE20mkCJFx34V9csXbBi5MpSPEm23j5O5gEKMXhuGs4=;
        b=kHMRo3Ufo081pWUR8vo0y4zoiD+BkRzAd6ec9rdD9TessPCVepUFDtrZKM6+gfA/Bi
         pK2uWP5xqgjNBldlngjLxdhdJfBrQXB7iuU/06XB1a9X2MG2jHHCYhYiwTLvS8Nmihto
         NDEp0SbV9dIVMee4PIdyYw5qfDcqIZzWmloDBb707OAUNUuRY23yZoQA1a6e9TyrQ8rf
         P47z2/1NuzOTJGxCyWCCGkhHhoePuo/+IT/ToRfMW46BhU40eLEd6YyEIWyCksQYSFfh
         npJoMmAnk6C8uyKMjOjO4iKVMa2XwAA+T+0Y9iGJ6q32ZOD0ruknWHmEXvbS/feKWZ4k
         vpyw==
X-Gm-Message-State: AOAM533k3ivmb4ih+P3uzkmv1xxRLUROlxTKOQb0aCcRzq+bWoyAozmG
        6mQWrJny3seDUGk2Yt9PQuhQxy6mARsm6iw05RX3HhJ84+hc
X-Google-Smtp-Source: ABdhPJxZCmzJJSBtD6oipaJudDBJ1GQFFB0c3Y+RmR7v/iFXEsAA2X6Ph+jfCB/546LXa6E6JWGbeRIObehShZ2GPeZnQjV295Tv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1303:: with SMTP id g3mr4832562ilr.218.1599230649567;
 Fri, 04 Sep 2020 07:44:09 -0700 (PDT)
Date:   Fri, 04 Sep 2020 07:44:09 -0700
In-Reply-To: <00000000000055e1a9059f9e169f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8101605ae7de686@google.com>
Subject: Re: KASAN: use-after-free Write in refcount_warn_saturate
From:   syzbot <syzbot+7dd7f2f77a7a01d1dc14@syzkaller.appspotmail.com>
To:     abhishekpandit@chromium.org, alainm@chromium.org,
        davem@davemloft.net, johan.hedberg@gmail.com,
        johan.hedberg@intel.com, josua.mayer@jm0.eu,
        jukka.rissanen@linux.intel.com, keescook@chromium.org,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        mcchou@chromium.org, mike@foundries.io, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b83764f9220a4a14525657466f299850bbc98de9
Author: Miao-chen Chou <mcchou@chromium.org>
Date:   Tue Jun 30 03:15:00 2020 +0000

    Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f92e3e900000
start commit:   c0842fbc random32: move the pseudo-random 32-bit definitio..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf567e8c7428377e
dashboard link: https://syzkaller.appspot.com/bug?extid=7dd7f2f77a7a01d1dc14
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b606dc900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123e87cc900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
