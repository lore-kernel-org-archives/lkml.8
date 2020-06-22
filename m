Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2AB25425
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyF5FuUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgFVGm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgFVGm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:42:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D935EC061795
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:42:25 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u12so1442345qth.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UhciZLVdGKEJk7KHTw+RU8JWs5dQKAECyz5UjSzBrP0=;
        b=EyF5FuUsWQitHjx7BN4lfK2XcWY7vlK1Elm2C5+czbIrJnmhqFTAkpW5dNchOjMYQa
         m2TLVe5resLpBBx6d16MAKG8YbkEM7gSyEr0VRWn6GoH7+uEoEW090OfViix7wAoT/6E
         vP8jz4YaO+TAiSfGRcxcZLnf94KukhpdZugyRYd9Cr/xOsWN93pQOg4ZrSpwwQPypW3y
         Xc/FL4aARuZ3E6Aoh8B/DXUBsDQxJ6n0Ey9MzbMssaMalGxbbiW+y4MMWDiQ8/y80Mhj
         SOLke1Gc4AIHcB/xAxa07KjuW2Gin3VRjJaRkMucEqOZeq60mtVn2HfRwq97kVDrfsgb
         jZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UhciZLVdGKEJk7KHTw+RU8JWs5dQKAECyz5UjSzBrP0=;
        b=Vlf3co3m8v949jN60Nh4jZiB1+TePnFzY/NkSwnhg/DO0b9HX9oqMY90RfAzOcpPL9
         5whpygd4NFmqSOHOlELvc4zGFGFJKrveokIg8vmeUXrL2jUZSlU2DIN9DSt71mq/ApI7
         ZwggDxeqTIuZcb6a9CYda1v2rBfq1g6o+PvwLu8oE1N16kvXbq1tfKNqBtIJGXwNO7D7
         xt9nD5Lr9NeYgy19c3fKF8z2jMbWIiJVHGJfNt0Q8Jm2rl8Cm+mIr/ZNSIdXnZ6JmzIA
         wsRzLW3SfpfMULeSQvqiISePzmS9V4Hh2Z6iDdmzcrp+xNT6+4k4JpWQO06nFEP2R3XC
         hNdQ==
X-Gm-Message-State: AOAM533cbgtsCBmvdN3+tNKg+fbeEBvzKBRz2SaAuP9WsjFc+yQf4dC3
        xFG6vzzcLg6AYPCmdLN0lGSq/3GYejtHb4JYes5MjQN2
X-Google-Smtp-Source: ABdhPJxrXaR2MRdiPAJU6NZZSqPOj09boIx0YXa64M3CfHeEi2VvHVT8MYtt4nmImQOknEhCv3I16YGiBoKqk30+teY=
X-Received: by 2002:ac8:36c2:: with SMTP id b2mr15006149qtc.257.1592808144668;
 Sun, 21 Jun 2020 23:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000617f9d05a8a5a2c4@google.com> <4A35E92B-9DEF-4833-81DD-0C6FA50EB174@lca.pw>
In-Reply-To: <4A35E92B-9DEF-4833-81DD-0C6FA50EB174@lca.pw>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 22 Jun 2020 08:42:13 +0200
Message-ID: <CACT4Y+ZcbA=9L2XPC_rRG-FdwOoH6XteOoGHg7jfvd+1CH2M+w@mail.gmail.com>
Subject: Re: linux-next boot error: WARNING in kmem_cache_free
To:     Qian Cai <cai@lca.pw>
Cc:     syzbot <syzbot+95bccd805a4aa06a4b0d@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 8:29 AM Qian Cai <cai@lca.pw> wrote:
> > On Jun 22, 2020, at 1:37 AM, syzbot <syzbot+95bccd805a4aa06a4b0d@syzkal=
ler.appspotmail.com> wrote:
> >
> > WARNING: CPU: 0 PID: 0 at mm/slab.h:232 kmem_cache_free+0x0/0x200 mm/sl=
ab.c:2262
>
> Is there any particular reason to use CONFIG_SLAB rather than CONFIG_SLUB=
?

There is a reason, it's still important for us.
But also it's not our strategy to deal with bugs by not testing
configurations and closing eyes on bugs, right? If it's an official
config in the kernel, it needs to be tested. If SLAB is in the state
that we don't care about any bugs in it, then we need to drop it. It
will automatically remove it from all testing systems out there. Or at
least make it "depends on BROKEN" to slowly phase it out during
several releases.


> You are really asking for trouble to test something that almost nobody is=
 exercising that code path very well nowadays.
>
> Anyway, there is a patchset in -mm that might well introduce this regress=
ion that we could go to confirm it, but I kind of don=E2=80=99t want to spe=
nd too much time on SLAB that suppose to be obsolete eventually.
