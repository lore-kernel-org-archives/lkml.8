Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53109C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3352620899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgE0TNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:13:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46020 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE0TNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:13:41 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1je1Ue-0003jw-Hw; Wed, 27 May 2020 19:13:36 +0000
Date:   Wed, 27 May 2020 21:13:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matt Denton <mpdenton@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <20200527191335.mt5ywrgvpppiqj7v@wittgenstein>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <20200527173706.GA1242@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527173706.GA1242@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 05:37:07PM +0000, Sargun Dhillon wrote:
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
> > +
> Any reason not to write this as:
> for (orig = tsk->seccomp.filter; refcount_dec_and_test(&orig->live); orig = orig->prev)?

Mainly to follow coding style if you look at:

static void __put_seccomp_filter(struct seccomp_filter *orig)
{
	/* Clean up single-reference branches iteratively. */
	while (orig && refcount_dec_and_test(&orig->usage)) {
		struct seccomp_filter *freeme = orig;
		orig = orig->prev;
		seccomp_filter_free(freeme);
	}
}

seemed easier to just have a visual correspondence between those two
codepaths.

> 
> Also, for those of us who are plumbing in the likes of Go code into the
> listener, where we don't have direct access to the epoll interface (at
> least not out of the box), what do you think about exposing this on the RECV

I think requiring users to import
golang.org/x/sys/unix
is reasonable. You'll need to special case this to linux builds anyway
even if you have a client or some such that build on on-unixes. And even
if you don't want to import there's always the possibility to use cgo. :)

> ioctl? Or, do you think we should lump that into the "v2" receive API?

I'm confused how you want to plumb this into the ioctl. That seems
unpleasant and against usual poll/wait semantics. I'm now also wondering
how you're using this whole interface without poll. The idea is to wait
until you're notified you can receive.

> 
> Either way, this seems useful, as right now, we're intertwining process
> tree lifetime with manager lifetime. This seems cleaner.

Cool.
Christian
