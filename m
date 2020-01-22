Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384F6C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D21C24683
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgAVMBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:01:03 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:43302 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgAVMBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 07:01:02 -0500
Received: by mail-io1-f69.google.com with SMTP id v15so1767128iol.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 04:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=61s/b2ve7Ymq8tfjb3CXMkDvuEBC5uRjhgGwyXBI6Ks=;
        b=eQOsnGcIzNz4xzd193mPjnOQIAe38ieDKzXwQjEG/WBJoVZMpwcFpjMNdg2O4q71B6
         eJpRjNX4o/cPFGECMqVJVHAXdLSdMvoG/RjiWzMyeiZNpT5paC51B+x18ac41ywWZ72q
         L1mSsEp1Ggui0F+PTFbH4ZKa3yRI+D01CLgZ/vL6+nRhqj2dSo2ll/E/tOPm8fbwOdSM
         ftlu6M8ETyPPyk4cxgBFwJI7oojokhUw+3wZTN5DCR7PDCTZIPXCZPXSPI2yAcBNHgIE
         xnvsyqFf0iPKuz1WAghGvqIK87BlCUVSMqilaTvC4AzH6HB1IcsOAOtPdj8acz5cIZd9
         XypA==
X-Gm-Message-State: APjAAAV4vzeNIYgwzSBU6+PSsFXqyMtqBgCJMlDAc/QYzWO5zhD7hS2P
        tZc9WfOfxpKm5fRZ4vdHa0Sf0qGDtbDGhzlSkSHuhgRndWaG
X-Google-Smtp-Source: APXvYqyauwF/AYy3VXIkvRTGiyeWl5ltDClvjnrtOVeCsUgRufF0STZg5aTzuLZ1EBQ/uEcFf23kAN1WfFJdg2uVlA8aHwOKEUSo
MIME-Version: 1.0
X-Received: by 2002:a02:ce5c:: with SMTP id y28mr6785824jar.96.1579694462294;
 Wed, 22 Jan 2020 04:01:02 -0800 (PST)
Date:   Wed, 22 Jan 2020 04:01:02 -0800
In-Reply-To: <0000000000007c3ba2059cb50843@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004762b3059cb947b4@google.com>
Subject: Re: WARNING in cbq_destroy
From:   syzbot <syzbot+63bdb6006961d8c917c6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, echaudro@redhat.com, ivecera@redhat.com,
        jhs@mojatatu.com, jiri@mellanox.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit d51aae68b142f48232257e96ce317db25445418d
Author: Jiri Pirko <jiri@mellanox.com>
Date:   Mon Nov 27 17:37:21 2017 +0000

    net: sched: cbq: create block for q->link.block

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a51a95e00000
start commit:   d96d875e Merge tag 'fixes_for_v5.5-rc8' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16a51a95e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a51a95e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=63bdb6006961d8c917c6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a1a721e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a91a95e00000

Reported-by: syzbot+63bdb6006961d8c917c6@syzkaller.appspotmail.com
Fixes: d51aae68b142 ("net: sched: cbq: create block for q->link.block")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
