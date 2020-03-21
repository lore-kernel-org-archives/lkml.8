Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C818C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B1120754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgCUOMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 10:12:05 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:43012 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgCUOME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 10:12:04 -0400
Received: by mail-io1-f70.google.com with SMTP id b21so7226832iot.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 07:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Zlgi2xoadfax49bYHX7gbtP8mxGb/dTs9YET+aZW4co=;
        b=OlCzbZSYWx/ZRflxkMcqSG52IlI3TJGWRbNscQE83hFIlgkdOPFneApiITRDrkcES5
         hJAwh1Xk500D7RR7Zsh1ME6zvOd/PkJSz7n71GLwgKWu6CBH2ptZ0iw8PYzP0xSCezOw
         Y3GC5e8NHB10oIz59ade0i9QaRoEMU5gRpEzCeJvc2oUvTEEXSH9GVrYRf3XL7u49ZjL
         PQw79J9Yb87XgnF5eqENXmACwGr68DDnWfm0OhVMj3FTWiWkP2WxpSAnH/w3UTMpcnhJ
         F26iCImKII1jxqM8eJYbi7XLKeyiQYX3sLBj1pQRABuJjau4saWdVPMGUx6K2tg370Vb
         Kc4A==
X-Gm-Message-State: ANhLgQ2+Wghv0GmxoTHW8xb02PE/lmTO2AC4EFuXX3F3U5Cs+gKnMAzp
        G2HW/8VeYaM1a3dienBGEiOhKpvPPP5/jxQHMshu14CH9Pjn
X-Google-Smtp-Source: ADFU+vuuCa3cSD3fZhOXW2dpWnTKAtvHOd2BTTp43x5m0RVqxGUPwhgKorQewidseLLgyQQPPATg+dwWVhHeM40pT400onNAlSrA
MIME-Version: 1.0
X-Received: by 2002:a02:a85:: with SMTP id 127mr12515540jaw.51.1584799922592;
 Sat, 21 Mar 2020 07:12:02 -0700 (PDT)
Date:   Sat, 21 Mar 2020 07:12:02 -0700
In-Reply-To: <000000000000b55d8805992071b5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d22ee05a15dfccf@google.com>
Subject: Re: INFO: task hung in tty_ldisc_hangup
From:   syzbot <syzbot+3105793febc8f3e591ce@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, jslaby@suse.cz,
        linux-kernel@vger.kernel.org, okash.khawaja@gmail.com,
        samuel.thibault@ens-lyon.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit e8c75a30a23c6ba63f4ef6895cbf41fd42f21aa2
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Fri Feb 28 11:54:06 2020 +0000

    vt: selection, push sel_lock up

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124970ade00000
start commit:   c6017471 Merge tag 'xfs-5.5-fixes-2' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f6119e2e3675a73
dashboard link: https://syzkaller.appspot.com/bug?extid=3105793febc8f3e591ce
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124fc6c1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16cb16c1e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: vt: selection, push sel_lock up

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
