Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB3EC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D29B20732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgDMOFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:05:07 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:51933 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbgDMOFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:05:05 -0400
Received: by mail-il1-f199.google.com with SMTP id i13so10676019ilq.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dSAaCUxfmH3RsO4S6JaqC9sPiFMT1emTj9SauC2DHLk=;
        b=fdC46RIExKTw9SmxCzjZJTqGSSA2r08zRI5ymDmYbBevrGZVVBfVavTTo5oRxlzqlR
         zaY3xroGVtr84zNomLLijGywTUj/Im29aZLvRycV5VyFTAAXEENBz0Ki25cagvxMsnoG
         icAMhVoDJbvBgPjkOSbZ9PA//pCoiE7Q5k9+a1LM6jPpB28Jvf8PM9lUfuToLVQYm7lK
         ne/qt48EOdLRqonIipef8d9Rp1iIRA6kK652gU3lFMRA4O7YyPVFXrFdrG0AsPZH9TGe
         vJ/cz4bBK2xsk+Tk90YriuXwy84dTu+FlV4JXD2e8WqQ9mI6gfNsv1wmFXgEnh6LGAxq
         NcQw==
X-Gm-Message-State: AGi0PuYxJBTZpORno/A0xYfvXmzSYtr2Ptp/f3T2rEl+mgAtZE3LV4Ze
        F8hUu2SAlPnBgErPuyqMH7gXGdh/qetHy0mkIMy+rZsyIFwi
X-Google-Smtp-Source: APiQypLR1F78iaVNLapYRHoDrHWZAKXWioEFmpkhtSEmyxWdBCDJ9YMPc5xSsHv6bj/OoSxNP8wJr0eMQai+nXX/+ecVqEcBkG0h
MIME-Version: 1.0
X-Received: by 2002:a02:7b05:: with SMTP id q5mr16487082jac.105.1586786703461;
 Mon, 13 Apr 2020 07:05:03 -0700 (PDT)
Date:   Mon, 13 Apr 2020 07:05:03 -0700
In-Reply-To: <000000000000bb471d05a2f246d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb517b05a32c917b@google.com>
Subject: Re: WARNING in hwsim_new_radio_nl
From:   syzbot <syzbot+a4aee3f42d7584d76761@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, mathew.j.martineau@linux.intel.com,
        matthieu.baerts@tessares.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 01cacb00b35cb62b139f07d5f84bcf0eeda8eff6
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Fri Mar 27 21:48:51 2020 +0000

    mptcp: add netlink-based PM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10225bb3e00000
start commit:   4f8a3cc1 Merge tag 'x86-urgent-2020-04-12' of git://git.ke..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12225bb3e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14225bb3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bfbde87e8e65624
dashboard link: https://syzkaller.appspot.com/bug?extid=a4aee3f42d7584d76761
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100825afe00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10df613fe00000

Reported-by: syzbot+a4aee3f42d7584d76761@syzkaller.appspotmail.com
Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
