Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67914C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5712068F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgGJVCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:02:09 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:42800 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgGJVCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:02:08 -0400
Received: by mail-il1-f200.google.com with SMTP id d3so4538531ilq.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EcX2YoSI4hSwdGD5PhGCWpYPH2pi2umYsQ04cJa1lWU=;
        b=LVMs6zPC65oeQW8RfO+yU0CV47MEAyUwogwLfPbSB2GM2SBALjpGqK5VeJsq2DVfSt
         XfQ/xwC3ed9diia3J9b3iJVT16svVlU8yKL3DAR3pxnDDkrDMdRXANigGzNcIrF8cCPf
         gopml3IJSRyWEHyjfVzmFL/tCcEHtI9FVVj6KueCZDU5mJJQ98nP3MrX2uteR5V5FBwL
         ayb7XKxORc34lTSSzy9hKXn6bfqlcv+1SsfBSA5V2++fPioS6ceuRwGRegsSwCCcj2jB
         GSdqFh+m4t+EkGScQ+i1GNP3Kf17i8Tu7ngHLCPdPFrPDawDTkppHaoHpqpfdYudgNbF
         /ZGg==
X-Gm-Message-State: AOAM5306uqL8U2xS3vmHF5Txwq4mNt0HhisR1yR9mhnWccznmmGLyy1r
        JLvUL134zlnPFnNEMBXwt+nNHKB9K//sXYIs/cFT12L1eyky
X-Google-Smtp-Source: ABdhPJyEq9NElE2CSRzXLsV2eA/q4ph+H8ODuNt0JPwMVMptXa9fHTlPXbqtll4w0/ey3EQ8Hk51+Rr2HK3XNMuFsi5+FTKc0c7b
MIME-Version: 1.0
X-Received: by 2002:a6b:7610:: with SMTP id g16mr44556439iom.115.1594414927282;
 Fri, 10 Jul 2020 14:02:07 -0700 (PDT)
Date:   Fri, 10 Jul 2020 14:02:07 -0700
In-Reply-To: <000000000000b9c33505a63f2fea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d881b05aa1ca788@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in mark_lock
From:   syzbot <syzbot+31610284091be1bf04f4@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org,
        christophe.jaillet@wanadoo.fr, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit c154703bc8dd2231ae81aafef5589b795b2b7e09
Author: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date:   Sun Apr 19 04:18:07 2020 +0000

    Input: tca6416-keypad - fix a typo in MODULE_DESCRIPTION

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151c0000900000
start commit:   d2f8825a Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c33c7f7c5471fd39
dashboard link: https://syzkaller.appspot.com/bug?extid=31610284091be1bf04f4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14797b81100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f86d6e100000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: Input: tca6416-keypad - fix a typo in MODULE_DESCRIPTION

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
