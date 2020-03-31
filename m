Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B810C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E681A20787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Pl6wunnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgCaIfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:35:13 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32782 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbgCaIfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:35:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id z65so24131288ede.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 01:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rLFubCEpgldKurlG4URIBkpTK5CEAUrKTvEkFewMCc=;
        b=Pl6wunnFAOyFrLjRF4MLa/729tmRbfvLqvNbOMvx8XQPOctWtryQtH04K/E5S2+qBC
         ePAeM6bPzByKY90dlYOUaqZEo+JcCIjCXbWPFBl4qB4tZM4goBwE/hSdS3js5G4lNwXl
         urTXdaybd2HhJ+bGwiYNbcuzzErWv5XyrqZ9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rLFubCEpgldKurlG4URIBkpTK5CEAUrKTvEkFewMCc=;
        b=id2XG6LZOpr086GJy4LQrD2FjqJCZNAlD4fLs6Mb2Lus21sAgFtCBeYS8hSZ3Xmyjq
         kKLvTIKmhYEfleslTrlX/UOri4v3pzaMiDvau13/r7XiC+COO/g5Y9NrFTEp1SPQoNtK
         XP5cbwDLa9Bwx2Mdm70iL85xebb77OQvpZ2e828ax0TXbw9U0dXVqrkt9umdnnp8RjoW
         RypY5hog42IqCcF5avm0aprRos68kBVyyqpLQKx7TcGOCV8TA8EcyhjPhguFtJE/oIv6
         EWXmU109GRgDZn55Xq8/MMIeMFBO0AfHudp9z24567UAJL+ggIKZD3XB0mhFqm3QIc32
         n/6g==
X-Gm-Message-State: ANhLgQ3sE8ff1TFZxjDCrP6qgiVTNpRvl7uVMe5oMzwXhGa8yKFKENZ5
        G161134RXP6v0u++v+PQePS22Q7vZ7/pnoAoFQjH8w==
X-Google-Smtp-Source: ADFU+vtv+tXPNHXP7ARcHQpTkYalP7cBmBf5/XjaaCBBR2f6V6HnH9gs6cBg/IlbBfMiOag3DlBSeZGOqpzpLteyY6k=
X-Received: by 2002:a17:906:6545:: with SMTP id u5mr5686172ejn.27.1585643707995;
 Tue, 31 Mar 2020 01:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <1445647.1585576702@warthog.procyon.org.uk> <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com> <20200331081507.f6an4x32cxwpxdpd@wittgenstein>
In-Reply-To: <20200331081507.f6an4x32cxwpxdpd@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 31 Mar 2020 10:34:56 +0200
Message-ID: <CAJfpegsR7Vx1F0DNzoR0=SdNyuT02SWwO5wQRJtiKq_SOv71kw@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:15 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Mar 31, 2020 at 07:11:11AM +0200, Miklos Szeredi wrote:
> > On Mon, Mar 30, 2020 at 11:17 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> >
> > > Fwiw, putting down my kernel hat and speaking as someone who maintains
> > > two container runtimes and various other low-level bits and pieces in
> > > userspace who'd make heavy use of this stuff I would prefer the fd-based
> > > fsinfo() approach especially in the light of across namespace
> > > operations, querying all properties of a mount atomically all-at-once,
> >
> > fsinfo(2) doesn't meet the atomically all-at-once requirement.  Sure,
> > it's possible to check the various change counters before and after a
> > batch of calls to check that the result is consistent.  Still, that's
> > not an atomic all-at-once query, if you'd really require that, than
> > fsinfo(2) as it currently stands would be inadequate.
>
> It at all that's only true for batch requests.

For example, there's no way to atomically query mount flags, parent,
and list of children with a single fsinfo() call, you actually need
three calls and they can reflect different states of the same mount.
Not saying this is a problem, just that there's no list of
requirements on what is needed and why.

> > > and safe delegation through fds. Another heavy user of this would be
> > > systemd (Cced Lennart who I've discussed this with) which would prefer
> > > the fd-based approach as well. I think pulling this into a filesystem
> > > and making userspace parse around in a filesystem tree to query mount
> > > information is the wrong approach and will get messy pretty quickly
> > > especially in the face of mount and user namespace interactions and
> > > various other pitfalls.
> >
> > Have you actually looked at my proposed patch?   Do you have concrete
>
> Yes. So have others, Al actively disliked and nacked it and no-one got
> excited about it.

Al, as far as I remember, nacked several things the patch was doing.
I fixed those.

> > issues or just vague bad feelings?
>
> We have had that discussion on-list where I made my "vague bad feelings"
> clear where you responded with the same dismissive style so I don't see
> the point in repeating this experience.
>
> Again, I want to make it clear that here I'm stating my preference as a
> user of this api and as such I don't want to have to parse through a
> filesystem to get complex information about filesystems. We've had
> fruitful discussions [1] around how fsinfo() ties in with supervised
> mounts and the rest of the mount api and its clear and simple especially
> in the face of namespaces and implements a nice delegation model. So +1
> from me.

And you keep ignoring the fact that my patch implements that exact
same delegation model.  That's why I'm asking if you have looked at it
or not.

The "I don't want to have to parse through a filesystem to get complex
information about filesystems" is not a set of requirements that an
API can be designed from.

Thanks,
Miklos
