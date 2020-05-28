Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7783AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 04:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B78E20721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 04:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAQkusrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgE1EFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 00:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgE1EFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 00:05:19 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FCDC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 21:05:17 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k5so31573911lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 21:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofjEiXNaaliQL8FtDdVTaAf3B86SXT30nWNXfVlq1sE=;
        b=ZAQkusrPK4WHGMyLu35qH5ersSTeIx5Nq8zLio92SD11BIusqFHCk3ikv48B2IaiWC
         wsd1Dmz1v6f/5LR2XWvaz27QeXzzsr5vxV9NaOKv5NP14ILfm6kTBN/A7fyTX2Pt47Xh
         7LBSVEBvzEagiaTrbowNQFyXmToHbr4Q2foEq9FR7BOzfzWU0sd5DZ0QzT/LIUlBwJKD
         9LrnvJtBfMQcx75F230eUE1ENcperAkMMYhhSUmUellqMN1+j4HxMJBT52OgHrSx4v41
         21x/GvcP0aWijJVLzW01beXoEiecdCxJSsJ9CoIsujGvOjPsAbQAOJ1N+u5Ed1cad3/3
         FVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofjEiXNaaliQL8FtDdVTaAf3B86SXT30nWNXfVlq1sE=;
        b=bTbQ3UkqfymUxVYTBbXixyJqQpxB5PcmVaZEn8AUI8tRhJEeeUziJqVKHzuycR5sOf
         npLQcWPrH30+2AvsDD/3M7Axs6gX4DNfRymXSlLhXu2LMzcDLMggsih1i4H1WvuV9lM9
         1Xilm/1AAYi7UWbWI1D1kmmdpIUvCZpw8lWaYoDbcjT62q1zDkbjVKz47RiCN5RtW6cc
         gk4Mub6PlVWy0i/XVcwq/OZ7U6aU3SuhP7H27Os4Nku5izb0nvpUjpQYyTMv/1Wescr0
         c2Wd+l2aaMcQ8T0uAARwZsOp0F1R4/NmJ96ZFqERF1uZaN36V7deKvOsiDuXFyx3dfRe
         pvow==
X-Gm-Message-State: AOAM532fXOZ6XmjEXM5KnQbzeeOj9N2qs+2l447U6FQxrIIpfNL28J+r
        NVV6ZmvvUvFeKASXbHVPmDg2iq//PUCjLxkVpMMAaA==
X-Google-Smtp-Source: ABdhPJzCRFTicLTy9cM5bbeci/AK6fVi1KYo7ae9K3VJQlqo/4bUuwsUTPU7AUqzJpyQ04NwLoJF6qQJRt4wbejJ2SA=
X-Received: by 2002:a05:651c:3c6:: with SMTP id f6mr419657ljp.138.1590638715432;
 Wed, 27 May 2020 21:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200527111902.163213-1-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 May 2020 06:04:48 +0200
Message-ID: <CAG48ez3z4TTKHwQmZbeyb+egAdKsFb0kkReSLtJsA+9MP6VUBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 1:19 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> We've been making heavy use of the seccomp notifier to intercept and
> handle certain syscalls for containers. This patch allows a syscall
> supervisor listening on a given notifier to be notified when a seccomp
> filter has become unused.
[...]
> To fix this, we introduce a new "live" reference counter that tracks the
> live tasks making use of a given filter and when a notifier is
> registered waiting tasks will be notified that the filter is now empty
> by receiving a (E)POLLHUP event.
> The concept in this patch introduces is the same as for signal_struct,
> i.e. reference counting for life-cycle management is decoupled from
> reference counting live taks using the object.
[...]
> + * @live: tasks that actually use this filter, only to be altered
> + *          during fork(), exit()/free_task(), and filter installation

This comment is a bit off. Actually, @live counts the number of tasks
that use the filter directly plus the number of dependent filters that
have non-zero @live.

[...]
> +void seccomp_filter_notify(const struct task_struct *tsk)
> +{
> +       struct seccomp_filter *orig = tsk->seccomp.filter;
> +
> +       while (orig && refcount_dec_and_test(&orig->live)) {
> +               if (waitqueue_active(&orig->wqh))
> +                       wake_up_poll(&orig->wqh, EPOLLHUP);
> +               orig = orig->prev;
> +       }
> +}

/me fetches the paint bucket

Maybe name this seccomp_filter_unuse() or
seccomp_filter_unuse_notify() or something like that? The current name
isn't very descriptive.
