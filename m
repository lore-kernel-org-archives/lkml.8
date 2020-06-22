Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03E7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB192071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5GkBE1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgFVMDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:03:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59514 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726889AbgFVMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592827389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XVrUkWunS1SNkKo57Lfv0f1FPTYSboRjBRmoZLWSzhU=;
        b=Z5GkBE1hD1FvRxwTP71pRGEzdbi8G0HrcUOq45h5j4OGPEeeHTPqKSHz+v4Gt3ng3P4OSt
        7hQDyYFPeaHl/uqgtSYl/ucy/qLVzPhGEuadoFYjCjG/afczo7CCIQi6RsDJ2nUmyWO/Gc
        jqjGF0yAjIxk8g5FHiibf+4GyrkmTPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-hb0t208fPqq-Zx5kPmQn6w-1; Mon, 22 Jun 2020 08:03:05 -0400
X-MC-Unique: hb0t208fPqq-Zx5kPmQn6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC3A881CBE3;
        Mon, 22 Jun 2020 12:03:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.236])
        by smtp.corp.redhat.com (Postfix) with SMTP id 77C9F5C1BD;
        Mon, 22 Jun 2020 12:03:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Jun 2020 14:03:03 +0200 (CEST)
Date:   Mon, 22 Jun 2020 14:03:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, liuzhiqiang26@huawei.com,
        joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
Message-ID: <20200622120259.GD6516@redhat.com>
References: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
 <20200622062527.GA6516@redhat.com>
 <20200622083905.c3nurmkbo5yhd6lj@wittgenstein>
 <20200622102401.GA12377@nautica>
 <20200622113610.okzntx7jmnk6n7au@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622113610.okzntx7jmnk6n7au@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22, Christian Brauner wrote:
>
> On Mon, Jun 22, 2020 at 12:24:01PM +0200, Dominique Martinet wrote:
> > Christian Brauner wrote on Mon, Jun 22, 2020:
> > > On Mon, Jun 22, 2020 at 08:25:28AM +0200, Oleg Nesterov wrote:
> > >> current->sighand is stable and can't go away. Unless "current" is exiting and
> > >> has already passed exit_notify(). So I don't think net/9p needs this helper.
> > >
> > > From what I can gather from the thread (cf. [1]) that is linked in the
> > > commit message the main motivation for all of this is sparse not being
> > > happy and not some bug. (Maybe I'm not seeing something though.)
> > >
> > > The patch itself linked here doesn't seem to buy anything. I agree with
> > > Oleg. Afaict, lock_task_sighand() would only be needed here if the task
> > > wouldn't be current. So maybe it should just be dropped from the series.
> >
> > Sure. I honestly have no idea on what guarantees we have from the task
> > being current here as opposed to any other task -- I guess that another
> > thread calling exit for exemple would have to wait?
>
> When a thread in a non-trivial thread-group (sorry for the math
> reference :)) execs it'll unshare its struct sighand.

Well, not really...

The execing threads will kill other other threads, then it will check
if ->sighand should be unshared. The latter is very unlikely, I don't
think CLONE_SIGHAND without CLONE_THREAD is actually used today.

But this doesn't really matter. I mean, even if you race with another
thread doing exec/exit/whatever, current->sighand is stable. Unless, again,
current has already exited (called exit_notify()).

> The new struct
> sighand will be assigned using rcu_assign_pointer() so afaik (Paul or
> Oleg can yell at me if I'm talking nonsense) any prior callers will see
> the prior sighand value.

Yes, but see above.

If tsk is not current, then (in general) it is not safe to use tsk->sighand
directly. It can can be changed by exec (as you explained), or you can hit
tsk->sighand == NULL if you race with exit.

Oleg.

