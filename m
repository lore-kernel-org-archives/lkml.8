Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C391C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13AF20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qazYXUmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389293AbgDBRUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:20:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39861 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389165AbgDBRUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:20:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id a43so5241593edf.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8EoII7z9i5h4OnvIq0Rj015ZeVzlUXsiRDLRpXTqXw=;
        b=qazYXUmbDRgfAw8MLzT3O7+59Pt4zqcbTg4g0l/11y7Dr1rCScxhqWrtzb5yM/chh5
         xRLOjQHXW3454+bqFfrL1FiSjO9gPgydQ36xBjx2kVTf975fxHNN0Qpy7X52lFiDdAwG
         YO5SKfy/vuW+9URF5W7+XZqL7uBAwxH9JaXFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8EoII7z9i5h4OnvIq0Rj015ZeVzlUXsiRDLRpXTqXw=;
        b=inauW8bniQNIJ8+y1/uvI4olQghjLBbX28b3GXCsbleq9HdXC6F8XbD81eqeRIfaEm
         tMTs7xjiPF9lqtUP2YzUrkqeR9RZKttS6GXRnocTQJqtk0vGKBnLTUBW4f+1tJ2hPpBB
         6Jf3Z5adeGcd2B23Csfr5qIGW1ZbP6Z1mac/r0NkCCBLa75k02re9O8PU3EwbAtFqVkc
         IMDt0g8a+AWQ14/CJ3XP1vScXulRj7AD8Gt6c3USHVCXwjVx7O465sMhOsguZQ/o7NSh
         WID0d8ZS9qn56ydIaVn+U945IlW2d0SFn6qxcPplQkbBrnYWE51UEZo0RpTHCcUR2ICv
         9yUQ==
X-Gm-Message-State: AGi0PuYJDRvB6fnozC39hrLSVY0ZceI5f90y5A3eqtAHoaf9M4LSB0Yg
        RPnFqMVmAq/HG02j2LQKAUSdQIb6jDe4SlvZ4s8bgQ==
X-Google-Smtp-Source: APiQypIQHESW7HGsSbWi/b67+Z8CM+ogEI/TSMrREOv0dfgoAhH5cHrRKa2azcoZn3/BZnYkNIQR6b32zGY3N0UdqOc=
X-Received: by 2002:aa7:cfd4:: with SMTP id r20mr3924122edy.378.1585848038082;
 Thu, 02 Apr 2020 10:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200401144109.GA29945@gardel-login> <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login> <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login>
In-Reply-To: <20200402155020.GA31715@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 2 Apr 2020 19:20:26 +0200
Message-ID: <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 5:50 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Do, 02.04.20 17:35, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > > systemd cares about all mount points in PID1's mount namespace.
> > >
> > > The fact that mount tables can grow large is why we want something
> > > better than constantly reparsing the whole /proc/self/mountinfo. But
> > > filtering subsets of that is something we don't really care about.
> >
> > I can accept that, but you haven't given a reason why that's so.
> >
> > What does it do with the fact that an automount point was crossed, for
> > example?  How does that affect the operation of systemd?
>
> We don't care how a mount point came to be. If it's autofs or
> something else, we don't care. We don't access these mount points
> ourselves ever, we just watch their existance.
>
> I mean, it's not just about startup it's also about shutdown. At
> shutdown we need to unmount everything from the leaves towards the
> root so that all file systems are in a clean state.

Unfortunately that's not guaranteed by umounting all filesystems from
the init namespace.  A filesystem is shut down when all references to
it are gone.  Perhaps you instead want to lazy unmount root (yeah,
that may not actually be allowed, but anyway, lazy unmounting the top
level ones should do) and watch for super block shutdown events
instead.

Does that make any sense?

Thanks,
Miklos
