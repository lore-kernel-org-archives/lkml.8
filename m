Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C82C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1A820675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1nOj8P0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgENU2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:28:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51441 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725975AbgENU2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589488131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TSLa/dtbCyvxyN5oIuPfHoLuHt8yn4QjYXztKgqiblU=;
        b=Q1nOj8P07empx1mqkH3jer8hjP1Gw1AMekXFiyk+U+1PHYlBiojU9ZRNHxb27oCUtKtTUR
        dT3BLaU9WZ8Dl9ZFdLdC7RVBH1U2tSWzFCzp7kB28ZVgIrKuvykp447TY21rzqeyXMfbQv
        qWJMRiOiwS6K5JL5zORF75iPE4vQ/Wk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-qANUTNzSPaqn5qHUdJuQOg-1; Thu, 14 May 2020 16:28:47 -0400
X-MC-Unique: qANUTNzSPaqn5qHUdJuQOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52D641005510;
        Thu, 14 May 2020 20:28:45 +0000 (UTC)
Received: from treble (ovpn-117-14.rdu2.redhat.com [10.10.117.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D31F1C933;
        Thu, 14 May 2020 20:28:42 +0000 (UTC)
Date:   Thu, 14 May 2020 15:28:39 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Jones <dsj@fb.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH 4.19 41/48] x86/unwind/orc: Prevent unwinding before ORC
 initialization
Message-ID: <20200514202839.l2ztrqd4zff4e4as@treble>
References: <20200513094351.100352960@linuxfoundation.org>
 <20200513094402.645961403@linuxfoundation.org>
 <20200513215210.GB27858@amd>
 <20200514194457.wipphhvyhzcshcup@treble>
 <20200514201340.GA14148@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200514201340.GA14148@amd>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:13:40PM +0200, Pavel Machek wrote:
> > > > @@ -563,6 +560,9 @@ EXPORT_SYMBOL_GPL(unwind_next_frame);
> > > >  void __unwind_start(struct unwind_state *state, struct task_struct *task,
> > > >  		    struct pt_regs *regs, unsigned long *first_frame)
> > > >  {
> > > > +	if (!orc_init)
> > > > +		goto done;
> > > > +
> > > >  	memset(state, 0, sizeof(*state));
> > > >  	state->task = task;
> > > >  
> > > 
> > > As this returns the *state to the caller, should the "goto done" move
> > > below the memset? Otherwise we are returning partialy-initialized
> > > struct, which is ... weird.
> > 
> > Yeah, it is a little weird.  In most cases it should be fine, but there
> > is an edge case where if there's a corrupt ORC table and this returns
> > early, 'arch_stack_walk_reliable() -> unwind_error()' could check an
> > uninitialized value.
> > 
> > Also the __unwind_start() error handling needs to set that error bit
> > anyway, in its error cases.  I'll fix it up.
> 
> I did this in the mean time. It moves goto around memset, and I
> believe that 8 in get_reg should have been sizeof(long) [not that it
> matters, x86-32 is protected by build bug on.]
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

I already have the same memset patch (along with other error-handling
fixes) which I'll be posting shortly once it runs through my testing.

Since the sizeof(long) thing isn't really a bug, I'll make that change
later, along with some other pending improvements I have.

-- 
Josh

