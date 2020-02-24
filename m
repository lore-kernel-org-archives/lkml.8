Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88294C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691D42072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgBXMZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:25:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48310 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgBXMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:25:16 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j6CnI-0002AG-1u; Mon, 24 Feb 2020 12:25:04 +0000
Date:   Mon, 24 Feb 2020 13:25:03 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH][next] clone3: fix an unsigned args.cgroup comparison to
 less than zero
Message-ID: <20200224122503.2m4oc5wgg2oqpjsi@wittgenstein>
References: <20200222001513.43099-1-colin.king@canonical.com>
 <20200222121801.cu4dfnk4z5xd5uc2@wittgenstein>
 <20200224073157.GB3286@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224073157.GB3286@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 10:31:57AM +0300, Dan Carpenter wrote:
> On Sat, Feb 22, 2020 at 01:18:01PM +0100, Christian Brauner wrote:
> > On Sat, Feb 22, 2020 at 12:15:13AM +0000, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 2diff --git a/kernel/fork.c b/kernel/fork.c
> > index 2853e258fe1f..dca4dde3b5b2 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2618,7 +2618,8 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> >                      !valid_signal(args.exit_signal)))
> >                 return -EINVAL;
> > 
> > -       if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup < 0)
> > +       if ((args.flags & CLONE_INTO_CGROUP) &&
> > +           (args.cgroup > INT_MAX || (s64)args.cgroup < 0))
> 
> If we're capping it at INT_MAX then the check for negative isn't
> required and static analysis tools know it's not so they might complain.

It isn't, but it's easier to understand for the reader. But I don't care
that much and if it's trouble for tools than fine.

Christian
