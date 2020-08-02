Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BAFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 07:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0BA207FB
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 07:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHBHnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 03:43:07 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:51257 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgHBHnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 03:43:06 -0400
Received: by mail-il1-f198.google.com with SMTP id c84so1367439ila.18
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 00:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eqE7M2+jLX9Z2b2ijRlZEwnniJaj49l3REpKdM5etlE=;
        b=rR9ZSSicnQgUNipiNsViAWp1waWntq0xUE+hnQDz2H8+YUPMLSnaSNgnHqwfASn8Fh
         sJxF7vXAEEwWdLg6YdQ4v29veJT0uziuJVMq5rYaIrZLE5f2PoQHcUFTg3F4JNC+1wol
         t54GRTe2kXbGMr3TkGphFtkTq5StOyaUK+tIfehJYuC8cMQ53spstK+5bURZJH3pym2F
         2YojB4h0lbBiMMJaAzbwrlOTyLeE1o2E1ZRwuiXnxP2fEU/cALTgvpnEHvVbELFFR6cu
         WVcqUUNtbeYK1xx3jjXWcLScAJxaVqJ8wgV0A4UUYglIFE1TFIIeYRbSpGSUECZwCHLa
         IJsw==
X-Gm-Message-State: AOAM53352a2M3ocvurAmnZVQzZuVVfwfVQKlK0rErNYFfuyGuEaSjoxW
        dKgThnwFXbWFoEurobGMr5iYFpT8DHxlLuwHauHwatx7Zss8
X-Google-Smtp-Source: ABdhPJwPGH2yiYhjXOJM0c9EdW/Wpe7YJ1kZV2DXqRnNQjYhM6BG3LXmVT5ZL1XYU6JMC/FZ7hlVZVJTAwLiRQixN1DQMDrTFguA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2647:: with SMTP id n7mr1328983jat.61.1596354185896;
 Sun, 02 Aug 2020 00:43:05 -0700 (PDT)
Date:   Sun, 02 Aug 2020 00:43:05 -0700
In-Reply-To: <000000000000ea90600598c9b089@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fa64705abe02c21@google.com>
Subject: Re: possible deadlock in __dev_queue_xmit (3)
From:   syzbot <syzbot+3b165dac15094065651e@syzkaller.appspotmail.com>
To:     ap420073@gmail.com, davem@davemloft.net, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 1a33e10e4a95cb109ff1145098175df3113313ef
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sun May 3 05:22:19 2020 +0000

    net: partially revert dynamic lockdep key changes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10434970900000
start commit:   d8b9faec Merge tag 'drm-fixes-2020-07-31' of git://anongit..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12434970900000
console output: https://syzkaller.appspot.com/x/log.txt?x=14434970900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0cfcf935bcc94d2
dashboard link: https://syzkaller.appspot.com/bug?extid=3b165dac15094065651e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163e2c92900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143f2bb8900000

Reported-by: syzbot+3b165dac15094065651e@syzkaller.appspotmail.com
Fixes: 1a33e10e4a95 ("net: partially revert dynamic lockdep key changes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
