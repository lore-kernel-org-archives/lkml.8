Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20332C33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 04:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF43217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 04:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAUElC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 23:41:02 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:44384 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgAUElB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 23:41:01 -0500
Received: by mail-io1-f69.google.com with SMTP id t17so960418ioi.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 20:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NCHvuKVSBxRHeizGAyp94YLEyZNHqgNg1esxuxlJg/o=;
        b=RUPsUvOJaE1E/5sh5D4rM9rsG/V+QpPjWk616iiaM8FN1v0ZXWPa7OLRs3oNwtLk7s
         EGNJFjWbiCn21fgoE3KfaGkltBpqoGIaG4ne3S6w8Zu34BuRn7sN4qLMX5D8lMZSdme0
         2Cs6J/NvwGd4K3wuNZbQADQRWqkjVwLNNRQvY8jaWKMcC5foXpsMLOlyr9hzwzygDgK3
         zaNPYnqNQH8Qf7qanKo9X7uN/VQeVK7+HUbXzQt8cu6jATxcNOSuOuYT5VM6i8tJwA7J
         aPTixds9mwCRqw7oyDxZ8W/tTycJNVwITtYZJiQ62f2A+MUyd2OjuUEupeLlwJfoIkVG
         tIuQ==
X-Gm-Message-State: APjAAAVXOudtODOMtnULUzOh6MhhE8/YdUAma8rMB16ESacDc8Glvj9C
        OdCgghka5+9Dgh9PTFYo2dHWqZsZioG0tsOkGL0/1zqKAWRp
X-Google-Smtp-Source: APXvYqzJrudOM5ZqIhdp6/vUqAJPKgAZHJimMJnIa4tHcx71IDDXqV6DGIP5tIwdhQNRHsKr47nmu6rr4NtsU6zWdZOvYEY4ROX2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr2062010ils.54.1579581661230;
 Mon, 20 Jan 2020 20:41:01 -0800 (PST)
Date:   Mon, 20 Jan 2020 20:41:01 -0800
In-Reply-To: <000000000000bb0378059c865fdf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfbeb5059c9f036d@google.com>
Subject: Re: KASAN: use-after-free Read in bitmap_ip_destroy
From:   syzbot <syzbot+8b5f151de2f35100bbc5@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        coreteam@netfilter.org, davem@davemloft.net,
        florent.fourcot@wifirst.fr, fw@strlen.de, jeremy@azazel.net,
        johannes.berg@intel.com, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, lipeng321@huawei.com,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        tanhuazhong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 354d0fab649d47045517cf7cae03d653a4dcb3b8
Author: Peng Li <lipeng321@huawei.com>
Date:   Thu Jul 4 14:04:26 2019 +0000

    net: hns3: add default value for tc_size and tc_offset

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cc0685e00000
start commit:   8f8972a3 Merge tag 'mtd/fixes-for-5.5-rc7' of git://git.ke..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17cc0685e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13cc0685e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbb8fa33f49f9f3
dashboard link: https://syzkaller.appspot.com/bug?extid=8b5f151de2f35100bbc5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e22559e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16056faee00000

Reported-by: syzbot+8b5f151de2f35100bbc5@syzkaller.appspotmail.com
Fixes: 354d0fab649d ("net: hns3: add default value for tc_size and tc_offset")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
