Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84634C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601FE20776
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlZR3lEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgDRRST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 13:18:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725887AbgDRRSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 13:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587230297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ie9EL70Lwd9PPSN1xNj6PeAxkZsghWSxXFhNLGVt4Vw=;
        b=NlZR3lEZhphKk1c/QeQ9WzcfZdNpOUglmzLDbwSqOANyjzJDYDe/CQteaankg5uiDFjSl9
        gyJTeuO6WF0XUaIANo293KC2hsBh/WEAQq0+lumS/Zw2s00I8Uf9sIr846UpDqwgYhFhaG
        1AXtFZRGyRUOpo2P/0rtSPM/mM0JuQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-96sEaGbqPjel3zKRyqR_Pg-1; Sat, 18 Apr 2020 13:18:15 -0400
X-MC-Unique: 96sEaGbqPjel3zKRyqR_Pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38ADDDB60;
        Sat, 18 Apr 2020 17:18:14 +0000 (UTC)
Received: from treble (ovpn-112-81.rdu2.redhat.com [10.10.112.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D891012973B;
        Sat, 18 Apr 2020 17:18:12 +0000 (UTC)
Date:   Sat, 18 Apr 2020 12:18:10 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, jthierry@redhat.com
Subject: Re: [PATCH v5 02/17] objtool: Better handle IRET
Message-ID: <20200418171810.n4vcaihdfksltuqg@treble>
References: <20200416114706.625340212@infradead.org>
 <20200416115118.631224674@infradead.org>
 <8692ee18-e553-6f90-5291-62d6d57407cd@oracle.com>
 <20200417182339.GJ20730@hirez.programming.kicks-ass.net>
 <CALCETrU58muwSVDstRJQGEn20aOOHFctzZkxHRGh-yEGR9x1VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrU58muwSVDstRJQGEn20aOOHFctzZkxHRGh-yEGR9x1VA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 04:53:31PM -0700, Andy Lutomirski wrote:
> I'm wondering if this would be easier if we just moved the guts of
> sync_core() into asm.
> 
> In the near future, I think we want to rework it a tiny bit.  In
> particular, I think we're going to want to make sync_core() do:
> 
> if (static_cpu_has(X86_FEATURE_SERIALIZE))
>   asm volatile ("serialize");
> else
>   iret_to_self();
> 
> where iret_to_self() is the meat of the IRET hack.  And then we're
> going to add a new thingy unmask_nmi() that does iret_to_self() on
> everything except SEV-ES.  The near-term motivation is that I think we
> have some genuine bugs in a couple of corner cases:
> 
> 1. On AMD chips, if NMI hits user code with invalid CS or SS, we will
> enter on the NMI stack, switch to the normal stack, and return with
> IRET, and the IRET will fail.  And then we end up in a nasty state in
> which NMIs are masked but the code path we run doesn't expect that.
> So we should unmask_nmi() in fixup_bad_iret() or similar.  Intel CPUs
> are unaffected because Intel is differently quirky.
> 
> 2.  do_nmi() does this:
> 
>     if (user_mode(regs))
>                 mds_user_clear_cpu_buffers();
> 
> because it can't safely call prepare_exit_to_usermode().  This is a
> gross wart and I'd like to fix it.  Fixing it involves teaching the
> relevant code paths to unmask_nmis() if they're going to so IRQs-on
> exit work.
> 
> None of this is really relevant to the current patch, but it wouldn't
> be unreasonable to turn the IRET thing from an inline asm into a real
> asm function if it makes objtool's life easier.

I don't think that would make objtool's life any easier -- it still has
to understand the stack impact of the IRET-to-self thing regardless.

-- 
Josh

