Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F58AC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C949215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gidG8iko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgIGLpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729043AbgIGLnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599478990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Up+NtoEoKF1B3IFUbGlV4iwCjaDtp0Abje/+V+Ja+dY=;
        b=gidG8iko2bR8798ai1rgrwdV/XPFt9G0nsZCxcMRq3BOjgv6nLhi+V+aI7GFWw4q+CW0c1
        MWLeSn1ZxmWKjzMMrB0mwHM4Yc139rE4nNqFbXSZysch81gCyb/Sdktsj0mD6atNxpVYbD
        NpGcXBf/cTD8a4ZsJ/gAixDqj13Y3e8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-KTPUyLjDNq2xpVad29wziw-1; Mon, 07 Sep 2020 07:43:06 -0400
X-MC-Unique: KTPUyLjDNq2xpVad29wziw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BAFA1007461;
        Mon,  7 Sep 2020 11:43:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.127])
        by smtp.corp.redhat.com (Postfix) with SMTP id 724625C26B;
        Mon,  7 Sep 2020 11:43:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  7 Sep 2020 13:43:04 +0200 (CEST)
Date:   Mon, 7 Sep 2020 13:43:02 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     rostedt@goodmis.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fgraph: Convert ret_stack tasklist scanning to rcu
Message-ID: <20200907114301.GA31050@redhat.com>
References: <20200907013326.9870-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907013326.9870-1-dave@stgolabs.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06, Davidlohr Bueso wrote:
>
> Here tasklist_lock does not protect anything other than the list
> against concurrent fork/exit. And considering that the whole thing
> is capped by FTRACE_RETSTACK_ALLOC_SIZE (32), it should not be a
> problem to have a pontentially stale, yet stable, list. The task cannot
> go away either, so we don't risk racing with ftrace_graph_exit_task()
> which clears the retstack.

I don't understand this code but I think you right, tasklist_lock buys
nothing.

Afaics, with or without this change alloc_retstack_tasklist() can race
with copy_process() and miss the new child; ftrace_graph_init_task()
can't help, ftrace_graph_active can be set right after the check and
for_each_process_thread() can't see the new process yet.

This can't race with ftrace_graph_exit_task(), it is called after the
full gp pass. But this function looks very confusing to me, I don't
understand the barrier and the "NULL must become visible to IRQs before
we free it" comment.

Looks like, ftrace_graph_exit_task() was called by the exiting task
in the past? Indeed, see 65afa5e603d50 ("tracing/function-return-tracer:
free the return stack on free_task()"). I think it makes sense to
simplify this function now, it can simply do kfree(t->ret_stack) and
nothing more.

ACK, but ...

> @@ -387,8 +387,8 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
>  		}
>  	}
>  
> -	read_lock(&tasklist_lock);

then you should probably rename alloc_retstack_tasklist() ?

Oleg.

