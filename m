Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A639C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C5520738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCQVAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:00:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45111 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgCQVAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:00:06 -0400
Received: by mail-io1-f69.google.com with SMTP id h76so9292551iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 14:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jOHQtkE+j+BwIkremLXMAym3S1dSOKIG4OvqLs6ZU6s=;
        b=rQdaPJyxRe6l8EaHDFZsYOqKO2WA/V8GfHQi6lZoGgEB7EgI6ERu5XklwP8spNkIcJ
         HJAoQ5+Hd9MOIcGUrpA+Xo5cf4e9CgSLkRJtUzoiDELSfSeaVuHfTCtz3/l2GrlHIFEB
         9HWcwOx3au6NpYyWoon57u+2A/SbHl87BPQWLXrar9xFh7j6d29Vw1xtAFsoCVN6IZl5
         HEVI2ofg6R5o4/8oZR4UQNE+AaNhdqBkMLPKMWC1FoqgMBuXhrTL5A+Lcude7Bgvzz2n
         b3VI0GQ0lpPho2S2DNsHSLfyj4T8UusvIeqne3ya1V8GF8NJHCDAAQf+gIm5jEosRUh6
         7oLA==
X-Gm-Message-State: ANhLgQ1Z/4Rm9YFxqGHFeqH1LnZ9GgJEZ6x63nzMsTYMMvpYlpzZmI6s
        7NKB2BpbKGGaUj4VSxsud+80gijd0g1xXrKMAlXkSCSVoLH+
X-Google-Smtp-Source: ADFU+vvjZYbx7yw6D42qU49X2AdYKRb+wwE/boG6wr6tdhE57By27JNVOyvqOTfhPYLqsPqBjiMMmM8UOmZHaQdMVGzs1UGN1xRV
MIME-Version: 1.0
X-Received: by 2002:a05:6638:a99:: with SMTP id 25mr1264995jas.37.1584478803965;
 Tue, 17 Mar 2020 14:00:03 -0700 (PDT)
Date:   Tue, 17 Mar 2020 14:00:03 -0700
In-Reply-To: <000000000000f3b11305a0879723@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043c5e505a11338e0@google.com>
Subject: Re: WARNING in kfree (2)
From:   syzbot <syzbot+50ef5e5e5ea5f812f0c2@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13257803e00000
start commit:   2c523b34 Linux 5.6-rc5
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10a57803e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17257803e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e311dba9a02ba9
dashboard link: https://syzkaller.appspot.com/bug?extid=50ef5e5e5ea5f812f0c2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d8ae91e00000

Reported-by: syzbot+50ef5e5e5ea5f812f0c2@syzkaller.appspotmail.com
Fixes: 599be01ee567 ("net_sched: fix an OOB access in cls_tcindex")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
