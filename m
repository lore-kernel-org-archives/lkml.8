Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6B0C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86374206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFFuLiv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgD1Qdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:33:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56535 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727920AbgD1Qdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588091617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wSkRhJrdUvPB39G9qnTZVglhIvjNd+74ma1bDbTUagI=;
        b=VFFuLiv9aYb4z3HhM6qXFLNTgdNWxS6YJf8i9Z6ajhMF1OjZKpK9GqJM9QD3Y6kUpYDzJO
        DQPJmPodDHO97XHAvD6vNveRIJBifteZ+wpyiu1wbB8ipRCmlUVa/MqCVnlle+Aru7wYAW
        /39QGAe4Op2OXUWZ1xPot7CM3xmaM98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-G9BrDAggPxGFtA_sAylraA-1; Tue, 28 Apr 2020 12:33:32 -0400
X-MC-Unique: G9BrDAggPxGFtA_sAylraA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AA75A0BD7;
        Tue, 28 Apr 2020 16:33:30 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E955560300;
        Tue, 28 Apr 2020 16:33:28 +0000 (UTC)
Date:   Tue, 28 Apr 2020 11:33:27 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        alexandre.chartre@oracle.com
Subject: Re: x86 entry perf unwinding failure (missing IRET_REGS annotation
 on stack switch?)
Message-ID: <20200428163327.br43qcontatbrxlf@treble>
References: <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
 <20200428070450.w5l5ey54dtmqy5ph@treble>
 <20200428124627.GC13558@hirez.programming.kicks-ass.net>
 <20200428141614.GA13616@hirez.programming.kicks-ass.net>
 <20200428143157.nxxrgfpo3leia2kr@treble>
 <20200428152552.GD13592@hirez.programming.kicks-ass.net>
 <20200428154909.4cjwetyyb2zhnq5i@treble>
 <20200428155413.b5xzef4s2kyzg5ed@treble>
 <20200428162551.GF12735@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428162551.GF12735@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:25:51AM -0700, Sean Christopherson wrote:
> On Tue, Apr 28, 2020 at 10:54:13AM -0500, Josh Poimboeuf wrote:
> > On Tue, Apr 28, 2020 at 10:49:09AM -0500, Josh Poimboeuf wrote:
> > > On Tue, Apr 28, 2020 at 05:25:52PM +0200, Peter Zijlstra wrote:
> > > > On Tue, Apr 28, 2020 at 09:31:57AM -0500, Josh Poimboeuf wrote:
> > > > > That's quite the monstrosity, and I still don't see the point.  I
> > > > > thought we decided to just disallow CFI changes in alternatives anyway?
> > > > > That can be done much simpler.
> > > > 
> > > > Something like so then ?
> > > > 
> > > > ---
> > > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > > index 8443ec690051..d14d83e6edb0 100644
> > > > --- a/tools/objtool/check.c
> > > > +++ b/tools/objtool/check.c
> > > > @@ -940,6 +940,7 @@ static int handle_group_alt(struct objtool_file *file,
> > > >  
> > > >  		last_new_insn = insn;
> > > >  
> > > > +		insn->alt_group = true;
> > > >  		insn->ignore = orig_insn->ignore_alts;
> > > >  		insn->func = orig_insn->func;
> > > >  
> > > > @@ -2242,6 +2243,11 @@ static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
> > > >  	list_for_each_entry(op, &insn->stack_ops, list) {
> > > >  		int res;
> > > >  
> > > > +		if (insn->alt_group) {
> > > > +			WARN_FUNC("alternative has CFI", insn->sec, insn->offset);
> > > > +			return 1;
> > > > +		}
> > > > +
> > > 
> > > ACK (separate patch)
> > 
> > BTW, since most people don't know what CFI is, how about something like
> > 
> > 	"unsupported stack change in alternatives code"
> 
> Would it be accurate to print
> 
> 	"unsupported CFI stack change in alternatives code"?
> 
> to give the developer something more explicit to plug into their search
> engine?

I don't have a strong opinion either way, though this warning is going
to be documented in stack-validation.txt anyway right Peter? :-)

-- 
Josh

