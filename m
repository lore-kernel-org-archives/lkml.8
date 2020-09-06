Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C8FC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 01:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2CBD2078D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 01:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgIFBHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 21:07:08 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:39601 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgIFBHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 21:07:06 -0400
Received: by mail-il1-f205.google.com with SMTP id v17so515792ilg.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 18:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uErToetCtxM2LxDa/nunGNpiTq3iUJM6c1gSOFYhqVE=;
        b=KM2I5ut0c2EILD8Lnc9dmYlItMyCUWyoxTNOPJgnq8fNbI8OAZSLQPdSu8SLnX1Ita
         aXPZLEpw/DM8L2OoeqHfsaZlsPly+0omeE/v3ugmUryD7/VHlxX5L+buQWvIue1FXg2M
         a/lA7tp4ethSI9iUJxfBaoTWhL0o6eZVRr8fzNZ6htQrcMP14X7/YRNAfaqFU5xKWFo4
         Gnhb0Mv9QmMugCmOJyZTezgTcKGbMAuCVZCPmUU7jeyCMELC9fTA5oEZaMsrRgM9IN4A
         +mgmxsReAfd3jXKAQw6dM8lc0mZFQJF/KvkM2FSMjROg8+XJxB6N0u9kFGQ87j0UcwtI
         4kmg==
X-Gm-Message-State: AOAM5302T55y1Jf/MM+Yum8T0XE3I5jmgUKX4C5QSa5ykkb9ufXfAc2B
        W+wo5wr9ufN16QDrjWF+NAt5HHLUJuMsqExhHlBtQa4KGV+W
X-Google-Smtp-Source: ABdhPJym3N6qwjYEE5uH53mipM2L77NAqTDZN1skGYxJ5p38lVrxFf0yXeNgvWFwORCMUNrX5wE8e7Ubtqufgb0mrh/6nKA86/PQ
MIME-Version: 1.0
X-Received: by 2002:a5d:8042:: with SMTP id b2mr13018336ior.60.1599354425033;
 Sat, 05 Sep 2020 18:07:05 -0700 (PDT)
Date:   Sat, 05 Sep 2020 18:07:05 -0700
In-Reply-To: <0000000000000cce30059f4e27e9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005fc62d05ae9ab8c2@google.com>
Subject: Re: WARNING: refcount bug in l2cap_chan_put
From:   syzbot <syzbot+198362c76088d1515529@syzkaller.appspotmail.com>
To:     abhishekpandit@chromium.org, alainm@chromium.org,
        bliniob53@gmail.com, davem@davemloft.net, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, mcchou@chromium.org, netdev@vger.kernel.org,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11aaff5d900000
start commit:   fffe3ae0 Merge tag 'for-linus-hmm' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=18bb86f2e4ebfda2
dashboard link: https://syzkaller.appspot.com/bug?extid=198362c76088d1515529
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152a482c900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109b781a900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
