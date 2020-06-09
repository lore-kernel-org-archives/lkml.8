Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DA5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8B6206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OB0UNLhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgFITnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgFITnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:43:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0823CC03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:43:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg4so8442848plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YKDRAYFyZDX1iJtgq+nOe6dDVNHusLb2+M7rgUsbsuA=;
        b=OB0UNLhqrd2lvGP8kICD9vdu5hzwtgTCgQdsPH8Jthhlb5OjbH10hbkTSDtS9Y6Yq9
         IH/aWtVQZa6caTzYolvet5MBvzTv7KW1n7QSgK2K7waIvCgl8sn3G74fT8VrNWAuDyad
         3y9gtdX/8HU3qLr/UDOis0i/AVaOUfhOJcOzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YKDRAYFyZDX1iJtgq+nOe6dDVNHusLb2+M7rgUsbsuA=;
        b=AcbtrX1m4PZJ7EAfj9qmaEwwfdcHhMjukr9S3PNMf+d+voRad3c+3RCY4Sdk/trc8H
         Y4ssTsJhZk1ai+TCChvzOE0LJlGaSmPQMuf4jN73DnNklfPPRLvmYHr94A3QsV4YYWAH
         EJdXx2iLM+Y7VdQrpL4x8tOXFZzC9t1HlTWBVTjgslZ3GLtz7NJs87Es5nigvSVzcBvh
         jBWEDTuxPYn2e9LvneYaKOlwXw1Y42bw0iG9X5C9QeHR5vjcL/mrE9aSX3wKqeGrCTmf
         hx7oyKgJReBWWc8HS2INnsYf4ZML3uHKCb/Q3e0eWYd9w3lelMYQ83sruQS91Xd49CH5
         y5/Q==
X-Gm-Message-State: AOAM5323P8OQLmYQQ54bTgNz7QkCitA/KC662vbSTRQUA5TLUQiNijgY
        ERvyix+/sysTjQLwyVzlYCw5jQ==
X-Google-Smtp-Source: ABdhPJxtk3TJrsb3cn4/u86ecqtQjJyGnypX0YpSUv3MM3RiJjFoBvLKI78ZXrjRKTi6EyRQYt5UNA==
X-Received: by 2002:a17:90b:46cf:: with SMTP id jx15mr6514637pjb.121.1591731830517;
        Tue, 09 Jun 2020 12:43:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18sm10637371pfr.106.2020.06.09.12.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:43:49 -0700 (PDT)
Date:   Tue, 9 Jun 2020 12:43:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        containers@lists.linux-foundation.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>,
        "David S . Miller" <davem@davemloft.net>,
        John Fastabend <john.r.fastabend@intel.com>,
        Tejun Heo <tj@kernel.org>, stable@vger.kernel.org,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] fs, net: Standardize on file_receive helper to
 move fds across processes
Message-ID: <202006091235.930519F5B@keescook>
References: <20200603011044.7972-1-sargun@sargun.me>
 <20200603011044.7972-2-sargun@sargun.me>
 <20200604012452.vh33nufblowuxfed@wittgenstein>
 <202006031845.F587F85A@keescook>
 <20200604125226.eztfrpvvuji7cbb2@wittgenstein>
 <20200605075435.GA3345@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605075435.GA3345@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 07:54:36AM +0000, Sargun Dhillon wrote:
