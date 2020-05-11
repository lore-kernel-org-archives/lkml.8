Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3555C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A3B20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgEKUBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:01:05 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:43408 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:01:05 -0400
Received: by mail-io1-f69.google.com with SMTP id t130so10639045iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=r3rvLS/7OSymcywLi3ykqp9cMo+6POjxD+uKb7XeVJ4=;
        b=C8vez4U2GpL885JL+gipfxd47dhDcCDyVYwaSg9xFUeUdFBARZ05OEnnCSHuvx10Yw
         3aK9SQC7QEVe6GvE3mmQxgQIqx+YH2epum4h33pz/GgDYaY+zPMsGloP0QYaG8BMbFsg
         ARZJEJ2m5nr4AWJ/uXWvwZCFr8e2guufQoDrpL9PdOHz2Dc/ax+sMSG8/r7qcfkl8n3i
         rPdfMr19TZI6rKcIxjaiSb4xrjfrOO7YFhNYEALkq4+qHdY7z8+hNsSe/FZi3/dlIt9r
         tGe+kDmcN/GVGYQ08Ak/8F/kdaA5ieD75XH/mJGdgS2BdCikc7VmGPSC0MU2rvuOV1zL
         Yurg==
X-Gm-Message-State: AGi0PuYhZjngmsgTfIgB3FLxITgx4zLV/K8DFUxix9wEqTHC4N1Hewr9
        FIhDNL4zak6WWHpVZGrVSMZPlbltgiT3/iUk2MS/2173FG24
X-Google-Smtp-Source: APiQypL8PyCi7XJoh3MlvMhOulxVo8dgsO7rD64GpEBtis3OCHtOopeofe3eSf9kphlB30gqo6BxhKHD7PAx9eQlxJ1F6mlQVttq
MIME-Version: 1.0
X-Received: by 2002:a02:245:: with SMTP id 66mr17192352jau.69.1589227264250;
 Mon, 11 May 2020 13:01:04 -0700 (PDT)
Date:   Mon, 11 May 2020 13:01:04 -0700
In-Reply-To: <000000000000dd891a05a56369b8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008da02c05a564ce24@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in fl6_update_dst
From:   syzbot <syzbot+e8c028b62439eac42073@syzkaller.appspotmail.com>
To:     ahabdels@gmail.com, davem@davemloft.net, kuba@kernel.org,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0cb7498f234e4e7d75187a8cae6c7c2053f2488a
Author: Ahmed Abdelsalam <ahabdels@gmail.com>
Date:   Mon May 4 14:42:11 2020 +0000

    seg6: fix SRH processing to comply with RFC8754

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1154da84100000
start commit:   2ef96a5b Linux 5.7-rc5
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1354da84100000
console output: https://syzkaller.appspot.com/x/log.txt?x=1554da84100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=efdde85c3af536b5
dashboard link: https://syzkaller.appspot.com/bug?extid=e8c028b62439eac42073
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102bfda2100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f8510c100000

Reported-by: syzbot+e8c028b62439eac42073@syzkaller.appspotmail.com
Fixes: 0cb7498f234e ("seg6: fix SRH processing to comply with RFC8754")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
