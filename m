Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB6AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B880D22BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEgoS3an"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgGTOCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:02:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26752 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbgGTOCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595253754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mVYe0PcPmkjOf6CORnuWXSv9MuS8EVP6/4K4yP8XJ8g=;
        b=PEgoS3anGnRBbW6qQhm0VusQOWFfhXJbvb7r4gevFHqXUeON3wLZhr7hI0yD7Ufzju6jKo
        ekQFyfUGJ6oxrScoQmyf6QgXdvP5FW5WRI+zGw6ZE+LHXOFTMYm8iPvoioKmaKEdYqwRUD
        8rswB8lCNrYT67E2UEbmNYrQLZ/mFng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-WpRavCHzOTeF7Mv6KdB5tw-1; Mon, 20 Jul 2020 10:02:30 -0400
X-MC-Unique: WpRavCHzOTeF7Mv6KdB5tw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93775100960F;
        Mon, 20 Jul 2020 14:02:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.147])
        by smtp.corp.redhat.com (Postfix) with SMTP id 02D9B7305A;
        Mon, 20 Jul 2020 14:02:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 20 Jul 2020 16:02:28 +0200 (CEST)
Date:   Mon, 20 Jul 2020 16:02:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     peterz@infradead.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200720140224.GD6612@redhat.com>
References: <20200717122651.GA6067@redhat.com>
 <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720105924.GE43129@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20, Peter Zijlstra wrote:
>
> Also, is there any way to not have ptrace do this?

Well, we need to ensure that even SIGKILL can't wake the tracee up while
debugger plays with its registers/etc.

> How performance
> critical is this ptrace path?

This is a slow path.

We can probably change ptrace_check_attach() to call ptrace_freeze_traced()
after wait_task_inactive(), but I would like to not do this... Because we
actually want to avoid wait_task_inactive() when possible.

Perhaps ptrace_freeze_traced() can __task_rq_lock() to avoid the race with
__schedule() ? No, it reads prev_state before rq_lock().

> Because I really hate having to add code
> to __schedule() to deal with this horrible thing.

Oh yes, I agree.

I have to admit, I do not understand the usage of prev_state in schedule(),
it looks really, really subtle...

Oleg.

