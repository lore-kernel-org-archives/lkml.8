Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109A5C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD354206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO721s4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgD1OcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:32:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27381 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727855AbgD1OcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588084323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2SlTGLtYaTdehOLDxIEKTdZ7FKV0xedALB+Auejv0kM=;
        b=YO721s4+f2LONr00M8KlUDtTYnsuRCUdTJMT059zwK84t+JLRbOTHZiCxWKSzxFw+RucL3
        5lexbYIduYKUMWYPcroUNGJk5pv8+H31h6UXn4uyE6dNe0MP5B0gfKd6U6th0jDn7JwXok
        nb96gaTOidp7ZGWdNlO4jBtKba6X1zI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-Wflh6F4yNOeOEVHAR_05Ow-1; Tue, 28 Apr 2020 10:32:01 -0400
X-MC-Unique: Wflh6F4yNOeOEVHAR_05Ow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 431B6800688;
        Tue, 28 Apr 2020 14:32:00 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EAA25D710;
        Tue, 28 Apr 2020 14:31:59 +0000 (UTC)
Date:   Tue, 28 Apr 2020 09:31:57 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        alexandre.chartre@oracle.com
Subject: Re: x86 entry perf unwinding failure (missing IRET_REGS annotation
 on stack switch?)
Message-ID: <20200428143157.nxxrgfpo3leia2kr@treble>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
 <20200428070450.w5l5ey54dtmqy5ph@treble>
 <20200428124627.GC13558@hirez.programming.kicks-ass.net>
 <20200428141614.GA13616@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428141614.GA13616@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 04:16:14PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 28, 2020 at 02:46:27PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 28, 2020 at 02:04:50AM -0500, Josh Poimboeuf wrote:
> 
> > > I'm thinking something like this should fix it.  Peter, does this look
> > > ok?
> > 
> > Unfortunate. But also, I fear, insufficient. Specifically consider
> > things like:
> > 
> > 	ALTERNATIVE "jmp 1f",
> > 		"alt...
> > 		"..."
> > 		"...insn", X86_FEAT_foo
> > 	1:
> > 
> > This results in something like:
> > 
> > 
> > 	.text	.altinstr_replacement
> > 	e8 xx	...
> > 	90
> > 	90
> > 	...
> > 	90
> > 
> > Where all our normal single byte nops (0x90) are unreachable with
> > undefined CFI, but the alternative might have CFI, which is never
> > propagated.
> > 
> > We ran into this with the validate_alternative stuff from Alexandre.
> 
> > So rather than hacking around this issue, should we not make
> > create_orc() smarter?
> > 
> > I'm trying to come up with something, but so far I'm just making a mess.
> 
> Like this, it's horrid, but it seems to work.
> 
> What do you think of the approach? I'll work on cleaning it up if you
> don't hate it too much ;-)

How'd you know I'd hate it ;-)

That's quite the monstrosity, and I still don't see the point.  I
thought we decided to just disallow CFI changes in alternatives anyway?
That can be done much simpler.

-- 
Josh

