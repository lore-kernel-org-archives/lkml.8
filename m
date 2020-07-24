Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F0DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E8F207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGXD2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:28:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36684 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGXD2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 23:28:06 -0400
Received: by mail-io1-f72.google.com with SMTP id h205so5450338iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 20:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ont9djuNY0GU/qTuUTW3soxu8Qb4Ubkk1v7mFHEioWA=;
        b=aTdZFoWggYl+KeBPRbaTybgVC0LHpms6JEyvRTsUCMEcx9TrWBM3oKL8DtzeJbp0tx
         VMKrhrvOcCkJWO5gHfBH84noVNKUEk6/aX6gL34mgAHcj2OlkGKaDFw50XFBj1E6yE/J
         tFXA/KZBSbFy4h8MvQqepBdNBnfE+KvKstsF5q8d0Yzl7CKHu8MFD22lhL22ADeBryiy
         6m1hIbaOyIJRFPz2gJZAZUUK5IMdPrE0SCCUIDDdJSbrGAZ8gPvT586rLImCq9kmKA8e
         QZjshklK3K+tO4NjSPDGBuLQVeyPT+hJyeTfo2brNgiRnBlLV1gmrEtscoETe83cxfXQ
         OofA==
X-Gm-Message-State: AOAM533wRfoqHJyL3fXRIntrwyQkq+MkG0/M1JowQ0/qTGRh6RzyNwUV
        0kwoU22c0NNkBo6zxT9hnUSXmZnN0A2+mc93xzIqqGYKK8im
X-Google-Smtp-Source: ABdhPJyJhGuaT6ThvP5DAjoFMNwap5je5huhz7wXrzNaWbB0+3IhSTSajSiENIBUlIaXs4NeyJWylMSwM1m6OQPseXtVJY63B+ii
MIME-Version: 1.0
X-Received: by 2002:a92:cf06:: with SMTP id c6mr8246821ilo.73.1595561284301;
 Thu, 23 Jul 2020 20:28:04 -0700 (PDT)
Date:   Thu, 23 Jul 2020 20:28:04 -0700
In-Reply-To: <0000000000000a8e8605a22a1ae0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091792505ab278f0a@google.com>
Subject: Re: INFO: rcu detected stall in netlink_sendmsg (4)
From:   syzbot <syzbot+0fb70e87d8e0ac278fe9@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, mingo@redhat.com,
        netdev@vger.kernel.org, rostedt@goodmis.org, sven@narfation.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vinicius.gomes@intel.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d46e1b100000
start commit:   7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d46e1b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=0fb70e87d8e0ac278fe9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1023588f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1647a88f100000

Reported-by: syzbot+0fb70e87d8e0ac278fe9@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
