Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE87C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 21:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7512098B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 21:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgIBVlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 17:41:09 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:45401 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBVlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 17:41:07 -0400
Received: by mail-il1-f199.google.com with SMTP id m80so770300ilb.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 14:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zYHP8UduVrprHqF64bsSb84lGj8UCXHH3vw/WRSp4Lk=;
        b=ThJw0veWB7Gbb2hfPAV08pHM7k7z83NA3388XNQ3fDTZKspXztEw6KpMm76/8c4h4F
         MWteqjpK269owcmL7rS/9yH0g/ICZVIYKIVC2d8UWr/Suu0W5EAPkM2OoShskZJFfNMc
         8xfSTw8cxHU155qedC+WFBW9rltkPNsyr79B6RNKczfRyZDdEzEN63exbvWBi1CaSHAt
         4kcCSK/7qU4a9cKPopzxsf8P+/EUfUkjv4t/E4cHdN0Dnxh8umCY/lVVo15T6p9prl/Q
         aHQ3V6TIRAhjc8CmE6fu++HaMtzjn4MEYf6580f5rjSYN+5BAJwirmrjv4usdC6909oL
         Y1Yw==
X-Gm-Message-State: AOAM532vGM0JJpEIOGhg7QiPPgHyg3CguP4kfgWRbeEQWU8rK4b7Fcwr
        iIbuDS6F0VrGNYB2rjRP3r8znSAmXHs5+VFYIcYKvrVAo4d+
X-Google-Smtp-Source: ABdhPJzwb18iZGt0VuWOjCyns2qo393k1g5sM41Eny5nqT6RjGgPAom0iTU28KrEcsdItQWpIqHZ8Qp11pXPX90RStQlQhVETdRf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ca3:: with SMTP id 3mr215750ilg.227.1599082866022;
 Wed, 02 Sep 2020 14:41:06 -0700 (PDT)
Date:   Wed, 02 Sep 2020 14:41:06 -0700
In-Reply-To: <0000000000002c6fbf05a8954afe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032273905ae5b7ee1@google.com>
Subject: Re: BUG: sleeping function called from invalid context in do_user_addr_fault
From:   syzbot <syzbot+7748c5375dc20dfdb92f@syzkaller.appspotmail.com>
To:     bp@alien8.de, daniel.vetter@ffwll.ch, ebiggers@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 033724d6864245a11f8e04c066002e6ad22b3fd0
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Wed Jul 15 01:51:02 2020 +0000

    fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=156ad38e900000
start commit:   7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=183dd243398ba7ec
dashboard link: https://syzkaller.appspot.com/bug?extid=7748c5375dc20dfdb92f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1469d28f100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
