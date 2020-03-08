Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348E8C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041FA206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583684967;
	bh=h6bh4lUB4o8beGo2LEzYsT2Oa/+jsxvEQGwlKbWSiyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MgGvnp0sYZ+QPykeZXVCHm6Z5Ap3jIfiFZiaAsG/hoeYMY9iVKeYQBKH6/tjg7NZd
	 opXiioYChwS1hAQ5h/OByf5MeJnS7zWi9/vZq4ECb60yI781DnR0pfaEXKTsoY2/WC
	 zQNOrm5jyE8Da9/ycAy1OcETCQrSx5gTnYRLAVKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgCHQ3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgCHQ3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:29:18 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D381208C3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Mar 2020 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583684957;
        bh=h6bh4lUB4o8beGo2LEzYsT2Oa/+jsxvEQGwlKbWSiyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ocKfrLh0a/K3Vo79AoR3e9vZpWHNw74rkjabIivlTIibje6SNISOjo2M7IXrGhYIl
         7iXBsaPyffaYZoMVIOPxHtj+pg3gXpGeeW6ApS2i6BYSXcqqrmKyg7VzZxJXkSnsk4
         fzpl8ZGn+HnS4qtQzGALfFAljXjIfwn6Ur/Sw1YU=
Received: by mail-wm1-f46.google.com with SMTP id a132so7435817wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 09:29:17 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0/lGKlxSJuvxiBChayiBWnVOVeAP7Xm0nCyS9nE9xDyVKkOPyy
        QID3s3nxGAnXVlGmxsrRROk5E+Ag0Z0ExUxnOv9AAw==
X-Google-Smtp-Source: ADFU+vsCizjuQ03ySjWKPleOVT6PaTxr+ozJy7oKPuRZh/OUor8MQAngDU6ApmgxbREZ6k5L5xVHRC6vydU2mv7yDAs=
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr15512359wmi.21.1583684955840;
 Sun, 08 Mar 2020 09:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ff323f05a053100c@google.com>
In-Reply-To: <000000000000ff323f05a053100c@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 8 Mar 2020 09:29:04 -0700
X-Gmail-Original-Message-ID: <CALCETrV-wMcO8eqzzQX1Jh20Zn-mEkYpQbd+cfCdcgV+AYsaKA@mail.gmail.com>
Message-ID: <CALCETrV-wMcO8eqzzQX1Jh20Zn-mEkYpQbd+cfCdcgV+AYsaKA@mail.gmail.com>
Subject: Re: general protection fault in syscall_return_slowpath
To:     syzbot <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 7, 2020 at 11:45 PM syzbot
<syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16cfeac3e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> dashboard link: https://syzkaller.appspot.com/bug?extid=cd66e43794b178bb5cd6
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a42329e00000
>

I bet this is due to entirely missing input validation in
con_font_copy() and/or fbcon_copy_font().
