Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF89BC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C7520857
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FN0iqcin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbgDBVn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:43:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25733 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726963AbgDBVn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585863807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xsIz4H/Ni5AE+EVn4JwYu2FiPVnZwl2enRQ269SRuYE=;
        b=FN0iqcin/XA4yCpoI7dLytw18ov2iooAU9XxGnGh2XiFvjk4gHh8/RB+gQEgsafuu4JM1g
        u8WguidQT5pt/eX9QPqzUHEfPYiqjvDZ9JH6CHYUvl7RkY9hJRBABk7Lch6XdOXwXC66IB
        jVLBlttsjXLbaJ7yrJChFdEQKdaCsWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-zWKhIzf_Ol-IJu4R8Qx8pA-1; Thu, 02 Apr 2020 17:43:25 -0400
X-MC-Unique: zWKhIzf_Ol-IJu4R8Qx8pA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8FEB18B9FC1;
        Thu,  2 Apr 2020 21:43:22 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 634575E02B;
        Thu,  2 Apr 2020 21:43:20 +0000 (UTC)
Date:   Thu, 2 Apr 2020 16:43:18 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paul McKenney <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [RESEND][patch V3 06/23] bug: Annotate WARN/BUG/stackfail as
 noinstr safe
Message-ID: <20200402214318.v54a34rvvo2svtoh@treble>
References: <20200320175956.033706968@linutronix.de>
 <20200320180032.994128577@linutronix.de>
 <20200402210115.zpk52dyc6ofg2bve@treble>
 <20200402213431.GK2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200402213431.GK2452@worktop.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 11:34:31PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 02, 2020 at 04:01:15PM -0500, Josh Poimboeuf wrote:
> > On Fri, Mar 20, 2020 at 07:00:02PM +0100, Thomas Gleixner wrote:
> > > Warnings, bugs and stack protection fails from noinstr sections, e.g. low
> > > level and early entry code, are likely to be fatal.
> > > 
> > > Mark them as "safe" to be invoked from noinstr protected code to avoid
> > > annotating all usage sites. Getting the information out is important.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > ---
> > >  arch/x86/include/asm/bug.h |    3 +++
> > >  include/asm-generic/bug.h  |    9 +++++++--
> > >  kernel/panic.c             |    4 +++-
> > >  3 files changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > --- a/arch/x86/include/asm/bug.h
> > > +++ b/arch/x86/include/asm/bug.h
> > > @@ -70,13 +70,16 @@ do {									\
> > >  #define HAVE_ARCH_BUG
> > >  #define BUG()							\
> > >  do {								\
> > > +	instr_begin();						\
> > >  	_BUG_FLAGS(ASM_UD2, 0);					\
> > >  	unreachable();						\
> > >  } while (0)
> > 
> > For visual symmetry at least, it seems like this wants an instr_end()
> > before the unreachable().  Does objtool not like that?
> 
> Can't remember, but I think it's weird to put something after you know
> it unreachable.

Yeah, I guess... but my lizard brain likes to see closure :-)

-- 
Josh

