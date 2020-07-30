Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB05E22CA0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgG3OnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:43:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53322 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgG3OnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:43:15 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k19ln-0001Uf-3p; Thu, 30 Jul 2020 14:42:55 +0000
Date:   Thu, 30 Jul 2020 16:42:54 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, davem@davemloft.net,
        akpm@linux-foundation.org, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
Message-ID: <20200730144254.uabteale5tvtpkzp@wittgenstein>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <87k0yl5axy.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87k0yl5axy.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:34:01AM -0500, Eric W. Biederman wrote:
> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> 
> > Currently, there is no a way to list or iterate all or subset of namespaces
> > in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
> > but some also may be as open files, which are not attached to a process.
> > When a namespace open fd is sent over unix socket and then closed, it is
> > impossible to know whether the namespace exists or not.
> >
> > Also, even if namespace is exposed as attached to a process or as open file,
> > iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
> > this multiplies at tasks and fds number.
> 
> I am very dubious about this.
> 
> I have been avoiding exactly this kind of interface because it can
> create rather fundamental problems with checkpoint restart.
> 
> You do have some filtering and the filtering is not based on current.
> Which is good.
> 
> A view that is relative to a user namespace might be ok.    It almost
> certainly does better as it's own little filesystem than as an extension
> to proc though.
> 
> The big thing we want to ensure is that if you migrate you can restore
> everything.  I don't see how you will be able to restore these files
> after migration.  Anything like this without having a complete
> checkpoint/restore story is a non-starter.
> 
> Further by not going through the processes it looks like you are
> bypassing the existing permission checks.  Which has the potential
> to allow someone to use a namespace who would not be able to otherwise.
> 
> So I think this goes one step too far but I am willing to be persuaded
> otherwise.

I think we discussed this at Plumbers (last year I want to say?) and
you were against making this a part of procfs already back then, I
think. The last known idead we could agree on was debugfs (shudder). But
a tiny separate fs might work as well.

We really would want those introspection abilities this provides though.
For us it was for debugging when namespaces linger and also to crawl
and inspect namespaces from LXD and various other use-cases. So if we
could make this happen in some form that'd be great.

Thanks!
Christian
