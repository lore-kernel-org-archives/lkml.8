Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6366C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD68120781
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SSt1VrIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgCaPKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:10:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46713 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbgCaPKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:10:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id cf14so25527946edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7MnP0ziMJ05b/KxlP+M8bkph/ifpBLqQViGWOB4DEo=;
        b=SSt1VrIVX/Tjp7n2tm5hZ28Rimha6AkiiRqswnMUOZrX6u8JAvs7EpidlIibrDgWn6
         8f3oR+MSicBlmRwxRGlRmocZLP58QcOxLLy/3P8XMGN78DlSS3Yc9BcLygTC477mg5aR
         2bw79UepxHWGRmpmqa2topzKhKBf6CZHFQB5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7MnP0ziMJ05b/KxlP+M8bkph/ifpBLqQViGWOB4DEo=;
        b=RXC/hxSpy+WH8hY1xzkbYQnOBRFpCcbkmX6jHZXXgF+AIAF7jaQhJkRsAbjEJOyXx0
         z4YhwOR1lq5m2/vuTlEWRNY8ekgwXNtqPHAE2Onvu47FO6zk1V5L4fKyhWkwdydt3nFj
         ZMF0IYJ62T7sPGi/RsHO4FPXqYFpn+NDRlTLpuhcqxnDLzxtHBA/mtHqac0ceIi+q9A+
         tlF5JmvN203i00DhBNt6VWjeIaKzQBd4Cz75Q/0J0/k8nyWKZS+fECs0dwIPMxXjZ+GV
         yaDTiAUVRQlbZ0rU7HIwah85J6MZHpBJbMIe/0JlR3w6XPXGEm5VZHjXe1zEUBjO3LsF
         wEhg==
X-Gm-Message-State: ANhLgQ35+vzF4GVe3EdiUTrGO8OjvyZ5hxD/vEQSQf4njXgg7ZCMytPI
        +uueP8Bcx8iVG+AcI50UeLF1gMlAxeOidhYFCe567A==
X-Google-Smtp-Source: ADFU+vv3Rldz1B2TlCvia6yybcz1TZKY48JT2JSMOypFogu2KyaS+8B9LeWuNNEUuazthmsFwiMPNgKhW+h/eb48onU=
X-Received: by 2002:a17:906:6545:: with SMTP id u5mr7087508ejn.27.1585667445614;
 Tue, 31 Mar 2020 08:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <1445647.1585576702@warthog.procyon.org.uk> <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
 <20200331083430.kserp35qabnxvths@ws.net.home> <CAJfpegsNpabFwoLL8HffNbi_4DuGMn4eYpFc6n7223UFnEPAbA@mail.gmail.com>
 <20200331122554.GA27469@gardel-login>
In-Reply-To: <20200331122554.GA27469@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 31 Mar 2020 17:10:34 +0200
Message-ID: <CAJfpegvo=T0VuXsPnvo83H3RqwHLE-9Q=dTZKWxnBKMykfJcNA@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Karel Zak <kzak@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 2:25 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Di, 31.03.20 10:56, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > On Tue, Mar 31, 2020 at 10:34 AM Karel Zak <kzak@redhat.com> wrote:
> > >
> > > On Tue, Mar 31, 2020 at 07:11:11AM +0200, Miklos Szeredi wrote:
> > > > On Mon, Mar 30, 2020 at 11:17 PM Christian Brauner
> > > > <christian.brauner@ubuntu.com> wrote:
> > > >
> > > > > Fwiw, putting down my kernel hat and speaking as someone who maintains
> > > > > two container runtimes and various other low-level bits and pieces in
> > > > > userspace who'd make heavy use of this stuff I would prefer the fd-based
> > > > > fsinfo() approach especially in the light of across namespace
> > > > > operations, querying all properties of a mount atomically all-at-once,
> > > >
> > > > fsinfo(2) doesn't meet the atomically all-at-once requirement.
> > >
> > > I guess your /proc based idea have exactly the same problem...
> >
> > Yes, that's exactly what I wanted to demonstrate: there's no
> > fundamental difference between the two API's in this respect.
> >
> > > I see two possible ways:
> > >
> > > - after open("/mnt", O_PATH) create copy-on-write object in kernel to
> > >   represent mount node -- kernel will able to modify it, but userspace
> > >   will get unchanged data from the FD until to close()
> > >
> > > - improve fsinfo() to provide set (list) of the attributes by one call
> >
> > I think we are approaching this from the wrong end.   Let's just
> > ignore all of the proposed interfaces for now and only concentrate on
> > what this will be used for.
> >
> > Start with a set of use cases by all interested parties.  E.g.
> >
> >  - systemd wants to keep track attached mounts in a namespace, as well
> > as new detached mounts created by fsmount()
> >
> >  - systemd need to keep information (such as parent, children, mount
> > flags, fs options, etc) up to date on any change of topology or
> > attributes.
>
> - We also have code that recursively remounts r/o or unmounts some
>   directory tree (with filters),

Recursive remount-ro is clear.  What is not clear is whether you need
to do this for hidden mounts (not possible from userspace without a
way to disable mount following on path lookup).  Would it make sense
to add a kernel API for recursive setting of mount flags?

What exactly is this unmount with filters?  Can you give examples?

> - We also have code that needs to check if /dev/ is plain tmpfs or
>   devtmpfs. We cannot use statfs for that, since in both cases
>   TMPFS_MAGIC is reported, hence we currently parse
>   /proc/self/mountinfo for that to find the fstype string there, which
>   is different for both cases.

Okay.

Thanks,
Miklos
