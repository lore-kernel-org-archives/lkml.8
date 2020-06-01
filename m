Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E81C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DED206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lvZ06Iwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgFASkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731300AbgFASkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:40:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7737EC008630
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:40:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p30so3882732pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZSR8304cXHhSD6xXUkH5QV8FNg4zYtslwe34m2r8ft0=;
        b=lvZ06IwlVqCiv/4C3u/mxFApnFV6CACMMokvsQy/v9BKmpjCPMvhJ7V6KtweROJGKW
         GQCT+1x0ZOdk0dGTHFlMfv8+MGt17/BhWw60goOQ8NLo3NFrC7RtGvN3S6hFhPWZw6p4
         xV8xrVlX5ZN3IgisUKlPZnUmUXpv1Yr/6jGbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZSR8304cXHhSD6xXUkH5QV8FNg4zYtslwe34m2r8ft0=;
        b=t8wJI7AiqU9uXgk6C2JClGSVPNQQWjWoBt9HGjjmKaxo22Kh9z7bHuLJoe1QGjrEe4
         PqF7ezJR9F9rIgtPyTJSlOJ/pieYG4g+PVV1KnWPek80P+8lF6hVzk7f2jLuqdGtngHV
         c0EV1SGnzj6yd5VAP9wv/KVXzkUi/kum7oxkbUqoUL/iPMQeEjB22BaT6q3U1DeS7uw+
         dTnD0Nos3pv/S1tbINMbSVmWaujoJLFfnyjtRvkZN5iJKcZKGVdGQJwBK2W6+GSKFdTq
         Uex49wQHooP6u2pGBg3eNvyKAwftuYzcojo2YrU49wp7q6mn2kOxPYzjncCnduPKOj52
         YHhg==
X-Gm-Message-State: AOAM532b2WTBmsxumq9eLdMls7sRmrp7X+Ur1kYV7rG2sVOqZ7jOQ6K/
        DTMI1n8Oqnxuhm8MMImpE5gZCA==
X-Google-Smtp-Source: ABdhPJwfoGwgqvWVVMjRxcaL3453ZHmKQEaM7nggH3+WpJzfIxn6+ectiUjSGSQlsvFginiEpZ2uNw==
X-Received: by 2002:a65:6247:: with SMTP id q7mr12721181pgv.353.1591036816050;
        Mon, 01 Jun 2020 11:40:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f136sm132780pfa.59.2020.06.01.11.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:40:15 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:40:14 -0700
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
Subject: Re: [PATCH v3 2/4] seccomp: release filter after task is fully dead
Message-ID: <202006011139.BB51C671@keescook>
References: <20200531115031.391515-1-christian.brauner@ubuntu.com>
 <20200531115031.391515-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531115031.391515-2-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 01:50:29PM +0200, Christian Brauner wrote:
> The seccomp filter used to be released in free_task() which is called
> asynchronously via call_rcu() and assorted mechanisms. Since we need
> to inform tasks waiting on the seccomp notifier when a filter goes empty
> we will notify them as soon as a task has been marked fully dead in
> release_task(). To not split seccomp cleanup into two parts, move
> filter release out of free_task() and into release_task() after we've
> unhashed struct task from struct pid, exited signals, and unlinked it
> from the threadgroups' thread list. We'll put the empty filter
> notification infrastructure into it in a follow up patch.
> 
> This also renames put_seccomp_filter() to seccomp_filter_release() which
> is a more descriptive name of what we're doing here especially once
> we've added the empty filter notification mechanism in there.
> 
> We're also NULL-ing the task's filter tree entrypoint which seems
> cleaner than leaving a dangling pointer in there. Note that this shouldn't
> need any memory barriers since we're calling this when the task is in
> release_task() which means it's EXIT_DEAD. So it can't modify it's seccomp
> filters anymore. You can also see this from the point where we're calling
> seccomp_filter_release(). It's after __exit_signal() and at this point,
> tsk->sighand will already have been NULLed which is required for
> thread-sync and filter installation alike.
> 
> Cc: Tycho Andersen <tycho@tycho.ws>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Matt Denton <mpdenton@google.com>
> Cc: Sargun Dhillon <sargun@sargun.me>
> Cc: Jann Horn <jannh@google.com>
> Cc: Chris Palmer <palmer@google.com>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Robert Sesek <rsesek@google.com>
> Cc: Jeffrey Vander Stoep <jeffv@google.com>
> Cc: Linux Containers <containers@lists.linux-foundation.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks! Applied with typo fixes to the commit log, a slightly expanded
comment on seccomp_filter_release() to just drive home the reason we
don't need barriers, and a variable renaming to avoid some needless
churn in the coming patches...

-- 
Kees Cook