> On Thu, Jun 04, 2020 at 02:52:26PM +0200, Christian Brauner wrote:
> > On Wed, Jun 03, 2020 at 07:22:57PM -0700, Kees Cook wrote:
> > > On Thu, Jun 04, 2020 at 03:24:52AM +0200, Christian Brauner wrote:
> > > > On Tue, Jun 02, 2020 at 06:10:41PM -0700, Sargun Dhillon wrote:
> > > > > Previously there were two chunks of code where the logic to receive file
> > > > > descriptors was duplicated in net. The compat version of copying
> > > > > file descriptors via SCM_RIGHTS did not have logic to update cgroups.
> > > > > Logic to change the cgroup data was added in:
> > > > > commit 48a87cc26c13 ("net: netprio: fd passed in SCM_RIGHTS datagram not set correctly")
> > > > > commit d84295067fc7 ("net: net_cls: fd passed in SCM_RIGHTS datagram not set correctly")
> > > > > 
> > > > > This was not copied to the compat path. This commit fixes that, and thus
> > > > > should be cherry-picked into stable.
> > > > > 
> > > > > This introduces a helper (file_receive) which encapsulates the logic for
> > > > > handling calling security hooks as well as manipulating cgroup information.
> > > > > This helper can then be used other places in the kernel where file
> > > > > descriptors are copied between processes
> > > > > 
> > > > > I tested cgroup classid setting on both the compat (x32) path, and the
> > > > > native path to ensure that when moving the file descriptor the classid
> > > > > is set.
> > > > > 
> > > > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > > > Suggested-by: Kees Cook <keescook@chromium.org>
> > > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
> > > > > Cc: David S. Miller <davem@davemloft.net>
> > > > > Cc: Jann Horn <jannh@google.com>,
> > > > > Cc: John Fastabend <john.r.fastabend@intel.com>
> > > > > Cc: Tejun Heo <tj@kernel.org>
> > > > > Cc: Tycho Andersen <tycho@tycho.ws>
> > > > > Cc: stable@vger.kernel.org
> > > > > Cc: cgroups@vger.kernel.org
> > > > > Cc: linux-fsdevel@vger.kernel.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > ---
> > > > >  fs/file.c            | 35 +++++++++++++++++++++++++++++++++++
> > > > >  include/linux/file.h |  1 +
> > > > >  net/compat.c         | 10 +++++-----
> > > > >  net/core/scm.c       | 14 ++++----------
> > > > >  4 files changed, 45 insertions(+), 15 deletions(-)
> > > > > 
> > > > 
> > > > This is all just a remote version of fd_install(), yet it deviates from
> > > > fd_install()'s semantics and naming. That's not great imho. What about
> > > > naming this something like:
> > > > 
> > > > fd_install_received()
> > > > 
> > > > and move the get_file() out of there so it has the same semantics as
> > > > fd_install(). It seems rather dangerous to have a function like
> > > > fd_install() that consumes a reference once it returned and another
> > > > version of this that is basically the same thing but doesn't consume a
> > > > reference because it takes its own. Seems an invitation for confusion.
> > > > Does that make sense?
> > > 
> > > We have some competing opinions on this, I guess. What I really don't
> > > like is the copy/pasting of the get_unused_fd_flags() and
> > > put_unused_fd() needed by (nearly) all the callers. If it's a helper, it
> > > should help. Specifically, I'd like to see this:
> > > 
> > > int file_receive(int fd, unsigned long flags, struct file *file,
> > > 		 int __user *fdptr)
> > 
> > I still fail to see what this whole put_user() handling buys us at all
> > and why this function needs to be anymore complicated then simply:
> > 
> > fd_install_received(int fd, struct file *file)
> > {
> > 	security_file_receive(file);
> >  
> >  	sock = sock_from_file(fd, &err);
> >  	if (sock) {
> >  		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
> >  		sock_update_classid(&sock->sk->sk_cgrp_data);
> >  	}
> > 
> > 	fd_install();
> > 	return;
> > }
> > 
> > exactly like fd_install() but for received files.
> > 
> > For scm you can fail somewhere in the middle of putting any number of
> > file descriptors so you're left in a state with only a subset of
> > requested file descriptors installed so it's not really useful there.
> > And if you manage to install an fd but then fail to put_user() it
> > userspace can simply check it's fds via proc and has to anyway on any
> > scm message error. If you fail an scm message userspace better check
> > their fds.
> > For seccomp maybe but even there I doubt it and I still maintain that
> > userspace screwing this up is on them which is how we do this most of
> > the time. And for pidfd_getfd() this whole put_user() thing doesn't
> > matter at all.
> > 
> > It's much easier and clearer if we simply have a fd_install() -
> > fd_install_received() parallelism where we follow an established
> > convention. _But_ if that blocks you from making this generic enough
> > then at least the replace_fd() vs fd_install() logic seems it shouldn't
> > be in there. 
> > 
> > And the function name really needs to drive home the point that it
> > installs an fd into the tasks fdtable no matter what version you go
> > with. file_receive() is really not accurate enough for this at all.
> > 
> > > {
> > > 	struct socket *sock;
> > > 	int err;
> > > 
> > > 	err = security_file_receive(file);
> > > 	if (err)
> > > 		return err;
> > > 
> > > 	if (fd < 0) {
> > > 		/* Install new fd. */
> > > 		int new_fd;
> > > 
> > > 		err = get_unused_fd_flags(flags);
> > > 		if (err < 0)
> > > 			return err;
> > > 		new_fd = err;
> > > 
> > > 		/* Copy fd to any waiting user memory. */
> > > 		if (fdptr) {
> > > 			err = put_user(new_fd, fdptr);
> > > 			if (err < 0) {
> > > 				put_unused_fd(new_fd);
> > > 				return err;
> > > 			}
> > > 		}
> > > 		fd_install(new_fd, get_file(file));
> > > 		fd = new_fd;
> > > 	} else {
> > > 		/* Replace existing fd. */
> > > 		err = replace_fd(fd, file, flags);
> > > 		if (err)
> > > 			return err;
> > > 	}
> > > 
> > > 	/* Bump the cgroup usage counts. */
> > > 	sock = sock_from_file(fd, &err);
> > > 	if (sock) {
> > > 		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
> > > 		sock_update_classid(&sock->sk->sk_cgrp_data);
> > > 	}
> > > 
> > > 	return fd;
> > > }
> > > 
> > > If everyone else *really* prefers keeping the get_unused_fd_flags() /
> > > put_unused_fd() stuff outside the helper, then I guess I'll give up,
> > > but I think it is MUCH cleaner this way -- all 4 users trim down lots
> > > of code duplication.
> > > 
> > > -- 
> > > Kees Cook
> How about this:
> 
> 
> static int do_dup2(struct files_struct *files,
> 	struct file *file, unsigned fd, unsigned flags)
> __releases(&files->file_lock)
> {
> 	struct file *tofree;
> 	struct fdtable *fdt;
> 
> 	...
> 
> 	/*
> 	 * New bit, allowing the file to be null. Doesn't have the same
> 	 * "sanity check" bits from __alloc_fd
> 	 */
> 	if (likely(file))
> 		get_file(file);
> 	rcu_assign_pointer(fdt->fd[fd], file);
> 
> 	__set_open_fd(fd, fdt);

IIUC, this means we can get the fdt into a state of an open fd with a
NULL file... is that okay? That feels like something Al might rebel at.
:)

