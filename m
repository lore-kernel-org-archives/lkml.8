Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9169C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B651320728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgDWRUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:20:03 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:53732 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbgDWRUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:20:03 -0400
Received: by mail-il1-f200.google.com with SMTP id 9so6306982ill.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4mHKeAyAGDDsSPX7mqI92rd3yyYuGCPiX2VzFqgkLt0=;
        b=AKyB0+xcpxYeWEGebamLZEKTqAzRWqCrHHR3D9KGUkNUDccoDaDT3Qmk+Zk5n6xk9B
         FDhV6etJGoJZoqcTERam3+xfm42zHNKLwvA8aJ6ewEJM7WARJsqZPDw/JEfqDtf5n4uj
         H+hZbBevm7PPQTj0TLlbtMn+H3YjQJexwzTwtOzXzItidVpi2ToQ2aK/If51LrebyuJk
         8MzyehURv6pTisMGKq2ZRaSZH8//ewErjkBdzm1ZlHtPhaXbNCHFff0RBXcVOotikwJu
         uSv+2ob9LPr5zkHy3N1q5jNiCsZt1DDQmz6MBJQsSycXtJLxasDeINXwQTpx/E2abjKZ
         WPHw==
X-Gm-Message-State: AGi0PubiYJgoc2mQj/YmZPG9uqkLOovi2t75RYze1XZFSdpwT2qF4343
        lylN2DtOEcvbAGG5uNc7mcHIX3BN7uxbsNO2XBzvH/E0sFi6
X-Google-Smtp-Source: APiQypL3/Yll+s/nR/T7aWG5H5r0GMTjZ+XDNfQFUpGPUOlIZiYuDIrlgjwlvi0UJ9oFMUvbGMpJcF1eGb6b/taoe3T0JYP7C2Ye
MIME-Version: 1.0
X-Received: by 2002:a6b:7302:: with SMTP id e2mr4356263ioh.98.1587662402406;
 Thu, 23 Apr 2020 10:20:02 -0700 (PDT)
Date:   Thu, 23 Apr 2020 10:20:02 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004231235560.20147-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084cea205a3f875bd@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
From:   syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=db339689b2101f6f6071
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1027bca0100000

Note: testing is done by a robot and is best-effort only.
