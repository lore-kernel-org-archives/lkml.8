Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76F7C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47FB24686
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgAMUmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:42:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52283 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAMUmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:42:44 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ir6Xm-0004SH-UB; Mon, 13 Jan 2020 20:42:39 +0000
Date:   Mon, 13 Jan 2020 21:42:37 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Daniel Colascione <dancol@google.com>
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
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
Message-ID: <20200113204237.ew6nn4ohxu7auw3u@wittgenstein>
References: <20200110213433.94739-1-minchan@kernel.org>
 <20200110213433.94739-3-minchan@kernel.org>
 <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
 <20200113104256.5ujbplyec2sk4onn@wittgenstein>
 <20200113184408.GD110363@google.com>
 <20200113191046.2tidyvc544zvchek@wittgenstein>
 <CAKOZuev5k3EquMd-6VbvruahjjtxQzRhUVo2ttgVyk+yYz9aOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZuev5k3EquMd-6VbvruahjjtxQzRhUVo2ttgVyk+yYz9aOA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 11:27:03AM -0800, Daniel Colascione wrote:
> On Mon, Jan 13, 2020 at 11:10 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > This does not
> > affect the permission checking you're performing here.
> 
> Pidfds-as-capabilities sounds like a good change. Can you clarify what
> you mean here though? Do you mean that in order to perform some
> process-directed operation X on process Y, the pidfd passed to X must
> have been opened with PIDFD_CAP_X *and* the process *using* the pidfds
> must be able to perform operation X on process Y? Or do pidfds in this
> model "carry" permissions in the same way that an ordinary file
> descriptor "carries" the ability to write to a file if it was opened
> with O_WRONLY even if the FD is passed to a process that couldn't
> otherwise write to that file? Right now, pidfds are identity-only and
> always rely on the caller's permissions. I like the capability bit
> model because it makes pidfds more consistent with other file
> descriptors and enabled delegation of capabilities across the system.

I'm going back and forth on this. My initial implementation has it that
you'd need both, PIDFD_FLAG/CAP_X and the process using the pidfd must
be able to perform the operation X on process Y. The alternative becomes
tricky for e.g. anything that requires ptrace_may_access() permissions
such as getting an fd out from another task based on its pidfd and so
on.

Christian
