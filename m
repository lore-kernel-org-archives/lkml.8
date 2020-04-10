Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909BCC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B15C20757
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W13t47Ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDJHa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 03:30:57 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35705 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgDJHa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:30:57 -0400
Received: by mail-qv1-f67.google.com with SMTP id q73so590824qvq.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zE293TlPY0PXIZoxGZ19deIGVNU/dNrI92J3h9QNCoc=;
        b=W13t47HaMfh4V3Q9wpYP/1p+LWRs3rS5DG+rf1Pb4YFwCQ9E0jzBCXWGQQclAjirqn
         RRiqBP6jlUwQtYtigLt2fdnLwRUUoasQ37BKz6SELgrDk7qt2CC1b1uXXK3sDI7IFnJC
         obsEAVKAhvsELlrAHqdplaAxarpCWHeGwCjeCUHORByf9sjpmQ+4PGsODhPa0K0aLXP8
         wEPQ3kdlH9fr0x+ag5lPvaFC2Nay5yyvLS1MsGYBgeQRxzXO+f9L6nKcSijEXvC0bVom
         0DBhMFg2FU92AegBkpqMizT8WlrHg5rShEk519QOMCQTB/uCsuEP5rjfgy5Z4DF9cG1T
         Bazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zE293TlPY0PXIZoxGZ19deIGVNU/dNrI92J3h9QNCoc=;
        b=r6O+MhKB47vp6lWal0o+iAKXdq8XV8q//C7lIJfJwHfPx18d4fSdNM09ZldjCI/RTX
         q0L49vK/dqlSBQEKBGgt/SEErOws/LJqG1BO0HBhrXH2aKW/rSVxi0jP62CjaevgBbwD
         xFwVk1itrPa+ZKEJhqvrkVp/Fl+3sHUPKYX65YI74gyaJUWuuWoU/n1rLJaZt+1gl0RS
         9/ncLJgZ3xC0Pr6UtJ+AVSZr9zUM676M252hwYrlTsM7TSqyV7yV0isqAu61zkc3PKN7
         Q99fynWomX/zak86NZy4FH8GnafAnICc2k9y69reEXS/4/OU0UYR6C4Iuqd1nzbB99z9
         zxBw==
X-Gm-Message-State: AGi0PuY4iPdD2uWef6kk5XcqzFrMspomRwwvENqa94SHWtdlRMwbyQxg
        k8fH3/T5PEF/ASk+LzrGlhN0i4/or9DfdnV6cv0c+w==
X-Google-Smtp-Source: APiQypLFXroO3aDs139N5y+NKyobDIMB16yzh/nEcvFBWWT7zMY0ayKhEl1sUwexcYBE6ShfizIc2JEte3Mud+3ekrs=
X-Received: by 2002:ad4:5051:: with SMTP id m17mr4108363qvq.122.1586503854690;
 Fri, 10 Apr 2020 00:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cbd2ec05a2eab0a3@google.com>
In-Reply-To: <000000000000cbd2ec05a2eab0a3@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 10 Apr 2020 09:30:43 +0200
Message-ID: <CACT4Y+aZruGLZuaEDavwpJgCCS1+KGSu9DThhkdOXCqiYi8L3g@mail.gmail.com>
Subject: Re: linux-next test error: BUG: mismatching fuzzer/executor system
 call descriptions: ADDR vs ADDR (3)
To:     syzbot <syzbot+528253fcf7f3c9d2747a@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now fixed with:
https://github.com/google/syzkaller/commit/2f886fb32cd97875de4a67dfb04c90d925b7d73d

#syz invalid

On Fri, Apr 10, 2020 at 9:29 AM syzbot
<syzbot+528253fcf7f3c9d2747a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    b2e2a818 Add linux-next specific files for 20200406
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12ff05fbe00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=595413e7170f444b
> dashboard link: https://syzkaller.appspot.com/bug?extid=528253fcf7f3c9d2747a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+528253fcf7f3c9d2747a@syzkaller.appspotmail.com
>
> Warning: Permanently added '10.128.1.24' (ECDSA) to the list of known hosts.
> 2020/04/06 07:22:58 fuzzer started
> 2020/04/06 07:22:59 connecting to host at 10.128.0.26:46701
> 2020/04/06 07:22:59 checking machine...
> 2020/04/06 07:22:59 checking revisions...
> 2020/04/06 07:22:59 BUG: mismatching fuzzer/executor system call descriptions: 670a1e865c0bc7d60e9886acf4666ee3677e346e vs f787d115f9efa49fdd59261850f5c05f43fbe327
> syzkaller login:
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000cbd2ec05a2eab0a3%40google.com.
