Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E204C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B17D20809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgG0V0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:26:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56335 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgG0V0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:26:06 -0400
Received: by mail-io1-f70.google.com with SMTP id f21so12221694ioo.23
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=C9mzOQpMUlCYKf2m16G2hyBLpPVpFOrRAgbuBtFCLhg=;
        b=qw4VcR254I2WjoddcZqP3o0JG+IzGQwcw2sDHeBkvbee8TtMMTBSnICvXVv/GytpPN
         m6J+efJH5W+Ypvf2Ppq2PaHkPwRgMsQbLWzcrzlcRxvXDRRQjoy0COftA6jdDhl8wm81
         HQjEmQpud4Um5uI4hWzKbgUx6W2dbunx6lr+Mu3Pi5Lu679yVvLtmx/QvhK5cPhUlSvC
         D0k+IA19OjXsgTpVxp7Gsb8wZ2kImvqqfy4+j7we3v8Um2PFir6N20xkJY/aqcBaF1B7
         bI9A0/JpkTgAzE3dIU1boHhiTzNcNWPtHL4bOaK9LD5cy7u60ddkth+QXfM5BpUHyNGv
         P/ig==
X-Gm-Message-State: AOAM533HtWGeGQwtaOXuTFfMlJShvy+YyxX2fTM4T5Fj1DRaCo8KajH3
        u4AiqCyP9NzwsvKSsyAGfNJa9p4a+7JeJtQEEoUDINa6lefd
X-Google-Smtp-Source: ABdhPJz18y1AdlDdgyG6yqNd6AaeSLfn7Lt+IYO+uB8XlBLqcd7KMKTTICdULPavX6foDq4kV2IpCFdr8O/JSJ+q0F/uVlJEHqxA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f85:: with SMTP id v5mr24871365ilo.31.1595885165853;
 Mon, 27 Jul 2020 14:26:05 -0700 (PDT)
Date:   Mon, 27 Jul 2020 14:26:05 -0700
In-Reply-To: <000000000000dbe36f05996858db@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069c23105ab72f8f9@google.com>
Subject: Re: BUG: unable to handle kernel paging request in insert_char
From:   syzbot <syzbot+6a8d618862e1fc55313d@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit ce684552a266cb1c7cc2f7e623f38567adec6653
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Sun Jul 12 11:10:12 2020 +0000

    vt: Reject zero-sized screen buffer size.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14357d8c900000
start commit:   510c9788 Merge tag 'Wimplicit-fallthrough-5.5-rc2' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=6a8d618862e1fc55313d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ed05dee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e569b6e00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: vt: Reject zero-sized screen buffer size.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
