Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A99C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CCCA2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgDUKVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:21:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52770 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgDUKVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:21:10 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jQq1Z-0001L1-1c; Tue, 21 Apr 2020 10:21:05 +0000
Date:   Tue, 21 Apr 2020 12:21:04 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christof Meerwald <cmeerw@cmeerw.org>
Subject: Re: [PATCH] signal: Avoid corrupting si_pid and si_uid in
 do_notify_parent
Message-ID: <20200421102104.6pt34jknxmtu5ygm@wittgenstein>
References: <20200419201336.GI22017@edge.cmeerw.net>
 <87sggyytnh.fsf@x220.int.ebiederm.org>
 <20200421083031.5wapruzncjkagvhf@wittgenstein>
 <20200421092846.GB6787@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421092846.GB6787@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:28:47AM +0200, Oleg Nesterov wrote:
> On 04/21, Christian Brauner wrote:
> >
> > > -		__group_send_sig_info(sig, &info, tsk->parent);
> > > +		__send_signal(sig, &info, tsk->parent, PIDTYPE_TGID, false);
> >
> > So below you switch to __send_signal() but set the "force" argument to
> > to "false".
> 
> it must be false, the signal is generated from the parent's namespace or
> its descendant
> 
> > Before that, if the signal was generated from another pid
> > namespace and we fixed up si_pid and si_uid the "force" argument was set
> > to "true",
> 
> before that the "force" argument could be falsely true by the same reason,
> task_pid_nr_ns(tsk, tsk->parent) can return 0 because "tsk" no longer have
> pids after __unhash_process().

As I said in my mail, looking at the codepath it seems safe. My question
was whether it is _always_ incorrectly false which I do think it is
because child subreapers can't come from outside the pid namespace. If
they could you could create a scenario where the signal is generated
from a sibling pid namespace in which case it would be correctly set to
true.

Christian
