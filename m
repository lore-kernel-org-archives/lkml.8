Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAA1C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABB524672
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pywZLKqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgAMVFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:05:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39472 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAMVFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:05:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id l2so11723551lja.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 13:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/u5MUGVpDUAbfDbLeEsPX6aUptgWMsZ6OpMkOdaH+A4=;
        b=pywZLKqdxPfExS0SnABaJ4aTlQdAJxvMIPcUiv09kBnxMbRddIefk6L+AZtCxKjWgA
         liHsrkFRC3T9RBzdlmOhUVoaEwJ5JAUBmXvh78E0up26nPZ4ijaFW8mUbjAFWyB2kxi1
         edgeWwJ3faA3x9NLcDaEa0gXbEXEgCF6iZ12xGf4x2B1oR62JNenKpXiDsinOqybcBL/
         5z60/LxPmvRsfacCOOyvejl2NFaOXDPWX6k8QKvbmBf8vjXLe2Nc/I6MAqALAeeOUOB3
         5OC/2iiijXYynwhr1LtgfBkelfr6L54T3rAd02/rrhUTlSv2CTl04r7b6+dIP+dzetEf
         HUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/u5MUGVpDUAbfDbLeEsPX6aUptgWMsZ6OpMkOdaH+A4=;
        b=laO2nZKf2P8Y4XOlR27YOe9z4Bz7F8dztZVFO/0knOC0D8htPN9zaf5myzE0+QpSjb
         O4i160YPeP5nhMsdl6hk/0XwQeQrnAkRnpYg+plWMzFTyeEdZGQb+nBWnr50yVtzEOBf
         +qZnMJo0MddnJGssaqN1kw9/cwz6Owe6kaVOVYW+ABctGFyT8my21Z6tWP25KOHaNfUc
         BYPrfdJknsx1UXqQW9/pts9WA9lrfqEmGIbhbmsNdXgpWb90AYSCZGhCNkjqdkX1JJlm
         6DWv6UkdhQmp4bGsWMcvz111KfYl6j+0oPohETepUjmf0KInXBa14xdqcsUQ8xEoMiKq
         ZhwQ==
X-Gm-Message-State: APjAAAW4k2a60sf0aYJp1GHPEAmFv7nccePQAU5ze8k1z0m5d6qTbzhV
        MRXzY0ROv4+pXIeJRRuSFvdH4oA29X8MrxRYdHtIauKW
X-Google-Smtp-Source: APXvYqzQfqC3NRhrk3Zbw6Vxs6CF1OSy/YynDWKFCf4ieKNe8SG3O6+EGYSzBmYNgwrdJR5te76K8Vzy42PCS745ObY=
X-Received: by 2002:a2e:884d:: with SMTP id z13mr12351302ljj.116.1578949522306;
 Mon, 13 Jan 2020 13:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20200110213433.94739-1-minchan@kernel.org> <20200110213433.94739-3-minchan@kernel.org>
 <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com> <20200113104256.5ujbplyec2sk4onn@wittgenstein>
 <20200113184408.GD110363@google.com> <20200113191046.2tidyvc544zvchek@wittgenstein>
 <CAKOZuev5k3EquMd-6VbvruahjjtxQzRhUVo2ttgVyk+yYz9aOA@mail.gmail.com> <20200113204237.ew6nn4ohxu7auw3u@wittgenstein>
In-Reply-To: <20200113204237.ew6nn4ohxu7auw3u@wittgenstein>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 13 Jan 2020 13:04:44 -0800
Message-ID: <CAKOZueu=U4c2URaq8Pz-B00XV+TxaKwHRNXv3BUiDbQrLQpJ3A@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 12:42 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Mon, Jan 13, 2020 at 11:27:03AM -0800, Daniel Colascione wrote:
> > On Mon, Jan 13, 2020 at 11:10 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > > This does not
> > > affect the permission checking you're performing here.
> >
> > Pidfds-as-capabilities sounds like a good change. Can you clarify what
> > you mean here though? Do you mean that in order to perform some
> > process-directed operation X on process Y, the pidfd passed to X must
> > have been opened with PIDFD_CAP_X *and* the process *using* the pidfds
> > must be able to perform operation X on process Y? Or do pidfds in this
> > model "carry" permissions in the same way that an ordinary file
> > descriptor "carries" the ability to write to a file if it was opened
> > with O_WRONLY even if the FD is passed to a process that couldn't
> > otherwise write to that file? Right now, pidfds are identity-only and
> > always rely on the caller's permissions. I like the capability bit
> > model because it makes pidfds more consistent with other file
> > descriptors and enabled delegation of capabilities across the system.
>
> I'm going back and forth on this. My initial implementation has it that
> you'd need both, PIDFD_FLAG/CAP_X and the process using the pidfd must
> be able to perform the operation X on process Y. The alternative becomes
> tricky for e.g. anything that requires ptrace_may_access() permissions
> such as getting an fd out from another task based on its pidfd and so
> on.

I think the alternative is necessary though. What's the point of the
pidfd capability bits if they don't grant access? If I have a pidfd
for Y that doesn't let me do operation X, but I have ambient authority
to do Y anyway, then I can just make my own pidfd for Y and then use
that new pidfd to do X. AFAICT, pidfd capabilities only do something
when they replace ptrace_may_access and friends for access control.
Otherwise, they seem purely advisory. Am I missing something?
