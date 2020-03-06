Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F65C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F98420675
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="a/IuF7wJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCFTyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:54:23 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34360 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFTyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:54:23 -0500
Received: by mail-il1-f193.google.com with SMTP id c8so2756224ilm.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 11:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7Yr6iThBvFiVFuCMIOneOYkdq7rfICUbWrdUVOauj8=;
        b=a/IuF7wJJcvi7R3raqpSjmvjHoyW1rzHNoNPJ0cJfivQZWXrYKMcvZM30/HL9FrbcH
         pMF1QkRGD4uJZxewNiWfwBxXriuNcwx61quGyA/Rro1MDFlI11ET8p2IalfTci7JStaH
         fJaiUxC+ZIwj0qt1rArbYbZBCTn2dwh4ihQ08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7Yr6iThBvFiVFuCMIOneOYkdq7rfICUbWrdUVOauj8=;
        b=pvkd8vczXSeSkLSqARt+/ydNxY8lhAQtwGf/HNZqVZCXligwdNSSzyvw975JkaYXJ9
         tv4SuHqMHaYXnW5vGD7PxN5muatfQbRpr/B148srlQP8kHRoaikAXADk08EFcdHh0nQo
         6+MUHRwWwYPVwUR/ld7FA+I2NfjGpTzkHXZouMsIQjCcCRU+j7lBYe1EHcXXKdgk2d1u
         HVuzDGw7eNhOMFNhs4D9ydz1a1qRTl99A3ndquEAbRdcTZU8uuKNj9eY3vei+EHfii2W
         ZV3KBcLXkg78h7Tz3So6cUz+9Bflt1xmMma/Y3oWY9Bpog9U2RMZh5l6oY2rEjHceOgU
         Tkqg==
X-Gm-Message-State: ANhLgQ3fZ3woJee36pkq/tWlBPlW90VFxaSCxwkCRQZ6o4dA8D1Wxeso
        HEq9AE96XWHwTpVRarMkanDId/1MibkGdfRovV56UQ==
X-Google-Smtp-Source: ADFU+vtbpbl0w2HqWSs8biDjZfjr/C5cekqgPQWRzbyVdoi71n4jrNADZpiqZ9BIxofq9rqM9Tu5nWBqs8hbde/f8Dw=
X-Received: by 2002:a05:6e02:f43:: with SMTP id y3mr4766895ilj.174.1583524462599;
 Fri, 06 Mar 2020 11:54:22 -0800 (PST)
MIME-Version: 1.0
References: <1582556135.3384.4.camel@HansenPartnership.com>
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com> <20200306194322.GY23230@ZenIV.linux.org.uk>
In-Reply-To: <20200306194322.GY23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Mar 2020 20:54:10 +0100
Message-ID: <CAJfpegtCsLmJF-DZH7P8=sVNdg86ZKa1Wgu-FN=YL1N5LdZh6w@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 8:43 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Mar 06, 2020 at 05:25:49PM +0100, Miklos Szeredi wrote:
> > On Tue, Mar 03, 2020 at 08:46:09AM +0100, Miklos Szeredi wrote:
> > >
> > > I'm doing a patch.   Let's see how it fares in the face of all these
> > > preconceptions.
> >
> > Here's a first cut.  Doesn't yet have superblock info, just mount info.
> > Probably has rough edges, but appears to work.
>
> For starters, you have just made namespace_sem held over copy_to_user().
> This is not going to fly.

Where?

Thanks,
Miklos
