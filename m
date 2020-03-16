Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FDEC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D03E20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgCPHtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:49:05 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:44065 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgCPHtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:49:05 -0400
Received: by mail-il1-f199.google.com with SMTP id h87so13124431ild.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 00:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ouibFrPDWjCxL4FEpaUkFRuLLdmqeyOHLoLDagTo38s=;
        b=acnRlMGRhNt8H8UFRftWAoITt4Cru5I2IFV7GcxF6VqmqELmG5bTuqnEXIx9/PNe+L
         ec6HY6bCfPWqHgYAtXDIgAKqKzW9zAz6G2idAYGmE+8/6O2JHg0T4JpRE0fQVV6sdzul
         PUzCrhTO4YNepI3Vc/XKoCajftgH0RXMtdlexen8kjGFqOGswCcvkNGzxM/pHZE3C9h2
         KmsJZhOBj0pMjRcAkFKzXqh1u3E3qc0ExLFgit63L4ch0Aorc4XI86uh1QkUmwF288qR
         6Y2XZMR7mppXN8k3EQ0ste7xWIDIln2lPx924yiuxahoPw96XVxpdjY/aiMoYf6+Cb/k
         cGJA==
X-Gm-Message-State: ANhLgQ1uUhg53LkeuYWL5lVKiyM23C+gNaAjB11d8DdQOGkt/TSzM3zM
        rOwhQ2BWw1Nma8E0VbivA7aAVMcU3Uu+NmsJQckOhlgNswjm
X-Google-Smtp-Source: ADFU+vuDRuPOxa1IDImesiTPozC5o7HpVN8zsZ8bX3G8vsFE+prdAIwJ0Rw4kazKiRUzVPk45zL965SLV5YZQfZX51CMEkoS3u30
MIME-Version: 1.0
X-Received: by 2002:a6b:dd14:: with SMTP id f20mr22452258ioc.32.1584344942619;
 Mon, 16 Mar 2020 00:49:02 -0700 (PDT)
Date:   Mon, 16 Mar 2020 00:49:02 -0700
In-Reply-To: <000000000000c08f2005a0ed60d4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081b1df05a0f40d13@google.com>
Subject: Re: general protection fault in erspan_netlink_parms
From:   syzbot <syzbot+1b4ebf4dae4e510dd219@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        petrm@mellanox.com, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e1f8f78ffe9854308b9e12a73ebe4e909074fc33
Author: Petr Machata <petrm@mellanox.com>
Date:   Fri Mar 13 11:39:36 2020 +0000

    net: ip_gre: Separate ERSPAN newlink / changelink callbacks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101477fde00000
start commit:   0fda7600 geneve: move debug check after netdev unregister
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=121477fde00000
console output: https://syzkaller.appspot.com/x/log.txt?x=141477fde00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e311dba9a02ba9
dashboard link: https://syzkaller.appspot.com/bug?extid=1b4ebf4dae4e510dd219
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1627f955e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111ac52de00000

Reported-by: syzbot+1b4ebf4dae4e510dd219@syzkaller.appspotmail.com
Fixes: e1f8f78ffe98 ("net: ip_gre: Separate ERSPAN newlink / changelink callbacks")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
