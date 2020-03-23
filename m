Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBA9C10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0162070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCWHhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:37:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48125 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCWHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:37:03 -0400
Received: by mail-io1-f71.google.com with SMTP id c2so5799207iok.14
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 00:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xI0usRcGed/whdLZrrsYIFzz4drUK13ORfQnfasIJ14=;
        b=jA8Ep/yFxPeKgA7BJoLh0h6GooWHkZpl4sGfGmcSvNnaUeGJ4pmYlE1a0OhXxTX6TS
         QOuX6rLu0hun5yHtW9jRVMHS8rpgm1hRygB7KKLJlYkG2vhQXYLeTQNEQiBq3W7vNyIk
         dp1EUsxnx13CfaD5BIfweuKy1qpOT/337qaUR8+CDG+Lbb23TWe4nEcP8nZ1yzMrGJLA
         JUqc0+fIt0NH1HndwVS4V2lC6xAin3lRmFq5Y820OCndXqmWaO80cnrNPeimddvrNSMD
         5ON+UX4EYA1o1xX7sG5QMJySDOcqGaXEPT2mpQ7LnMUvr+olT1qdWAi5zmdm+AHDfoIn
         qw5Q==
X-Gm-Message-State: ANhLgQ1CpJjzvzGV4AulWT3KagUabj3UAT0arOQsWx8p08WvWvMO/IO+
        KjweWhGamYkfCTVAdsH9jqErdjkMF3zvMyE2ZMwxkeEQ4Fl7
X-Google-Smtp-Source: ADFU+vufWP1ZmfhWge9JYASUxfhkELaTlcETnEuwcsBoeOODucklUQVC3o7tld/u7Pwx7D1VAa9UfQDBlJdJnT2pfzm7+QwL09Wo
MIME-Version: 1.0
X-Received: by 2002:a6b:f60d:: with SMTP id n13mr17817597ioh.147.1584949022600;
 Mon, 23 Mar 2020 00:37:02 -0700 (PDT)
Date:   Mon, 23 Mar 2020 00:37:02 -0700
In-Reply-To: <000000000000e9e518059fd84189@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ab36905a180b328@google.com>
Subject: Re: KASAN: use-after-free Write in hci_sock_bind (2)
From:   syzbot <syzbot+04e804c8c2224b6a9497@syzkaller.appspotmail.com>
To:     a@unstable.cc, andrew@lunn.ch, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, f.fainelli@gmail.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7d13eca09ed5e477f6ecfd97a35058762228b5e4
Author: Florian Fainelli <f.fainelli@gmail.com>
Date:   Sat Aug 27 22:34:20 2016 +0000

    Documentation: networking: dsa: Remove platform device TODO

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1746f3f9e00000
start commit:   770fbb32 Add linux-next specific files for 20200228
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14c6f3f9e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c6f3f9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=576314276bce4ad5
dashboard link: https://syzkaller.appspot.com/bug?extid=04e804c8c2224b6a9497
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fc5e75e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10707013e00000

Reported-by: syzbot+04e804c8c2224b6a9497@syzkaller.appspotmail.com
Fixes: 7d13eca09ed5 ("Documentation: networking: dsa: Remove platform device TODO")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
