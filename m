Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F29C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB5C20782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0YmWV1n0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgDTU0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgDTU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:26:35 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81851C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:26:34 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g16so8515986eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwUPCWKp0XjwepXQOmIetCoyqhWj31DcYHiSp/UXrjU=;
        b=0YmWV1n0z4XY862A56LDL9361hcUyKkvjduePmlWXnKre6rH3zuS2lFpfDJpRnc27j
         qk6MKZWa1lYLFvgYbBc0dM5AhoXm/ZdEull8BAqiHShll2GfzVYe/Mgd8yFymvrZepRx
         HK2CH461EJMbYocppHf6HjwMeCq+44KqJHni9CtwxWFh36TKIix0Uyg7akZwibmmBOLl
         b4T7kRst9+BDXIKGZbcZ51LScJmLrRk2j6bvU1SPbExbSvouyA5mf76M960lsoWcCowM
         nWd1JjYNlMOIWTNIU7hH31nMtlM20n5+wVYhsxgRPmJ/nf+XREzaccj/S7IvZPZqROc1
         W1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwUPCWKp0XjwepXQOmIetCoyqhWj31DcYHiSp/UXrjU=;
        b=ZonQ2Fsq74tVxMPFxjehohwBkcDv6E57sK8NodByRF0qyk7iN5MiDDIZfFNy3R0CiB
         /grKX5fRBwI2B39OTzRyk9b0tn7A4Yjo9Gtq5952x5RZ84OTESQu9FDmDMdnxJz3dU9h
         410qtNu9dvOiMn+hkVRKCYBl994y3jWu7vClVlwUgSgJO5uAp9Fn8apDVuAboN8BXwGa
         WiK+VHtqVx9RBuf6FDpyeHzFOGsenX/ZjsZkfSwVhHMKlatgSlye7gxMAQStPyAfRU5U
         1jWONzl6NYabmvK24iY5AfJrU82tZ/JggDBndFE/rD82jqG8f/RpIbaaCDhKfdtk6wew
         GXhA==
X-Gm-Message-State: AGi0PuY5RfpWbfT6XsGUyWPG5bmfcf9a0LTkZkuyUUn5enaSXc6HTgAB
        bfDnecOAhCpyGEX8xpzq8IW4uiVvs81NObD4joeX
X-Google-Smtp-Source: APiQypJPD/FkR6eQInJaCe11axRqNxPjye0HG0pNX0w10VJWP4Vuxwr6q4w9/9a603DJDHR6p9S2rG2NX4NP4J8beZA=
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr16361574edw.128.1587414392996;
 Mon, 20 Apr 2020 13:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000064f6e505a3b243aa@google.com> <CAHC9VhTZ_itetT4cx32vW3A79tb76dzjaBC_0S8Y_=DcEBL2nw@mail.gmail.com>
 <CACT4Y+ZUpH3giZmiA51NZ1BhHOoGETqfxscBW6kBxWDf6-Q-HA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZUpH3giZmiA51NZ1BhHOoGETqfxscBW6kBxWDf6-Q-HA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Apr 2020 16:26:21 -0400
Message-ID: <CAHC9VhQOvA8-9wCXn1CV4iz_OtoQAaAv9gS+kWsitU3-axsbzg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in audit_log_vformat (2)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+49e69b4d71a420ceda3e@syzkaller.appspotmail.com>,
        Eric Paris <eparis@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        linux-audit@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 2:12 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Apr 20, 2020 at 6:29 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Apr 20, 2020 at 1:35 AM syzbot
> > <syzbot+49e69b4d71a420ceda3e@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    5356842d [EXPERIMENTAL] kmsan: eagerly allocate shadow at ..
> > > git tree:       https://github.com/google/kmsan.git master
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=12f06720100000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a5915107b3106aaa
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=49e69b4d71a420ceda3e
> > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > > userspace arch: i386
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133b5dabe00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143e1610100000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+49e69b4d71a420ceda3e@syzkaller.appspotmail.com
> > >
> > > =====================================================
> > > BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:608 [inline]
> > > BUG: KMSAN: uninit-value in string+0x522/0x690 lib/vsprintf.c:689
> > > CPU: 1 PID: 8854 Comm: syz-executor694 Not tainted 5.6.0-rc7-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0x1c9/0x220 lib/dump_stack.c:118
> > >  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
> > >  __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
> > >  string_nocheck lib/vsprintf.c:608 [inline]
> > >  string+0x522/0x690 lib/vsprintf.c:689
> > >  vsnprintf+0x207d/0x31b0 lib/vsprintf.c:2574
> >
> > Are there any ongoing problems with [vsn]printf() in the kernel at the
> > moment with syzbot?
> >
> > I ask because on first look I'm not seeing any obvious problems in the
> > audit portion of this code path.
>
> None I am aware of. Alex?
> Can it be related to data_len==0? I don't see any obvious checks for
> this. And in that case will 0-terminate out-of-bounds (at offset -1?)
> and print potentially uninit data. But I looked at the code only very
> briefly so potentially I am totally wrong.

Bingo, that's likely it.  Thanks.

I was in the process of fixing another audit bug when I looked at this
and got fixated on the varg stuff, not the variables themselves.  I'll
have a patch out later today.

-- 
paul moore
www.paul-moore.com
