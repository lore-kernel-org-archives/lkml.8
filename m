Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1686AC18E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4567208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CLeuNfcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgCJJSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:18:22 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42925 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgCJJSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:18:21 -0400
Received: by mail-il1-f195.google.com with SMTP id x2so11309344ila.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hhr2JQNCTfwAz5fM8AxpKXVAk7m03eW/WPRPp++R3bc=;
        b=CLeuNfcd8lneEopBSQtHp3Kt+HipoV0gZP6IuZpydHV2/p4TlsVqkfu5HowfqMTXt4
         B6Nes0PUjpXtVP2DD/+CYwm5MJkMF1NpiN6Pigz83+0gVtQu29MQJHpZf1loCCFWgnuY
         NvSCicUjakpnIekJzu1+qB/DP+TL60iT/Mg+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hhr2JQNCTfwAz5fM8AxpKXVAk7m03eW/WPRPp++R3bc=;
        b=PToHk6U/te1wg8wBANVn6fgtpU3j47wHQBMYFyg2d0ZOeiAve/C9d3JbIP7SBmfiWw
         KcgcWBmzDuFoRIRGxxS/LK7UxQHnZ1cNy73gsI6l7SpGDDRIqT4Wn2XK+ylciQHxqw6P
         BWOg8S/q7BsKx3Xzljhk/zkcbhUkbmRxo1xgLiodr7yMFyc4/IsV+pJpFRQQYfdVLJT1
         4RZ86NVS0y6cIy/LXrH20t+N9RXw/ajRr7R2hRZj3Q0OqQ0c6eFGQommIB7dReZZYkos
         XYLsT7a5YOFTuoctjnBUG8Wf8uthhy2OIyvl1gI0frILhFJhdEYl4CL0aP5Ij70hQVWz
         q3rg==
X-Gm-Message-State: ANhLgQ1acXpLpIlDto8m3MlCO0Tgpu7PAXy1DkXQQsP+kPHXthePu3BA
        MCMlNPzZ6RlpH5+DKmdsHdg2nVugQnEVr9+aXr/1Pg==
X-Google-Smtp-Source: ADFU+vugKYA3Ig1dwzBjyGS81nr/dzb7dU1rNPjVpJ6bTLDiyqMRJ04NHueIU+BRzWkQaOZi8m5WZXZZBMnnCNWaxaA=
X-Received: by 2002:a92:9602:: with SMTP id g2mr18883520ilh.212.1583831899169;
 Tue, 10 Mar 2020 02:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <20200309200238.GB28467@miu.piliscsaba.redhat.com> <537182.1583794373@warthog.procyon.org.uk>
In-Reply-To: <537182.1583794373@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 10:18:08 +0100
Message-ID: <CAJfpegt9TqfyJuk0G-OJdWLiKuxSeY0cQKK=1GVf1fStA9COBw@mail.gmail.com>
Subject: Re: [PATCH 00/14] VFS: Filesystem information [ver #18]
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Stefan Metzmacher <metze@samba.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 11:53 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > >  (1) It can be targetted.  It makes it easy to query directly by path or
> > >      fd, but can also query by mount ID or fscontext fd.  procfs and sysfs
> > >      cannot do three of these things easily.
> >
> > See above: with the addition of open(path, O_PATH) it can do all of these.
>
> That's a horrible interface.  To query a file by path, you have to do:
>
>         fd = open(path, O_PATH);
>         sprintf(procpath, "/proc/self/fdmount/%u/<attr>");
>         fd2 = open(procpath, O_RDONLY);
>         read(fd2, ...);
>         close(fd2);
>         close(fd);
>
> See point (3) about efficiency also.  You're having to open *two* files.

I completely agree, opening two files is surely going to kill
performance of application needing to retrieve a billion mount
attributes per second.</sarcasm>

> > >  (2) Easier to provide LSM oversight.  Is the accessing process allowed to
> > >      query information pertinent to a particular file?
> >
> > Not quite sure why this would be easier for a new ad-hoc interface than for
> > the well established filesystem API.
>
> You're right.  That's why fsinfo() uses standard pathwalk where possible,
> e.g.:
>
>         fsinfo(AT_FDCWD, "/path/to/file", ...);
>
> or a fairly standard fd-querying interface:
>
>         fsinfo(fd, "", { resolve_flags = RESOLVE_EMPTY_PATH },  ...);
>
> to query an open file descriptor.  These are well-established filesystem APIs.

Yes.  The problem is with the "..." part where you pass random
structures to a function.   That's useful sometimes, but at the very
least it breaks type safety, and not what I would call a "clean" API.

> > Now onto the advantages of a filesystem based API:
> >
> >  - immediately usable from all programming languages, including scripts
>
> This is not true.  You can't open O_PATH from shell scripts, so you can't
> query things by path that you can't or shouldn't open (dev file paths, for
> example; symlinks).

Yes.  However, you just wrote the core of a utility that could do this
(in 6 lines, no less).  Now try that feat with fsinfo(2)!

Thanks,
Miklos
