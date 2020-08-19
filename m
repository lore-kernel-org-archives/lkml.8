Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8564C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E572083B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgHSOvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:51:14 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:55735 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgHSOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:51:06 -0400
Received: by mail-il1-f199.google.com with SMTP id q17so16883305ile.22
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 07:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=L7T0UptgHYmri7SaCGXWygzaLJh2phRnY0wB5fixdgI=;
        b=G/hWzhQFS7T/ffbUrXJKY/U9u7U2PGkKfEj+6BEsxrTnbQMr0i/8kseaD4Ymw73cBA
         wBAG+q9qSDdqF42Zrb6Zs09lMYn3DytogXSuakvfigfYvQVXSSOfGUbTpgE9HbAlQcQC
         WukXnMkt3ePZU2BtlWhr5PN462jpeQ6Mav1+RlzfBzI8f9wJ3FRrCmii63hc6D2rTkZB
         DMSqvhFqju+x3nV3mBRoXCH+7JH2WhGMFWFkfnVn3gI9FRdnGUYGZXXzb+jCTfpL5nS0
         2juLjTpzZpCN6Y0sTtZgXIRTlatPp7nJIE21avDEPXT4bZ2eijPzqopg1/CzVsUdcoJY
         nLNA==
X-Gm-Message-State: AOAM5315sEWoV+0ETZvjTMqYYcrL4VB6MgFI4nDN+p0P1qmQB1M5STRq
        lLSEFQhZJLzENrVEPc4gGu0Q179l34Ro3cNXaCsLqxL68g/P
X-Google-Smtp-Source: ABdhPJw8Eul5BA7PMHLOe+q9UZT4RyJM5c/bIGJstDY4zpBDZ19RM9Uzxo9blXQp3uPwrJTIFVk3E4JNQ3rznpSbNdvNHR3LHUnk
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2417:: with SMTP id s23mr19902065ioa.94.1597848665416;
 Wed, 19 Aug 2020 07:51:05 -0700 (PDT)
Date:   Wed, 19 Aug 2020 07:51:05 -0700
In-Reply-To: <000000000000568fc005ad3b57c3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b6bb205ad3c222b@google.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free (4)
From:   syzbot <syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 449325b52b7a6208f65ed67d3484fd7b7184477b
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Tue May 22 02:22:29 2018 +0000

    umh: introduce fork_usermode_blob() helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f86186900000
start commit:   18445bf4 Merge tag 'spi-fix-v5.9-rc1' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13f86186900000
console output: https://syzkaller.appspot.com/x/log.txt?x=15f86186900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
dashboard link: https://syzkaller.appspot.com/bug?extid=df400f2f24a1677cd7e0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15859986900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1228fea1900000

Reported-by: syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com
Fixes: 449325b52b7a ("umh: introduce fork_usermode_blob() helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
