Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D97C433E3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935822073E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgHEHbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:31:13 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35731 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEHbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:31:08 -0400
Received: by mail-io1-f72.google.com with SMTP id s5so25862178iow.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 00:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UAjlV35CqUYg8Wq8iE9joWFodTfiF9zQm++Jk44fcSY=;
        b=olmH9p/GDFR69CQ0m3hVMasTOu0qLurnKoWn3DJnhS/SnVbUH/NJN9trTduTTIG/62
         +KxJECrOeyGfKSHCuc9sQWKkSReChUgXIuA+NbicxmufdPlvOENZWRcflm/x20b9YCWm
         QPkF9vGA6OAa6uqyv+S2Hc894Yj3xAy4eabK/yS0QJxww8diAs5REECIFpC93MgvM3qS
         obkkPItaJgAEgZPCcbKDByupZ1caXNRQMoR3cFk5Jz03P765cl8k9hhwrcIkV5dyWxnm
         vH6Tbr6yonkxVcSxXxgoHZOE0lrXlpfEc3tVhfKqsuvxOVbksn416vl6TS4I9W4ra13k
         Mpbg==
X-Gm-Message-State: AOAM533r19o6WRTADVR9cJMteB3FLXinkN78Nlaq+26Ky1UFUrWPbjrz
        inpCcXlUCPXJ5w9327G514NnD1J3eAlQ8t95P2/Y/zfzZZNR
X-Google-Smtp-Source: ABdhPJydINKXG6kk6Rt5Q7YptVJc6WU2HIGHbqBbyEup0nCj4eB/muV9ogT+bIQJk1+5SdRMqrFrePgB51/EIuvRRPKG7IPv2d9A
MIME-Version: 1.0
X-Received: by 2002:a92:1b5b:: with SMTP id b88mr2679375ilb.104.1596612668103;
 Wed, 05 Aug 2020 00:31:08 -0700 (PDT)
Date:   Wed, 05 Aug 2020 00:31:08 -0700
In-Reply-To: <000000000000a39e4905abeb193f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed214e05ac1c5ae8@google.com>
Subject: Re: general protection fault in hci_phy_link_complete_evt
From:   syzbot <syzbot+18e38290a2a263b31aa0@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, johan.hedberg@gmail.com,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, kvalo@codeaurora.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux@armlinux.org.uk,
        marcel@holtmann.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit b59abfbed638037f3b51eeb73266892cd2df177f
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Thu Sep 15 13:30:03 2016 +0000

    mac80211_hwsim: statically initialize hwsim_radios list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dd5f98900000
start commit:   c0842fbc random32: move the pseudo-random 32-bit definitio..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17dd5f98900000
console output: https://syzkaller.appspot.com/x/log.txt?x=13dd5f98900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf567e8c7428377e
dashboard link: https://syzkaller.appspot.com/bug?extid=18e38290a2a263b31aa0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e4e094900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1143e7ca900000

Reported-by: syzbot+18e38290a2a263b31aa0@syzkaller.appspotmail.com
Fixes: b59abfbed638 ("mac80211_hwsim: statically initialize hwsim_radios list")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
