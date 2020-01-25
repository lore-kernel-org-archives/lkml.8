Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC1C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 00:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E7F2072C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 00:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbgAYApC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:45:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:48520 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387600AbgAYApB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 19:45:01 -0500
Received: by mail-il1-f199.google.com with SMTP id u14so2864018ilq.15
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 16:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7t8461NsKJ7dggiUJMEiWFWH6uHHmMrVa8LOc9k9NXU=;
        b=nGMWotkqCHUCNa6mqL2WTO1EONCPa1LpYeSVypWE1zj67CVRvt3wS+jpk933WlsITA
         u22L+M4IGikpXjupwnwhvPewsST0d46D4WohcBpLCbk+Iqk8F+hQj6/DKfSQsqE/D5Lh
         yuIZHF4MtbIfnHm1i83wJeRVd7dhlAhySejLgLhQLrmzJBnDbNXG1Ad5jIAOapFz5TIg
         cUCiEZ5X7FoLdPYl1V/uu7PAK7JyTihzEM98gx7lfgdZDW6xU2gCxbZPcVXfMnDA5XeP
         5brjRmZbxtREmLUlOMQtv1B86hsO9n1PufHLuYnRtyaQR1G7bd2bLxTPUZUPTpWqyJeW
         5I7g==
X-Gm-Message-State: APjAAAVkkMpFmdLMtRs0g8puc1sqW8MDRAHnaWIAZmAYyPhTuHYGf3FO
        JeIFe4PCNqDVCLU1mW3P5Davn2EqQDHEgW5gAgaMFKdwtcrt
X-Google-Smtp-Source: APXvYqwJo/vSmPmq9gsIz8uynVDogIStRUI8hB7HAkeHhbeN4sRbsogeWVwDSqjIRI+0a2J/NhCBO2MPxF0CPwKx3SXQudBlBCiz
MIME-Version: 1.0
X-Received: by 2002:a6b:915:: with SMTP id t21mr4112476ioi.34.1579913101128;
 Fri, 24 Jan 2020 16:45:01 -0800 (PST)
Date:   Fri, 24 Jan 2020 16:45:01 -0800
In-Reply-To: <000000000000cdbe79059ce82948@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b3861059cec2f82@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ipmac_destroy
From:   syzbot <syzbot+a85062dec5d65617cc1c@syzkaller.appspotmail.com>
To:     a@unstable.cc, arvid.brodin@alten.se,
        b.a.t.m.a.n@lists.open-mesh.org, coreteam@netfilter.org,
        davem@davemloft.net, florent.fourcot@wifirst.fr, fw@strlen.de,
        jeremy@azazel.net, johannes.berg@intel.com, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123fce01e00000
start commit:   4703d911 Merge tag 'xarray-5.5' of git://git.infradead.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=113fce01e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=163fce01e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=a85062dec5d65617cc1c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1301ed85e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b7b79ee00000

Reported-by: syzbot+a85062dec5d65617cc1c@syzkaller.appspotmail.com
Fixes: b9a1e627405d ("hsr: implement dellink to clean up resources")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
