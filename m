Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD93C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 16:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960462071E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 16:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgHAQdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 12:33:07 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:41004 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgHAQdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 12:33:06 -0400
Received: by mail-il1-f200.google.com with SMTP id l6so12918010ilf.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 09:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SIdCK8Q+4LKw+jmzrptYCoQd/JoF3mumY50X9Ph/hTE=;
        b=XLsCmDdmzdh+XMnartDP7AiPhpF5N6oeszz5BUl5saVxa2fYC9H9pVDag5pYuqjSDv
         4yndp1U4DcRSUYi5ctHgCeGRtMduEWldNEOyT+/wixE9nkquxelFCwC+bbUVjg394qYW
         u8B59Q9YHShjWYSPxDP2ZFTM8nWRYL3HMlhs9+GMZKTeVqpuQtfLklHmMjdOn83KiNdw
         vQkFnX4+L9UroNrslsldF8tRUkSYmvN9KgxrcG4keqr7hpmFGfaod1ZwvHGTUlLJKJJh
         xdSpskesCd/QWn+b39aMVNBFv+gOy9brwHeP9wXLJaYmWH63tPTkY9eHLiH6UfhZlxhP
         dpmw==
X-Gm-Message-State: AOAM532sPLBeGmki6iQMjST4cvfh/Xamx6CuccrFEF4SLw2Bg2nIQYaJ
        RaogDPUmW5zsT0lBJTZWqeMQ7RWaC0BHmkV+bnopwpv7uXmh
X-Google-Smtp-Source: ABdhPJxr/wL4FBG9BjuUQiXlSC8n5B0989oGaJ3+8JI4slsvtNxiaGVvvNeo1Fc/qvwpgTWkAaur6QYbJbGO5vawji+M3kZenXYs
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1343:: with SMTP id i3mr8889517iov.134.1596299585453;
 Sat, 01 Aug 2020 09:33:05 -0700 (PDT)
Date:   Sat, 01 Aug 2020 09:33:05 -0700
In-Reply-To: <000000000000f298fc05abb42b70@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf03f305abd37535@google.com>
Subject: Re: WARNING: ODEBUG bug in cancel_delayed_work
From:   syzbot <syzbot+338f014a98367a08a114@syzkaller.appspotmail.com>
To:     bhumirks@gmail.com, coreteam@netfilter.org, davem@davemloft.net,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        johan.hedberg@gmail.com, kaber@trash.net, kadlec@blackhole.kfki.hu,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 43ff7f53de2294a83dcf84b35de6ffa1ffafae9d
Author: Bhumika Goyal <bhumirks@gmail.com>
Date:   Thu Oct 6 18:10:01 2016 +0000

    Staging: vc04_services: vchiq_arm: Remove unused function remote_event_destroy

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=107c810c900000
start commit:   d8b9faec Merge tag 'drm-fixes-2020-07-31' of git://anongit..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=127c810c900000
console output: https://syzkaller.appspot.com/x/log.txt?x=147c810c900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0cfcf935bcc94d2
dashboard link: https://syzkaller.appspot.com/bug?extid=338f014a98367a08a114
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1111ad5c900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16565d5c900000

Reported-by: syzbot+338f014a98367a08a114@syzkaller.appspotmail.com
Fixes: 43ff7f53de22 ("Staging: vc04_services: vchiq_arm: Remove unused function remote_event_destroy")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
