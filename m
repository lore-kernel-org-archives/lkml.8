Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054C2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57D62078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBNSDL9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHTDqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgHTDqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597895207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJp8ETPySMsCpzxcqSo+vhA8i7HDv8eDmkf15FdeaxY=;
        b=EBNSDL9zOOn3bpAmGNw4ZMLXUYXh3TePPLhs2EQk6SeWeU+Mr7omjxk4jxubXlgdexQcUV
        hSdZ6rEq359wPKQiNuECwERRCrP2Nwk5t7DmrAEQJat8X0jK6IntHciDliONL7jWHCdwLu
        nH2mJGSrS5CRzNV0fKr6sj9XRDmZ2LI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-CPdbQVJvNBSygXj1nyor9g-1; Wed, 19 Aug 2020 23:46:45 -0400
X-MC-Unique: CPdbQVJvNBSygXj1nyor9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63875100CEC4;
        Thu, 20 Aug 2020 03:46:42 +0000 (UTC)
Received: from treble (ovpn-117-70.rdu2.redhat.com [10.10.117.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 339621B47B;
        Thu, 20 Aug 2020 03:46:39 +0000 (UTC)
Date:   Wed, 19 Aug 2020 22:46:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, Kyle Huey <me@kylehuey.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [REGRESSION 5.8] x86/entry: DR0 break-on-write not working
Message-ID: <20200820034636.tl4nq5aiitpfvx62@treble>
References: <CAP045Ao5-+vvTzCOaCkfwztsd2Q0_8kh85UxuXW0bbcfVbF40w@mail.gmail.com>
 <20200819184149.GH2674@hirez.programming.kicks-ass.net>
 <CAP045ApfQnsHsimmhLsSeL2OSB98-Q3f=nM4em5rqr_paz4=5Q@mail.gmail.com>
 <20200819213534.GQ3982@worktop.programming.kicks-ass.net>
 <20200819224731.3edo5lqw6lbuprdx@treble>
 <CALCETrV8sVjhVYig4ZvYDN3pEbF0tvekXCcJCBakeZbMn0gZ=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrV8sVjhVYig4ZvYDN3pEbF0tvekXCcJCBakeZbMn0gZ=A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 05:14:18PM -0700, Andy Lutomirski wrote:
> On Wed, Aug 19, 2020 at 3:47 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > What amazes me is that it successfully schedules back to the end of the
> > #DB handler finish and everything keeps working.
> >
> > Do we not have assertions in the scheduler to catch this?
> 
> You almost nailed it.
> 
> I'm pretty sure you have the buggy sequence of events right, but for
> the wrong reason.  There's nothing wrong with scheduling when
> delivering SIGTRAP, but it's definitely wrong to blindly save and
> restore DR7 around scheduling and around ptrace invocations.  Remember
> this is an entry from user mode, so it runs on the user stack.

Wow, I had no idea user #DB's run on the task stack.  The scheduling
from #DB blew my mind :-)  What's the purpose of that?

-- 
Josh

