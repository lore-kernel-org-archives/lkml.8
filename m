Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB252C10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 20:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813B02070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 20:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PV3bf2R9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgCGUst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 15:48:49 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38363 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgCGUst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 15:48:49 -0500
Received: by mail-il1-f193.google.com with SMTP id f5so5259548ilq.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZlaiWBNqvrdyvkEefn9yJWjZp7C2bAb1YLICnuJhP8I=;
        b=PV3bf2R9X3sQruGbBjzJvFY4AOshOxYvj+SiyibH20IZIQwjIExrhsqLUFM6P6R+lL
         LrAJRQjI/qJXCe04P0VvuJgkt9vJeW2qTNk71iIlLi/SHzLO0MvLutNTnfsD4TjmaXrj
         pun1BhXPZ65cZKYbR1qBfSXAyqWEqWfjqbGtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlaiWBNqvrdyvkEefn9yJWjZp7C2bAb1YLICnuJhP8I=;
        b=GL5scZbDCpnBebqbg6bJjMT234/U5bmsKn7tS58GTDBZILhxDiay7pAZUAhBcEaW4J
         Zq3yb/0cWB9umVmNCf+ewCaHs9x9FwnxCtTfAX+QmvLcbSZQYoIqobZbe/UH8gyWB3ZJ
         cbegFFoHGHr42bcuJmnAlPVVANTtpYF9Z40OoYq6HoRGspN2Mft5Qwy0jWkoD03N4NIj
         0XCoU3eZISmPYapAGYhQnybWpthQbF30xzKQYA319kUYXb0iJpWlKgywEhXb69N9WxJm
         Zf5yBo4UMbKF5rWZBsJVhhHAGrOezQZC3SrBCfHjBicYKGiv9gqmBKj8VhGD8vOe1PWB
         9rpA==
X-Gm-Message-State: ANhLgQ3ivzJKusxmuTD67A4vYhrwuzjgzOcL/L3ZnYuFaPx+4OY/lwtF
        MJqd2wPkG3mQC8tWmZsXf/Untu909dko2cZFN5FXFQ==
X-Google-Smtp-Source: ADFU+vskwVXCTzkhh+ZXd7Wbqe2WHoM17S7U48HvUGcGrtwnAQOiiNlg5R1xofLf5jp6bJ1vVeTIGj3wJCAenoDZ5x8=
X-Received: by 2002:a92:d745:: with SMTP id e5mr8793655ilq.285.1583614126795;
 Sat, 07 Mar 2020 12:48:46 -0800 (PST)
MIME-Version: 1.0
References: <1582556135.3384.4.camel@HansenPartnership.com>
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com> <20200307094834.GA3888906@kroah.com>
In-Reply-To: <20200307094834.GA3888906@kroah.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sat, 7 Mar 2020 21:48:35 +0100
Message-ID: <CAJfpegvOi0ZPEW4Aq8N8SPDwiEw8Tgzo-ngf30WNmHXBdfHnqA@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 7, 2020 at 10:48 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 06, 2020 at 05:25:49PM +0100, Miklos Szeredi wrote:
> > On Tue, Mar 03, 2020 at 08:46:09AM +0100, Miklos Szeredi wrote:
> > >
> > > I'm doing a patch.   Let's see how it fares in the face of all these
> > > preconceptions.
> >
> > Here's a first cut.  Doesn't yet have superblock info, just mount info.
> > Probably has rough edges, but appears to work.
> >
> > I started with sysfs, then kernfs, then went with a custom filesystem, because
> > neither could do what I wanted.
>
> Hm, what is wrong with kernfs that prevented you from using it here?
> Just complexity or something else?

I wanted to have a single instance covering all the namespaces, with
just a filtered view depending on which namespace the task is looking
at it.

Having a kernfs_node for each attribute is also rather heavy compared
to the size of struct mount.

Thanks,
Miklos
