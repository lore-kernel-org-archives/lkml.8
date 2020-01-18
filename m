Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78CBC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 08:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3FE2467C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 08:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgARIgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:36:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:45092 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgARIgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 03:36:02 -0500
Received: by mail-il1-f199.google.com with SMTP id w6so20550192ill.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 00:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=f6arYuzOgRiNLirbokwAadEyI3EtpDczyp+p4b7vfMk=;
        b=VPFJb05eJRHz2I8mM9DaqyZfbMxUlhHvebm0lytgLd2UnG8DcsnCX2vo5cRIpr/wrV
         MvLEzJKaSy/jEQE1ftiksMYLumPt66gKvNhO3H08YBbVvqFxGCYQt8X7o9O2moeZRRM/
         p9O71hYKMPCdjy6SWRWvWc4aJH0JT+ZyZzeA8CLx8077s2Wb83mKTE0Fv2JCqXHzjiEl
         yL0rnymRv4latCrLQtO1SOlcEA2c3q/Qko6Tmll9n/JUvqhfKKAIyKcgpWbAs1TiQwt6
         i71X1ey7QpnZ9tam//ee9Lpt5knwImfC2oJhhh+vjj5tYsK5yxt9vkXLUvPBF0KFWQCo
         12uw==
X-Gm-Message-State: APjAAAU/r/kS+iCPJ68DlD5R50czjWZFCFa2jj6r+n75aBdPu6TZofQU
        mxYPTXM+WbCQOS+iMlm8KAvezg+LYbwfpdAY2FRgcAW4aRJY
X-Google-Smtp-Source: APXvYqxpKnt5Q1gviMC5prN5JTg6U+mpzrK7koY1nSdpvBADtfR8n77cXbnKp9w6a0f/yM6V1iVvJQS62W2YH/DmuX9np5aG08ox
MIME-Version: 1.0
X-Received: by 2002:a6b:7201:: with SMTP id n1mr29961612ioc.37.1579336561855;
 Sat, 18 Jan 2020 00:36:01 -0800 (PST)
Date:   Sat, 18 Jan 2020 00:36:01 -0800
In-Reply-To: <000000000000b9c312059c656759@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c01359059c65f22e@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ipmac_list
From:   syzbot <syzbot+190d63957b22ef673ea5@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, coreteam@netfilter.org, davem@davemloft.net,
        florent.fourcot@wifirst.fr, fw@strlen.de,
        jakub.kicinski@netronome.com, jeremy@azazel.net,
        johannes.berg@intel.com, john.hurley@netronome.com,
        kadlec@netfilter.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, simon.horman@netronome.com,
        syzkaller-bugs@googlegroups.com, willemb@google.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit ed246cee09b9865145a2e1e34f63ec0e31dd83a5
Author: John Hurley <john.hurley@netronome.com>
Date:   Sun Jul 7 14:01:55 2019 +0000

    net: core: move pop MPLS functionality from OvS to core helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127260f1e00000
start commit:   ab7541c3 Merge tag 'fuse-fixes-5.5-rc7' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=117260f1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=167260f1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=190d63957b22ef673ea5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fe12a5e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1138dfaee00000

Reported-by: syzbot+190d63957b22ef673ea5@syzkaller.appspotmail.com
Fixes: ed246cee09b9 ("net: core: move pop MPLS functionality from OvS to core helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
