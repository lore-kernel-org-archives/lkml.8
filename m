Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790F7C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B2C206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eMbg0eTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgGJQKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:10:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31366C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:10:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q17so2431521pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zmW8ec5Dt+lImhfBII8mb3lOzcmhvKNb+zPkMO/QQ5Q=;
        b=eMbg0eTOumM5whjWlh4jJJ2moWaLNrdk7fajRjcV0NUxfmgQdadlIMcveXpHNJ3BeI
         1KPfI8EJiyYo9QvAvd/oFk0RcejN7Jb8P79mFtROpbyUDCWnIwwJtshcMQDuxEwadmdY
         JV4N9nCePXytoVXO4Bl8RkQ6aGHwPkZ8NsLBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zmW8ec5Dt+lImhfBII8mb3lOzcmhvKNb+zPkMO/QQ5Q=;
        b=SX6DskIu+matL1exGEcOCvMmHvmEl78d7DTvmym+SwxyVZVzVe42oAlZUyeFqV9CFT
         UJR13tMFtVkon44xD/xZdk6qTIl/M9PFYI7h1lolVnoKlMvyyQuMbWFwrzBwqet2EAjz
         Sm7V7yisPyRFCkj2RDL2YolUD0mvMD1gWTyYF034YjKAEmFGAsjMx49bnwqdcQDImvZO
         ckQMFvWB4cVJULtwVpKIgWLKFjc963cSUiMxTzVROfM1hxGaqp69X880ZVJUQDLvSr84
         50IrNxox6HNjOksK+4xkXPdspUIYpCFW9I6zUtgUKySgcQu5HlQSjGp/No+eOBi5hEKw
         Mz9g==
X-Gm-Message-State: AOAM533Ax/Cbs5BgRqjtTHNQSJiipxkmDbAuAAVRbEf25acMcpynrieJ
        W3S6IcJbetTuoVbMY5/o36LVlQ==
X-Google-Smtp-Source: ABdhPJw4yMztQBG9o5biOtOd11XxFqhNJMYreXhVKUHho/zJskPlZr2UflkydhW/fZLZNTKXqRjZSg==
X-Received: by 2002:a17:902:9f96:: with SMTP id g22mr15261428plq.306.1594397408754;
        Fri, 10 Jul 2020 09:10:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lx9sm1412890pjb.52.2020.07.10.09.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:10:07 -0700 (PDT)
Date:   Fri, 10 Jul 2020 09:10:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, alex.gaynor@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>, geofft@ldpreload.com,
        jbaublitz@redhat.com, Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <202007100905.94A79A7A76@keescook>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200710062803.GA1071395@kroah.com>
 <20200710125022.alry7wkymalmv3ge@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710125022.alry7wkymalmv3ge@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 02:50:22PM +0200, Christian Brauner wrote:
> On Fri, Jul 10, 2020 at 08:28:03AM +0200, Greg KH wrote:
> > On Thu, Jul 09, 2020 at 11:41:47AM -0700, Nick Desaulniers wrote:
> > > Hello folks,
> > > I'm working on putting together an LLVM "Micro Conference" for the
> > > upcoming Linux Plumbers Conf
> > > (https://www.linuxplumbersconf.org/event/7/page/47-attend).  It's not
> > > solidified yet, but I would really like to run a session on support
> > > for Rust "in tree."  I suspect we could cover technical aspects of
> > > what that might look like (I have a prototype of that, was trivial to
> > > wire up KBuild support), but also a larger question of "should we do
> > > this?" or "how might we place limits on where this can be used?"
> > > 
> > > Question to folks explicitly in To:, are you planning on attending plumbers?
> > > 
> > > If so, would this be an interesting topic that you'd participate in?
> > 
> > Yes, I'll be there.
> 
> We actually had this dicussion a while back and there were some more
> people interested in this. I'd be interested to attend this and I've
> spoken with Kees and a few others about this topic at last Plumbers (I
> think Greg might have been around for this informal discussion as well.
> But I might be imagining things.).

I'm quite interested in this topic still, yes. :) (And will be attending
Plumbers.)

We had interesting discussions with the LSS 2019 "Rust in the kernel"[1]
speakers, and I know Nick has reviewed their work[2] too. Perhaps we should
reach out to them as well?

-Kees

[1] https://ldpreload.com/p/kernel-modules-in-rust-lssna2019.pdf
[2] https://github.com/fishinabarrel/linux-kernel-module-rust

-- 
Kees Cook
