Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F6C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21575216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3geM7oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgEAPNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:13:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31005 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728896AbgEAPNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588346000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F4yL4oTUsOpbnfJKXRJ3LDveHMm1KM/d4GtJdspShdk=;
        b=J3geM7ozXb4qY+RP49bGdsP5j+GeJqJZIUkX9xPbQrqYF785LtBVSjgNv2WOCNwPfZAJeH
        3Kk83PORUWrObJrUKXFMYsWFGSZGWyltXyz6gmRLOFKSSP1u4xkDHYxaQ+9nkQm5tugtvp
        XJL2ATLWWFJQSG12nsUTETVF8ySBBGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-BCs19SbTMpe_3nCJyFV0SA-1; Fri, 01 May 2020 11:13:16 -0400
X-MC-Unique: BCs19SbTMpe_3nCJyFV0SA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F28568005B7;
        Fri,  1 May 2020 15:13:14 +0000 (UTC)
Received: from treble (ovpn-114-104.rdu2.redhat.com [10.10.114.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBA6A5C1BB;
        Fri,  1 May 2020 15:13:12 +0000 (UTC)
Date:   Fri, 1 May 2020 10:13:10 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC][PATCH] x86/ftrace: Have ftrace trampolines turn read-only
 at the end of system boot up
Message-ID: <20200501151310.zo5bhnxpu5gubofj@treble>
References: <20200430202147.4dc6e2de@oasis.local.home>
 <20200501044733.eqf6hc6erucsd43x@treble>
 <20200501051706.4wkrqwovybt2p6hr@treble>
 <20200501092404.06d1adcb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501092404.06d1adcb@gandalf.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 09:24:04AM -0400, Steven Rostedt wrote:
> On Fri, 1 May 2020 00:17:06 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > > Would it be easier to just call a new __text_poke_bp() which skips the
> > > SYSTEM_BOOTING check, since you know the trampoline will always be
> > > read-only?
> > > 
> > > Like:  
> > 
> > early_trace_init() is called after mm_init(), so I thought it might
> > work, but I guess not:
> 
> Yeah, I was about to say that this happens before mm_init() ;-)

It happens *after* mm_init().  But now text_poke() has a dependency on
poking_init(), has a dependency on proc_caches_init(), which has a
dependency on kmem_cache_init_late(), etc.

So how early do you need early_trace_init()?  I'm assuming moving it to
after kmem_cache_init_late() would be too late.

> It's why we already have magic for enabling function tracing the first time.
> 
> Do you see anything wrong with this current solution? It probably needs
> more comments, but I wanted to get acceptance on the logic before I go and
> pretty it up and send a non RFC patch.

Assuming we can't get text_poke() working earlier, it seems reasonable
to me.

-- 
Josh