> 
> 	...
> }
> 
> /*
>  * File Receive - Receive a file from another process
>  *
>  * Encapsulates the logic to handle receiving a file from another task. It
>  * does not install the file descriptor. That is delegated to the user. If
>  * an error occurs that results in the file descriptor not being installed,
>  * they must put_unused_fd.
>  *
>  * fd should be >= 0 if you intend on replacing a file descriptor, or
>  * alternatively -1 if you want file_receive to allocate an FD for you
>  *
>  * Returns the fd number on success.
>  * Returns negative error code on failure.
>  *
>  */
> int file_receive(int fd, unsigned int flags, struct file *file)
> {
> 	int err;
> 	struct socket *sock;
> 	struct files_struct *files = current->files;
> 
> 	err = security_file_receive(file);
> 	if (err)
> 		return err;
> 
> 	if (fd >= 0) {
> 		if (fd >= rlimit(RLIMIT_NOFILE))
> 			return -EBADF;
> 
> 		spin_lock(&files->file_lock);
> 		err = expand_files(files, fd);
> 		if (err < 0) {
> 			goto out_unlock;
> 		}
> 
> 		err = do_dup2(files, NULL, fd, flags);
> 		if (err)
> 			return err;

This seems like we're duplicating some checks and missing others -- I
really think we need to do this using the existing primitives. But I'd
really like some review or commentary from Al. We can do this a bunch of
ways, and I'd like to know which way looks best to him. :(

> This way there is:
> 1. No "put_user" logic in file_receive
> 2. Minimal (single) branching logic, unless there's something in between
>    the file_receive and installing the FD, such as put_user.
> 3. Doesn't implement fd_install, so there's no ambiguity about it being
>    file_install_received vs. just the receive logic.

I still wonder if we should refactor SCM_RIGHTS to just delay put_user
failures, which would simplify a bunch. It's a behavior change, but it
seems from Al and Jann that it just shouldn't matter. (And if it does,
we'll hear about it.)

-- 
Kees Cook
