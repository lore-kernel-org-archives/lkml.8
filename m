Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99232C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B70D20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHNNRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:17:12 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:51150 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgHNNRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:17:08 -0400
Received: by mail-il1-f199.google.com with SMTP id t20so6548241ill.17
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 06:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IH2yFUwfReDyb+ZllS6U8RBdlomdqdJ/qVk5KbqvAis=;
        b=YlOczIz1RrPJz5d59PCiLPr8UgSefrpKH9tgQI8zgi1FqbTeldwzwtMdp3R+uavGSK
         qUqTZW6uw+krRJrD48fWtWDSILyotAFRd4BPsjEDTbudnk8az87G4ZmrCfENymFnMfvQ
         qhpWnmXjMvCZIUeBF8p/d9n84V1zIi5GCYLkMa9DRy4KGFR0ZEzjOVivxF4WF7K64rLm
         iA51aaPliJS4k16adFZS61sYjaqypzbDMHoC5yzwQgnvNonYghvxuZakO6IzsXcln9AO
         //5jimNJa7BcfO2PNxFRrUEAE3YqluK0bhI5W6pjXYtClH4TGroU3HlY1HP0ivO91A56
         YVYQ==
X-Gm-Message-State: AOAM531QsgthXCXO4S7h584UwMZ//pJKKZDber9i55GfiGKo9GmpEoKB
        VK2clh7Mhys/5F6SjgQTWGG1Pwi53KOXCiauwhE7YeM7OETx
X-Google-Smtp-Source: ABdhPJw0DlrmX1wRwvc5QY6U9kAZSrT6vpFGHl67k3p4ysMpI61y/3sf2z41wWaLsVc2vLfboRZmffcWc+uADhjTbkL89fyq6HPG
MIME-Version: 1.0
X-Received: by 2002:a92:d588:: with SMTP id a8mr2552007iln.146.1597411027574;
 Fri, 14 Aug 2020 06:17:07 -0700 (PDT)
Date:   Fri, 14 Aug 2020 06:17:07 -0700
In-Reply-To: <0000000000006dc0290581ca413e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbe6ee05acd63ca2@google.com>
Subject: Re: WARNING: locking bug in try_to_grab_pending
From:   syzbot <syzbot+2b713236b28823cd4dff@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, jmaloy@redhat.com,
        kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1378817486d6860f6a927f573491afe65287abf1
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu May 21 18:29:58 2020 +0000

    tipc: block BH before using dst_cache

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175599f6900000
start commit:   6663cf82 flow_offload: Fix flow action infrastructure
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=8572a6e4661225f4
dashboard link: https://syzkaller.appspot.com/bug?extid=2b713236b28823cd4dff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e932a8c00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: tipc: block BH before using dst_cache

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
