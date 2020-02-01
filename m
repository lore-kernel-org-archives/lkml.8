Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC42C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 13:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEF0206E3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 13:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBANhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 08:37:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58232 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgBANhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 08:37:03 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixsxJ-005jfR-JB; Sat, 01 Feb 2020 13:37:01 +0000
Date:   Sat, 1 Feb 2020 13:37:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+32c9f7d8a32ea5127669@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in do_dentry_open (2)
Message-ID: <20200201133701.GI23230@ZenIV.linux.org.uk>
References: <00000000000091cacb059d809681@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000091cacb059d809681@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 01, 2020 at 01:48:11AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    c677124e Merge branch 'sched-core-for-linus' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=157511bee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9892b0ce783fa
> dashboard link: https://syzkaller.appspot.com/bug?extid=32c9f7d8a32ea5127669
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1476cf66e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1640085ee00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+32c9f7d8a32ea5127669@syzkaller.appspotmail.com

security_file_open() or ->open() of some file returning a positive number.  No way
to tell which one (or which file had that been) without a reproducer...
