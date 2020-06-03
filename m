Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FD9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5E820679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="i4l7WCm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgFCX5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgFCX5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:57:38 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7570C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 16:57:36 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q19so4058554eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 16:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qxl9UqwBxJWfx8IWKXcwSwjGKz8RQbusLDYMB9ncMJU=;
        b=i4l7WCm1Z5zGSujeMsVJUyO08b2q/Hb/0ZptV6brzAfQzAlV86jOsCR4m+FUtjzGl4
         4Cqalj8Xr5UtMNdWribSTS4X5lqqF+KltPrGsBRHnaFzJH+5wIrS8Ow4cI6befD2Kpxv
         Nz/kxP5A2ADSemhyLF1+kAKfU5BwnG+onbMGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qxl9UqwBxJWfx8IWKXcwSwjGKz8RQbusLDYMB9ncMJU=;
        b=QsrCVl0o+SnMofI7hA8JfqFeOfj3Je3aKNWF2oob9GpgFySeWYCacDWamw/Q6ygmhW
         IfPNei7iXCSjXukHu2bZ9DYouweXIGIL/XEDiWyDRAVhjgiqR+lTD9bJEFHKU16z5mGt
         LEmTStT0pd+1O8coDWI1fcqVnrKGLTdVKY/Mn82a0okS8kM7PUCKDn1q0nf5odRl8Mbi
         L673rmhZ8p+kH8myg8jKeSu4ic/odklH8s02KLMsUI84fEDNLbZY8koOiuFnVUTSBGZ/
         f/BZgPz9PEN4xj7PgC+wuMzS1aJb+VB72tcqjFnapVsSJj0nZ/PEdoD10mp1wklYr8Bc
         Jbcw==
X-Gm-Message-State: AOAM532pEsk4BijzUrjw/saBi3s4eodFO7H+Ubz6lS95SbbSruYFqUtU
        aZ92zD1WMTPOtEwp7xBUP+xiQ+gAXhRKjlyQnv5/pA==
X-Google-Smtp-Source: ABdhPJxq5weChnYWGZX8A/LxL13fIKbCFvAwo23a3Z/SlQObiHXmtI8ec7QPALTa21EqNlaI9ueFmeHjPnztX6wc/pg=
X-Received: by 2002:a17:906:95d6:: with SMTP id n22mr144782ejy.138.1591228655260;
 Wed, 03 Jun 2020 16:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011044.7972-1-sargun@sargun.me> <202006031639.E053742@keescook>
In-Reply-To: <202006031639.E053742@keescook>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Wed, 3 Jun 2020 16:56:59 -0700
Message-ID: <CAMp4zn-8iSozHvgqXBPKz-ux7HH6T4Dj9p0fA3fs_e7ZwEPZRg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add seccomp notifier ioctl that enables adding fds
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 4:42 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jun 02, 2020 at 06:10:40PM -0700, Sargun Dhillon wrote:
> > Sargun Dhillon (4):
> >   fs, net: Standardize on file_receive helper to move fds across
> >     processes
> >   pid: Use file_receive helper to copy FDs
>
> The fixes (that should add open-coded cgroups stuff) should be separate
> patches so they can be backported.
Patch 1/4, and 2/4 are separated so they can be backported. Patch 1 should
go into long term, and patch 2 should land in stable.

Do you see anything in 1/4, and 2/4 that shouldn't be there?

>
> The helper doesn't take the __user pointer I thought we'd agreed it
> should to avoid changing any SCM_RIGHTS behaviors?
>
It doesn't change the SCM_RIGHTS behaviour because it continues
to have the logic which allocates the file descriptor outside of the
helper.
1. Allocate FD (this happens in scm.c)
2. Copy FD # to userspace (this happens in scm.c)
3. Receive FD (this happens in the new helper)


> >   seccomp: Introduce addfd ioctl to seccomp user notifier
> >   selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
>
> Otherwise, yeah, this should be good.
>
> --
> Kees Cook
