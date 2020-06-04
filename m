Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43249C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 02:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120B420657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 02:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BJRqlu/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgFDCoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 22:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFDCoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 22:44:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C968C03E96D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 19:44:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p30so2837311pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 19:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M+ZPzbvo6DkD0LCMR7LBK6dMn71+gL/ltXCMZHKLzqM=;
        b=BJRqlu/lSv5gNuMFfOnlSYn8vx/3AJGhdHHSM+T7S4EsXtjKaqAC1xpZZcA4zJsEHG
         T8sHp2AXJevzDkrspviOHvZzS3A1B9YRHK4HHk1FP9M5C4pvHRzFx/dTwEB0ghJD2SMF
         e+6DiR1C/JQWFPj/06W4KXitecQA1uGwFNZ20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M+ZPzbvo6DkD0LCMR7LBK6dMn71+gL/ltXCMZHKLzqM=;
        b=h7zJnZLHwVb787y2xQFGKXrWkKsnOWHpL3J8KfS4HnMKMjHMlzXbnXfPwav3mMniL8
         ddV7GgKHcDTkZE+Mrlms4srM5cUb+yotTPABTteDgAXY8F75UsEfDDQvnqa8FUZSxM4k
         rUanNBltdhTGgHSgSM+A6bi+C8YFDdqUVpJEYgqV4buigMM45QFZEGWLnA/w8LJFK/Dp
         2hK+uMYplzHWzPRBbDZ+CuQRzZiOE4mkciip28JyVDnHo/STRw7BFosrHamR0S+2PsMB
         K63wlfSEINljHQbh/vPdnCtIQCFl1lrx+8m++Cc0Q9OFWKHwGl8dUA2DKkjPOJ4mmr/W
         BKLQ==
X-Gm-Message-State: AOAM530FZDJGtxls3lTxJZgGdvr4I+Ygln6QAWOGOo6//KLYMGK/Fp7u
        nTGmE2r+LT9tje3FaEL/LBG0zA==
X-Google-Smtp-Source: ABdhPJw+Bww2rQcgLGavGk2DSJkUN2GH2E6qT/s8t4M49q0ggLiLO5HFBRoDRvjnk7y4m/bTs7nmKw==
X-Received: by 2002:a63:9319:: with SMTP id b25mr2385531pge.374.1591238646020;
        Wed, 03 Jun 2020 19:44:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j26sm2960569pfr.215.2020.06.03.19.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 19:44:05 -0700 (PDT)
Date:   Wed, 3 Jun 2020 19:44:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/4] Add seccomp notifier ioctl that enables adding fds
Message-ID: <202006031923.C8017E342A@keescook>
References: <20200603011044.7972-1-sargun@sargun.me>
 <202006031639.E053742@keescook>
 <CAMp4zn-8iSozHvgqXBPKz-ux7HH6T4Dj9p0fA3fs_e7ZwEPZRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMp4zn-8iSozHvgqXBPKz-ux7HH6T4Dj9p0fA3fs_e7ZwEPZRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 04:56:59PM -0700, Sargun Dhillon wrote:
> On Wed, Jun 3, 2020 at 4:42 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jun 02, 2020 at 06:10:40PM -0700, Sargun Dhillon wrote:
> > > Sargun Dhillon (4):
> > >   fs, net: Standardize on file_receive helper to move fds across
> > >     processes
> > >   pid: Use file_receive helper to copy FDs
> >
> > The fixes (that should add open-coded cgroups stuff) should be separate
> > patches so they can be backported.
> Patch 1/4, and 2/4 are separated so they can be backported. Patch 1 should
> go into long term, and patch 2 should land in stable.
> 
> Do you see anything in 1/4, and 2/4 that shouldn't be there?

So, my thinking was to open code the fixes to minimize the code churn
in the -stable trees and isolate logical changes. However, in looking
at the commits (3.6, 3.8) and the age of the rest of the nearby code in
SCM_RIGHTS (3.7), and the actual oldest supported kernel release (3.16),
I guess it would be better to split it like you've done.

> > The helper doesn't take the __user pointer I thought we'd agreed it
> > should to avoid changing any SCM_RIGHTS behaviors?
> >
> It doesn't change the SCM_RIGHTS behaviour because it continues
> to have the logic which allocates the file descriptor outside of the
> helper.
> 1. Allocate FD (this happens in scm.c)
> 2. Copy FD # to userspace (this happens in scm.c)
> 3. Receive FD (this happens in the new helper)

Sorry, I was not writing very clearly: I was meaning to have said:

I was expecting the helper to take the __user pointer (like I thought
we agreed[1]) so we could both avoid changing SCM_RIGHTS behavior and
avoid copy/pasting of the get_unused/put_unused code in 3 places. (I
get into this more in the other thread[2]).

So, let's finalize this decision in the thread at [2]. Again, sorry I
wasted your time due to my confusion!

-Kees

[1] Apologies, I misread your "1" in [3] to be "suggestion 1" from the
    quoted text from me in that email, rather than the "[1]" it was,
    which was a link to your counter-proposal. And then I wasted your
    time by saying "agreed".
[2] https://lore.kernel.org/lkml/202006031845.F587F85A@keescook/
[3] https://lore.kernel.org/lkml/20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal/

-- 
Kees Cook
