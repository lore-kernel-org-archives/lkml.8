Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA03FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C073120899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgE0PfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:35:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39291 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgE0PfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:35:07 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jdy5B-0005PW-I8; Wed, 27 May 2020 15:35:05 +0000
Date:   Wed, 27 May 2020 17:35:04 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <20200527153504.d7va44xn75fbzyrr@wittgenstein>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <20200527152559.GB4153131@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527152559.GB4153131@cisco>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:25:59AM -0600, Tycho Andersen wrote:
> On Wed, May 27, 2020 at 01:19:01PM +0200, Christian Brauner wrote:
> > +void seccomp_filter_notify(const struct task_struct *tsk)
> > +{
> > +	struct seccomp_filter *orig = tsk->seccomp.filter;
> > +
> > +	while (orig && refcount_dec_and_test(&orig->live)) {
> > +		if (waitqueue_active(&orig->wqh))
> > +			wake_up_poll(&orig->wqh, EPOLLHUP);
> > +		orig = orig->prev;
> > +	}
> > +}
> 
> Is there a reason this can't live in put_seccomp_filter()?

put_seccomp_filter() is called from free_task() which in turn gets
called via delayed_put_task_struct through call_rcu() so the
notification will happen at some point whereas you'd often want the
notification to happen at reliable point. This is why most of that stuff
happens in release_task() which is called in the exit path when the task
is finally marked as dead. This is similar to how cgroup_release() is
called from release_task() whereas cgroup_free() is called from
free_task() or other stuff.
