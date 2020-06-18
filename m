Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3220C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743D8206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgFRWwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:52:12 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42872 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgFRWwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:52:08 -0400
Received: by mail-io1-f71.google.com with SMTP id a16so5301991iow.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eWQTfX1g8JOgeWYSSIzFk760Kxm5cADaSJtq+50orro=;
        b=RQZVcyQWEB+tifrrddmrF8w8wy05iIBpgpUVyA5+/ypz+UekusyQ7HI1pxXwsB3NMs
         umdILM7hslbHWmCgcWDCVw9CYD2OdPCdaUnz2jHwWJcWKcDEWeJHNTWf7ozOEQZFlDr9
         /ncAEMLCduJoKAasl75ALTL+gb/qJr2pZzm2lBR1jaVN/vCx3e/Gvfy+camHhFO5fli5
         +ND1xRjVJq7QFEhEakxz/UyTR7J0QXyOHMMzygncTVIv6WxcTnMe0p9og8E5dmPGytkx
         PL2DXriUEi4h7wH6C+6yAyDXOecvrh5eij6DTBRHmaI8xrxGwDP5wWtoXu67MzVy44g3
         IMLQ==
X-Gm-Message-State: AOAM533g0vqd6PMrXY5/UlNaDmsAgJhOKGhGW5i2zFVyC+l1Xbp427on
        a8vyWLq6uCaTQuuF/Bcp2DcQY/UHPFr/yHsJbnTwyI2Pmc0z
X-Google-Smtp-Source: ABdhPJzueD6XzKGdxKBPJFSLQ5DjaVU/HXFzLbQiJVdvX4tT+HS52gVxYvFpJZJ1Ljb0snBMpA/OhqPiLRLuhFxaiBc66KFh8fm0
MIME-Version: 1.0
X-Received: by 2002:a92:a198:: with SMTP id b24mr864894ill.46.1592520726414;
 Thu, 18 Jun 2020 15:52:06 -0700 (PDT)
Date:   Thu, 18 Jun 2020 15:52:06 -0700
In-Reply-To: <00000000000086d87305801011c4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000320bcb05a863a04c@google.com>
Subject: Re: general protection fault in __bfs (2)
From:   syzbot <syzbot+c58fa3b1231d2ea0c4d3@syzkaller.appspotmail.com>
To:     amitc@mellanox.com, andy.shevchenko@gmail.com,
        bgolaszewski@baylibre.com, bp@alien8.de, davem@davemloft.net,
        douly.fnst@cn.fujitsu.com, hpa@zytor.com, idosch@mellanox.com,
        jon.maloy@ericsson.com, konrad.wilk@oracle.com,
        len.brown@intel.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org, petrm@mellanox.com,
        puwen@hygon.cn, rppt@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tipc-discussion@lists.sourceforge.net, x86@kernel.org,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 46ca11177ed593f39d534f8d2c74ec5344e90c11
Author: Amit Cohen <amitc@mellanox.com>
Date:   Thu May 21 12:11:45 2020 +0000

    selftests: mlxsw: qos_mc_aware: Specify arping timeout as an integer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1315b059100000
start commit:   8834f560 Linux 5.0-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
dashboard link: https://syzkaller.appspot.com/bug?extid=c58fa3b1231d2ea0c4d3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bab650c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a331df400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: selftests: mlxsw: qos_mc_aware: Specify arping timeout as an integer

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
