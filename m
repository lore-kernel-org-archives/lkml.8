Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C011C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1322074B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586317011;
	bh=wz+zOojkOgBUDnSmDA6ojneO9ESaji7hHwnvI6koPwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WnDy9PLuJTkSIg3tbWqlaofO+Emntilk5H1zkPCiutJyGwuCJIjf0BeL1HdWwiccU
	 knn46/nUMBjA8yl8s8fG3A3BVHoCdsdWKAVz2UucLlW9+5MQ0HjBTuLZssd/tM1P3Q
	 tcULvOrnGEfE86Nilotg0mKNduHJv3xwnmepQuZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgDHDgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:36:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38382 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgDHDgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:36:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id l11so4029051lfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 20:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJf9EXNj3y/TKHffW9ag62Sko1WtINX0aC0YEmTe104=;
        b=S5OUs8S2WPRcFflOiuuZsTxZ8A1VyAyMWTd+UIkBzHeqvN6tEv6DNT/Bpoq4rp7OB+
         ggO9z6fRYGobw4WBVT1GwWBGUhc1933I2vOXImxppct2Mq6upT6lf6wE5i9FG0JmTvnn
         rr5kl3i0aGePIwNow27mp+LGMU0yoljl7cDiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJf9EXNj3y/TKHffW9ag62Sko1WtINX0aC0YEmTe104=;
        b=GiFwmWifOcGuXgTeRkuGoVm4XN8rCoi+KAepZ1qSAM4OB/1nkaaslQx0rx+En+UjUp
         wGuRyfti0ZGLkJUoUnEqBvmdinJwXPUR8WhEJJEY+wXlNILGugAz9lcO4koF8tpMUR3n
         PF7l2r7w1o647UMonEEh/cP7v+qSlJFM5wM78SqS3Q+2pYNP5KhlBXwajQI0Rl2vgEJ2
         DVwsF1v4BJAm2m5ub9Px85rNoaGEYqUHTpJ69MfbytFp83bSutQFEtQukxR5sZj3JM2M
         kgeUbg46DwXE5Rv3q8JmkJC9LZec03ptyjuov2aX3IDohGROoXYrrgbrTkszZ58/nQpd
         8PPg==
X-Gm-Message-State: AGi0Pua8Vb2/bKo8cyOPFMfRWajRmgoBLfuNIXDoNNAy+jjn+Apd2aBe
        IEugykwLYMEGzRa+GBfPHdTFlN+yPwE=
X-Google-Smtp-Source: APiQypLRZVgYiHjQK6jMi+0vEOFREKcYATAebUBst9PD78sQ40NuPuIO1o+wfCzmbfwo/3MzzjubTw==
X-Received: by 2002:ac2:46f9:: with SMTP id q25mr3262941lfo.149.1586317005770;
        Tue, 07 Apr 2020 20:36:45 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id s10sm12978056ljp.87.2020.04.07.20.36.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 20:36:44 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id z23so4017378lfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 20:36:44 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr3241858lfl.125.1586317003620;
 Tue, 07 Apr 2020 20:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login> <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
 <20200403151223.GB34800@gardel-login> <20200403203024.GB27105@fieldses.org>
 <20200406091701.q7ctdek2grzryiu3@ws.net.home> <CAHk-=wjW735UE+byK1xsM9UvpF2ubh7bCMaAOwz575U7hRCKyA@mail.gmail.com>
 <20200406184812.GA37843@gardel-login>
In-Reply-To: <20200406184812.GA37843@gardel-login>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 20:36:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNuJaJS9Vfe83Tfgq92PonhpfLy1-vvG63SC=3VYf3+g@mail.gmail.com>
Message-ID: <CAHk-=wgNuJaJS9Vfe83Tfgq92PonhpfLy1-vvG63SC=3VYf3+g@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Karel Zak <kzak@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 11:48 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Mo, 06.04.20 09:34, Linus Torvalds (torvalds@linux-foundation.org) wrote:
>
> > On Mon, Apr 6, 2020 at 2:17 AM Karel Zak <kzak@redhat.com> wrote:
> > >
> > > On Fri, Apr 03, 2020 at 04:30:24PM -0400, J. Bruce Fields wrote:
> > > >
> > > > nfs-utils/support/misc/mountpoint.c:check_is_mountpoint() stats the file
> > > > and ".." and returns true if they have different st_dev or the same
> > > > st_ino.  Comparing mount ids sounds better.
> > >
> > > BTW, this traditional st_dev+st_ino way is not reliable for bind mounts.
> > > For mountpoint(1) we search the directory in /proc/self/mountinfo.
> >
> > These days you should probably use openat2() with RESOLVE_NO_XDEV.
>
> Note that opening a file is relatively "heavy" i.e. typically triggers
> autofs and stuff, and results in security checks (which can fail and
> such, and show up in audit).

For the use that Bruce outlined, openat2() with RESOLVE_NO_XDEV is
absolutely the right thing.

He already did the stat() of the file (and ".."), RESOLVE_NO_XDEV is
only an improvement. It's also a lot better than trying to parse
mountinfo.

Now, I don't disagree that a statx() flag to also indicate "that's a
top-level mount" might be a good idea, and may be the right answer for
other cases.

I'm just saying that considering what Bruce does now, RESOLVE_NO_XDEV
sounds like the nobrainer approach, and needs no new support outside
of what we already had for other reasons.

(And O_PATH _may_ or may not be part of what you want to do, it's an
independent separate issue, but automount behavior wrt a O_PATH lookup
is somewhat unclear - see Al's other emails on that subject)

             Linus
