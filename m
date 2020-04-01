Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E890DC2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493FD2063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lgNDPXVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbgDAQbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:31:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43356 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388108AbgDAQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:31:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id bd14so612241edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z5x/eD97YYe+UtsUcQWgKp4y9byY3ksGQkwZWyGAQus=;
        b=lgNDPXVyyGlYNRnOPf26yaHitf7+pqDoEBpBKrgXIVk39xhYHvjpaLoeMlCbYOOH35
         gqP+GsjwCSbvRLr0P1EYmVavLSzF91XZxVs0nTVil4/5vneArq4Br9GvtOwNnp+K84fp
         eeYPrrVySgZo3U4828x7nVKYv0l3frhycdpMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5x/eD97YYe+UtsUcQWgKp4y9byY3ksGQkwZWyGAQus=;
        b=t6DWyxQDuE0JD0RUlZtqeSB19orFX1MMJNm7GknaLLVHHnjX3xxBSHRwr/dKgdHEwX
         2a2o6bKtbuZQMwpoXggZP7mIVKMMVKCZQ5B3wGwdWYnuG5J8mh/P5ycWoPbpVfPP9/m1
         aj7v7TkVdYoBXKRtksEBIhkEyAeTlpmGz9yaU2Vwlkq6Kn747lGOraemKxTaZzSyh1XV
         8CfnmJJ4F7dbzi3WKzJbspjrN/ldIb5f0Mb0kE+y45/2GhULpyS6zqjlOsvaK7viXE2E
         hnPsRdM4zs60YjvqBjDpNdUOJCNQ88Ip/oN/xec+JkaWX3fU0mJi7VcEP/Mxl2yLWQ4E
         4tEA==
X-Gm-Message-State: ANhLgQ23pkZPqCcD83UDq/NlkPkh9OcygxaIt9xzaGnchpf9IuU1FxRv
        iCZxBvSa1LdpNqGDJEt53Svrvd7D0iBk58H6EL8sYw==
X-Google-Smtp-Source: ADFU+vuXSy+WOIY1LRGVIsjX6cs7PxeglKy6P6ZhdJuuMLQsyJawyKskAGhJxAk2Obp0S8U3eefwNGGiUrNlnslw5RY=
X-Received: by 2002:a50:c341:: with SMTP id q1mr22249117edb.247.1585758670968;
 Wed, 01 Apr 2020 09:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpeguu52VuLAzjFH4rJJ7WYLB5ag8y+r3VMb-0bqH8c-uJUg@mail.gmail.com>
 <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401090445.6t73dt7gz36bv4rh@ws.net.home>
 <2488530.1585749351@warthog.procyon.org.uk> <2488734.1585749502@warthog.procyon.org.uk>
 <CAJfpeguLJcAEgx2JWRNcKMkyFTWB0r4wS6F4fJHK3VHtY=EjXQ@mail.gmail.com> <2590276.1585756914@warthog.procyon.org.uk>
In-Reply-To: <2590276.1585756914@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Apr 2020 18:30:59 +0200
Message-ID: <CAJfpeguxDiq3BW94AVFhgY75P+jy_+jk3pdyNZ5z-aJPXNvvGA@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     David Howells <dhowells@redhat.com>
Cc:     Karel Zak <kzak@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
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

On Wed, Apr 1, 2020 at 6:02 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > > But doesn't actually do what Karel asked for.  show_mountinfo() itself does
> > > > not give you what Karel asked for.
> >
> > Not sure what you mean.  I think it shows precisely the information
> > Karel asked for.
>
> It's not atomic.

Yes it is.

Thanks,
Miklos
