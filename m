Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5A9C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D8A222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgCJWsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:48:03 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:34367 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgCJWsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:48:03 -0400
Received: by mail-il1-f198.google.com with SMTP id l13so51212ils.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=q5ZfIbP9gSY9pdPHS/kIAKtPmXSbcAcSEV6rs0Snm+0=;
        b=cNk9ZUOlL1y7OrQocgJ39ckOK8ZB/hUTKCddF3bXeexr7w4wcpbXWRnUKJUV2xmlGw
         prsr/A8ezAFj/yYCaZ+J4anSUfeOYMagimvcRPhEEjzHZfXhVaaDyE29GpPhYXG3mAxt
         WsttPG0tPS/9+wmFaFxmIOee2Qt/66t2w1VLTYVnKF5R6nR8AQ8SAXeQ9Xfob37+ph3s
         hnhdjtk/5Li59HRoBOAExvIaIVeuHUUIFk3mMprNd5XwywpqwpK6T6F6C341gDCrr/nt
         WIdltwP53GU/j3dOgdFgoDiC2QbBdfp82293zR66kU1ld0IOfbVCGOYSs77MqfPa+t8R
         cAVw==
X-Gm-Message-State: ANhLgQ3z886mSZKjhdHBejJogK4k9KCkkatrEDzb7NMqGUW/KcgmmPk6
        yrDqzh0Dy26C2diFPRM3HbxvsKrk9GBjyYJzsmOz49KeOcxX
X-Google-Smtp-Source: ADFU+vsUpjaOtAr4hhw0rq5N3kQz/0hNMAgmfm1xXX732YmORbP3PrSO7VAQ4OKpFhJHkvH5+C6ASJ2eFbWOuCz4cHIHD8swbAza
MIME-Version: 1.0
X-Received: by 2002:a6b:7c04:: with SMTP id m4mr298568iok.208.1583880482351;
 Tue, 10 Mar 2020 15:48:02 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:48:02 -0700
In-Reply-To: <0000000000006601b005a08774fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000846f6905a087e9b8@google.com>
Subject: Re: general protection fault in tcf_action_destroy (2)
From:   syzbot <syzbot+92a80fff3b3af6c4464e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 599be01ee567b61f4471ee8078870847d0a11e8e
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon Feb 3 05:14:35 2020 +0000

    net_sched: fix an OOB access in cls_tcindex

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170df5c3e00000
start commit:   30bb5572 Merge tag 'ktest-v5.6' of git://git.kernel.org/pu..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=148df5c3e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=108df5c3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e311dba9a02ba9
dashboard link: https://syzkaller.appspot.com/bug?extid=92a80fff3b3af6c4464e
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13faf439e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16956ddde00000

Reported-by: syzbot+92a80fff3b3af6c4464e@syzkaller.appspotmail.com
Fixes: 599be01ee567 ("net_sched: fix an OOB access in cls_tcindex")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
