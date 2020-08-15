Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1237C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7BD22BED
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgHOV7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgHOVvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:42 -0400
Received: from mail-il1-x145.google.com (mail-il1-x145.google.com [IPv6:2607:f8b0:4864:20::145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B612C08C5ED
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 03:18:09 -0700 (PDT)
Received: by mail-il1-x145.google.com with SMTP id i66so8287636ile.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 03:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aSMYatUGNqv5jWLXKfM6VYDCIDAFgzJgx/5GgNSFP4s=;
        b=tUATX8PPYoXt7M3zDZ55qKyMQglHSBvgqDbE8wp5wrm/TZ+/Wwkx/Sgsc4w2gPDAfu
         6Pj1LdVKYm9wk27KtAWvyxRnzyn+bVOFfwMzNZIm7dWZqTNZENgnvz+LIZnscCpvXCiU
         l7xbWWfEZt04umeJ1EGlxHNY2RB/vtSf3CWqZtPaS+Q800G26rSVK+v1wU0RuJrLr6XZ
         k3sUegRxUfQjR7lqjzowMYQPF89/t8huDqmuzdmlkcLXjU0+QJjGrxTFrqe1uMNpnZJV
         JyoWwfM5184zvQddl5ilIOHFLPBS1OyR9nS/guXo92uVMZ4w4fUaERGL5zVIGVhfAlCR
         2X8w==
X-Gm-Message-State: AOAM533DZr5DB0cnLecEqQRlGZW91x67WCRo4bwEcMYE86tsdXukZd2b
        MxotSzgeMJfmYzgJ33YpXByMvHAkBbJAwrifNGPG6+lDINwZ
X-Google-Smtp-Source: ABdhPJxa9WohqkoJcux/K8+Cn7Cm1Tp8E/EBpa4BoOZW/55b+UPuL60utKTAuqde6IT36lWruGC7XaYYmAtA/9xMATE9zbYd1D+t
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ea3:: with SMTP id u3mr5809783ilj.49.1597486685361;
 Sat, 15 Aug 2020 03:18:05 -0700 (PDT)
Date:   Sat, 15 Aug 2020 03:18:05 -0700
In-Reply-To: <000000000000ff323f05a053100c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a1b9e05ace7da39@google.com>
Subject: Re: general protection fault in syscall_return_slowpath
From:   syzbot <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com>
To:     bp@alien8.de, dan.carpenter@oracle.com, daniel.vetter@ffwll.ch,
        dvyukov@google.com, gregkh@linuxfoundation.org, hpa@zytor.com,
        jannh@google.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, natechancellor@gmail.com,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f979f6900000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=cd66e43794b178bb5cd6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a42329e00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
