Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09AAC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B60207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2AFVg5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBSVFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:05:41 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34227 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgBSVFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:05:41 -0500
Received: by mail-ua1-f66.google.com with SMTP id 1so770414uao.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rt+9TBr746y3EZMJw1I5B3EZu8arYEFN5BR+od/TLHk=;
        b=M2AFVg5vlnRB3u0UzpK+hLhHk2mzBcRqt/6FJ1ZyF5r+AaBEx1gUxnRQSBOb0rzsyC
         OssyBFfAp6/IEb4RBw90uXsOGquHbiFdA522MeNyJB2f0frsziq3ldDADScxoHLDOIwK
         V6W4VIH3P43aqTC6dt4/ggCcYIxhLquDhGx5xo1MqBsqpvRW/rhYSUp3QnE1p/lrXuCX
         b5nzo1aS57ZMpuIbqh9o7gzTrOVuJzKHSZ4CHNyd/sCj/RRJlLgIqp2U4gPtkxn7CE2H
         Tk4t2hC5GVNf6S+sByLpwSYMsqe98h4r5qbRn0K4c6HsXz/6EDPWGEeKleNSQu5oF+vG
         qiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rt+9TBr746y3EZMJw1I5B3EZu8arYEFN5BR+od/TLHk=;
        b=iwC2Hke/376Egt+tKUkcMXtj7SYraoW6HeYaaLP9N9Kr9uo96RkMOXe9mHe8PPYe9g
         1cIU/yZkSeCBW4bylnK060IaWg+/wT+v9R30Kq+zO99Z15mjzICPatYLvqqVDPBgO5ze
         PXVg2fWi+aCByQSmHev1K3ecNwCGdIgZJzHAYLie3o6ixI0nqplb4LHpMiaIzlINntQD
         OtNfFGB9fJvvneARO2qAK6xpWDtZBwhCeBHGZCwtrGo3lBDdIYXQ/MAhauJmTYUOItoo
         ROMvnPdQu2q0iQ5FuwC7yLxig/+ZWyKZvdVRZUCw0FSY3lBxdtvVfkV1xYMHsJ3F3+EG
         xtiw==
X-Gm-Message-State: APjAAAXC/pyaSg+L0+vYrAZrk6caKJxTr/P6fwc6fRdUcJAK6eWgsXSf
        QyccYtVuRgbYeZDaYJbVVGhmmxghn7m4tgiagJkYZQ==
X-Google-Smtp-Source: APXvYqyF757Ew+pQ4E0xwgB8qcfQWw35zjjmEjMj+nIZ6Tie14cLrBVfS3I6x1GGc2ULc3K0ofDrC/N30QBzYaDoDsk=
X-Received: by 2002:ab0:32cf:: with SMTP id f15mr14592717uao.42.1582146338347;
 Wed, 19 Feb 2020 13:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20200219014433.88424-1-minchan@kernel.org> <20200219120123.07dda51c29006a892059ccde@linux-foundation.org>
In-Reply-To: <20200219120123.07dda51c29006a892059ccde@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 19 Feb 2020 13:05:27 -0800
Message-ID: <CAJuCfpEAk+kD=Wxn3t9VKZxr5CovvdExL47qkEosyEAMEQ6t+Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] introduce memory hinting API for external process
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:01 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 18 Feb 2020 17:44:26 -0800 Minchan Kim <minchan@kernel.org> wrote:
>
> > Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
> > application could give hints to kernel what memory range are preferred to be
> > reclaimed. However, in some platform(e.g., Android), the information
> > required to make the hinting decision is not known to the app.
> > Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
> > and that daemon must be able to initiate reclaim on its own without any app
> > involvement.
> >
>
> This patchset doesn't seem to be getting a lot of interest from other
> potential users?  It seems very specialized.  Are there or will there
> ever be any users of this apart from one Android daemon?

Don't know if this can be considered another user since it's still in
the Android realm of things.
I'm interested in extending process_madvise() to support MADV_DONTNEED
to expedite memory ripping of a process killed by Android Low Memory
Killer. But for that I need process_madvise() to be accepted first.
IIRC Crome team was interested in these madv hints as well at some point...

>
> Also, it doesn't terribly hard for ActivityManagerService to tell
> another process "now run madvise with these arguments".  Please explain
> why this is not practical in ActivityManagerService and also within
> other potential users of this syscall.
>
>
