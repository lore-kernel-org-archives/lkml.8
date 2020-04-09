Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF76C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819BE20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586449487;
	bh=aOypcGOyYZsoma1DrxIATOhd4yXwxGgHbRtYlf4uBks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BOlGI5YV+D6zUIDD7vV5Y4XsBrsatyko3syAP3wWoimFavc0jMmVYny343wE5CKO7
	 Z6nBskE4+dgL8a7DNzQjIpzAgnJFIz4m8N20K8qSqtIEq19USQLJPLnzlcYPwW8SCd
	 kQ4IuM5YVhd8UWTX6Pghs1XkJiaOYU/U9ZRbl3XI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgDIQYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:24:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42284 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgDIQYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:24:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so269710ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjLWyj2I8ZRXEcsoPUZe3EIP3uQYRCpk96HRwzVQbnk=;
        b=I/lJYU7leajBNnvPyJmu6JLbCzcS4aB0IAW3HpvOjsTvVp86bGB1//YtEsGZdpJIvm
         ADahpdwELjtXyCLmLWFUZwXs2y++7nXzUlMnKgJDCKovBNJjakJuRTWzd/n7YSMXnSUy
         UVXz/A9ZRAvYV6/a4QkA3yNxMrVU5EBlrMOkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjLWyj2I8ZRXEcsoPUZe3EIP3uQYRCpk96HRwzVQbnk=;
        b=QNjfM2fD/uqXlQzgUPXbR8VOGVE5Ltt3tQgtjOLIIdUpgEl8a1VykqcWEHGIHOwZkx
         YttTCDJqp4LT520g1FV/klc763iXb318Y2DQuBVfNBlfzZO7HiDgD5ujg8n0B972IZwT
         /tfXGDRquZygMY4EZ8iD5Bv26bYSiJtvkc1NfiREZkmOutTawmtstc/ubpbikg3BywRn
         Jq0ph0m2YUsuH3VaT/0lpIsFOiXCSNOBE40nmZOXC+HEVjXcotKyoIDPBufqDPcmq2RX
         lBucP0aKCdoFcN/tM4/FTlUkirlnd/XvAI+75R4IrOgNqF4K2v6VN+raaER3uvXJsP8r
         btsQ==
X-Gm-Message-State: AGi0PuZ0PBFmfQhtsZ31esrDNWs2VqrEbWxi5SKxS1G7iMEFALCDk/D5
        zvKxHIuEqQ2xVTjNXaHcYdlMdNJL16Y=
X-Google-Smtp-Source: APiQypLbS0eDDyXalYzbSxKuPIA8u76kdAeZ7VhuQgjii2eE+uZemgmNouXT+IM3Owj5KFbXloaSxg==
X-Received: by 2002:a2e:9959:: with SMTP id r25mr371138ljj.200.1586449481748;
        Thu, 09 Apr 2020 09:24:41 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 64sm10441838lfh.32.2020.04.09.09.24.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 09:24:40 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id r7so239749ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 09:24:40 -0700 (PDT)
X-Received: by 2002:a2e:870f:: with SMTP id m15mr387502lji.16.1586449480215;
 Thu, 09 Apr 2020 09:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org> <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org> <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org> <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
In-Reply-To: <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 09:24:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
Message-ID: <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 9:15 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> may_ptrace_stop() is supposed to stop the blocking exactly so that it
> doesn't deadlock.
>
> I wonder why that doesn't work..
>
> [ Goes and look ]
>
> Oh. I see.
>
> That ptrace_may_stop() only ever considered core-dumping, not execve().
>
> But if _that_ is the reason for the deadlock, then it's trivially fixed.

So maybe may_ptrace_stop() should just do something like this
(ENTIRELY UNTESTED):

        struct task_struct *me = current, *parent = me->parent;

        if (!likely(me->ptrace))
                return false;

        /* If the parent is exiting or core-dumping, it's not
listening to our signals */
        if (parent->signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP))
                return false;

        /* if the parent is going through a execve(), it's not listening */
        if (parent->signal->group_exit_task)
                return false;

        return true;

instead of the fairly ad-hoc tests for core-dumping.

The above is hand-wavy - I didn't think a lot about locking.
may_ptrace_stop() is already called under the tasklist_lock, so the
parent won't change, but maybe it should take the signal lock?

So the above very much is *not* meant to be a "do it like this", more
of a "this direction, maybe"?

The existing code is definitely broken. It special-cases core-dumping
probably simply because that's the only case people had realized, and
not thought of the execve() thing.

            Linus
