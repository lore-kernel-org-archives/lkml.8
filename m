Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B61C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 11:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35712071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 11:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgAZL0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 06:26:02 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:35364 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgAZL0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 06:26:01 -0500
Received: by mail-io1-f69.google.com with SMTP id x10so4325500iob.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 03:26:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JBFyGLFaRClD3Lq6gKSOhEwna1ahm2jFZCVvyRd5gTk=;
        b=pbEgg04rPMxXM5wFjwkfMUE/Lm2RI2pCPes3TzdU9hL037gWSbGObJxIl+ZgXAsFZf
         Foa0Idi6U/ywiijc8i5xxDqcyOuPNg0E9H52ukVNAF1OZ1yNCyqPsEZCPG5fUSiXT8h+
         NjS43yFx9VA0u+h7/Gk1f7uKEBmGu9Rz+9CX0Y3GJdgFeDJb8Hcyi0nQ8CuIVvSnJ1Tr
         daczPdPX4yNOOy1/jauh5hxkEyE/kue8HpG8LssRnR3RTpfTqSZjN20cWqvrRmEwzML+
         U4xyJPmklyUUUJeBajdf61MB9UkezhONNW4y/q7vMCPHqlAxcGvOH/Bg4QfzaQgR+uUH
         4GYA==
X-Gm-Message-State: APjAAAVmDemE5DbpXvPgHfhSzm76s4/nqpzsvNG70jzHVaoqqkTKWt9M
        DApelsKITCtlalIr2ZsAMxeBEQjxyQ7D0hrg3xrVp+8J9cHz
X-Google-Smtp-Source: APXvYqyLaYc8gQfvUmEZVQhOZ0IYO/h52y/zmcO+U/WovieEJvKF5cOH25qr96Of+NGMIr4NK7EOiIp4DxSEObgLp7vhlByfHaDo
MIME-Version: 1.0
X-Received: by 2002:a92:8307:: with SMTP id f7mr10993148ild.73.1580037961001;
 Sun, 26 Jan 2020 03:26:01 -0800 (PST)
Date:   Sun, 26 Jan 2020 03:26:00 -0800
In-Reply-To: <00000000000044bcb8059a0a577e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065b384059d094190@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in vc_do_resize
From:   syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.thompson@linaro.org,
        daniel.vetter@ffwll.ch, daniel.vetter@intel.com, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        nico@fluxnic.net, okash.khawaja@gmail.com, oleksandr@redhat.com,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com,
        textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 9e1467002630065ed86c65ea28bfc9194fff6f0e
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue May 28 09:02:59 2019 +0000

    fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with direct calls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=135a779ee00000
start commit:   d96d875e Merge tag 'fixes_for_v5.5-rc8' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10da779ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=175a779ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=c37a14770d51a085a520
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1659a721e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16aa59c9e00000

Reported-by: syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com
Fixes: 9e1467002630 ("fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with direct calls")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
