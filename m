Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76530C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6C0208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gkEaaK+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgE1BtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE1BtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:49:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D42AC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 18:49:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cx22so2380729pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 18:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=96mpkTGIh5O+UhFhsZdg+qMWj6+2k5Ul5jGV+bLnnek=;
        b=gkEaaK+mzjRx+bD6cc68JEGvfpTM3rvOHmlG4Bnihe+uU/pUiP9UwNk19rHnCA1olu
         kNauOY3GmkNcZ/R9YuuewHA2/YJk6qI0DzkVsLdVyFqzj/bvCjDeCpJ3JbTbDpGopnn/
         LmcOcI+o6qHREUzxG/p89YipTrWC82xyuu828=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=96mpkTGIh5O+UhFhsZdg+qMWj6+2k5Ul5jGV+bLnnek=;
        b=PQziOGIgNIj6Z8aVxFf9zvDhmN8TY24XLx9p43AfhjFyeJlW7ToyR7MUMoFpsgOnrg
         qLap2RNiCXNyI7zb0s8rm97GQTbHAeVS4il5WTjfkWSdwtfpVpMu94LqH/gmNcmmLRMN
         ogthG5wEm+JsQUtIWlJSsu7ytEfaPFvmC4dnYJpUMrzYwOcZf2HfXt0/lxepX/Bbp9Oy
         Fz2ybRpAmBm6MoJf5qoyaDjGOmGp6cSF4ExwzYEIRKmT+qle1+DqaOoO/HB/AtKDBkQT
         +KkK/JbspJPT8NzpXvN7shr4COfhCQs9dlXl5fc2D/ULrJfj/SrD1zTSVif693VPAvth
         eLtg==
X-Gm-Message-State: AOAM531N+dWac4vlMhdM67zT6g9jcEz0OI1Z7CHoflA3VmVc7Dp8IS9U
        2hqyqBCEwicR9NBoHnPUII1SbqERhUsL1g==
X-Google-Smtp-Source: ABdhPJyYTOKEF0F/ft64x5o+RPpNjPsThjLEcZwqLphp+nYDzEhBHXTc5ufdDmZyz5fygyY5IReKww==
X-Received: by 2002:a17:90a:8d16:: with SMTP id c22mr1170872pjo.16.1590630563876;
        Wed, 27 May 2020 18:49:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n19sm54816pfu.194.2020.05.27.18.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:49:23 -0700 (PDT)
Date:   Wed, 27 May 2020 18:49:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <202005271846.80FC6F3@keescook>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <202005271408.58F806514@keescook>
 <20200527220532.jplypougn3qzwrms@wittgenstein>
 <202005271537.75548B6@keescook>
 <20200527224501.jddwcmvtvjtjsmsx@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527224501.jddwcmvtvjtjsmsx@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:45:01AM +0200, Christian Brauner wrote:
> On Wed, May 27, 2020 at 03:37:58PM -0700, Kees Cook wrote:
> > But there's a mapping between pidfd and task struct that is separate
> > from task struct itself, yes? I.e. keeping a pidfd open doesn't pin
> > struct task in memory forever, right?
> 
> No, but that's an implementation detail and we discussed that. It pins
> struct pid instead of task_struct. Once the process is fully gone you
> just get ESRCH.

Oh right! struct pid, yes. Okay, that's quite a bit smaller.

> For example, fds to /proc/<pid>/<tid>/ fds aren't just closed once the
> task has gone away, userspace will just get ESRCH when it tries to open
> files under there but the fd remains valid until close() is called.
> 
> In addition, of all the anon inode fds, none of them have the "close the
> file behind userspace back" behavior: io_uring, signalfd, timerfd, btf,
> perf_event, bpf-prog, bpf-link, bpf-map, pidfd, userfaultfd, fanotify,
> inotify, eventpoll, fscontext, eventfd. These are just core kernel ones.
> I'm pretty sure that it'd be very odd behavior if we did that. I'd
> rather just notify userspace and leave the close to them. But maybe I'm
> missing something.

Well, they have a "you are now disconnected" state, which I was thinking
could be done entirely entirely on the VFS side of things, but it looks
like it's not.

So, yes, okay, thank you for walking me through all that. I still want
to take a closer look at all the notify calls in here. It seems strange
that seccomp has to do all the wakeups (but I guess there are no
"generic" poll helpers?)

-- 
Kees Cook
