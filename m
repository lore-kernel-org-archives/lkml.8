Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E474FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA98207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbgGVPTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:19:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53118 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgGVPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:19:06 -0400
Received: by mail-io1-f72.google.com with SMTP id k12so2007295iom.19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8O+hcy9D+3uP1r6XjHEoJrtrZg3bcURkhZ7Tw7GCuco=;
        b=r32Kp8P6UAUf6JRJIH3rSe1ghOW5Nwd+D8Nu1Q73HsxgVj2P9BUhtg9B948xFe4Uk3
         TvU19rt0FAZt1BRGh4bFpIed8cMv9m6EzFa2rBoNCRzIo+g/ATAPkUjmu7Ziqj+/mFPO
         2VLQSUgBK99fFACAuvhek6SJHvt8DZjFWIQlEvdy2XKu8kDGa6D9N4s2mUCzmrOMpmRj
         WVg2yM3qG22jI4tCIXYXZRM9ltNfISXg8MD2iIS3AXocAn891sf5Wx0LeGXnlLYvtg/o
         B5dnyWnG2V1NEIzfZQo887al6pgrL92qEWpHRc0lmyDq0sgbk5krrvnx+PK/n9e/jUBc
         dS2A==
X-Gm-Message-State: AOAM530y073ekzyrFPvrzbIghH1QlbIdUVmJo5pwSwnlbvYcwFE2m7lr
        sHkwMqsbZ0dBuQfLf9RaN8hPHINSy1ljIiwMDdXkRW/YMbLL
X-Google-Smtp-Source: ABdhPJxrRwotvwsFMlv3C7Kix89/6yIaucCdCzBMJYqcV+TZWkdMEarhp/fVTNBpGxms54f0K8O0NlRmZla/4oD6CdGmmcZ6R3gT
MIME-Version: 1.0
X-Received: by 2002:a92:c011:: with SMTP id q17mr398957ild.290.1595431145264;
 Wed, 22 Jul 2020 08:19:05 -0700 (PDT)
Date:   Wed, 22 Jul 2020 08:19:05 -0700
In-Reply-To: <00000000000079a77705a8ce6da7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad5afa05ab09427f@google.com>
Subject: Re: general protection fault in qrtr_endpoint_post
From:   syzbot <syzbot+03e343dbccf82a5242a2@syzkaller.appspotmail.com>
To:     bjorn.andersson@linaro.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e42671084361302141a09284fde9bbc14fdd16bf
Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date:   Thu May 7 12:53:06 2020 +0000

    net: qrtr: Do not depend on ARCH_QCOM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f50e27100000
start commit:   1590a2e1 Merge tag 'acpi-5.8-rc3' of git://git.kernel.org/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=140d0e27100000
console output: https://syzkaller.appspot.com/x/log.txt?x=100d0e27100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20c907630cbdbe5
dashboard link: https://syzkaller.appspot.com/bug?extid=03e343dbccf82a5242a2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1496f9f9100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1692523d100000

Reported-by: syzbot+03e343dbccf82a5242a2@syzkaller.appspotmail.com
Fixes: e42671084361 ("net: qrtr: Do not depend on ARCH_QCOM")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
