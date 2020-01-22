Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A846C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F103A2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgAVVBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 16:01:02 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:42672 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgAVVBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:01:02 -0500
Received: by mail-io1-f71.google.com with SMTP id e7so577449iog.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 13:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lYr3VEa0Huaaj5cr2eT5ZYbboOtwrfmYEjzqbnc0FyU=;
        b=e+Sl1/YiiCOmvZTb3AzYE2yY4VjDZb9eXym80A8jgNSV/aGMiXVw9WMgMd396RcsTm
         wApT1cdccud6/6XFuV9IOwpGIt/8CcP0k+qR0LJEmdo/06JzvCAVcGgsgLI8ub6wAhcK
         1wUkqxj7nkHsBeDb8zpVUqy84aHw+z37oNjBT4z1KOjmVl8yJU5wAQVQETI2NXTBcqBQ
         TfBibsJGD4eUJALChMFkcfMfxyTZUsyoHBn6FN9x2/7idGNdkaj0mMwdASHS7mzlKLUK
         FOpFLBGgbsaUsCAFpsihnP5eq14iUSVHKClzmm3VDJt8j8kKeTqhOuyCt4SCX/Ias63s
         6lIg==
X-Gm-Message-State: APjAAAWyNHxtW1NVRYjLTk6PJKxLf0wFp7CXZXGjE/IvXydq5wV5nAtT
        TsnBTJU6L6PMzygbAzuPNK23lPuE6q0T+1NoOlxu+c80yjwL
X-Google-Smtp-Source: APXvYqy98tfXila0SvcgGKr7oS77gUHB1tW0UiRvSHV2F9dhjQ09YKNKJt8UX6JmXLfF/xJtAX4wfwJJc78t2tikEEKrLfVlGsr1
MIME-Version: 1.0
X-Received: by 2002:a5e:924c:: with SMTP id z12mr8598447iop.296.1579726861270;
 Wed, 22 Jan 2020 13:01:01 -0800 (PST)
Date:   Wed, 22 Jan 2020 13:01:01 -0800
In-Reply-To: <000000000000a16ad7059cbcbe43@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068843f059cc0d214@google.com>
Subject: Re: WARNING in bpf_warn_invalid_xdp_action
From:   syzbot <syzbot+8ce4113dadc4789fac74@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        corbet@lwn.net, daniel@iogearbox.net, davem@davemloft.net,
        dsahern@gmail.com, hawk@kernel.org, john.fastabend@gmail.com,
        kafai@fb.com, kuba@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 58956317c8de52009d1a38a721474c24aef74fe7
Author: David Ahern <dsahern@gmail.com>
Date:   Fri Dec 7 20:24:57 2018 +0000

    neighbor: Improve garbage collection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124a5985e00000
start commit:   d0f41851 net, ip_tunnel: fix namespaces move
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=114a5985e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=164a5985e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=8ce4113dadc4789fac74
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f99369e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d85601e00000

Reported-by: syzbot+8ce4113dadc4789fac74@syzkaller.appspotmail.com
Fixes: 58956317c8de ("neighbor: Improve garbage collection")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
