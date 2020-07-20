Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0980CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A6422CB2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL9mwDA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGTG4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:56:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26653 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgGTG4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595228199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FGxfsH7JoYjo8uZ25QL7MHJ8zI5IrhXb8UDFK05X1AM=;
        b=DL9mwDA76NTgnEh89lqiAWYEp6CIqOUCokwKSwVYUszNaAg+scjhnHrtB0QdlAPkPDLLYn
        hnZTNy0rVBCTHvmkhdSG3gw6K2qVc5l9mpZRAs2wdOnL61zcCXsvUJHiWD6mxnqBg/Wu0k
        bX19ujrystojha/1AGyxbSeW6lysjag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-uz-DO6llPKelP1Kl2nFCvw-1; Mon, 20 Jul 2020 02:56:37 -0400
X-MC-Unique: uz-DO6llPKelP1Kl2nFCvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D44D19057A8;
        Mon, 20 Jul 2020 06:56:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.147])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1007A1001B07;
        Mon, 20 Jul 2020 06:56:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 20 Jul 2020 08:56:35 +0200 (CEST)
Date:   Mon, 20 Jul 2020 08:56:33 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200720065633.GB6612@redhat.com>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717122651.GA6067@redhat.com>
 <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <0deb1081-299b-1475-f368-7ca65b535a9c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0deb1081-299b-1475-f368-7ca65b535a9c@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20, Jiri Slaby wrote:
>
> On 18. 07. 20, 19:14, Oleg Nesterov wrote:
> >
> > This is already wrong. But
> >
> > 	Where does this __might_sleep() come from ??? I ses no blocking calls
> > 	in ptrace_stop(). Not to mention it is called with ->siglock held and
> > 	right after this lock is dropped we take tasklist_lock.
>
> Decoded stacktrace:
>
> > ptrace_stop (include/linux/freezer.h:57 include/linux/freezer.h:67 include/linux/freezer.h:128 include/linux/freezer.h:173 kernel/signal.c:2217)
> > ptrace_do_notify (kernel/signal.c:2272)
> > ptrace_notify (arch/x86/include/asm/paravirt.h:656 arch/x86/include/asm/qspinlock.h:55 include/linux/spinlock.h:211 include/linux/spinlock_api_smp.h:167 include/linux/spinlock.h:403 kernel/signal.c:2282)
> > syscall_trace_enter (include/linux/tracehook.h:73 include/linux/tracehook.h:104 arch/x86/entry/common.c:159)
> > do_syscall_64 (arch/x86/entry/common.c:380)
> > entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:124)
>
> It is try_to_freeze_unsafe in try_to_freeze in freezable_schedule in
> ptrace_stop.

Aha, thanks a lot!

try_to_freeze_unsafe() is called after schedule() which must return with
->state = RUNNING, so this matches another WARN_ON(current->state) added
by debugging patch after freezable_schedule().

Somehow I decided __might_sleep() was called before read_unlock/schedule.

> >
> >       How this connects to the debugging patch I sent? Did you see this warning
> >       without that patch?
>
> I suppose this made it appear:
> +CONFIG_PREEMPT_COUNT=y
> -# CONFIG_DEBUG_ATOMIC_SLEEP is not set
> +CONFIG_DEBUG_ATOMIC_SLEEP=y

I see,

> Please see my other e-mail, all this is with dbfb089d360b applied. Maybe
> it makes more sense now?

Yes. Thanks Jiri!

Oleg.

