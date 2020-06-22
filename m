Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAD7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505722070E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgFVLgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:36:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35329 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgFVLgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:36:15 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnKkF-0000YV-Mk; Mon, 22 Jun 2020 11:36:11 +0000
Date:   Mon, 22 Jun 2020 13:36:10 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, liuzhiqiang26@huawei.com,
        joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
Message-ID: <20200622113610.okzntx7jmnk6n7au@wittgenstein>
References: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
 <20200622062527.GA6516@redhat.com>
 <20200622083905.c3nurmkbo5yhd6lj@wittgenstein>
 <20200622102401.GA12377@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622102401.GA12377@nautica>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:24:01PM +0200, Dominique Martinet wrote:
> Christian Brauner wrote on Mon, Jun 22, 2020:
> > On Mon, Jun 22, 2020 at 08:25:28AM +0200, Oleg Nesterov wrote:
> >> current->sighand is stable and can't go away. Unless "current" is exiting and
> >> has already passed exit_notify(). So I don't think net/9p needs this helper.
> > 
> > From what I can gather from the thread (cf. [1]) that is linked in the
> > commit message the main motivation for all of this is sparse not being
> > happy and not some bug. (Maybe I'm not seeing something though.)
> > 
> > The patch itself linked here doesn't seem to buy anything. I agree with
> > Oleg. Afaict, lock_task_sighand() would only be needed here if the task
> > wouldn't be current. So maybe it should just be dropped from the series.
> 
> Sure. I honestly have no idea on what guarantees we have from the task
> being current here as opposed to any other task -- I guess that another
> thread calling exit for exemple would have to wait?

When a thread in a non-trivial thread-group (sorry for the math
reference :)) execs it'll unshare its struct sighand. The new struct
sighand will be assigned using rcu_assign_pointer() so afaik (Paul or
Oleg can yell at me if I'm talking nonsense) any prior callers will see
the prior sighand value.

> What about the possibility of sighand being null that the function does
> check, is that impossible for current as well?

See above, I think that's impossible.

> 
> 
> Honestly not a part of the code I'm much familiar with, this all
> predates my involvement with 9p by a fair bit...

We can't be experts in everything. :)

Christian
