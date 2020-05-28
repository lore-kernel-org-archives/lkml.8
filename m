Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5D22084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TEUWhQ66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgE1Bu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE1Bu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:50:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C8C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 18:50:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z64so8179326pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 18:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=foNaBO5M0gttX4Deanmv+4MV7YTgTH1Dw1Ba0mJEKI0=;
        b=TEUWhQ66EouoTP5oSr4b2i8yoee/soXAhlKcpyhLTdH3zwczQQljamxh19Q/EO8Z7R
         wtFS863YLckwd3vINecEHk21qkGl7hT/irUImImnwJNynasmUBmPojoiJL0m9zHLzhYT
         XM3QwJCFCSS3Mu6CKkyteS14OQ2dYGFUuhBXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=foNaBO5M0gttX4Deanmv+4MV7YTgTH1Dw1Ba0mJEKI0=;
        b=tR5Fq6FiI1J+9TBvxwNc73VCwpSHvWrPuMuRcr0qTNVvVcfaExqrulTynHqqDNvWO6
         ENX/FZf175MVmbZsR8bvwid8buGUgHJLKORQQnekWD1rZvSk0xhyhSHAAxdJkeTpqAZ7
         DXVUBWaxO7CcSznQCLxpcNYPvaJicxl6efwszlkti1m2fl+USi5iRRJIv7q3iTRfmS7h
         fS6XVi9BVPe5IMX24xf8RStHyqlEuzTbDUjHN6npyYpl47VmtDTKn80mVkbDDob8edzQ
         AzuDJesxUXN7bTGP0MFupOH/NdQOErww4ci0Qp+1bBYsIVf5QspVW9eQFCHVqNKfSEpj
         i9Tw==
X-Gm-Message-State: AOAM531o+5cJ+gJCWbohOBYG3bzmgOl9+kDqhQ0aq7XDkxqAvq4UjO39
        kN2vXt3hz2hFILVqYgf5N5+nDg==
X-Google-Smtp-Source: ABdhPJzZD8Dg5qbVJaRbhQTVVGOz9kqTMb0AkXoOzHCTGL+96Bu92uETmZSa3nOr5HhAAeVuUlpGTw==
X-Received: by 2002:a63:4504:: with SMTP id s4mr593083pga.175.1590630658485;
        Wed, 27 May 2020 18:50:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b74sm2984800pga.31.2020.05.27.18.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:50:57 -0700 (PDT)
Date:   Wed, 27 May 2020 18:50:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <202005271849.F34CE6A@keescook>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <202005271408.58F806514@keescook>
 <20200527215203.GE4153131@cisco>
 <202005271457.CF4BBB47@keescook>
 <20200527225600.GF4153131@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527225600.GF4153131@cisco>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 04:56:00PM -0600, Tycho Andersen wrote:
> On Wed, May 27, 2020 at 03:36:09PM -0700, Kees Cook wrote:
> > On Wed, May 27, 2020 at 03:52:03PM -0600, Tycho Andersen wrote:
> > > On Wed, May 27, 2020 at 02:43:49PM -0700, Kees Cook wrote:
> > > > (While I'm here -- why can there be only one listener per task? The
> > > > notifications are filter-specific, not task-specific?)
> > > 
> > > Not sure what you mean here?
> > 
> > tatic struct file *init_listener(struct seccomp_filter *filter)
> > {
> >         struct file *ret = ERR_PTR(-EBUSY);
> >         struct seccomp_filter *cur;
> > 
> >         for (cur = current->seccomp.filter; cur; cur = cur->prev) {
> >                 if (cur->notif)
> >                         goto out;
> >         }
> > 
> > ...
> > 
> >         /* Installing a second listener in the chain should EBUSY */
> >         EXPECT_EQ(user_trap_syscall(__NR_getpid,
> >                                     SECCOMP_FILTER_FLAG_NEW_LISTENER),
> >                   -1);
> >         EXPECT_EQ(errno, EBUSY);
> > 
> > 
> > Why does this limit exist? Since the fd is tied to a specific filter,
> > I don't see conflicts about having multiple USER_NOTIF filters on one
> > task -- the monitor's response will either fake it or continue it, so
> > there is no "composition" needed? I must be missing something.
> 
> It exists because Andy asked for it :)
> 
> I agree that there's no technical reason for it to be there. I think
> it's just that the semantics were potentially confusing, and it wasn't
> a requirement anyone had to have multiples attached.

Okay, sounds good. It just seems seccomp continues to grow "layers", so
I'm eyeing this aspect of user_notif. i.e. what if systemd decides to
add a user_notif for something and now suddenly the containers can't use
it. Or if some complex thing inside a container tries to use user_notif
and it can't because the container manager is doing it, etc.

Future work! :)

-- 
Kees Cook
