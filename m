Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34896C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113D52073B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbgDBOg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:36:27 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:51066 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:36:26 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 7AF41E80A73;
        Thu,  2 Apr 2020 16:36:24 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 13E16160337; Thu,  2 Apr 2020 16:36:24 +0200 (CEST)
Date:   Thu, 2 Apr 2020 16:36:23 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
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
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200402143623.GB31529@gardel-login>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk>
 <20200401144109.GA29945@gardel-login>
 <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk>
 <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 02.04.20 15:52, Miklos Szeredi (miklos@szeredi.hu) wrote:

> > Don't get me wrong, neither the proc nor the fsinfo implementations
> > deal with the notification storms that cause much of the problem we
> > see now.
> >
> > IMHO that's a separate and very difficult problem in itself that
> > can't even be considered until getting the information efficiently
> > is resolved.
>
> This mount notification storm issue got me thinking.   If I understand
> correctly, systemd wants mount notifications so that it can do the
> desktop pop-up thing.   Is that correct?

This has little to do with the desktop. Startup scheduling is
mostly about figuring out when we can do the next step of startup, and
to a big amount this means issuing a mount command of some form, then
waiting until it is established, then invoking the next and so on, and
when the right mounts are established start the right services that
require them and so on. And with today's system complexity with
storage daemons and so on this all becomes a complex network of
concurrent dependencies.

Most mounts are established on behalf of pid 1 itself, for those we
could just wait until the mount syscall/command completes (and we
do). But there's plenty cases where that's not the case, hence we need
to make sure we follow system mount table state as a whole, regardless
if its systemd itself that triggers some mount or something else (for
example some shell script, udisks, …).

> But that doesn't apply to automounts at all.  A new mount performed by
> automount is uninteresting to to desktops, since it's triggered by
> crossing the automount point (i.e. a normal path lookup), not an
> external event like inserting a usb stick, etc...

systemd does not propagate mount events to desktops.

You appear to be thinking about the "udisks" project or so?

Lennart

--
Lennart Poettering, Berlin
