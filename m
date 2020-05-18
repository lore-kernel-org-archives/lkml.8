Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47222C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E7F20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giJxy9Cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgERHie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERHic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:38:32 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF03C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:38:32 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i5so9152067qkl.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q921Wgp+83ojYq38B4anE8YXdYXoDz1jeg8ReqzuEXI=;
        b=giJxy9CfFtsI3pCX1ReIwR8vC/K0BxX7Nkfr/SkEwxtnDujKapFJHW8vTw64H0LwSM
         IUF+/a2Aqd23a0XYewtEbhx7rvhPq1bVHrXCQIfbT1RvlwqKWosecjIXN1WHllHsQ/r8
         XkW52uXb+nMRelCaD4L41qDPwOLm5EkTnN8rqfHVa5se/EBGw6+zZQ5ji2Pd5Tb5J8v+
         6+yMEp0v+Psf6K9aTgjpuWooSuJx76jod0EMlIbbtbUmCDnk4C8Wd71LOqT2tbiRhzgL
         QFjoBn62GhVq8gATw8hOoMay16zPynLATbq5QgBOVEGZ48J07tjtWTvqvdFZOMSmtvLo
         uJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q921Wgp+83ojYq38B4anE8YXdYXoDz1jeg8ReqzuEXI=;
        b=OLZ/GfGwpIqdc/xq9OizQtgMTiKlBEQrcxN90lE4AwchSFoKt+UHHw2S1nIo7CeQ7e
         xQuD4ZjZdVwLOWPf58+QJyjtDQv5NkIU5Ez8h8d1xa1ak7JTpEny2oiZoEfOqxXFXdLp
         pGK4EPBtLTkaSaLyDCnYRzyY0NQWQSy7RcuPA0iC/w24LYzLH8RR+MBSz9cihrih+F2t
         ygW7rsyvwTfEnewCfHz2vh/6MN9NM+D+npwZrsxjcSWjqABe040Nh9knqgAEOBRq6IEh
         axI46JbU3/cK2AdtZCM9vZ8oyFiXsBNAHo6D8dLy/AER6sUSbn3SxuujrPHdzAiwmlXE
         KifA==
X-Gm-Message-State: AOAM533X2xvga7AL1nlI8mnASILk1nb0aHxnUKoZoZM3H/6GvAi/NP6Y
        vE9vDVm80WHbBYc1/LAOeb2MveLhLorzwjfXqwfrrQ==
X-Google-Smtp-Source: ABdhPJwjey5ko+TQxBWvYHoTRdpdfpR7G98YZUD9/ItzNmUxanirb5qlLE7MiuvPvpKt86nQmfeTd6+tLXO+XwbzrfU=
X-Received: by 2002:a37:4b0c:: with SMTP id y12mr13896802qka.43.1589787511125;
 Mon, 18 May 2020 00:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ada39605a5e71711@google.com>
In-Reply-To: <000000000000ada39605a5e71711@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 May 2020 09:38:19 +0200
Message-ID: <CACT4Y+bn1WFhHZkTJuvK+EDkOOMyMCkfbsfeW4uJ3Xnh0wY5+w@mail.gmail.com>
Subject: Re: BUG: Bad rss-counter state (4)
To:     syzbot <syzbot+347e2331d03d06ab0224@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 9:27 AM syzbot
<syzbot+347e2331d03d06ab0224@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    ac935d22 Add linux-next specific files for 20200415
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14b66e6e100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bc498783097e9019
> dashboard link: https://syzkaller.appspot.com/bug?extid=347e2331d03d06ab0224
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d18e6e100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104170d6100000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+347e2331d03d06ab0224@syzkaller.appspotmail.com

This seems to be related to the mmap/mremap calls, +mm/mmap.c maintainers.

> BUG: Bad rss-counter state mm:00000000a67744c9 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:00000000f49d6d70 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:0000000006212dd2 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:00000000b6ae35d3 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:00000000d44d5c2e type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:0000000023502204 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:000000001a912a5c type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:0000000072bd9e23 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:0000000053ee80f7 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:000000003cc0aff9 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:000000005a4ef043 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:00000000fe0ab895 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:00000000863004ed type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:0000000064449491 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:00000000f6a209ff type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:000000008100dc4b type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:00000000f80eb0e8 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:00000000475e50a5 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:00000000f2f5edcf type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:00000000bf721456 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:00000000d8d29ec3 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:00000000b5dff60e type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:000000001f0fe928 type:MM_ANONPAGES val:1
> BUG: Bad rss-counter state mm:000000006fc01973 type:MM_ANONPAGES val:1
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000ada39605a5e71711%40google.com.
