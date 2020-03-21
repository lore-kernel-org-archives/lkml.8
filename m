Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA04C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 04:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD4020663
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 04:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgCUEtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 00:49:04 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:40401 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgCUEtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 00:49:04 -0400
Received: by mail-il1-f197.google.com with SMTP id g79so7092376ild.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 21:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rvmUPiw7rPSJlg92ogk4urICD4aqXpL+uX1Y0EwFPbo=;
        b=qP3Dpxw76/pSykSNEIcShQc3QTBmwmwp/4/eZGYBNwGtQa752JvIzxvksvTOE6Re3e
         xnHHlSc45vsUlRnzdb5Nhbj6OUg2spI3TWRKza6BJmA5m6D76mmTEYt8gJdtDMdLtgo6
         fHB9Gy7V3sSkEPC3YYhmQ+khMqzSaPe/phGDp7tzIxVipnRWIWZrQVslJVEQ9iy/Hxxn
         +J+K/Sk8CS0NURegEmkbNzsIZ4mdEYn+vuKP3Ctw0X+/Qs6ijnt2MQKaN3gsnJbh1+YM
         OlKr3PBEzQBsZ7TM3MlA9LC9RMubUZ0l2NlbBrMJHJliZH1KXfBruRHKbg48WK9gD60H
         AldA==
X-Gm-Message-State: ANhLgQ3TjG+/7FlTwWtsH6cXD6aL4F+nSGM6veC5vE8FeINLmmkCunMj
        G3LYglEUvd7fJPff2kTOAaBcpLlzMmFfg2xAQoR30e91rIoV
X-Google-Smtp-Source: ADFU+vsIyP0VfZ6xrFZPZ16PlF2rSDU5ykaROKu09kcDvjHT5c2GSBuKPcaP+zOXNNI4Vxujqx9weHYXl9pOs/D5HzZ36C8tFWMC
MIME-Version: 1.0
X-Received: by 2002:a6b:7407:: with SMTP id s7mr10534502iog.11.1584766143328;
 Fri, 20 Mar 2020 21:49:03 -0700 (PDT)
Date:   Fri, 20 Mar 2020 21:49:03 -0700
In-Reply-To: <000000000000b380de059f5ff6aa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006777805a1561fa3@google.com>
Subject: Re: WARNING: ODEBUG bug in tcindex_destroy_work (3)
From:   syzbot <syzbot+46f513c3033d592409d2@syzkaller.appspotmail.com>
To:     adam.zerella@gmail.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, hdanton@sina.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 836e9494f4485127a5b505ae57e4387bea8b53c4
Author: Adam Zerella <adam.zerella@gmail.com>
Date:   Sun Aug 25 05:35:10 2019 +0000

    pcmcia/i82092: Refactored dprintk macro for dev_dbg().

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175cffe3e00000
start commit:   74522e7b net: sched: set the hw_stats_type in pedit loop
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14dcffe3e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10dcffe3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5acf5ac38a50651
dashboard link: https://syzkaller.appspot.com/bug?extid=46f513c3033d592409d2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17bfff65e00000

Reported-by: syzbot+46f513c3033d592409d2@syzkaller.appspotmail.com
Fixes: 836e9494f448 ("pcmcia/i82092: Refactored dprintk macro for dev_dbg().")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
